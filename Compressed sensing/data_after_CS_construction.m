function [x_CS]=data_after_CS_construction(x)
[N,~]=size(x);
K=sqrt(N);
K=floor(K)+1;
%M=2*K*log(N/K); 
%M=floor(M)+1;
M=N;
Psi=dct(eye(N));
Psi=Psi';
Phi=randn(M,N);
A=Phi*Psi;
y=Phi*x;
theta_CS = OMP(A,y,K);  
x_CS = Psi * theta_CS;
end