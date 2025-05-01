%load("ecoli r=2_Sample.mat")
load('MSRCv2_Sample.mat');

para.alpha=0.01;
para.beta=0.01;
para.gamma=10;
para.lambda=1;
para.mu=1;
para.maxiter=10;
para.maxit=5;
para.k=10; 


predictLabels=[];
ACC=[];
NMI=[]; 

for it=1:10

    train_data=data(train_idx{it},:);
    train_data=zscore(train_data);
    test_data = data(test_idx{it},:);
    test_data=zscore(test_data);
    train_p_target=partial_target(:,train_idx{it});
    test_target=target(:,test_idx{it});

    groups=PLC(train_data,train_p_target,test_data,para);

    [acc,nmi]=CalMetrics(test_target,groups);
    ACC=[ACC,acc];
    NMI=[NMI,nmi];
    
end

fprintf('ACC: %f std: %f\n',mean(ACC),std(ACC));
fprintf('NMI: %f std: %f\n',mean(NMI),std(NMI));


