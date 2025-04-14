function mustBeSameSize(x, y)
%
% function mustBeSameSize(x, y)
%
% Validation function to ensure input vectors are of similar size

assert(isequal(size(x), size(y)), "MidSideProcessor:UnequalSizeVectors", "Inputs must be the same size");

end

