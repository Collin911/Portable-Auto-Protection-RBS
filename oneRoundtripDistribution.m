function [U] = oneRoundtripDistribution(U_pre, H_fsdf, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftphase1, H_shiftphase2, tiltParam)
% % �Կ���Ϊ��ʼƽ��   
%     %mesh(abs(U_pre));
    U = Cal_AperturetoLens2(U_pre, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %������L2�������
    
    if tiltParam ~= 0
        psi = tiltParam(1);
        sampN = tiltParam(2); 
        deltaF = tiltParam(3); 
        lambda = tiltParam(4);
        U = Cal_TransTiltPlane(U, B_lens, B_aper, psi, sampN, lambda, deltaF);
    end
    
    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2�������-L2�������
    U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2�������-M2
    %U = Cal_FieldNormalization(U);
    %U = rot90(U, 2);

    U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'�������

    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
    U = Cal_AperturetoLens2(U, H_fsdf, B_aper, B_lensshift, delta, H_shiftphase2);             %L2'�������-����

    
    U = Cal_AperturetoLens1(U, H_fsf, B_lens, B_aper, delta);              %������L1�������

    U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
    U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %L1�������-M1
    %U = rot90(U, 2);
    
    U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'�������
    U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
    U = Cal_AperturetoLens1(U, H_fsf, B_aper, B_lens, delta);              %L1'�������-����

%     
%     % �Խ��ն�ƽ�澵Ϊ��ʼƽ��
%     U = Cal_AperturetoLens1(U_pre, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'�������
% %     mesh(abs(U));
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
%     U = Cal_AperturetoLens2(U, H_fsdf2, B_aper, B_lensshift, delta, H_shiftphase2);             %L2'�������-����
% %     mesh(abs(U));
%     
%     U = Cal_AperturetoLens1(U, H_fsf, B_lens, B_aper, delta);              %������L1�������
% %     mesh(abs(U));
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
%     U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %L2�������-M2
% %     mesh(abs(U));
%     U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'�������
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
%     U = Cal_AperturetoLens1(U, H_fsf, B_aper, B_lens, delta);              %L1'�������-����
% %     mesh(abs(U));
%     
%     U = Cal_AperturetoLens2(U, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %������L2�������
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2�������-L2�������
%     U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2�������-M2
% %     mesh(abs(U));
%    
    % �Խ��ն�͸��ǰ����Ϊ��ʼƽ��
    
%     U = U_pre.*B_lens;
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2�������-L2�������
%     U = Cal_AperturetoLens2(U, H_fsl, B_lensshift, B_lensshift, delta);     
%     U = Cal_AperturetoLens2(U, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'�������
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
%     U = Cal_AperturetoLens2(U, H_fsdf, B_aper, B_lensshift, delta);             %L2'�������-����
%     
%     U = Cal_AperturetoLens2(U, H_fsf, B_lens, B_aper, delta);              %������L1�������
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
%     U = Cal_AperturetoLens2(U, H_fsl, B_lens, B_lens, delta);              %L1�������-M1
%     U = Cal_AperturetoLens2(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'�������
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
%     U = Cal_AperturetoLens2(U, H_fsf, B_aper, B_lens, delta);              %L1'�������-����
%     
%     U = Cal_AperturetoLens2(U, H_fsdf, B_lensshift, B_aper, delta);         %������L2�������

% �޿���
%     U = Cal_AperturetoLens1(U_pre, H_fsl, B_lensshift, B_lensshift, delta);              %M2-L2'�������
%     mesh(abs(U));
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2'�������-L2'�������
%     mesh(abs(U));
%     U = Cal_AperturetoLens2(U, H_fsdf2, B_lens, B_lensshift, delta, H_shiftphase2);             %L2'�������-L1�������
%     mesh(abs(U));
%     
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1�������-L1�������
%     mesh(abs(U));
%     U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta).*(1i);              %L2�������-M2
%     mesh(abs(U));
%     U = Cal_AperturetoLens1(U, H_fsl, B_lens, B_lens, delta);              %M1-L1'�������
%     mesh(abs(U));
%     U = Cal_lensImpact(U, H_lens, B_lens);                                 %L1'�������-L1'�������
%     mesh(abs(U));
%         
%     U = Cal_AperturetoLens2(U, H_fsdf, B_lensshift, B_lens, delta, H_shiftphase1);         %������L2�������
%     mesh(abs(U));
%     U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                 %L2�������-L2�������
%     mesh(abs(U));
%     U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta).*(1i);              %L2�������-M2
%     mesh(abs(U));
   
% ƽ�澵��ǻƫ��
%     U = Cal_AperturetoLens2(U_pre, H_fsdf2, B_lens, B_lensshift, delta, H_shiftphase2);             %L2'�������-L1�������
%     mesh(abs(U));
%     
%     U = Cal_AperturetoLens2(U, H_fsdf, B_lensshift, B_lens, delta, H_shiftphase1);         %������L2�������
%     mesh(abs(U));
    
end