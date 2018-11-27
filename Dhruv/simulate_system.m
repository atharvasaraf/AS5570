function [state, L1] = simulate_system(X0, tspan, traj, L1)
    state = X0'; X = X0; t = tspan(1); tol = 1e-3;
    dt_inv = 1000;
    for i = 1:(tspan(2)-tspan(1))*dt_inv
        x = X(1); y = X(2); xdot = X(3); ydot = X(4);
        update = false;
        if  t - floor(t) <= tol
            update = false;
        end
        [Xdot,L1] = model(X, traj, L1, update);
        x_new = x + Xdot(1)/dt_inv;
        y_new = y + Xdot(2)/dt_inv;
        xdot_new = xdot + Xdot(3)/dt_inv;
        ydot_new = ydot + Xdot(4)/dt_inv;
        X = [x_new; y_new; xdot_new; ydot_new];
        state = [state;X']; t = t + dt_inv^-1;
    end
end