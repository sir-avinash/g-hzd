function createBusObject(S, BusName)
    BusInfo = Simulink.Bus.createObject(S);
    assignin('base', BusName, evalin('base', BusInfo.busName))
end
