function [x] = newton(f, g1, g2, H, startPoint, alpha, space, method)
    
    if ~exist('method', 'var')
        method = 'simple';
    end

    x = startPoint;
    x_old = [-1,-1];

    % visualization
    [X1,X2] = meshgrid(linspace(space(1,1),space(1,2),401),linspace(space(2,1),space(2,2),401));
    Z = f(X1,X2);
    contour(X1,X2,Z)
    hold on

    all_x = [x];

    while abs(x(1) - x_old(1)) > 0.00001 || abs(x(2) - x_old(2)) > 0.00001 

        x_old = x;
        
        hess = H(x(1), x(2));
        
        if(method == "modified")
            Hinv = inv(hess + eye(size(hess)));
        else
            Hinv = inv(hess);
        end
        g = [g1(x(1),x(2)); g2(x(1),x(2))];
        p = - Hinv * g;
        x = x + alpha * p;

        %data for ploting the movement
        all_x=[all_x, x];

        plot(all_x(1,:),all_x(2,:), '-o');    % plotting the traversed paths

    end

    hold off

end

