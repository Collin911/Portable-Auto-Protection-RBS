function [H] = Cal_FreeSpaceTransferMatrixAS(length, lambda, r_CatEye)
   [~, samplingNum, ~, ~, ~, deltaF] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;                                                   %���������������Ƶ��������
   M = samplingNum;                                                        %���������� M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %���ɲ������±�
   H=exp(1i*k*length*sqrt(1-(lambda*n1*deltaF).^2-(lambda*n2*deltaF).^2)); %��ʽ��9�����㴫�ݺ�������
   
   f_limit = 1./(lambda * sqrt((2 * length * deltaF)^2 + 1));
   i = find((n1*deltaF < -f_limit) | (n2*deltaF < -f_limit) | (n1*deltaF > f_limit) | (n2*deltaF > f_limit));
   H(i) = 0;
end