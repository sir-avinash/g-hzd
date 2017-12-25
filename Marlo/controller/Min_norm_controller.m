function u=Min_norm_controller(y_angle,dy_angle,Lf2y_angle,LgLfy_angle,controller)
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

        %Implement pointwise min-norm control
        
        if psi0 > 0
            if transpose(psi1)*psi1 > 0
                mu = -(psi0*psi1)/(transpose(psi1)*psi1);
            else
                mu = zeros(4,1);
                %disp('psi1 = 0')
            end
        else
            mu = zeros(4,1);
            %disp('psi0 <= 0')
        end
        
        v = LgLfy_angle\mu ;
        u_star=LgLfy_angle\(-Lf2y_angle);
        u = u_star + v;  