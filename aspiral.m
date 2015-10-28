function S = aspiral(n)
    %SPIRAL SPIRAL(n) is an n-by-n matrix with elements
	%   1:n^2 arranged in a rectangular spiral pattern.
    % Usage: S = aspliral(n);
    %        polar(S); or plot(S)
             
    % Enjoy the pretty
	S = [];
	for m = 1:n
        S = rot90(S,2);
        S(m,m) = 0;
        switch(m==1) case true, p = m, otherwise, p = m + (m-1)^2, end
        % No ternary. Sad sad.zer
        v = (m-1:-1:0); % v is a matrix
        S(:,m) = p-v';
        S(m,:) = p+v;
%         display 'ding: cycle complete'
    end
	if mod(n,2)==1
        S = rot90(S,2);
    end
end

