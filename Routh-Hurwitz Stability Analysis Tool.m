% INITIAL CLEANUP
clear all;
clc;

% INSERT CHARACTERISTIC EQUATION HERE
charEqCoeffs = [1 3 3 1];
% charEqCoeffs = input("");

% NUMBER OF COEFFICIENTS
numCoeffs = numel(charEqCoeffs);

% CHECK IF THE NUMBER OF COEFFICIENTS IS EVEN OR ODD
if mod(numCoeffs, 2) > 0
    charEqCoeffs = [charEqCoeffs 0]; % ADD A 0 IF ODD
    numCoeffs = numCoeffs + 1; % INCREASE NUMBER OF COEFFICIENTS BY 1
end

% INITIALIZE FIRST ROW WITH ZEROS
row1 = zeros(1, numCoeffs / 2);
counter = 1; % COUNTER STARTING AT 1

% FILL FIRST ROW WITH COEFFICIENTS AT ODD INDICES
for index = 1:2:numCoeffs
    row1(counter) = charEqCoeffs(index);
    counter = counter + 1;
end

% INITIALIZE SECOND ROW WITH ZEROS
row2 = zeros(1, numCoeffs / 2);
counter = 1; % COUNTER STARTING AT 1

% FILL SECOND ROW WITH COEFFICIENTS AT EVEN INDICES
for index = 2:2:numCoeffs
    row2(counter) = charEqCoeffs(index);
    counter = counter + 1;
end

% COMBINE FIRST AND SECOND ROWS TO FORM THE INITIAL MATRIX
routhTable = [row1; row2];

% DETERMINE NUMBER OF CALCULATIONS NEEDED (numCalculations)
% DETERMINE NUMBER OF SEGMENTS IN THE TABLE (numSegments)
numCalculations = 0;
numSegments = 0;
for index = -1:-1:((numCoeffs / 2) - 1) * -1
    numCalculations = numCalculations + (((numCoeffs / 2) + index) * 2);
    numSegments = numSegments + 1;
end

% ADD ZERO ROWS TO THE MATRIX FOR FURTHER CALCULATIONS
additionalRows = zeros((numSegments * 2), (numCoeffs / 2));

% EXPAND THE MATRIX TO ACCOMMODATE THE NECESSARY CALCULATIONS
routhTable(numCoeffs, numCoeffs / 2) = 0;

% MATCH THE SIZE OF additionalRows TO THE EXPANDED MATRIX
additionalRows(numCoeffs, 2) = 0;

% ASSIGN INDICES FOR FUTURE CALCULATIONS IN additionalRows
for segment = 0:1:numSegments
    for index = 1:1:(numSegments - segment) * 2
        additionalRows(index + 2, segment + 1) = segment + 1;
    end
end

% COMBINE THE INITIAL MATRIX AND additionalRows TO FORM THE FULL TABLE
routhTable = routhTable + additionalRows;

% GET THE SIZE OF THE MATRIX
[numRows, numCols] = size(routhTable);

% PERFORM THE NECESSARY CALCULATIONS TO COMPLETE THE ROUTH-HURWITZ TABLE
for segmentIndex = 0:1:(numSegments * 2) - 1
    for segment = 1:1:numSegments
        for row = 3 + segmentIndex:1:3 + segmentIndex 
            for col = 1:1:numCols
                if routhTable(row, col) == segment
                    % Calculate the determinant for this position
                    p1 = routhTable(row - 1, 1) * routhTable(row - 2, segment + 1);
                    p2 = routhTable(row - 2, 1) * routhTable(row - 1, segment + 1);
                    result = (p1 - p2) / routhTable(row - 1, 1);
                    routhTable(row, col) = result;
                end
            end
        end 
    end
end

% CHECK FOR STABILITY: COUNT SIGN CHANGES IN THE FIRST COLUMN
signChanges = sum(diff(sign(routhTable(:, 1))) ~= 0);

% PRINT RESULTS
if signChanges == 0
    disp('The system is stable.');
else
    disp(['The system is unstable with ', num2str(signChanges), ' roots having positive real parts.']);
end
