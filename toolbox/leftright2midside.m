function [sndMid, sndSide] = leftright2midside(sndLeft, sndRight)

% 
% function [sndMid, sndSide] = leftright2midside(sndLeft, sndRight)
%
% Converts audio supplied as a stereo signal into audio represented by a 
% Mid/Side signal. % See e.g. https://en.wikipedia.org/...
% wiki/Stereophonic_sound#M/S_technique:_mid/side_stereophony
%
% ToDo: Allow stereo input with one argument of dimension (:, 2)
%
% input params: 
%   sndLeft......Left stereo channel given as a vector
%   sndRight.....Right stereo channel given as a vector
%
% output params:
%   sndMid.....Mid signal derived from stereo input
%   sndSide.....Side signal derived from stereo input


arguments
    sndLeft double {mustBeVector}
    sndRight double {mustBeVector, mustBeSameSize(sndLeft, sndRight)}
end

sndMid = (sndLeft + sndRight) / 2;
sndSide = (sndLeft - sndRight) / 2;

end



    

