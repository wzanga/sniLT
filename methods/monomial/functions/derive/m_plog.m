function [y] = m_plog(a,T,p)
%Generate the derivative of the a*tan(ax+b) in the function g = D^{1}[logf]
%Note that D^{p}g = D^{p+1}[logf]
switch p
    case 0
        y = a*T;
    case 1
        y = a^2 *(T.^2 + 1); 
    case 2
        y = a^3 *(2*T.^3 + 2*T); 
    case 4
        y = a^4 *(24*T.^5 + 40*T.^3 + 16*T);
    case 6
        y = a^6 *(720*T.^7 + 1680*T.^5 + 1232*T.^3 + 272*T);
    case 8
        y = a^8 *(40320*T.^9 + 120960*T.^7 + 129024*T.^5 + 56320*T.^3 + 7936*T);
    case 10
        y = a^10*(3628800*T.^11 + 13305600*T.^9 + 18627840*T.^7 + 12207360*T.^5 + 3610112*T.^3 + 353792*T);
    otherwise
end
end