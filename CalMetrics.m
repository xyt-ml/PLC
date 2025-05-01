function [acc,nmi] = CalMetrics(test_target,groups)

a=size(test_target,2);
n=size(groups,1);
[~,index]=max(test_target, [], 1);
predictLabel = bestMap(index,groups(n-a+1:n));
acc = (sum(index' == predictLabel))/(size(index, 2));
[~, nmi, ~] = compute_nmi (index,groups(n-a+1:n));

end