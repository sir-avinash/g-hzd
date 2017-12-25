function checkData(filename,Nstep)
load(filename);

if Nstep == 1
    t1span = linspace(0,t1,25);
    figure(101)
    plot(t1span,[y1,dy1,ddy1])
elseif Nstep == 5
    t1span = linspace(0,t1,25);
    t2span = linspace(0,t2,25);
    t3span = linspace(0,t3,25);
    t4span = linspace(0,t4,25);
    t5span = linspace(0,t5,25);
    
    figure(101)
    plot(t1span,[y1,dy1,ddy1])

    figure(102)
    plot(t2span,[y2,dy2,ddy2])

    figure(103)
    plot(t4span,[y4,dy4,ddy4])

    figure(104)
    plot(t3span,[y3,dy3,ddy3])

    figure(105)
    plot(t5span,[y5,dy5,ddy5])
end





