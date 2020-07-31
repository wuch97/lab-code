function data_next=ar_pred(data,p)
clear a;
data_next=0;
a=arburg(data,p);
lenth_data=length(data);
for i=1:p
    data_next=data_next+data(lenth_data+1-i)*a(i+1)*(-1);
end
    




