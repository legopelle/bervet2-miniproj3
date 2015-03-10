clear;

%% Constants
M = 5; % Polynomial degree

%% Data import
[time,nh_mx,nh_sd,nhc,sh_mx,sh_sd,shc,gl_mx,gl_sd,glc,nhsh] ...
    = importfile('Old_GC_Globals_2001_prn.txt');

data = sh_mx;

%% Zero removal

nz = find(data ~= 0); % Returns indicies of nonzero value
x = time(nz); % Corresponding regressor
y = data(nz); % and response
N = length(x); % Number of data points

%% Fitting

[p, ~, mu] = polyfit(x, y, M);% Fit a polynomial of degree M
r_sq = sum((polyval(p,x,[],mu)-y).^2); % Calculate sum of residuals squared

%% Detrend

mx_det = zeros(1,length(data)); % Allocate detrended data
y_det = y - polyval(p, x, [], mu); % Subtract trend
mx_det(nz) = y_det; % Assign non-zero values

%% Monthly means

sum_months = zeros(1,12);
numval = zeros(1,12);

for i=1:12
    for j=i:12:N
        if (mx_det(j) ~= 0)
            sum_months(i) = sum_months(i) + mx_det(j);
            numval(i) = numval(i) + 1;
        end
    end
end

months_avg = sum_months ./ numval;

plot(1:12,months_avg);
title('Medelvärde av avtrendifierad N2O under året');
xlabel('Månad')
ylabel('Mängd N2O')