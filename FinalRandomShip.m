function[row, rowsDown, column, columnAcross]= FinalRandomShip(orientation, shipLength, gridShip,maxRC)
%Function creates random ships
%row = how many lines it will go down
%column = how many lines it will go across
%maxRC = maximum value for ship 

%rowsDown = how long it is in the downwards direction
%rowsAcross = how long it will be to the right

%orientation = gives what direction the ship is
%shipLength = how long the ship will be
%gridShip = used to test if space isn't occupied

confirmed = 0;      %confirmed ship placement is false

while confirmed == 0

%variables made based on input
horizontal = strcmp(orientation, 'a');
vertical = strcmp(orientation, 'd');


    if (vertical)
        %gives ship inside the grid going columnAcross
        columnAcross = 0;       %this will cause a N x 1 arrary
        rows = shipLength;
        rowsDown = rows - 1;    %-1 to show correct length on grid
        
        column = floor(rand*(10-1)+1);  %random value from 1-10 for column
        
        row = floor(rand*(maxRC-1)+1);  %random value from 1 - maxRC for row
                    

        
    elseif (horizontal)
        %gives ship inside the grid going rowsDown
        rowsDown = 0;           %this will cause a 1 x N arrary
        columns = shipLength;
        columnAcross = columns-1;   %-1 to show correct length on grid
        
        row = floor(rand*(10-1)+1); %random value from 1-10 for row
        
        column = floor(rand*(maxRC-1)+1);   %random value from 1 - maxRC for column
        
    end

%     %use "ismember" command to check if values generated give zero when
%     %given 10x10 matrix. if the there is zero, the values will be
%     %outputted. If there is one number that isn't a zero, randomly generate
%     %new row and column coordinates for ship
%     
%     %set matrix to check using randomly generated values
      %Using gridShip input, we can check for any overlaps

    finalRow = row+rowsDown;
    finalColumn = column+columnAcross;
    
%     Troubleshooting
%     disp(row)
%     disp(finalRow)
%     disp(column)
%     disp(finalColumn)
    
    
    calledMatrix = gridShip(row:finalRow,column:finalColumn);
    
    %Sets variable to part of matrix that was randomly called
    matrix2Check = calledMatrix;
%     disp(matrix2Check)
    
    %check if there are nonzero in this matrix
    nonzeros = [2,3,33,4,5];
    zeroCheck  = ismember(nonzeros,matrix2Check);
    
        %if there is nonzero, ship placement not confirmed, function runs
        %again
        if  zeroCheck == 1
            confirmed = 0;  %find new values
            
        %if there are no nonzero, ship placement is confirmed, loop breaks and outputs are sent to main code    
        elseif zeroCheck == 0
            confirmed = 1;

        end

    

    
end
end