function [H] = Cal_LensImpactMatrixShift(length, lambda, r_CatEye, shift_x, shift_y)
    if(~exist('shift_y','var'))
        shift_y = 0;  % ���δ���ָñ������������и�ֵ
    end
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;                                                   %���������������Ƶ��������
   M = samplingNum;                                                        %���������� M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %���ɲ������±�
   H=exp(-j*k./(2*length)*((n1*delta+shift_x).^2+(n2*delta+shift_y).^2));                  %��ʽ��9�����㴫�ݺ�������
%    H=exp(-j*k*(length-sqrt(length.^2+(n1*delta).^2+(n2*delta+shift).^2)));
end

% function [H] = Cal_LensImpactMatrixOffset(length, lambda, r_CatEye, ofx, ofy)
%    [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
%    k = 2 * pi ./ lambda;                                                   %���������������Ƶ��������
%    M = samplingNum;                                                        %���������� M
%    [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %���ɲ������±�
%    H=exp(-j*k./(2*length)*((n1*delta + ofx / delta).^2+(n2*delta+ofy).^2));                  %��ʽ��9�����㴫�ݺ�������
% %    H=exp(-j*k*(length-sqrt(length.^2+(n1*delta).^2+(n2*delta+shift).^2)));
% end

