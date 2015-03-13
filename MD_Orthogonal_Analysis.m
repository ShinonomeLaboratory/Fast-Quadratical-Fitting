function [A,b,c,RMSE] = MD_Orthogonal_Analysis(x,y)
dim=size(x);
dim=dim(1);
lim=dim+1+(dim+1)*dim/2;
SignalGroup=zeros(lim,length(y));

for i=1:lim
    vec=zeros(1,lim);
    vec(i)=1;
    [A,b,c] = Vec2Paras(vec,dim);
    hx= SimulateFunc(A,b,c,x);
    SignalGroup(i,:)=hx;
end

OrthogonalSignalGroup=zeros(lim,length(y));
OrthogonalSignalGroup(1,:)=SignalGroup(1,:);
OrthogonalAlgebraGroup=eye(lim);
for i=2:lim
    OrthogonalSignalGroup(i,:)=SignalGroup(i,:);
    for j=1:(i-1)
        Scale=dot(OrthogonalSignalGroup(j,:),OrthogonalSignalGroup(i,:))/dot(OrthogonalSignalGroup(j,:),OrthogonalSignalGroup(j,:));
        Projection=Scale.*OrthogonalSignalGroup(j,:);
        OrthogonalSignalGroup(i,:)=OrthogonalSignalGroup(i,:)-Projection;
        Projection=Scale.*OrthogonalAlgebraGroup(j,:);
        OrthogonalAlgebraGroup(i,:)=OrthogonalAlgebraGroup(i,:)-Projection;
    end
end

for i=1:lim
    IP=sqrt(dot(OrthogonalSignalGroup(i,:),OrthogonalSignalGroup(i,:)));
    OrthogonalSignalGroup(i,:)=OrthogonalSignalGroup(i,:)./IP;
    OrthogonalAlgebraGroup(i,:)=OrthogonalAlgebraGroup(i,:)./IP;
end

for i=1:lim
    Coefficient=dot(OrthogonalSignalGroup(i,:),y);
    OrthogonalAlgebraGroup(i,:)=OrthogonalAlgebraGroup(i,:).*Coefficient;
end
AnsVec=zeros(1,lim);
for i=1:lim
    AnsVec(i)=sum(OrthogonalAlgebraGroup(:,i));
end
[A,b,c] = Vec2Paras(AnsVec,dim);
[hx] = SimulateFunc(A,b,c,x);
RMSE=sqrt(sum((y-hx).^2));
end


