clear all

T=100;
Q=0.1;
R=0.1;
%error=2;

I=3;
nt_kalman=zeros(I,1);
nt_ar=zeros(I,1);
error=0.5;
NN=500:100:1500;
J=numel(NN);
for j=1:J
    N=NN(j);
    nt_kalman=zeros(I,1);
    nt_ar=zeros(I,1);
for i=1:I
    clear s;
    clear x;
    clear A;
    clear C;
    clear ss;
    clear xx_ar;
    
[s,x,A,C]=creat_s_and_x(N,T,R,Q);% s为真实值， x为节点观测获得的值
ss(:,1)=s(:,1);
ss(:,2)=s(:,2);
xx_ar(:,1)=x(:,1);
xx_ar(:,2)=x(:,2);
P_last=0;
P_t=zeros(N,T);        %P的初始值设为0.。。。。。。。。。。。。。。。待思考

for t=3:T
 %   [s_t,P_t,s_t_last]=kalman_pred(x(:,t),A,ss(:,t-1),C,R,Q,P_t);
 %   e_kalman=abs(s_t-s_t_last);
    for n=1:N      
         s_t_last(n,t)=A(n,n)*ss(n,t-1);
         P_t_last=A(n,n)^2*P_last+Q;
         K_t=(P_t_last*C(n,n))/(C(n,n)^2*P_t_last+R);
         s_t(n,t)=s_t_last(n,t)+K_t*(x(n,t)-C(n,n)*s_t_last(n,t));
         
         e_kalman=abs(x(n,t)-s_t_last(n,t));
         
        if e_kalman>error
            ss(n,t)=s_t(n,t);
            nt_kalman(i)=nt_kalman(i)+1;   
        else
            ss(n,t)=s_t_last(n,t);%%%关于P更新为什么待思考
        end
        xxx_ar(1)=xx_ar(n,t-2);
        xxx_ar(2)=xx_ar(n,t-1);
        x_ar(n,t)=ar_pred(xxx_ar,1);
        
        if abs(x(n,t)-x_ar(n,t))>error
            xx_ar(n,t)=x(n,t);
            nt_ar(i)=nt_ar(i)+1; 
        else
            xx_ar(n,t)=x_ar(n,t);
        end
    end
end
mse_kalman(i)=norm(ss-s)/(N*T);
mse_ar(i)=norm(xx_ar-s)/(N*T);
end
Nt_kalman(j)=sum(nt_kalman)/I;
Nt_ar(j)=sum(nt_ar)/I;
MSE_kalman(j)=sum(mse_kalman)/I;
MSE_ar(j)=sum(mse_ar)/I;
end



figure
plot(NN,Nt_kalman,'r');hold on;
plot(NN,Nt_ar);
figure
plot(NN,MSE_kalman,'r');hold on;
plot(NN,MSE_ar);