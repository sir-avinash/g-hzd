function u=CLF_QP_controller(y_angle,dy_angle,Lf2y_angle,LgLfy_angle,controller)
            F = [zeros(4), eye(4);
                 zeros(4), zeros(4)];
            G = [zeros(4);
                 eye(4)];
        
            eta = [y_angle;  dy_angle];
            P=controller.P;
            Q=controller.Q;

            V = transpose(eta)*P*eta;
            LfV = transpose(eta)*(transpose(F)*P+P*F)*eta;
        
            LgV = 2*(G'*P)*eta;
            
            psi0 = LfV + transpose(eta)*Q*eta; %controller.gamma*V;
            psi1 = LgV;
        
        %Implement CLF-QP controller
        
        H_qp = diag([1 1 1 1]) ; % cost function always \mu'*\mu
        f = zeros(size(H_qp,1), 1) ;
        
        Aqp= psi1'; 
        bqp= -psi0;        
        opts = optimset('largescale','off','Display','off');
% opts = optimset('Display','off');
        [x_qp, fval, qp_exitflag] = quadprog(H_qp,f,Aqp,bqp,[],[],[],[],[],opts) ;
        mu = x_qp(1:4) ;
        
        if qp_exitflag ~= 1
            qp_exitflag
%           mu
        end
        
        v = LgLfy_angle\mu ;
        u_star=LgLfy_angle\(-Lf2y_angle);
        u = u_star + v;  
%         CLF=V
        