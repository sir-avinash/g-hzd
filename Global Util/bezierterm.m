function b = bezierterm(alpha,s)

[m,n] = size(alpha);

M = n-1;
b = zeros(n,1);
for k = 0:M
term_k = (nchoosek(M,k))*(s.^k.*(1-s).^(M-k));
b(k+1) = term_k;
end
