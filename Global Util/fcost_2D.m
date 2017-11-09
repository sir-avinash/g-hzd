function J = fcost_2D(alpha_0,s_u, s_v ,q_act)


S = reshape(alpha_0, sqrt(length(alpha_0)), sqrt(length(alpha_0)));
hd = bezierpatchinterp(S,s_u,s_v)';

[~, J] = rsquare(q_act,hd);