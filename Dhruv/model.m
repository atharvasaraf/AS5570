function [Xdot,L1] = model(X, traj, L1, update)
   xdot = X(3); ydot = X(4);
   
   % heading angle
   alpha_p = atan2(ydot,xdot);
   
   wind = [0, -2];
   [a_p,L1] = l1_guidance(X, traj, L1, update, wind);

   xddot = a_p*sin(alpha_p);
   yddot = -a_p*cos(alpha_p);
   
   Xdot = [xdot + wind(1); ydot + wind(2); xddot; yddot];
end
