clear all;
N=1500;   %�ڵ������������Ҫ��һ�ģ�
M=200;    %�۲����ά�� ������N��Ҫ��һ�ģ�
K=20;      %ϡ���
T=10;     %ʱ϶��   (��)
x=creat_x(N,T);

Psi=dct(eye(N));

    Phi=rand(M,N);
    A=Phi*Psi;%���о���??
    y=Phi*x;%�õ��۲�����y??
    theta=OMP(A,y,K);
    x_r=Psi*theta;
    MSE=norm((x_r-x)/N/T)


