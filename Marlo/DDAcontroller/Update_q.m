function [q, dq, qHip, dqHip, qLegS, dqLegS, qLegS_prev, dqLegS_prev, qRoll,dqRoll,qSpringDef] = Update_q(q,dq,ControlState,ControlParams)

qSpringKA = [0 0 0  1 -1  0  0 -1 1 0  0 0 0;
             0 0 0  0  0  1 -1  0 0 0 -1 1 0]*q;


if ControlParams.Supervisory.ForBackward ~= 1   % if walk backward

        q = [pi;zeros(2,1);2*pi*ones(6,1);0;2*pi*ones(2,1);0]-q([1;2;3;5;4;7;6;9;8;10;12;11;13]);
        q(10) = -q(10);
        q(13) = -q(13);
        dq = -dq([1;2;3;5;4;7;6;9;8;10;12;11;13]);
        dq(10) = -dq(10);
        dq(13) = -dq(13);
        
    if ControlState.StanceLeg == 0
        qHip = q([10 13]);
        dqHip = dq([10 13]);
        qLegS = q([3 4 5]);
        dqLegS = dq([3 4 5]);
        qLegS_prev = q([3,6,7]);
        dqLegS_prev = dq([3,6,7]);
        qRoll = q(2);
        dqRoll = dq(2);
        qSpringDef = qSpringKA([1,2]);
        q = q([3 8 9 11 12]);
        dq = dq([3 8 9 11 12]);
    else
        qHip = q([13 10]);
        dqHip = dq([13 10]);
        qLegS = q([3 6 7]);
        dqLegS = dq([3 6 7]);
        qLegS_prev = q([3,4,5]);
        dqLegS_prev = dq([3,4,5]);
        qRoll = q(2);
        dqRoll = -dq(2);
        qSpringDef = qSpringKA([2,1]);
        q = q([3 11 12 8 9]);
        dq = dq([3 11 12 8 9]);
    end
        
else
    if ControlState.StanceLeg == 0
        qHip = q([10 13]);
        dqHip = dq([10 13]);
        qLegS = q([3 4 5]);
        dqLegS = dq([3 4 5]);
        qLegS_prev = q([3,6,7]);
        dqLegS_prev = dq([3,6,7]);
        qRoll = q(2);
        dqRoll = dq(2);
        qSpringDef = qSpringKA([1,2]);
        q = q([3 8 9 11 12]);
        dq = dq([3 8 9 11 12]);
    else
        qHip = q([13 10]);
        dqHip = dq([13 10]);
        qLegS = q([3 6 7]);
        dqLegS = dq([3 6 7]);
        qLegS_prev = q([3,4,5]);
        dqLegS_prev = dq([3,4,5]);
        qRoll = -q(2);
        dqRoll = -dq(2);
        qSpringDef = qSpringKA([2,1]);
        q = q([3 11 12 8 9]);
        dq = dq([3 11 12 8 9]);
    end

end

