function y = bezierval(alpha,s)

[m,n] = size(alpha);

M = n-1;
sum_term = zeros(m,length(s));

for k = 0:M
term_k = (alpha(:,k+1).*nchoosek(M,k))*(s.^k.*(1-s).^(M-k));
sum_term = sum_term+term_k;
end

y = sum_term;