
% Playback of audio file and introduce Mid/Side effect
% See https://www.mathworks.com/help/audio/gs/real-time-audio-in-matlab.html

%% Setup audio file read and audio output device
frameLength = 2048;
fileReader = dsp.AudioFileReader(...
    ".\data\FunkyDrums-44p1-stereo-25secs.mp3", ...
    "SamplesPerFrame", frameLength);
deviceWriter = audioDeviceWriter(...
    "SampleRate", fileReader.SampleRate)

%% Setup GUI
fig = uifigure()
sl = uislider(fig, "Limits", [0, 3], "Orientation", "vertical")

%% Do the processing
while (~isDone(fileReader))
    signal = fileReader();
    [sndMid, sndSide] = leftright2midside(signal(:,1), signal(:,2));
    drawnow()
    [sndLeft, sndRight] = midside2leftright(sndMid, sl.Value * sndSide);
    deviceWriter([sndLeft, sndRight]);
end

%% Clean up
close(fig)
release(fileReader)
release(deviceWriter)

