function [x] = quasiNewton(f, g1, g2, Hin, startPoint, alpha, space, method)

    % visualization
    [X1,X2] = meshgrid(linspace(space(1,1),space(1,2),401),linspace(space(2,1),space(2,2),401));
    Z = f(X1,X2);
    contour(X1,X2,Z)
    hold on

    x = startPoint;
    B = eye(2);
    all_x = [x];
    
%     H = Hin(x(1), x(2));
    H = eye(2);
    g = [g1(x(1),x(2)); g2(x(1),x(2))];
    p = - H * g;
    x_old = x;
    x = x + alpha * p;
    
    all_x = [all_x x];
    counter=0;
    
    while max(abs(x - x_old)) > 0.001
        y = [g1(x(1),x(2)); g2(x(1),x(2))] - [g1(x_old(1),x_old(2)); g2(x_old(1),x_old(2))];;
        p = x - x_old;
        
        if method == "SR1"
            H = H + ((p - H*y)*(p - H*y)')/((p - H*y)' * y);
        elseif method == "DFP"
            H = H - (H*y*y'*H)/(y'*H*y) + (p*p')/(y'*p);
        elseif method == "BFGS"
            gamma = 1/(y'*p);
            H = (eye(2) - gamma*p*y')*H*(eye(2)-gamma*y*p') + gamma*(p*p');
        else
            error("Wrong input method")
        end
        
        g = [g1(x(1),x(2)); g2(x(1),x(2))];
        p = - H * g;
        x_old = x;
        x = x + alpha * p;
        
        %data for ploting the movement
        all_x=[all_x x];

        plot(all_x(1,:),all_x(2,:), '-o');    % plotting the traversed paths
        
        counter = counter+1;
    end
    counter
    hold off
end

