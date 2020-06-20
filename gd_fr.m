function [x] = gd_fr(f, rondf1,rondf2, startPoint, alpha, space)

lr = alpha;   %learning rate

x = startPoint;

x_old = [-1; -1];

% visualization
[X1,X2] = meshgrid(linspace(space(1,1),space(1,2),401),linspace(space(2,1),space(2,2),401));
Z = f(X1,X2);
contour(X1,X2,Z)
hold on

all_x = [x];

%initialization
g = [-rondf1(x(1), x(2)); -rondf2(x(1),x(2))];
p=[rondf1(x(1), x(2)); rondf2(x(1),x(2))];
beta = 1;

% Steepest Descent Alg
while max(abs(x - x_old)) > 0.001
    
    x_old = x;
    g_old = g;
    x = x + alpha*p;
    
    g = [rondf1(x(1), x(2)); rondf2(x(1),x(2))];
    p = -g + beta*p;
        
    beta = norm(g)^2/norm(g_old)^2;
    
    %data for ploting the movement
    all_x = [all_x x];
    
    plot(all_x(1,:),all_x(2,:), '-o');    % plotting the traversed paths
    
end

hold off

end

