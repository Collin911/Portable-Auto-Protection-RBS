function [T] = Cal_BoundaryFunction(radius, r_CatEye, shift_x, shift_y)
    if(~exist('shift_y','var'))
        shift_y = 0;  % ���δ���ָñ������������и�ֵ
    end
    [~, M, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye); 
    [m1, m2]=meshgrid(linspace(-M/2, M/2-1, M));                           %���ɲ������±�
    T = zeros(M, M);                                                       %��ʼ���߽纯������
    a = 0.5; b = 0.5;                                                      %Բ���ӦԲ������
%     D = ((m1 + a).^2+(m2 + b).^2).^(1/2)*delta;                            %��׶�⾵��ӦԲ��
    %��ʽ��10����Ӧ�߽纯��
    %��׶�⾵��ӦԲ��λ��Ϊ1
    i = find(((m1+a)*delta+shift_x).^2 + ((m2+b)*delta+shift_y).^2 <= radius.^2); 
    T(i)=1;
end