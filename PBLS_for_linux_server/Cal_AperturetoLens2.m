function [U] = Cal_AperturetoLens2(U_pre, H_fsdf, B_lens, B_aper, delta, H_shiftphase)
%    H = fftshift(fft2(ifftshift(H_fsdf)));                                  %�������FFT�任
%    B = fftshift(fft2(ifftshift(U_pre.*B_aper)));                           %������ԭʼ�ⳡ��FFT�任
%    U = fftshift(ifft2(ifftshift(H.*B))).*B_lens.*delta.*delta;             %L2������ⳡ

   B = fftshift(fft2(ifftshift(U_pre.*B_aper)));                           %������ԭʼ�ⳡ��FFT�任
   B = B .* H_shiftphase;
   U = fftshift(ifft2(ifftshift(H_fsdf.*B))).*B_lens;             %L2������ⳡ
end