function [itr, samplingNum, windowExpandFactor, windowSize, delta, deltaF, lambda] = Para_FFTAlgorithm(r)
    radius =r;                                                             %��׶�⾵��Ч������뾶 r
    itr = 400;                                                              %�������� itr
%     if r > 1e-3
%         samplingNum = 8192;                                                    %����/Ƶ����������� M
%     else 
%         samplingNum = 512; 
%     end
samplingNum = 16384;
    windowExpandFactor = 1.5;                                                %���㴰���������� G
    windowSize = 2 * windowExpandFactor * radius;                          %���㴰�ڳߴ� 2Gr
    delta = windowSize./samplingNum;                                       %���������� delta=2Gr/M
    deltaF = 1./(windowSize);                                              %Ƶ�������� deltaF=(2Gr)^(-1)
    lambda = 1064E-9;
end