function [H] = Cal_ShiftPhaseMatrixAS(shift_x, shift_y, r_CatEye)
   [~, samplingNum, ~, ~, ~, deltaF] = Para_FFTAlgorithm(r_CatEye);
   M = samplingNum;                                                        %���������� M
   [n1, n2]=meshgrid(linspace(-M/2, M/2-1, M));                            %���ɲ������±�
   H=(exp(1i*2*pi*(n1*deltaF*shift_x+n2*deltaF*shift_y))); %��ʽ��9�����㴫�ݺ�������
end