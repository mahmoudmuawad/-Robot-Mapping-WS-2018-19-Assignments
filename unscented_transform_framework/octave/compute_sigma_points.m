function [sigma_points, w_m, w_c] = compute_sigma_points(mu, sigma, lambda, alpha, beta)
% This function samples 2n+1 sigma points from the distribution given by mu and sigma
% according to the unscented transform, where n is the dimensionality of mu.
% Each column of sigma_points should represent one sigma point
% i.e. sigma_points has a dimensionality of nx2n+1.
% The corresponding weights w_m and w_c of the points are computed using lambda, alpha, and beta:
% w_m = [w_m_0, ..., w_m_2n], w_c = [w_c_0, ..., w_c_2n] (i.e. each of size 1x2n+1)
% They are later used to recover the mean and covariance respectively.

n = length(mu);
sigma_points = zeros(n,2*n+1);

% TODO: compute all sigma points
sqrt_p = chol((n+lambda)*sigma, "lower");

sigma_points(:,1) = mu;

for i = 2:n+1
  sigma_points(:, i) = mu + sqrt_p(:, i-1);
  sigma_points(:, n+i) = mu - sqrt_p(:, i-1);
endfor 


% TODO compute weight vectors w_m and w_c
w_m = w_c =zeros(1, 2*n+1);
w_m(1,1) = lambda/(n+lambda);
w_c(1,1) = w_m(1,1) + (1-alpha^2+beta);

for i = 2:2*n+1
  w_m(1, i) = w_c(1, i) = 1/(2*(n+lambda));
endfor

end
