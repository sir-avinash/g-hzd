function rewindCallback(this, varargin)
%REWINDCALLBACK Rewind callback function.
%
% Copyright 2013-2014 Mikhail S. Jones

    % Update frame counter
    this.state.currentTime = this.scene.startTime;

    % Update seekbar slider and text to current frame
    set(this.handles.seekBarSlider, 'Value', this.state.currentTime);
    set(this.handles.seekBarText, 'String', ['Seek Bar: ' num2str(this.state.currentTime) ' / ' num2str(this.scene.endTime)]);

    % Draw scene at current frame
    this.scene.update(this.state.currentTime);
end % rewindCallback
