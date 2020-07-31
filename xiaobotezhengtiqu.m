function   tezhengtiqu
%�¹�һ������С����������ȡ----------------------------------------------------------


F=imread('a1.bmp');
F=im2bw(F);
F=imresize(F,[128 128]);
%��ȡ���ϵ�
for i=1:128
    for j=1:128
        if (F(i,j)==1)
            ytop=i;
            xtop=j;
            break;
        end
    end
    if(F(i,j)==1)
        break;
    end
end
%��ȡ���µ�
for i=1:128
    for j=1:128
        if (F(129-i,j)==1)
            ybottom=129-i;
            xbottom=j;
            break;
        end
    end
    if(F(129-i,j)==1)
        break;
    end
end
%��ȡ�����
for i=1:128
    for j=1:128
        if (F(j,i)==1)
            yleft=j;
            xleft=i;
            break;
        end
    end
    if(F(j,i)==1)
        break;
    end
end
%��ȡ���ҵ�
for i=1:128
    for j=1:128
        if (F(j,129-i)==1)
            yright=j;
            xright=129-i;
            break;
        end
    end
    if(F(j,129-i)==1)
        break;
    end
end
%��ȡ���ĵ�
x0=(xright-xleft)/2+xleft;
y0=(ybottom-ytop)/2+ytop;
x0=round(x0);
y0=round(y0);
%ͼ��ƽ��
F=double(F);
[M,N]=size(F);
F1=zeros(M,N);
M0=M/2;
N0=N/2;
for i=1:M
  for j=1:N
        if F(i,j)==1
           F1(i+M0-y0,j+N0-x0)=1;
        end
    end
end
%figure,imshow(F1);
%ͼ������
max=0;
for i=1:128
    for j=1:128
        if(F(i,j)==1)
            d=sqrt((i-y0)^2+(j-x0)^2);
            if(max<d)
                max=d;
            end
        end
    end
end
%max=round(max);
a=200.0/(max*2);
F2=imresize(F1,a);
%figure,imshow(F2);
%������ͼ������Ƶ�500*500��ͼ��Ĵ�С
[M,N]=size(F2);
m0=M/2;
m0=round(m0);
n0=N/2;
n0=round(n0);
f3=zeros(500,500);
y1=round((500-M)/2);
x1=round((500-N)/2);
for i=1:M
    for j=1:N
        if(F2(i,j)==1)
            f3(y1+i,x1+j)=1;
        end
    end
end
%figure,imshow(f3);
%ͼ��ӵѿ�������ת��Ϊ������------------------------------------------------------------
%�Ƕȼ��Ϊ2*pi/(128*128),128�����س���Ϊͼ��ĵ�λԲ�뾶
%f1����������Ŷ�Ӧ���뾶�ͽǶȵ�ֵ
f1=zeros(128,16384);
%ֱ�������뼫���꽨����һһ��Ӧ�Ĺ�ϵ           
for i=1:128
    for j=1:16384
        a=j*2*pi/16384.0;
        r=i;
        y=round(r*sin(a));
        x=round(r*cos(a));
       if (f3(250+x,250+y)==1)
            f1(i,j)=1;
        end
    end
end
F3=zeros(512,512);
%��������ת�����ͼ����ʾ����
for i=1:128
    for j=1:16384
        if  f1(i,j)==1
            a=j*2*pi/16384.0;
            x=round(i*cos(a));
            y=round(i*sin(a));
            F3(256+x,256+y)=1;
        end
    end
end
F3(256,256)=1;
%figure,imshow(F3);
%С����������ȡ-------------------------------------------------------------------
%���нǶȻ��ֵõ�Sq(r)------------------
N=16384;
Sq=zeros(128,4);
for r=1:128
    for q=1:4
        for m=1:N          
             Sq(r,q)=(f1(r,m)*exp(-j*2.0*pi*(m-1)*(q-1)/N))+Sq(r,q);
        end
       Sq(r,q)=1.0/N*Sq(r,q);
    end
end
%С����������ȡ-------------------------
x=3;
a=0.697066;
f0=0.409177;
w=sqrt(0.561145);
F1=zeros(3,9,4);
 tt=4*a^(x+1)/sqrt(2*pi*(x+1))*w;
for q=1:4
    for m=1:3
        rr=2^m+1;
        for n=1:rr
            for r=1:128
               %pp=2*(2^(m-1)*(r-1)/128.0-(n-1))-1;
               pp=2*(2^(m-1)*r/128.0-(n-1))-1;
               cc=cos(2*pi*f0*pp)*exp(-1.0*pp^2/(2*(w^2)*(x+1)));
               fan=2^((m-1)/2)*tt*cc;
               %Fmnq(m,n,q)=abs(Sq(r,q)*fan*(r-1)/128)+Fmnq(m,n,q);
               F1(m,n,q)=abs(Sq(r,q)*fan*r)+F1(m,n,q);
            end
        end
    end
end
  F1






