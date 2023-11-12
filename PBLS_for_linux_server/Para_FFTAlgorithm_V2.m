function [itr, samplingNum, windowExpandFactor, windowSize, delta, deltaF, lambda] = Para_FFTAlgorithm_V2(r, f, psi)
    radius =r;                                                             %��׶�⾵��Ч������뾶 r
    itr = 400;                                                              %�������� itr
    lambda = 1064E-9;
    
    windowExpandFactor = 1.5;                                                %���㴰���������� G
    windowSize = 2 * windowExpandFactor * radius;                          %���㴰�ڳߴ� 2Gr

    if psi == 0
        requiredSample  = 12 * r ^ 2 / (lambda * f);
    else
        requiredSample = windowSize/lambda*2;
    end 
    samplingNum = 2 ^ ceil(log2(requiredSample))

    delta = windowSize./samplingNum;                                       %���������� delta=2Gr/M
    deltaF = 1./(windowSize);                                              %Ƶ�������� deltaF=(2Gr)^(-1)
    
end