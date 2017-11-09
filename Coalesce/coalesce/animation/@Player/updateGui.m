function updateGui(this, stepLength, stepHeight, shape)
%UPDATEGUI Update graphical user
%
% Copyright 2013-2014 Mikhail S. Jones

    % Set state variables and options
    this.state.totalTime = this.scene.endTime;
    this.options.speed = 1;
    this.options.video.startTime = this.scene.startTime;
    this.options.video.endTime = this.state.totalTime;

    % Reset axes
    this.handles.axes = axes(...
        'Units', 'pixels', ...
        'OuterPosition', this.options.size + [50 50 2 2], ...
        'Position', this.options.size + [50 50 2 2], ...
        'DataAspectRatio', [1, 1, 1], ...
        'NextPlot', 'add', ...
        'Parent', this.handles.fig);

    % Reset user interface
    set(this.handles.fig, 'KeyPressFcn', @this.keyPressCallback);
    set(this.handles.seekBarSlider, ...
        'Min', this.scene.startTime, ...
        'Max', this.scene.endTime, ...
        'SliderStep', [1/30 1], ...
        'Enable', 'on');
    set(this.handles.uimenu.saveAs, 'Enable', 'on');
    set(this.handles.uimenu.playback, 'Enable', 'on');
    set(this.handles.uimenu.video, 'Enable', 'on');

    % Initialize scene
    this.scene.initialize(stepLength, stepHeight, shape);
    this.scene.update(this.scene.startTime);
end % updateGui
