function [H] = Cal_LensImpactMatrix(length, lambda, r_CatEye)
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_CatEye);
   k = 2 * pi ./ lambda;                                                   %���������������Ƶ��������
   M = samplingNum;                                                        %���������� M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %���ɲ������±�
   H=exp(-1i*k./(2*length)*((n1*delta).^2+(n2*delta).^2));                  %��ʽ��9�����㴫�ݺ�������
end