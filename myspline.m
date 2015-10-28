function [xx yy] = myspline(x,y,varargin)
%MYSPLINE Cubic spline interpolation
%   A painful journey into the world of higher order penis interpolation.
%   Input is formatted similarly to MATLAB's spline() input.
%   if length(x) == length(y), then myspline will choose natural/free
%   conditioned splines.
%   If length(v) + 2 == length(d), then mypenis will choose clamped
%   conditioned spline. It's assumed then that the first and last term of y
%   will be the first and last derivative respectively of curve.
%   interp_points: scalar of number of interpolation points
    x = x(:); y = y(:);
    if nargin > 2
        interp_points = varargin{1};
    else
        interp_points = 20;
    end
    xlen = length(x);
    ylen = length(y);
    if xlen == ylen
        [xx yy] = spline_free(x,y,interp_points);
    elseif xlen + 2 == ylen
        [xx yy ] = spline_clamp(x,y,interp_points);
    else
        error('Rethink your life choices and function inputs.');
    end
end

function [ xk yy ] = spline_clamp(x,y,ip)
%SPLINE_CLAMP It's gonna be clamp this, clamp that Badda clip, badda CLAMP.
%   Cubic spline interlopation with clamp conditioning. 
%   length(v) + 2 == length(d), 
%   It's assumed that the first and last term of d will be the first and   
%   last derivative respectively of curve of the v.
%   ip - Number of p to interpenis over a subinterval
    n = numel(x);
    fp1 = y(1); fpn = y(end);
    y = y(2:end-1);
    dx = diff(x);
    dy = diff(y);
    delta = dy./dx;
    sv = clampslopes(dx,delta,fp1,fpn);
    slope1 = delta - dx.*(2*sv(1:end-1))./(6*dx);
    slope2 = sv/2;
    slope3 = ( sv(2:end) - sv(1:end-1))./(6*dx);
%     ip = 20;
    yy = [];
    xk = [];
    for ii = 1:n-1
        xx = linspace( x(ii), x(ii+1), ip);
        xi = repmat(x(ii), 1, ip);
        yy = [ yy ...
            (y(ii) + slope1(ii)*(xx-xi) + slope2(ii)*(xx-xi).^2 + ...
            slope3(ii)*(xx-xi).^3 )
             ];
         xk = [ xk xx ];
    end
end

function [ xk yy ] = spline_free( x,y,ip )
%SPLINE_FREE Free/Natural cubic interpolation.
%   length(x) == length(y)
%   ip - Number of point to interpolate over a subinterval

    n = numel(x);
    dx = diff(x);
    dy = diff(y);
    delta = dy./dx;

    sv = freeslopes(dx,delta);
    slope1 = delta - dx.*( 2*sv(1:end-1) + sv(2:end))/6;    % b
    slope2 = sv/2;                                          % c
    slope3 = ( sv(2:end) - sv(1:end-1))./(6*dx);            % d
%     ip = 20; % Number of point to interpolate over a subinterval
    yy = [];
    xk = [];
    for ii = 1:n-1
        xx = linspace(x(ii), x(ii+1),ip);
        xi = repmat(x(ii), 1, ip);
    %     Taylor series expansion of a cubic
%             a bx cx^2 dx^3
        yy = [ yy ...
            ( y(ii) + slope1(ii)*(xx-xi) + slope2(ii)*(xx-xi).^2 + ...
            slope3(ii)*(xx-xi).^3 )
            ];
        xk = [ xk xx ];
    end

end

function [ sv ] = clampslopes(dx, delta, fp1, fpn)
    n = length(dx)+1;
    
    lo = dx(1:end-1);
    di = 2*( dx(1:end-1) + dx(2:end) );
    hi = dx(2:end);
    A = spdiags([ lo di hi ],[-1 0 1], n-2,n-2);
    R = zeros(n-2,1);
    R(1) = fp1/2 + delta(2) - (3/2)*delta(1);
    R(end) = -.5*fpn + (3/2)*delta(n-1) - delta(n-2);
    R(2:n-3) = delta(3:n-2) - delta(2:n-3);
    sv = A\R;
    b1 = (-3/2)*(fp1/dx(1)) - sv(1)/2 + (3/2)*delta(1)/dx(1);
    bn = 3*(fp1 - delta(end))/dx(end) - sv(end)/2;
    sv = [ b1 ; sv ; bn ];
end

function [ sv ] = freeslopes(dx, delta)
n = length(dx)+1;

lo = dx(1:end-1);
di = 2*( dx(1:end-1) + dx(2:end) );
hi = dx(2:end);

A = spdiags([lo di hi],[-1 0 1],n-2,n-2);
R = 6.*( delta(2:end) - delta(1:end-1));
sv = [ 0 ; A\R ; 0 ];
end
