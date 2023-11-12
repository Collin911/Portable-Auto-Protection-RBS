function [U,Vp] = oneRoundtripWithPB_V3_own(U_pre, H_fsdf, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam, ro, rp, PB_path_len)
    if(~exist('PB_path_len','var'))
        PB_path_len = 0;  % ���δ���ָñ������������и�ֵ
    end
% �Կ���Ϊ��ʼƽ��   
    %mesh(abs(U_pre));
    U = Cast_FreeSpaceShift(U_pre, H_fsdf, B_lensshift, B_aper, H_shiftphase1);         %������L2�������
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
    opd = 2 * pi / lambda * PB_path_len;
    
    Vp = Cal_DiffractionEfficiency(U, oneRoundtripPB_V2(U, H_fsdf, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam));

    nU = (rp * Vp^2 * exp(1i*opd)  - ro) / (1 - ro * rp * Vp^2 * exp(1j * opd)) .* U;
    %U_M2_total = U .* ro + pU .* to .* rp;
    
    U = Cast_FreeSpace(nU, H_fsl, B_lensshift, B_lensshift);              %M2-L2'�������
%     mesh(abs(U));
    U = Cast_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
    U = Cast_FreeSpaceShift(U, H_fsdf, B_aper, B_lensshift, H_shiftphase2);             %L2'�������-����
%     mesh(abs(U));
    
    U = Cast_FreeSpace(U, H_fsf, B_lens, B_aper);              %������L1�������
    if tiltParam ~= 0
        U = Cast_TiltPlane(U, B_lens, B_aper, -psi, sampN, lambda, deltaF);
    end
%     mesh(abs(U));   
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %L1�������-M1
    %U = rot90(U, 2);
%     mesh(abs(U));
    U = Cast_FreeSpace(U, H_fsl, B_lens, B_lens);              %M1-L1'�������
    U = Cast_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
    U = Cast_FreeSpace(U, H_fsf, B_aper, B_lens);              %L1'�������-����
%     mesh(abs(U));
    
end