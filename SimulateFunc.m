function [hx] = SimulateFunc(A,b,c,x) 
b=b(:)';
ecx=A*x;
dim=size(x);
len=dim(2);
dim=dim(1);
ecxa=zeros(1,len);
for i=1:dim
    ecxa=ecxa+ecx(i,:).*x(i,:);
end
hx=c+b*x+ecxa;
end
