%���ǵ����⣬����rt��ѡ��,��Ϊ��ͷ�ĸ���p,�۲���������M��
clear all;
L=100;
p=0.1;
NN=500:100:1500;
Q=numel(NN);
Ntotal=zeros(1,Q);
Ntotal_raw=zeros(1,Q);
for q=1:Q
    N=NN(q);


rt=4*log(N*p)/(pi*N*p);

for l=1:L
   
    LL=L;

co=rand(N,2);    %�ڵ�����
x=co(:,1);
y=co(:,2); 
%---------------------------
%����

j=0;
clear num;
clear Cluster;
clear CHs;
clear CH;
clear son;
clear num_son;
clear hop;

for i=1:N                              %ѡȡ��ͷ
    if rand<p
        j=j+1;
        num(j)=1;
        Cluster(j,1)=i;
    end
end
                                         %�ڵ��������Ĵ�ͷ
for i=1:N
    z(i)=Cluster(1,1);        %z(i)��ʾ�ڵ�i���ڴصĴ�ͷ
    c=1;
    for k=2:j
       if (x(i)-x(Cluster(k,1)))^2+(y(i)-y(Cluster(k,1)))^2<(x(i)-x(z(i)))^2+(y(i)-y(z(i)))^2;
           z(i)=Cluster(k,1);
           c=k;
       end
    end
    if z(i)~=i
        num(c)=num(c)+1;
        Cluster(c,num(c))=i;
    end 
end

%��ͷ����




CHs=Cluster(:,1);
CH=CHs;
i=0;
T=1;
num_son=zeros(1,j);
for k=1:j
   if  x(CHs(k))^2+y(CHs(k))^2<=rt
        i=i+1;
        hop(T).node(i)=k;
        CHs(k)=0;
   end 
    
end

while numel(unique(CHs))>1 && i>0
    T=T+1;
    i=0;
    for k=1:j
        if CHs(k)>0
            clear distance;
            for t=1:numel(hop(T-1).node)
                distance(t)=(x(CHs(k))-x(CH(hop(T-1).node(t))))^2+(y(CHs(k))-y(CH(hop(T-1).node(t))))^2;
            end
            
            [mi,f]=min(distance);
            if mi<rt
                i=i+1;
                num_son(hop(T-1).node(f))=num_son(hop(T-1).node(f))+1;
                son(hop(T-1).node(f)).node(num_son(hop(T-1).node(f)))=k;
                hop(T).node(i)=k;
                CHs(k)=0;
            end
        end
    end
end

if numel(unique(CHs))>1 && numel(CHs)<j
    T=T+1;
    i=0;
    for k=1:j
        if CHs(k)>0
            clear distance;
            for t=1:numel(hop(T-1).node)
                distance(t)=(x(CHs(k))-x(CH(hop(T-1).node(t))))^2+(y(CH(k))-y(CHs(hop(T-1).node(t))))^2;
            end
            
            [mi,f]=min(distance);
            
                i=i+1;
                num_son(hop(T-1).node(f))=num_son(hop(T-1).node(f))+1;
                son(hop(T-1).node(f)).node(num_son(hop(T-1).node(f)))=k;
                hop(T).node(i)=k;
                CHs(k)=0;
        end
    end
else
    LL=LL-1;
end



    clear num_raw;
for i=1:j
    num_raw(i)=numel(find(Cluster(i,:)>0));
end
Nt=num_raw;

for t=1:T-1
    k=T-t;
    for kk=1:numel(hop(k).node)
        for kkk=1:num_son(hop(k).node(kk))
            Nt(hop(k).node(kk))=Nt(hop(k).node(kk))+Nt(son(hop(k).node(kk)).node(kkk));
        end
    end
end


M=N*0.08;

NT(l)=0;

for i=1:j
    if Nt(i)<M
        NT(l)=NT(l)+Nt(i);
    else
        NT(l)=NT(l)+M;
    end
end

NT_withoutCS(l)=sum(Nt);

end

clear ll;

ll=0;

for i=1:L
    if NT(i)>N
        ll=ll+1;
        Ntotal(q)=Ntotal(q)+NT(i);
        Ntotal_raw(q)=Ntotal_raw(q)+NT_withoutCS(i);
    end      
end

Ntotal(q)=Ntotal(q)/ll;
Ntotal_raw(q)=Ntotal_raw(q)/ll;

x=creat_x(N,T);
Psi=dct(eye(N));
Phi=rand(M,N);
A=Phi*Psi;%���о���??
y=Phi*x;%�õ��۲�����y??
K=20;
theta=OMP(A,y,K);
x_r=Psi*theta;
MSE(q)=norm((x_r-x)/N/T)
end

figure
plot(NN,Ntotal,'r');hold on;
plot(NN,Ntotal_raw);
figure
plot(NN,MSE,'r');hold on;



