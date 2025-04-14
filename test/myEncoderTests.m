%%% Main test function
function testRes = myEncoderTest
    testRes = functiontests(localfunctions);
end

%%% Setup functions
function setupOnce(testCase)
    testCase.TestData.tol = 1e-10;
    testCase.TestData.sigDim = 1024;
end

%%% Local test functions
%% test helper functions
function testSameSizeValidator(testCase)
    % Check if validation function for same sized vectors is working
    errID = "MidSideProcessor:UnequalSizeVectors";
    cmd = @() mustBeSameSize(ones(10,1), randn(11,1));
    verifyError(testCase, cmd , errID)
end

%% Test Mid/Side encoder
function testStereoInput(testCase)
    % Check if Mid/Side encoder expects stereo input
    errID = "MATLAB:minrhs";
    tstLeft = ones(1024, 1);
    cmd = @() leftright2midside(tstLeft);
    verifyError(testCase, cmd , errID)
end

function testMidSideEqualWithZeroRightInput(testCase)
    % Tests if Mid and Side signals are equal in case the right channel 
    % is set to zero
    tstLeft = ones(testCase.TestData.sigDim, 1);
    tstRight = zeros(size(tstLeft));
    [tstMid, tstSide] = leftright2midside(tstLeft, tstRight);
    verifyEqual(testCase, tstMid, tstSide);
end

function testSideZeroWithEqualLeftRight(testCase)
    % Tests if Mid and Side signals are correctly calculated in cases
    % where the left and right signals are equal
    tstLeft = randn(testCase.TestData.sigDim, 1);
    [tstMid, tstSide] = leftright2midside(tstLeft, tstLeft);
    verifyEqual(testCase, tstMid, tstLeft);
    verifyEqual(testCase, tstSide, zeros(testCase.TestData.sigDim, 1));
end

%% Test Stereo Encoder
function testMidSideInput(testCase)
    % Check if Stereo encoder expects Mid and Side input
    errID = "MATLAB:minrhs";
    tstLeft = ones(testCase.TestData.sigDim, 1);
    cmd = @() midside2leftright(tstLeft);
    verifyError(testCase, cmd , errID)
end

function testLeftRightEqualWithZeroSideInput(testCase)
    % Tests if Mid and Side signals are equal in case the right channel 
    % is set to zero
    tstMid = ones(testCase.TestData.sigDim, 1);
    tstSide = zeros(size(tstMid));
    [tstLeft, tstRight] = midside2leftright(tstMid, tstSide);
    verifyEqual(testCase, tstLeft, tstRight);
end

function testAddLeftRight(testCase)
    % Tests if adding left and right channel results in twice mid channel
    % amplitude
    tstMid = randn(testCase.TestData.sigDim, 1);
    tstSide = randn(testCase.TestData.sigDim, 1);
    [tstLeft, tstRight] = midside2leftright(tstMid, tstSide);
    verifyTrue(testCase, max(abs(tstLeft + tstRight - 2*tstMid)) < testCase.TestData.tol);
end



