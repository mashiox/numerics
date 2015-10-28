function [ quads ] = splineSampleDriver( F, a, b, varargin )
%PROBLEM2DRIVER Evaluate definite integral numrically.
%   quads = PROBLEM2DRIVER(F, a, b) approximate integral of F(x) from a to
%   b via a spline interpolation 25 times with 20:25*20 interpolation
%   points.
% 
%   quads = PROBLEM2DRIVER(F, a, b, n) approximate integral of F(x) from a to
%   b via a spline interpolation 25 times with n:25*n interpolation
%   points.
% 
%   quads = PROBLEM2DRIVER(F, a, b, n, ip) approximate integral of F(x) from a to
%   b via a spline interpolation 25 times with n:ip*n interpolation
%   points.
% 
%   quads = PROBLEM2DRIVER(F, a, b, n, ip, it) approximate integral of F(x) from a to
%   b via a spline interpolation it times with n:ip*n interpolation
%   points.

switch nargin
    case 5
        n = varargin{1};
        ip = 20;
        it = 25;
    case 6
        n = varargin{1};
        ip = varargin{2};
        it = 25;
    case 7
        n = varargin{1};
        ip = varargin{2};
        it = varargin{3};
    otherwise
        n = 20;
        ip = 50;
        it = 25;
end
N = 1:it;
exact = integral(F,a,b);
quads = zeros(1,it);
for ii = N
    quads(ii) = engine(F, a, b, ii*n, ip);
end

error = abs(quads - exact);
loglog(N,error);
xlabel('log(N)')
ylabel('log(Q - Exact)');
disp('Min/Max Error');
disp(sprintf('Min: %d\nMax: %d',min(error),max(error)));
end

function [ Q ] = engine( F, a, b, varargin )
%ENGINE VROOM VROOOOOOM
%   Gotta go fast!

switch nargin
    case 4
        n = varargin{1};
        ip = 20;
    case 5
        n = varargin{1};
        ip = varargin{2};
    otherwise
        n = 20;
        ip = 50;
end
    
x = linspace(a,b,n);
y = F(x);

[xspl yspl] = myspline(x,y,ip);
Q = quadspline(xspl, yspl);

end

