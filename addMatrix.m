function m = addMatrix(n)
%addMatrix Each row and col gets assigned a natural value
%   Creates a nxn matrix of natural number values.
%   The groovy thing about this is that it deomonstrates 
%   that the natural number have geometric properties
%   using given the output is ran through polar()
%   Usage:
%   m = addMatrix(n);
%   polar(m);
    n = floor(n);
    m = zeros(n);
    index = 1;
    for row = 1:n
        for col = 1:n
            m(row,col) = index;
            index = index + 1;
        end
    end
end