function x_get=data_after_prediction(x,threshold,p)
num_train=10;
x_get=x;
[N,T]=size(x);
clear data;
clear j;
for j=1:1:N
    for i=num_train+1:T
        
         data=x_get(j,i-num_train:i-1);
         x_pred=pred(data,p);
         if abs(x_pred-x(j,i))<=threshold(j)
            x_get(j,i)=x_pred;
         end
   end
end
end

