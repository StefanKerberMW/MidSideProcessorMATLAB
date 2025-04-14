function [sndLeft, sndRight] = midside2leftright(sndMid, sndSide)

% 
% function [sndLeft, sndRight] = midside2leftright(sndMid, sndSide)
%
% Converts audio supplied as a Mid/Side signal into audio represented by a 
% stereo signal. % See e.g. https://en.wikipedia.org/...
% wiki/Stereophonic_sound#M/S_technique:_mid/side_stereophony
%
% ToDo: Allow mid/side input with one argument of dimension (:, 2)
%
% input params:
%   sndMid.....Mid signal derived from stereo input
%   sndSide.....Side signal derived from stereo input
% output params: 
%   sndLeft......Left stereo channel given as a vector
%   sndRight.....Right stereo channel given as a vector


arguments
    sndMid double {mustBeVector}
    sndSide double {mustBeVector, mustBeSameSize(sndMid, sndSide)}
end


sndLeft = (sndMid + sndSide);
sndRight = (sndMid - sndSide);


end



    