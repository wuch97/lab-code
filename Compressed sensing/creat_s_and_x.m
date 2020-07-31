function [s,x,A,C]=creat_s_and_x(N,T,R,Q)
s=zeros(N,T);
x=zeros(N,T);
a=1+0.01*randn(1,N);
A=diag(a);
for i=1:N
    s(i,1)=20;
end
C=eye(N);
for j=2:T
    s(:,j)=A*s(:,j-1)+sqrt(Q)*randn(N,1);
end


  x=C*s+sqrt(R)*randn(N,T);
