function[C,M,P] = Initial_PC(data,a,partial_target)
m=size(data,1);
p_t = full(partial_target);
M = zeros(m,m);
P = zeros(m,m);
for i = 1:a
    for j = 1:a
        P(i,j)=1;
        if p_t(i) == p_t(j)
           M(i,j)=1;
        end
    end
end
C=P-M;





