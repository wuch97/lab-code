%stage 1
%synthetic data
function [x,SIGMA,MU]=creat_x(N,T)
clear e;
clear x;
e=zeros(N,T);
x=zeros(N,T);

SIGMA=0.5*rand(N,1);  %系数待思考！！！！！
%SIGMA=sort(SIGMA);
MU=0;
for n=1:N
e(n,:)=normrnd(MU,SIGMA(n),1,T);
end


fs=80000;
ts=1/fs;  %  采样间隔 
f1=50;
f2=150;
for i=1:N
      for j=1:T
          Ts=i+j;
          x(i,j)=0.3*cos(2*pi*f1*Ts*ts)+0.6*cos(2*pi*f2*Ts*ts);
      end
end

x=x+e;
end




