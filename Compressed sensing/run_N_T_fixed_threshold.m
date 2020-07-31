% fixed MSE and adaptive MSE
clc;
clear all;
NN=500:100:1500;

T=100;
L=10;
num_train=10;
p=3;

lambda=[0.2,0.4,0.8];
C=numel(lambda);
threshold_f=0.1;
F=numel(threshold_f);



MSE_adaptive=zeros(C,L);
MSE_fixed=zeros(F,L);
n=numel(NN);
MSE_ada=zeros(C,n);
MSE_fix=zeros(F,n);

for i=1:n
    tic
    N=NN(i);
    for l=1:L
        clear x;
        clear SIGMA;
        [x,SIGMA,MU]=creat_x(N,T+num_train);
        %threshold_adaptive=threshold_selection(lambda,SIGMA:MU);
        threshold_adaptive=creat_x(N,T);
        for c=1:C
          %  x_get1=data_after_prediction(x,creat_x(N,T),p);
            
           x_get1=data_after_CS_construction(x);
           % x_get1=data_after_CS_construction(x_get1);
            MSE_adaptive(c,l)=norm(x-x_get1)/(N*T);
        end
        
        threshold_fixed=ones(N,1);
        threshold_fixed=threshold_fixed*threshold_f;
        threshold_fixed=threshold_fixed';
        for f=1:F
             %x_get2=data_after_prediction(x,threshold_fixed(f,:),p);
             x_get2=data_after_prediction(x,threshold_adaptive(f,:),p);
             MSE_fixed(f,l)=norm(x-x_get2)/(N*T);
        end
     
    end
       MSE_ada(:,i)=sum(MSE_adaptive,2)/L;
       MSE_fix(:,i)=sum(MSE_fixed,2)/L;
    
   toc 
   
   
end
figure
for c=1:C
plot(NN,MSE_ada(c,:),'r');
hold on;
end   
for f=1:F
       plot(NN,MSE_fix(f,:));
       hold on;
end

legend('0.2','0.4','0.8','fixed0.1')

