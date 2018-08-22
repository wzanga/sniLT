function [N] = m_invfn(r,n)
% Inverse of the function "m_fn"
% Compute the number of terms in the product reach the order n
% - INPUT
%       r : index of the class
%       n : desired order
% - OUTPUR
%       N : number of terms in the product

N = 1;
while( m_fn(r,N) < n)
    N = N + 1;
end
N = N-1;
end

