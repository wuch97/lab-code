function [A]=OMP(D,X,L)
%=============================================
% Sparse coding of a group of signals based on a given ���ڸ�����һ���źŵ�ϡ�����
% dictionary ad specified number of atoms to use. dictionary adָ��Ҫʹ�õ�ԭ����
% input arguments: �������
%       D - the dictionary (its columns MUST be normalized).�ֵ䣨���б����׼����
%       X - the signals to representҪ��ʾ���ź�
%       L - the max. number of coefficients for each signal.���ֵ ÿ���źŵ�ϵ����
% output arguments: �������
%       A - sparse coefficient matrix. ϡ��ϵ������
%=============================================
[N,P]=size(X);

[N,K]=size(D);
%A=zeros(P,K);
for k=1:1:P,
    a=[];
    x=X(:,k);
    residual=x;%�в�
    indx=zeros(L,1);%������
    for j=1:1:L,
        proj=D'*residual;%proj��K*1���У���Ϊresidual��Dÿһ�е��ڻ�ֵ
        [maxVal,pos]=max(abs(proj));%projȡ����ֵ��������꣬�ҵ��ڻ����ֵ��λ��
        pos=pos(1);%�����ֵ��ֹһ����ȡ��һ��
        indx(j)=pos;%�����λ�ô����������ĵ�j��ֵ
        a=pinv(D(:,indx(1:j)))*x;%indx(1:j)��ʾ��һ��ǰj��Ԫ��
        residual=x-D(:,indx(1:j))*a;
     %   if sum(residual.^2) < 1e-6
     %       break;
     %   end
    end;
    temp=zeros(K,1);
    temp(indx(1:j))=a;
    A(:,k)=sparse(temp);%ֻ��ʾ����ֵ����λ��
end;
return;

