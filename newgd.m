function [x] = newgd(f, g1, g2, H, startPoint, alpha, space)
   
    x = startPoint;
    x_old = [-1,-1];

    % visualization
    [X1,X2] = meshgrid(linspace(space(1,1),space(1,2),401),linspace(space(2,1),space(2,2),401));
    Z = f(X1,X2);
    contour(X1,X2,Z)
    hold on

    all_x = [x];
    
    goToGd = 0;
    
    while max(abs(x - x_old)) > 0.001

        x_old = x;
        fx_old = f(x(1), x(2));
        
        hess = H(x(1), x(2));
        Hinv = inv(hess);
        
        g = [g1(x(1),x(2)); g2(x(1),x(2))];
        p = - Hinv * g;
        xNew = x + p;
        
         if (fx_old < f(xNew(1), xNew(2)))
            x = x - (alpha * g);
         else
             x = xNew;
         end
        
         
        %data for ploting the movement
        all_x=[all_x, x];

        plot(all_x(1,:),all_x(2,:), '-o');    % plotting the traversed paths
        
       
    end

    hold off
    
    
end

