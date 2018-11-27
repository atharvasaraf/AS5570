function [a_p, L1] = l1_guidance(X, traj, L1, update, wind)
    x = X(1); y = X(2); xdot = X(3); ydot = X(4);
    n_points = size(traj); n_points = n_points(2);

    % distance from all points on trajectory
    dist_frm_traj = zeros(1,n_points);
    for i = 1:n_points
        dist_frm_traj(1,i) = ((x - traj(1,i))^2 + (y - traj(2,i))^2)^0.5;
    end
    
    % getting point closest to L1 distance
    candidate_points = find(dist_frm_traj <= L1);
    ref_point_index = max(candidate_points);
    ref_point = [traj(1,ref_point_index), traj(2,ref_point_index)];
    
    % getting eta
    theta = atan2((ref_point(2) - y),(ref_point(1) - x));
    alpha_p = atan2((ydot+ wind(2)),(xdot+wind(1)));
    V = ((xdot+wind(1))^2 + (ydot+wind(2))^2)^0.5;
    eta = alpha_p - theta;
    
      % when it switches to next circle
      if ref_point_index >= 100
          lam = 1.0089; R = 3;
          L1 = 2*V*R/(V^2 + (2*R*lam)^2)^0.5;
      end
    
    if update == true
        plot([X(1), ref_point(1)], [X(2), ref_point(2)], 'm')
        plot(X(1), X(2), 'sr')
        plot(ref_point(1), ref_point(2), 'og')
    end
    
    a_p = 2*(V^2)*sin(eta)/L1;
end