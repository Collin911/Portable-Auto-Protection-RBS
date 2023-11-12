function [U,Vp, Vvector] = oneRoundtripWithPB_V4_multipleV(U_pre, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam, ro, rp, PB_path_len)
%�˺����в��û������ڷ��������ɿռ䴫�䣬��ȷ��H_fsw�������Ϊʵ�ʾ���(d+f)/windowTimes
%H_shiftwindow�������Ϊʵ�ʾ���shift/windowTimes
    Vvector = [];
    if(~exist('PB_path_len','var'))
        PB_path_len = 0;  % ���δ���ָñ������������и�ֵ
    end
% �Կ���Ϊ��ʼƽ��   
    %mesh(abs(U_pre));
    U = U_pre;
    for i = 1:windowTimes
        U = Cast_FreeSpaceShift(U, H_fsw, 1, B_aper, H_shiftwindow1);         %������L2����
    end
    U = Cast_FreeSpace(U, H_fsf, B_lensshift, B_aper);             %L2���㵽L2�������

%     mesh(abs(U));
    if tiltParam ~= 0
        psi = tiltParam(1);
        sampN = tiltParam(2); 
        deltaF = tiltParam(3); 
        lambda = tiltParam(4);
        U = Cast_TiltPlane(U, B_lens, B_aper, psi, sampN, lambda, deltaF);
    end
    U = Cast_lensImpact(U, H_lensShift, B_lensshift);                                 %L2�������-L2�������
    U = Cast_FreeSpace(U, H_fsl, B_lensshift, B_lensshift);              %L2�������-M2
    %U = Cal_FieldNormalization(U);
    %U = rot90(U, 2);
%     mesh(abs(U));
    
    [~, ~, ~, ~, ~, ~, lambda] = Para_FFTAlgorithm(0);
    dPhi = 2 * pi / lambda * PB_path_len;
    
    if ro ~= 1 && rp ~= 0
        Vp = Cal_DiffractionEfficiency(U, oneRoundtripPB_window(U, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
        H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam));
        coeff = (rp * Vp^2 * exp(1i*dPhi)  - ro) / (1 - ro * rp * Vp^2 * exp(1j * dPhi));
        nU = coeff .* U;
    else 
        Vp = 0;
        nU = U;
    end
    %U_M2_total = U .* ro + pU .* to .* rp;
    
    V2 = Cal_DiffractionEfficiency(U_pre, U);
    U_pre = U;

    U = Cast_FreeSpace(nU, H_fsl, B_lensshift, B_lensshift);              %M2-L2'�������
%     mesh(abs(U));
    U = Cast_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
    U = Cast_FreeSpace(U, H_fsf, B_lensshift, B_aper);             %L2������浽L2����
    for i = 1:windowTimes
        U = Cast_FreeSpaceShift(U, H_fsw, B_lensshift, B_aper, H_shiftwindow2);         %L2���㵽����
    end

    V3 = Cal_DiffractionEfficiency(U_pre, U);
    U_pre = U;
    
%     mesh(abs(U));
    
    U = Cast_FreeSpace(U, H_fsf, B_lens, B_aper);              %������L1�������
    if tiltParam ~= 0
        U = Cast_TiltPlane(U, B_lens, B_aper, -psi, sampN, lambda, deltaF);
    end
%     mesh(abs(U));   
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %L1�������-M1

    V4 = Cal_DiffractionEfficiency(U_pre, U);
    U_pre = U;
    %U = rot90(U, 2);
%     mesh(abs(U));
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %M1-L1'�������
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
    U = Cast_FreeSpace(U, H_fsf, B_aper, B_lens);              %L1'�������-����
    
    V1 = Cal_DiffractionEfficiency(U_pre, U);    
    Vvector = [V1 V2 V3 V4];
%     mesh(abs(U));
    
end