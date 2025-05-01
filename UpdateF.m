function F = UpdateF(W, train_p_target)
%Update label confidence matrix F

[p,q]=size(train_p_target);

options = optimoptions('quadprog',...
'Display', 'off','Algorithm','interior-point-convex' );
WT = W';
sum(WT);
for i=1:p
    ft(i,:)=train_p_target(i,:)/sum(train_p_target(i,:));
end

T =WT*W+W*ones(p,p)*WT.*eye(p,p)-2*WT;
for j=1:p
    lb=sparse(q,1);
    ub=train_p_target(j,:);
    A=ones(1,q);
    b=1;
    M=T(j,j)*eye(q,q);
    f=zeros(1,q);
    for i=1:p
        if i~=j
            f=f+T(i,j).*ft(i,:);
        end
    end
    y=quadprog(M,f,[],[],A,b,lb,ub,[],options);
    ft(j,:)=y';
    F(j,:)=y';
end
end