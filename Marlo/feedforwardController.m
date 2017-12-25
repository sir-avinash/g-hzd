function u = feedforwardController(t,x,response)

while t > response.time{1}(end)
    t = t - response.time{1}(end);
end

[x, u] = response.eval(t);







