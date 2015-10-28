function F = sierpinski(varargin)
% Just run it(TM)
showstep = (nargin >= 1) && ischar(varargin{end});
if showstep || (nargout == 0)
   clf
   shg
   set(gcf,'menubar','none','numbertitle','off','name','It`s Dangerous to go alone!', ...
       'color','white')
   darkgreen = [0 2/3 0];
   darkred = [2/3 0 0];
end
if showstep
   finish = uicontrol('style','toggle','string','finish', ...
      'value',0,'background','white');
end
if (nargin >= 1) && ~ischar(varargin{1})
   n = varargin{1};
else
   n = 100000;
end


A = [ .5 0 ; 0 .5 ];
b1 = [ 0 ; 0 ];
b2 = [ .5 ; .5 ];
b3 = [ .25 ; (sqrt(3)/4) ];

x = [ 0 ; 0 ];
xs = zeros(2,n);
xs(:,1) = x;
for j = 2:n
   r = floor(3*rand);
   if r == 0
      x = A*x + b1;
   elseif r == 1
      x = A*x + b2;
%       x = [cos(pi/6) -sin(pi/6) ; sin(pi/6) cos(pi/6)]*x;
   else % r is 2, or something exploded.
      x = A*x + b3;
%       x = [cos(-pi/3) -sin(-pi/3) ; sin(-pi/3) cos(-pi/3)]*x;
   end
%       x(2) = x(2) - x(1); 
% I want to believe.
%     x = [ 0.7071 -0.7071 ; 0.7071 0.7071 ]*x;
%     x = [0 -1 ; 1 0]*x;
    
   xs(:,j) = x;
end

plot(xs(1,:),xs(2,:),'.','markersize',1,'color',darkgreen);
axis([0 1 0 1])
axis on
