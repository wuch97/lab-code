function [A]=OMP(D,X,L)
%=============================================
% Sparse coding of a group of signals based on a given 基于给定的一组信号的稀疏编码
% dictionary ad specified number of atoms to use. dictionary ad指定要使用的原子数
% input arguments: 输入参数
%       D - the dictionary (its columns MUST be normalized).字典（其列必须标准化）
%       X - the signals to represent要表示的信号
%       L - the max. number of coefficients for each signal.最大值 每个信号的系数数
% output arguments: 输出参数
%       A - sparse coefficient matrix. 稀疏系数矩阵
%=============================================
[N,P]=size(X);

[N,K]=size(D);
%A=zeros(P,K);
for k=1:1:P,
    a=[];
    x=X(:,k);
    residual=x;%残差
    indx=zeros(L,1);%索引集
    for j=1:1:L,
        proj=D'*residual;%proj是K*1的列，其为residual与D每一列的内积值
        [maxVal,pos]=max(abs(proj));%proj取绝对值最大后的坐标，找到内积最大值的位置
        pos=pos(1);%若最大值不止一个，取第一个
        indx(j)=pos;%将这个位置存入索引集的第j个值
        a=pinv(D(:,indx(1:j)))*x;%indx(1:j)表示第一列前j个元素
        residual=x-D(:,indx(1:j))*a;
     %   if sum(residual.^2) < 1e-6
     %       break;
     %   end
    end;
    temp=zeros(K,1);
    temp(indx(1:j))=a;
    A(:,k)=sparse(temp);%只显示非零值及其位置
end;
return;

