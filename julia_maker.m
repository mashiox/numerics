function julia_maker_updated( cr, ci, Rg, Npts, M )
%%%%%%%%%%%%%%%%%
% Naming this function with the suffix _updated in order to distinguish it 
% from the turned in addendum and the originally turned in work. 
% both are present on Google Drive.
%%%%%%%%%%%%%%%%%
% For the the map f(z) = z^2 + c, we have: 
% c = cr + 1i*ci,
% |zr|<= Rg, |zi|<= Rg,
% Npts^2 is the number of z points you want to iterate over, or Npts per
% side of the rectangle defined by Rg.
% M is the bound that defines the map J_M(z).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function actually computes the map J_M(z), i.e. we find the number
% of iterations it takes to reach the bound M.
    function total = kernel(z,c,M)        
          % Initialize the total number of iterations
          f = @(z1) z1^2 + c;
          index = 0;
          %z_n = f(z) + c;
          while( abs(z) < M ) % You need to add a condition which tells us when to stop.  
              % Given |z| < M, we'll continue to iterate.
              z = f(z) + c;
              % We update the iteration count.
              index = index + 1; % no ++ opr, ;__;
          end
          total = index;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % You need to figure out how to make points along the X-axis.
    X = linspace(-Rg,Rg,Npts);
    % Figured symmetry was still cool.
    Y = X;
    % Define a matrix to hold the totals from the kernel function.
    julia_set = zeros(length(X), length(Y));
    % I don't know if empty zeros() was slowing this down. It's suspect.
    
    c = (cr+1i*ci);
    for ii=1:length(X)
        for jj=1:length(Y)
            julia_set(ii,jj) = kernel( (X(ii) + 1i*Y(jj)), c, M); %You need to figure out how to pass z, c, and M here.
        end
    end
    % Plot a top down view of the count over the complex plane.
    imagesc(X,Y,julia_set')
    
end

