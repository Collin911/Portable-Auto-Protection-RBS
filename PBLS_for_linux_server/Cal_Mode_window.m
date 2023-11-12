function [S, finalDistribution, U_eigen, U_next, itr_times] = Cal_Mode_window(H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
    H_fsf, B_lens, B_aper, B_lensshift, r_CatEye, H_shiftwindow1, H_shiftwindow2, tiltParam, ro, rp, PB_path_len)
   [N_itr, ~, ~, ~, delta,~] = Para_FFTAlgorithm(r_CatEye);                 %�����������
    if(~exist('PB_path_len','var'))
        PB_path_len = 0;  % ���δ���ָñ������������и�ֵ
    end   
%    length = 0.004;
%    shift = -0.0001;
%    lambda = 1064E-9;
%    primaryU = InitialTiltWave(length, shift, lambda, r_CatEye);

   primaryU = 1;                                                           %��ʼ���ֲ�

   firstU = oneRoundtripWithPB_V3_window(primaryU, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam, ro, rp, PB_path_len);                                      %�����һ��round trip��������ϵķֲ�   
% firstU = oneRoundtripPB_window(primaryU, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
%         H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam);   %�����ܽ��ն���ʼ

   firstU = gpuArray(firstU);
   %��ʼ��������
   prevU = firstU;
   prevV = 1;
   itr = 0;
   while 1
        U_eigen = oneRoundtripWithPB_V3_window(prevU, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam, ro, rp, PB_path_len);  %������漴�´����� 
% U_eigen = oneRoundtripPB_window(prevU, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
%         H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam); %�����ܽ��ն���ʼ

        U = U_eigen;                                                          
        U_abs = abs(U);                                                    %������ֲ���ģ = sqrt(a^2 + b^2)
        U_abs_maxArr = max(U_abs);                                           %��ֵ�����ֵdiscrete*discrete��1*discrete
        U_abs_maxVal = max(U_abs_maxArr);                                       %��ֵ�����ֵ1*discrete��1*1
        m = U_abs./U_abs_maxVal;                                              %��һ����ķ�ֵ
        V = Cal_DiffractionEfficiency(prevU, U);        
        if abs(V - prevV) < 0.001 || itr > N_itr
            break
        end
        U = U./U_abs_maxVal;                                                  %��һ��
        prevU = U;
        prevV = V;
%         tempU = U_itr;
        itr = itr + 1;
        if mod(itr, 10) == 0
            if (mod(itr, 50) == 0 && itr > 100) || itr <= 100
                itr
            end
        end
   end
%    U = Cal_AperturetoLens2(s_it, H_fsdf, B_lensshift, B_aper, delta, H_shiftphase1);         %������L2�������
%    U = Cal_lensImpact(U, H_lensShift, B_lensshift);                                           %L2�������-L2�������
%    U = Cal_AperturetoLens1(U, H_fsl, B_lensshift, B_lensshift, delta);              %L2�������-M2
%    finalDistribution =  (abs(U)./(max(max(abs(U))))).^2;                                              %�����ֵ

        U_next = oneRoundtripWithPB_V3_window(U_eigen, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
       H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1, H_shiftwindow2, tiltParam, ro, rp, PB_path_len);  %������漴�´����� 
% U_next = oneRoundtripPB_window(U_eigen, H_fsw, windowTimes, H_fsl, H_lens,H_lensShift,...
%         H_fsf, B_lens, B_aper, B_lensshift, delta, H_shiftwindow1,...
%         H_shiftwindow2, tiltParam); %�����ܽ��ն���ʼ

   finalDistribution =  m.^2;

   temp = (1./exp(1)).*(max(max(m)));
   tempS = sum(sum(m>=temp));
   S = tempS*delta*delta;
   itr_times = itr;
end