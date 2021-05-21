function[row, column] = RefCoordinateCaller(number, letter)
%Function used to give corresponding coordinates on 10x10 matrix from
%letter and number input

%number input to output
row = number;                %-1 to compensate for 11x11 matrix size

%letter input to output
%Char to Decimal Converter needed!

convertletter = uint8(letter);   %string to ASCII converter
column = convertletter - 63;     % -63 so it alligns correctly in 11x11 grid
