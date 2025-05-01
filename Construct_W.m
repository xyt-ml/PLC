function W = Construct_W(train_data, train_p_target, para)

k=para.k;
[p,~]=size(train_p_target);
train_data = normr(train_data);
kdtree = KDTreeSearcher(train_data);
[neighbor,~] = knnsearch(kdtree,train_data,'k',k+1);
neighbor = neighbor(:,2:k+1);
options = optimoptions('quadprog',...
'Display', 'off','Algorithm','interior-point-convex' );
W = zeros(p,p);
for i = 1:p
	train_data1 = train_data(neighbor(i,:),:);
	D = repmat(train_data(i,:),k,1)-train_data1;
	DD = D*D';
	lb = sparse(k,1);
	ub = ones(k,1);
	Aeq = ub';
	beq = 1;
	w = quadprog(2*DD, [], [],[], Aeq, beq, lb, ub,[], options);
	W(i,neighbor(i,:)) = w';
end

end
