function [U] = InitialTiltWave(length, shift, lambda, r_MAX)
   [~, samplingNum, ~, ~, delta, ~] = Para_FFTAlgorithm(r_MAX);
   k = 2 * pi ./ lambda;                                                   %���������������Ƶ��������
   M = samplingNum;                                                        %���������� M
   [~, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %���ɲ������±�
   U=exp(-1i*k*(n2*delta)*sin(atan(shift/length))); %��ʽ��9�����㴫�ݺ�������
end