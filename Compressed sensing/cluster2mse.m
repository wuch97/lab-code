clear all;
N=1500;   %节点个数（根据需要改一改）
M=200;    %观测矩阵维度 （根据N需要改一改）
K=20;      %稀疏度
T=10;     %时隙数   (改)
x=creat_x(N,T);

Psi=dct(eye(N));

    Phi=rand(M,N);
    A=Phi*Psi;%传感矩阵??
    y=Phi*x;%得到观测向量y??
    theta=OMP(A,y,K);
    x_r=Psi*theta;
    MSE=norm((x_r-x)/N/T)


