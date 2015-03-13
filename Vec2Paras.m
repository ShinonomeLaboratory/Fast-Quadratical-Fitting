function [A,b,c] = Vec2Paras(opti_para,dim)
A=zeros(dim,dim);
lim1=dim*(dim+1)/2;
%生成二次型矩阵
for i=1:lim1
    pos_y=round((1+sqrt(1+8*(i-1)))/2-0.5);
    pos_x=i-pos_y*(pos_y-1)/2;
    if pos_x==pos_y
        A(pos_x,pos_y)=opti_para(i);
    else
         A(pos_x,pos_y)=opti_para(i)/2;
         A(pos_y,pos_x)=opti_para(i)/2;
    end
end
b=opti_para(lim1+1:lim1+dim);
c=opti_para(lim1+1+dim);
end
