function out_U=Cal_FieldNormalization(in_U)
    s_abs_max =  max(max(abs(in_U)));                                       %��ֵ�����ֵ1*discrete��1*1
    out_U = in_U./s_abs_max;                                                  %��һ��
end