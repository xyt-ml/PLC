

function groups=PLC(train_data,train_p_target,test_data,para)

data_new = [train_data;test_data];
a = size(train_data,1);
b = size(test_data,1);
m = size(train_p_target,1);
n = a+b;
pt=ones(m,b);
p_target_new = [train_p_target,pt];
W = Construct_W(data_new, p_target_new',para);
F = Construct_F(W,p_target_new');
W = (W+W')/2;


t1 = zeros(n,1); 
for j = 1:n
    [~,pp] = max(F(j,:));
    t1(j) = pp;
end
[~,t1]=max(F, [], 2);
[C,~,P]=Initial_PC(data_new,n,t1);
[S,D,~] = AdversarialPCP(W,P,C,para);


for it = 1:para.maxit

    % W subproblem
    W = UpdateW(data_new,F,S,D,para);
    W = (W+W')/2;

    % F subproblem
    F = UpdateF(W,p_target_new');

    % S&D subproblem
    [S,D,~] = AdversarialPCP(W,P,C,para);

end

groups = spectralCluster(W,m);


end




