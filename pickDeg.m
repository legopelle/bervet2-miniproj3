%% Data import

[time,nh_mx,nh_sd,nhc,sh_mx,sh_sd,shc,gl_mx,gl_sd,glc,nhsh] ...
    = importfile('Old_GC_Globals_2001_prn.txt');

data = sh_mx;

%% Zero removal

nz = find(data ~= 0); % Returns indicies of nonzero value
x = time(nz); % Corresponding regressor
y = data(nz); % and response

%% Loop

N = length(x);
var = zeros(1,6);
for M=1:6
    
    
    % Fitting
    p = polyfit(x, y, M);
    r_sq = sum((y-polyval(p,x)).^2); % Sum of square of residuals
    
    % Metric
    var(M) = r_sq / (N - M - 1);
    
end

plot(1:6, var);
title('Varians för olika polynomgrad');
xlabel('Polynomgrad');
ylabel('Varians');