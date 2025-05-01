function F = Construct_F(W, train_p_target)

[p,q]=size(train_p_target);
WT = W';
T =WT*W+ W*ones(p,p)*WT.*eye(p,p)-2*WT;
T1 = repmat({T},1,q);
M = spblkdiag(T1{:});
lb=sparse(p*q,1);
ub=reshape(train_p_target,p*q,1);
II = sparse(eye(p));
A = repmat(II,1,q);
b=ones(p,1);
M=sparse(M);
M = (M+M');
fprintf('quadprog...\n');
options = optimoptions('quadprog',...
'Display', 'iter','Algorithm','interior-point-convex' );
Outputs= quadprog(M, [], [],[], A, b, lb, ub,[], options);
F=reshape(Outputs,p,q);

end
