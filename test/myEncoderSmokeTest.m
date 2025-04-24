%%% This is a test script to verify everything is in place to 
% run simple audio processing and our Mid/Side encoder


%% Is the Audio Toolbox installed and enabled
allAddons = matlab.addons.installedAddons;
audioTbxLic = allAddons(allAddons.Name == "Audio Toolbox", :);
assert(audioTbxLic.Enabled);

%% Does encoding and decoding a random signal lead to the inital signal 
% values
sigDim = 2048;
tol = 1e-10;

sndLeft = randn(2048, 1);
sndRight = randn(2048, 1);

[sndMid, sndSide] = leftright2midside(sndLeft, sndRight);
[encodedLeft, encodedRight] = midside2leftright(sndMid, sndSide);

assert(max(abs(encodedLeft-sndLeft)) < tol);
assert(max(abs(encodedRight-sndRight)) < tol);

