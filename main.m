
f = @(X1,X2) X1.^2 + 4*X2.^2-4*X1-8*X2; % defining functions
rondf1 = @(x1, x2) 2*x1 - 4;
rondf2 = @(x1, x2) 8*x2 - 8;

res = gd(f,rondf1,rondf2, [0;0], 0.1, [-3,7; -3,5]);

H = @(x1, x2) [2 0; 0 8];
newton(f, rondf1, rondf2, H,[0;0], 1, [-3,7; -3,5]);

%%
f =     @(x1,x2) x1.^4 + x1.*x2 + (1+x2).^2;
g1 =    @(x1,x2) 4*(x1.^3) + x2;
g2 =    @(x1,x2) x1 + (2*x2) + 2;
H =     @(x1, x2) [12*(x1.^2) 1; 1 2];

res = newton(f, g1, g2, H,[0.75; -1.25], 1, [ -1,2;-3,0]);

res = newton(f, g1, g2, H,[0;0], 1, [ -1,2;-3,0]);

res = newgd(f, g1, g2, H,[0;0], 0.1, [ -1,2;-3,0]);

res = newton(f, g1, g2, H,[0;0], 1, [ -1,2;-3,0], 'modified');

%%
f =     @(x1,x2) 10 * x1.^2 + x2.^2;
g1 =    @(x1,x2) 20*x1;
g2 =    @(x1,x2) 2*x2;
H =     @(x1, x2) [20 0; 0 2];
res = quasiNewton(f, g1, g2, H,[0.1;1], 0.1, [ -2,2;-2,2], 'SR1');
res = quasiNewton(f, g1, g2, H,[0.1;1], 0.1, [ -2,2;-2,2], 'DFP');
res = quasiNewton(f, g1, g2, H,[0.1;1], 0.1, [ -2,2;-2,2], 'BFGS');
res = gd_fr(f, g1, g2,[0.1;1], 0.01, [ -2,2;-2,2]);
