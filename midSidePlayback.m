
% Playback of audio file and introduce Mid/Side effect
% See https://www.mathworks.com/help/audio/gs/real-time-audio-in-matlab.html

%% Setup audio file read and audio output device
frameLength = 2048;
fileReader = dsp.AudioFileReader(...
    ".\data\FunkyDrums-44p1-stereo-25secs.mp3", ...
    "SamplesPerFrame", frameLength);
deviceWriter = audioDeviceWriter(...
    "SampleRate", fileReader.SampleRate)

%% Setup scope
scope = timescope(...
    "SampleRate", fileReader.SampleRate, ...
    "TimeSpan", 2, ...
    "BufferLength", fileReader.SampleRate*2*2,...
    "YLimits", [-1, 1], ...
    "TimeSpanOverrunAction", "Scroll")


%% Setup GUI
fig = uifigure()
sl = uiknob(fig, "Limits", [0, 3], "Value", 1);

%% Do the processing
while (~isDone(fileReader))
    signal = fileReader();
    [sndMid, sndSide] = leftright2midside(signal(:,1), signal(:,2));
    drawnow()
    [sndLeft, sndRight] = midside2leftright(sndMid, sl.Value * sndSide);
    deviceWriter([sndLeft, sndRight]);
    scope(sndLeft, sndRight)
end

%% Clean up
close(fig)
release(fileReader)
release(deviceWriter)
release(scope)
