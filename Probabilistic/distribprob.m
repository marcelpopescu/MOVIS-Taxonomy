function p = distribprob(miu1,sigma1,miu2,sigma2)

step = 1e-4;

x = -10:step:10;
% Normal distribution
f1 = 1/(sqrt(2*pi)*sigma1).*exp((-1)/(2*sigma1^2).*(x-miu1).^2);

%Normal distribution
f2 = 1/(sqrt(2*pi)*sigma2).*exp((-1)/(2*sigma2^2).*(x-miu2).^2);
f2 = f2./max(f2);

%  p = sum(f1.*f2*step);
p = sum(f1.*f2);

