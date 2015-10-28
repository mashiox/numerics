function [ Q ] = quadspline(x,y)
%quadspline Cubic spline quadrature
%   Uses Composite Simpson's Rule to approximate the integral over the
%   domain x. Length of x and y need not match, but first and last term of
%   x must be the upper and lower bound of y.
    n = length(y);
    Q = 0;
    h = (x(end) - x(1))/n;
    if mod(n,2) == 0
        Q = h*( y(1) - y(n) + sum( 2*y(2:2:n-2) + 4*y(3:2:n-1) ) )/3;
    else
        Q = h*( y(1) - y(n) + y(2) + 4*y(n-1) + sum( 2*y(4:2:n-2) + 4*y(3:2:n-3) ) )/3;
    end

end