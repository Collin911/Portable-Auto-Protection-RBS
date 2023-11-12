function [U] = Cast_FreeSpace(U_pre, H_fs, B_dest, B_start)
%    H = fftshift(fft2(ifftshift(H_fsdf)));                                  %�������FFT�任
%    B = fftshift(fft2(ifftshift(U_pre.*B_aper)));                           %������ԭʼ�ⳡ��FFT�任
%    U = fftshift(ifft2(ifftshift(H.*B))).*B_lens.*delta.*delta;             %L2������ⳡ

   B = fftshift(fft2(ifftshift(U_pre.*B_start)));                           %������ԭʼ�ⳡ��FFT�任
   U = fftshift(ifft2(ifftshift(H_fs.*B))).*B_dest;             %L2������ⳡ
end