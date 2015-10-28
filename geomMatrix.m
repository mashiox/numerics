function [ M ] = geomMatrix( n )
%geomMatrix More geometric matrix fun
%   Usage: 
%       M = geomMatrix(n);
%       polar(M); % pretty! n > 30
M = zeros(n);
k = 0;
for ii = 1:n
    for jj = 1:n
        M(ii,jj) = ii + jj;
    end
end


end

