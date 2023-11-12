clear all
r = 25e-4; %�ظ��������뾶
% cav_d = 1-10000e-9:1e-9:1+10000e-9; %ǻ����0.5�׵�3��
figure;
%for i = [0.005, 0.0025]
cav_d = 0.5:0.01:3; 
cav_d = 2:0.03:3;
lambda = 1064e-9; %����
%lambda = 800e-9:1e-9:1800e-9;

L = 2 * r + 6 * (r + cav_d) ; %��̲�
k = 2 * pi ./ lambda; %����
% modu_phi = mod(L / (lambda / 2), 2) * pi; %��̲���λ


% % for i = 1:len
% %     if (modu_phi(i) > pi/2) && (modu_phi(i) < 3 * pi/2)    
% %         modulator(1,i) = pi / 2; %���Ʋ���
% %     end 
% % end

phi_0 = 0;
delta_phi = k .* L; %��λ��
phi = phi_0 + delta_phi;
% 
% modu_phi = mod(phi, 2*pi);
% s = size(modu_phi);
% len = s(2);
% lower = find(modu_phi > pi/2);
% upper = find(modu_phi < 3 .* pi/2);
% intvl = intersect(lower, upper);
% modulator = repmat(pi/2,[1 len]);
% modulator(intvl) = 0;
% 
% plot(cav_d, modu_phi);
% hold on 
% plot(cav_d, modulator, 'linewidth', 1.5)
% hold off 
% figure;

R1 = 0.6; %���ն�ǻ����ǿ������
r1 = sqrt(R1); %���ն�ǻ�����������
R2 = 1; 
r2 = sqrt(R2); %�����ⷴ�侵���������
V = 0.5636; % ��ʱ����Ч�ʼ���Ϊ80%

for i = [0, 1]
phi = mod(phi, 2*pi) ;%+ i * modulator;
numerator = (1 - R1) * r2 * V^2 .* exp(1j .* phi); %������
denominator = 1 - r1 * r2 * V^2 .* exp(1j .* phi); %��ĸ��
remainder = r1 .* exp(1j * (phi_0 + pi)); %����
R = numerator ./ denominator + remainder;
R = abs(R) .^ 2;
% Reff = (R1 + R2 - 2 * sqrt(R1 * R2) .* cos(phi)) ./ (1 + R1 * R2 - 2 * sqrt(R1 * R2) .* cos(phi));
if i == 1
    thresh = 0.7;
    index = find(R<thresh);
    while(~isempty(index))
        phi(index) = phi(index) + pi/1.5;
        numerator = (1 - R1) * r2 * V^2 .* exp(1j .* phi); %������
        denominator = 1 - r1 * r2 * V^2 .* exp(1j .* phi); %��ĸ��
        remainder = r1 .* exp(1j * (phi_0 + pi)); %����
        R = numerator ./ denominator + remainder;
        R = abs(R) .^ 2;
        index = find(R<thresh);
    end
end
plot(cav_d, R);%, 'linewidth', 1.5);
hold on;
% plot(cav_d, exp(1j .* phi));

    
end

R1 = R1 + cav_d .* 0;
plot(cav_d, R1);%, 'linewidth',2);
hold off;
legend('Equiv. Reflct.','Equiv. Reflct. Modued.','Original Reflct.');
% figure;
% plot(cav_d, real(exp(1j .* phi)));
% figure;
% plot(cav_d, imag(exp(1j .* phi)));
% legend('Equivalent Reflectivity', 'Original Reflectivity', 'Reff');