function [ sum ] = m_fn(r,n)
%compute sum[ k=0 to n, k^r]
sum = 0;
for k=1:n
    sum = sum+ k^r;
end
end
