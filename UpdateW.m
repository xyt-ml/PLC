function W=UpdateW(data,y,S,D,para)
%Update weight matrix W

a=para.alpha;
b=para.beta;
lambda=para.lambda;
mu=para.mu;
k=para.k;

[p,~]=size(y);
data=normr(data);
kdtree = KDTreeSearcher(data);
[neighbor,~] = knnsearch(kdtree,data,'k',k+1);
neighbor = neighbor(:,2:k+1);
W = zeros(p,p);
options = optimoptions('quadprog',...
'Display', 'off','Algorithm','interior-point-convex' );
for i = 1:p
    data1 = data(neighbor(i,:),:);
	O = repmat(data(i,:),k,1)-data1;
	Gx = O*O';
	y1 = y(neighbor(i,:),:);
	Oy = repmat(y(i,:),k,1)-y1;
	Gy = Oy*Oy';
	GxGy = lambda*Gx + mu*Gy;
    D1 = D(neighbor(i,:),:);
    Dh = vecnorm((repmat(D(i,:),k,1)-D1),2,2).^2;
    S1 = S(neighbor(i,:),:);
    Sh = vecnorm((repmat(S(i,:),k,1)-S1),2,2).^2;
    f = a.*Dh + b.*Sh;
	lb = sparse(k,1);
	ub = ones(k,1);
	Aeq = ub';
	beq = 1;
	w = quadprog(2*GxGy, f, [],[], Aeq, beq, lb, ub,[], options);
	W(i,neighbor(i,:)) = w';
end
end