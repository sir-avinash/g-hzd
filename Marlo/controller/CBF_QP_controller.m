function u=CBF_QP_controller(y_angle,dy_angle,Lf2y_angle,LgLfy_angle,gb,Lf_gb,Lg_gb,Lf_a_com,Lg_a_com,controller)
% Exponential CBF-CLF-QP controller

        % calculate necessary terms for CLF    
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
        
            u_star=LgLfy_angle\(-Lf2y_angle);
         
        % Calculate necessary terms for CBF
        % condition: dgb+gamma*gb >= 0
        % Lf_gb+gamma*gb+Lg_gb*(u_star+inv(LgLfy_angle)*mu)>= 0
        % => psi0_b+psi1_b*mu <=0
        gamma=controller.CBF_gamma;
        if controller.Exp_CBF 
            p=1; % 1= Exp cbf; 3=reciprocal CBF
        else
            p=3;
        end
        psi0_b=-(Lf_gb+gamma*gb.^p+Lg_gb*u_star);
        psi1_b=-Lg_gb/LgLfy_angle;
       
            
            %% Implement CBF-QP controller
%         inv_LgLfH=inv(LgLfy_angle);
        H_qp = diag([1 1 1 1 controller.p1]) ; % cost function always \mu'*\mu
        f = zeros(size(H_qp,1), 1) ;        

        Aqp=[psi1' -1;
%             psi1_b zeros(3,1);
%            psi1_b(1,:) zeros(1,1);
%            psi1_b(2,:) zeros(1,1);
%          inv(LgLfy_angle) zeros(4,1);
%          -inv(LgLfy_angle) zeros(4,1);
         ];
         
        bqp=[-psi0;
%              -psi0_b;
%             -psi0_b(1);
%             -psi0_b(2);
%             controller.u_max-u_star;
%             u_star-controller.u_min;
            ];
        if controller.CBF_stepping_stone_constraint
            Aqp=[Aqp;
                psi1_b(1,:) zeros(1,1);
                psi1_b(2,:) zeros(1,1);
                ];
            bqp=[bqp;
                -psi0_b(1);
                -psi0_b(2);
                ];
        end
        
        if controller.CBF_friction_constraint
       % add constraint on friction coefficient
        delta_a = controller.friction_delta_a;%5;
        kf=controller.friction_kf;%0.16;% nominal -0.13 < F/N <0.16
        % abs (F_f/N) <= kf (kf=2/3)
        % => (F_f < kf*N) && (F_f > -kf*N)
        % => Lf_a_com(1)+Lg_a_com(1)*u < kf*(Lf_a_com(2)+Lg_a_com(2)*u+g)
        % => (Lg_a_com(1)-kf*Lg_a_com(2))*(u_star+ inv_LgLfH*mu)< kf*(Lf_a_com(2)+g)-Lf_a_com(1)
        % => A=(Lg_a_com(1)-kf*Lg_a_com(2))*inv_LgLfH*mu
        %    b= kf*(Lf_a_com(2)+g)-Lf_a_com(1)-(Lg_a_com(1)-kf*Lg_a_com(2))*u_star
                
        %(F_f > -kf*N)
        % => Lf_a_com(1)+Lg_a_com(1)*u > -kf*(Lf_a_com(2)+Lg_a_com(2)*u+g)
        % => (Lg_a_com(1)+kf*Lg_a_com(2))*(u_star+ inv_LgLfH*mu)> -kf*(Lf_a_com(2)+g)-Lf_a_com(1)
        % => A=-(Lg_a_com(1)+kf*Lg_a_com(2))*inv_LgLfH*mu
        %    b= kf*(Lf_a_com(2)+g)+Lf_a_com(1)+(Lg_a_com(1)+kf*Lg_a_com(2))*u_star
        inv_LgLfH=inv(LgLfy_angle);
        psi1_friction = [-Lg_a_com(2,:)*inv_LgLfH;
                          (Lg_a_com(1,:)-kf*Lg_a_com(2,:))*inv_LgLfH;
                         -(Lg_a_com(1,:)+kf*Lg_a_com(2,:))*inv_LgLfH];
                 
        psi0_friction =[-(Lf_a_com(2,:)+9.81-delta_a+ Lg_a_com(2,:)*u_star);% add 9.81-delta for a threshold of vertical contact force
                       -(kf*(Lf_a_com(2,:)+9.81)-Lf_a_com(1,:)-(Lg_a_com(1,:)-kf*Lg_a_com(2,:))*u_star);
                       -(kf*(Lf_a_com(2,:)+9.81)+Lf_a_com(1,:)+(Lg_a_com(1,:)+kf*Lg_a_com(2,:))*u_star)];
        
        Aqp=[Aqp;
            psi1_friction zeros(3,1)];
        bqp=[bqp;
            -psi0_friction];
        H_qp = diag([1 1 1 1 controller.p1]) ; % cost function always \mu'*\mu
        f = zeros(size(H_qp,1), 1) ;        

%         Aqp=[psi1' -1;
%             psi1_b -zeros(2,1);
%             psi1_friction zeros(3,1);
% %          inv(LgLfy_angle) zeros(4,1);
% %          -inv(LgLfy_angle) zeros(4,1);
%          ];
%          
%         bqp=[-psi0;
%              -psi0_b;
%              -psi0_friction;
% %             controller.u_max-u_star;
% %             u_star-controller.u_min;
%             ];
        
        end
        
       if controller.CBF_soft_saturation
           Aqp=[Aqp;
               inv(LgLfy_angle) zeros(4,1);
               -inv(LgLfy_angle) zeros(4,1);
               ];
           
           bqp=[bqp;
               controller.u_max-u_star;
               u_star-controller.u_min;
               ];
       end
        opts = optimset('largescale','off','Display','off');
        [x_qp, fval, qp_exitflag] = quadprog(H_qp,f,Aqp,bqp,[],[],[],[],[],opts) ;
        mu = x_qp(1:4) ;
        
%         if qp_exitflag ~= 1
%             qp_exitflag
% %           mu
%         end

        v = inv(LgLfy_angle)*mu ;
        u = u_star + v;  
       
