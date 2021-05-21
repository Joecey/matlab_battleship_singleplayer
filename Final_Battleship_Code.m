%Battleship Final Assignment
%Joe  Cedrick Linogao 18320851

%%%% play condition set to 1 %%%%

%Code is done by having nested while loops

play = 1;
while play == 1
    
    clc
    clear
    %Battleship_The_Game
    
    %%%%%   INTRODUCTION  %%%%%
    disp('Welcome to Battleship: The Game, by Joe Linogao')
    
    %Asking if you want to start
    askLoop = 0;
    while askLoop == (0)
        
        playAsk = input('Do you have the determination to play Battleship? (Y/N): ', 's');
        
        if playAsk == ('N')
            askLoop = 0;
            disp('Oh I am sure you do. Type in "y" instead')
            disp(' ')
            
        elseif playAsk ==('Y') 
            askLoop = 1;
            break
        end
        
        
    end
    
   
    %Clear command window 
    clc
    
    %Create a cell filled with strings
    Tips = {'Tip: You win the game by winning', 'Tip: The computer is going to cheat clearly', 'Tip: You should have a lot of determination', 'Tip: Swag', 'Tip: You will get an epic victory royale if you beat the computer'};
    loading = 0;
    
    while (0 <= loading) && (loading<=2)
        
        %Chooses random tip to display from the cell arrary
        randTip = Tips(randi(numel(Tips)));
        
        disp('Loading.')
        disp(randTip)
        pause (1.5)
        clc
        disp('Loading..')
        disp(randTip)
        pause (1.5)
        clc
        disp('Loading...')
        disp(randTip)
        pause(1.5)
        clc
        loading = loading +1;
        
        
        if loading == 3
            break
        end
    end
    
    %%%%    INITIAL SETUP   %%%%
    
    %Asking player if they would like to open a previous save (.txt format)
    openSave = input('Would you like to open a previous save (Y/N)?: ', 's');
    
    
    if openSave == ('Y') 
        %Open save file
        clc
        openFile = fopen('Game_Save','r');
        
        if openFile == -1
            %occurs if file is unable to be opened
            %Thus, it generates a new game save
            disp('Problem opening this file')
            disp('Creating new game save...')
            pause(3)
            
            %Clean Slate, create new gridShip, gridRef, myHits and numGuess
            
            %Creates 10x10 grid to place virtual ships
            gridShip = zeros(10,10);
            
            %Set first value for max row/column ship can start from
            maxRC = 9;
            
            %Loop for generating ships into gridShip
            %Create random placement for ships length 2-5 (other length 3
            %has to be done manually outside the for loop)
            
            for shipLength = 2:5
                
                %cell created that has two orientaion options
                dORa = {'a','d'};   %Notice curly brackets
                
                %Choose random orientation using random string command
                %cellOri = Cell Orientation
                
                cellOri = dORa(randi(numel(dORa)));
                orientation = char(cellOri);    %go from cell to string
                
                
                %send inputs to function
                [row, rowsDown, column, columnAcross] = FinalRandomShip(orientation, shipLength,gridShip,maxRC);
                
                %use created outputs to place ship on grid
                %row+rowsDown displays ship in generated spot, same with columns
                gridShip(row:(row+rowsDown),column:(column+columnAcross)) = shipLength;
                
                %-1 from maxRC so ships can fit in 10x10 gridShip
                maxRC = maxRC - 1;
                
                
            end
            
            
            %Create random ship for other length 3 ship (with number 33)
            %For this case, we have to manually select our inputs
            
            shipLength = 3;
            maxRC = 8;
            
            %cell created that has two orientaion optionsx
            dORa = {'a','d'};   %Notice curly brackets
            
            %Choose random orientation using random string command
            cellOri = dORa(randi(numel(dORa)));
            orientation = char(cellOri);    %go from cell to string
            
            %send inputs to function
            [row, rowsDown, column, columnAcross] = FinalRandomShip(orientation, shipLength,gridShip,maxRC);
            
            %use created outputs to place ship on grid
            %row+rowsDown displays ship in generated spot, same with columns
            %use 33 to represent other length 3 ship
            gridShip(row:(row+rowsDown),column:(column+columnAcross)) = 33;
            
            
            disp('Welcome to Battleship the Game!')
            disp(' ')
            
            gameEnd = 0; %gameEnd not met, gameEnd = false
            %gameEnd = 1 when player wins or computer succeeds
            
            %11x11 grid for coordinates and marking
            gridRef = zeros(10,11);
            %Note:
            %0 = not shot, 1 = already called that, 11 = ship hit
            
            %Create initial coordinate system
            gridRef(1:10,1) = (1:10);
            
            %Initial amount of guesses
            numGuess = 0;
            
            %Status of each ship
            % 1 = alive, 0 = sunk
            destroyer = 1;
            submarine = 1;
            cruiser = 1;
            battleship = 1;
            aircraft_carrier = 1;
            
            %Times you are hit
            myHits = 0;
            
        else
            %Occurs if file opens successfully
            disp('Game save detected!')
            disp('Loading game save...')
            pause(3)
            
            %Clear command window
            clc
            
            %gameEnd = 0 for main game while loop
            gameEnd = 0;
            
            %Status of each ship
            % 1 = alive, 0 = sunk
            destroyer = 1;
            submarine = 1;
            cruiser = 1;
            battleship = 1;
            aircraft_carrier = 1;
            
            %Create new empty variables
            
            gridShip = zeros(10,10);
            gridRef = zeros(10,11);
            numGuess = 0;
            myHits = 0;
            
            %start lineNumber count at 0
            lineNumber = 0;
            columnNumber = 0;
            
            %While there is still a line to scan
            while feof(openFile) == 0
                lineNumber = lineNumber + 1;
                columnNumber = columnNumber + 1;
                
                %Do different things depending on what line is read
                %gridShip = 1 to 10
                %gridRef = 11 to 21
                %numGuess = 22
                %myHits = 23
                %destroyer = 24
                %submarine = 25
                %cruiser = 26
                %battleship = 27
                %aircraft_carrier = 28
                
                if lineNumber >= 1 && lineNumber <= 10
                    %Most recently scanned line
                    currentLine = fgetl(openFile);
                    lineArray = str2num(currentLine);  %Converts from string to number array
                    
                    %Puts array in correct column in shipGrid
                    gridShip(1:10, columnNumber) = lineArray;
                    
                elseif lineNumber >= 11 && lineNumber <= 21
                    currentLine = fgetl(openFile);
                    lineArray = str2num(currentLine); %#ok<*ST2NM>
                    
                    %Here, column Number is going to go from 11 to 21, so
                    %we need to compensate with -10
                    
                    gridRef(1:10, columnNumber-10) = lineArray;
                    
                elseif lineNumber == 22
                    %numGuess info
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>
                    
                    numGuess = number;
                    
                    
                elseif lineNumber == 23
                    %myHits info
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>
                    
                    myHits = number;
                    
                elseif lineNumber == 24
                    %Line 24 has destroyer
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>
                    
                    destroyer = number;
                    
                elseif lineNumber == 25
                    %Line 25 has submarine
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>
                    
                    submarine = number;
                    
                elseif lineNumber == 26
                    %Line 26 has cruiser
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>   
                    
                    cruiser = number;
                    
                elseif lineNumber == 27
                    %Line 27 has battleship
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>
                    
                    battleship = number;
                    
                elseif lineNumber == 28
                    %Line 28 has aircraft_carrier
                    currentLine = fgetl(openFile);
                    number = str2num(currentLine); %#ok<*ST2NM>                    
                    
                    aircraft_carrier = number;
                                
                end
                
            end
            
            %Reminding player their stats
            fprintf('You have been hit %d times already \n', myHits)
            fprintf('You have taken %d guesses \n', numGuess)
            pause(4)
            
        end
        
 
        disp(' ')
        disp('Welcome to Battleship the Game!')
        
    elseif openSave == ('N')
        clc
        disp('Creating new game save...')
        pause(3)
        clc
        %Clean Slate, create new gridShip, gridRef, myHits and numGuess
        
        %Creates 10x10 grid to place virtual ships
        gridShip = zeros(10,10);
        
        %Set first value for max row/column ship can start from
        maxRC = 9;
        
        %Loading Ships into gridShip
        %Create random placement for ship length 2-5
        
        for shipLength = 2:5
            
            %cell created that has two orientaion options
            dORa = {'a','d'};   %Notice curly brackets
            
            %Choose random orientation using random string command
            cellOri = dORa(randi(numel(dORa)));
            orientation = char(cellOri);    %go from cell to string
            
            
            %send inputs to function
            [row, rowsDown, column, columnAcross] = FinalRandomShip(orientation, shipLength,gridShip,maxRC);
            
            %use created outputs to place ship on grid
            %row+rowsDown displays ship in generated spot, same with columns
            gridShip(row:(row+rowsDown),column:(column+columnAcross)) = shipLength;
            
            %-1 from maxRC so ships can fit in 10x10 gridShip
            maxRC = maxRC - 1;
            
            
        end
        
        
        %Create random ship for other length 3 ship (with number 33)
        %For this case, we have to manually select our inputs
        
        shipLength = 3;
        maxRC = 8;
        
        %cell created that has two orientaion optionsx
        dORa = {'a','d'};   %Notice curly brackets
        
        %Choose random orientation using random string command
        cellOri = dORa(randi(numel(dORa)));
        orientation = char(cellOri);    %go from cell to string
        
        %send inputs to function
        [row, rowsDown, column, columnAcross] = FinalRandomShip(orientation, shipLength,gridShip,maxRC);
        
        %use created outputs to place ship on grid
        %row+rowsDown displays ship in generated spot, same with columns
        %use 33 to represent other length 3 ship
        gridShip(row:(row+rowsDown),column:(column+columnAcross)) = 33;
        
        
        disp('Welcome to Battleship the Game!')
        disp(' ')
        
        gameEnd = 0; %gameEnd not met, gameEnd = false
        %gameEnd = 1 when player wins or computer succeeds
        
        %11x11 grid for coordinates and marking
        gridRef = zeros(10,11);
        %Note:
        %0 = not shot, 1 = already called that, 11 = ship hit
        
        %Create initial coordinate system
        gridRef(1:10,1) = (1:10);
        
        %Initial amount of guesses
        numGuess = 0;
        
        %Status of each ship
        % 1 = alive, 0 = sunk
        destroyer = 1;
        submarine = 1;
        cruiser = 1;
        battleship = 1;
        aircraft_carrier = 1;
        
        %Times you are hit
        myHits = 0;
        
    end
    
    %Creating Ship that computer will fire on
    %1 x 10 matrix with generated values from 1 - 50
    myShip = floor(1+(50-1)*rand(1,10));
    
    %Creates an arrary with these numbers
    %When comupter fires, it will generate a random number between 1 and 50
    %If the number called is in myShip, then you are hit
    %You can survive up to 10 hits before you lose
    
    
    %%%%%%  MAIN GAME  %%%%%%
    
    while gameEnd == 0
        disp(' ')
        
        %Testing purposes
%         disp(gridShip)
        
        %Main Code Start
        %Display refGrid with Letters
        disp('           A     B     C     D     E     F     G     H     I     J  ')
        disp(gridRef)
        disp(' ')
        disp('0 not shot yet, 1 = shot called here, 11 = ship here')
        disp(' ')
        
        %Display how many hits the player can take from computer
        hitsLeft = 10 - myHits;
        fprintf('We can take %d more hit(s) \n', hitsLeft)
        disp(' ')
        
        %Status of each ship
        if destroyer == 1
            disp('Enemy Destroyer still up (Length 2)')
            
        end
        
        if submarine == 1
            disp('Enemy Submarine still up (Length 3)')
            
        end
        
        if cruiser == 1
            disp('Enemy Cruiser still up (Length 3)')
            
        end
        
        if battleship == 1
            disp('Enemy  b a t t l e s h i p   still up (Length 4)')
            
        end
        
        if aircraft_carrier == 1
            disp('Enemy Aircraft Carrier still up (Length 5)')
            
        end
        
        %Inputting Coordinates
        checkCoords = 0;     %coordinates not confirmed
        while checkCoords == 0
            
            lengthConfirm = 0;
            while lengthConfirm == 0
                
                disp(' ')
                disp('Letters A-J correspond to columns 1-10')
                disp(' ')
                letterCall = input('What column do you want to attack? (A-J, use capitals): ','s');
                numberCall = input('Which row do you want to attack? (1-10): ');
                disp(' ')
                
                %Checking if letter call is only one string long
                
                lengthLetter = length(letterCall);
                
                if lengthLetter == 1
                    lengthConfirm = 1;
                    break
                    
                elseif lengthLetter ~= 1
                    disp('Column chosen is too long. Try again!')
                    disp(' ')
                    
                end
                
                
            end
            
            
            
            %Reference Grid Function
            %Input sent to reference grid function so correct numbers are
            %used
            [refRow, refColumn] = RefCoordinateCaller(numberCall, letterCall);
            
            %         avaiableRows are from (1:10);
            %         avaiableColumns are from (2:11);
            
            if refRow >= 1 && refRow <= 10 && refColumn >= 2 && refColumn <= 11
                %if refRow is between or equal 1 and 10, and refColumn is
                %between or equal to 2 and 11
                
                checkCoords = 1;
                clc
                break
                %while loop breaks, code continues
                
                
            elseif refRow < 1 || refRow >10 || refColumn < 2 || refColumn >11
                %If chosen coordinate is outside of matrix boundaries
               
                disp('That is not a coordinate, please try again!')
                disp(' ')
                
            end
            
            
        end
        
        
        %Also, check if you fired in this location already
        fireCheck = 0;       %coordinate check not confirmed
        
        while fireCheck == 0
            
            %IF PLAYER FIRED ON THIS POSTITION ALREADY
            if gridRef(refRow,refColumn) ~= 0
                disp('You already fired on that position or, position not avaiable')
                disp('Try again!')
                disp('Resetting coordinate system')
                pause(4)
                clc
                disp(' ')
                
                %Repeat input commands from above
                checkCoords = 0;     %coordinates not confirmed
                while checkCoords == 0
                    
                    disp('           A     B     C     D     E     F     G     H     I     J  ')
                    disp(gridRef)
                    
                    lengthConfirm = 0;
                    while lengthConfirm == 0
                        disp(' ')
                        disp('Letters A-J correspond to columns 1-10')
                        disp(' ')
                        letterCall = input('What column do you want to attack? (A-J, use capitals): ','s');
                        numberCall = input('Which row do you want to attack? (1-10): ');
                        disp(' ')
                        
                        %Checking if letter call is only one string long
                        
                        lengthLetter = length(letterCall);
                        
                        if lengthLetter == 1
                            lengthConfirm = 1;
                            break
                            
                        elseif lengthLetter ~= 1
                            disp('Column chosen is too long. Try again!')
                            disp(' ')
                            
                        end
                        
                        
                    end
                    
                    %Apply refCoordinate Function
                    [refRow, refColumn] = RefCoordinateCaller(numberCall, letterCall);
                    
                    %         avaiableRows are from (1:10);
                    %         avaiableColumns are from (2:11);
                    
                    if refRow >= 1 && refRow <= 10 && refColumn >= 2 && refColumn <= 11
                        %if refRow is between or equal 1 and 10, and refColumn is
                        %between or equal to 2 and 11
                        
                        checkCoords = 1;
                        clc
                        break
                        %while loop breaks, code continues
                        
                        
                    elseif refRow < 1 || refRow >10 || refColumn < 2 || refColumn >11
                        clc
                        disp('That is not a coordinate, please try again!')
                        disp(' ')
                        
                    end
                    
                end
                
                %IF PLAYER HAS NOT FIRED ON POSITION
            elseif gridRef(refRow,refColumn) == 0
                
                disp('Checking coordinates now...')
                pause(1.5)
                disp(' ')
                
                %Break this while loop
                break
            end
        end
        
        
        %     disp(refRow)
        %     disp(refColumn)
        
        %Ship Grid function
        [rowAttack, columnAttack] = ShipCoordinateCaller(numberCall, letterCall);
        
        %     disp(rowAttack)
        %     disp(columnAttack)
        
        %Locking in coordinates and firing action
        disp('Confirming Coordinates...')
        pause(1.5)
        disp('Loading shot! Firing in 3...')
        pause(1)
        disp('2...')
        pause(1)
        disp('1...')
        pause(1)
        disp('FIRE!!!')
        pause(1.5)
        
        disp(' ')
        
        %Confirming if there was a hit or not
        if gridShip(rowAttack,columnAttack) ~= 0
            %There is nonzero here!
            disp('Confirmed hit! Good Shot!')
            disp(' ')
            
            gridShip(rowAttack,columnAttack) = 0;
            gridRef(refRow, refColumn) = 11;
            
        elseif gridShip(rowAttack,columnAttack) == 0
            %There is no nonzero here!
            disp('Bridge just confirmed a miss!')
            disp(' ')
            
            gridRef(refRow, refColumn) = 1;
            
        end
        
        numGuess = numGuess +1;
        pause(4)
        
        %%%%%   CHECKING EACH SHIP STATUS    %%%%%
        %ismember command for each ship
        
        ship2check = ismember(2,gridShip);
        ship3check = ismember(3,gridShip);
        ship33check = ismember(33,gridShip);
        ship4check = ismember(4,gridShip);
        ship5check = ismember(5,gridShip);
        
        if ship2check == 0 && destroyer == 1
            
            %Ex: If there are no more 2's, and the code still says the
            %destroyer is still up
            
            destroyer = 0;      %destroyer status set to sunk
            disp('You sunk the enemy destroyer!')
            disp(' ')
            disp('          |\___..--"/')
            disp('   __..--``        / ')
            disp('  \_______________/  ')
            pause(3)
            
        elseif ship3check == 0  && submarine == 1
            submarine = 0;
            disp('You sunk the enemy submarine!')
            disp(' ')
            disp('                    /---|               ')
            disp('          ,--------"    "-----------___ ')
            disp('         (                          _--+')
            disp('          `----------------------""""   ')
            
            pause(3)
            
        elseif ship33check == 0 && cruiser == 1
            cruiser = 0;
            disp('You sunk the enemy cruiser!')
            
            disp('                    __/___           ')
            disp('              _____/______|          ')
            disp('      _______/_____\_______\_____    ')
            disp('      \              < < <       |   ')
            disp('   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
            
            pause(3)
            
        elseif ship4check == 0 && battleship == 1
            battleship = 0;     %battleship status set to sunk
            disp('You sunk the enemy battleship!')
            disp(' ')
                                               
          
            disp('                            _/|     _/|-++"                                 ')
            disp('                        +  +--|    |--|--|_ |-                              ')
            disp('                     { /|__|  |/\__|  |--- |||__/                           ')      
            disp('                    +---------------___[}-_===_."____               /\      ')
            disp('                ____`-" ||___-{]_| _[}-  |     |_[___\==--          \/      ')
            disp(' __..._____--==/___]_|__|_____________________________[___\==--___,-----" .7')
            disp('|                                                                   BB-61/  ')
            disp(' \_______________________________________________________________________|  ')
            pause(3)
            
        elseif ship5check == 0 && aircraft_carrier == 1
            aircraft_carrier = 0;
            disp('You sunk the enemy aircraft carrier!')
            disp(' ')
            disp('                                    ]+[                                ')
            disp('        \ /                        --|--         ---x-8-x---           ')
            disp('    x---o8o---x                    |_|__|                              ')
            disp('                                   |____                               ')       
            disp('  ----------------------------------|65|-------------------------------')
            disp('  \                   \                        (------)               /')
            disp('   ~~~~~~~~~OOooo_______\_____________________________________~~~~ooo__')            
            pause(3)
            
        end
        
        %%%%% CHECKING FOR WIN CONDITION %%%%%%%
        clc
        saved = 0;
        
        %Check for win condition
        %Check if gridShip still has numbers in it
        nonzeros = [2,3,33,4,5];
        zeroCheck  = ismember(nonzeros,gridShip);
        
        %If there are nonzeros
        if zeroCheck == 1
            
            %Game continues
            
            %If there are no nonzeros
        elseif zeroCheck == 0
            gameEnd = 1;
            break
        end
        
        %%%% COMPUTER TURN/ CHECK FOR LOSE CONDITION
        %Allow computer to fire back/ check for lose condition
        clc
        
        %Choose number between 1 and 50 (round to lowest integer)
        enemyFire = floor(rand*(50-1)+1);
        
        %Check if number is in
        enemyHit = ismember(enemyFire, myShip);
        disp('Warning! Incoming fire!')
        pause(2)
        disp('Brace for impact!!')
        pause(2)
        
        if enemyHit == 1 && myHits < 10
            %Say that computer has hit you and add counter
            disp('Enemy ship has hit us! Reparing the damage now')
            
            myHits = myHits +1;
            
            %How many hits we can take left
            hitsLeft = 10 - myHits;
            fprintf('We can take %d more hit(s) \n', hitsLeft)
            
            
        elseif enemyHit == 0 && myHits < 10
            %Say that computer has missed you
            disp('Enemy missed us! Preparing counter attack!')
            
            %How many hits we can take left
            hitsLeft = 10 - myHits;
            fprintf('We can take %d more hit(s) \n', hitsLeft)
            
        elseif enemyHit == 1 && myHits == 10
            %Say we've been hit again, and you lose
            disp('We have been hit again!')
            disp('Abandon ship! Abandon ship!!!')
            pause(3)
            gameEnd = 1;
            break
            
        end
        pause(4)
        
        %Do you want to take another shot or save?
        clc
        saveOption = input('Do you want to take another shot (Y) or save (S)?: ', 's');
        
        if saveOption ==('Y')
            %Code continues
            
        elseif saveOption == ('S')
            saved = 1;
            
            %Save gridShip, gridRef, numGuess, myHits in one file
            %shipGrid first 10 lines (10 columns)
            %gridRef, 11 lines (10 columns)
            %numGuess line 22 (1)
            %myHits line 23 (1)
            
            %Open new file to write to
            gameSave = fopen('Game_Save', 'w');
            
            %fprintf each variable
            %Grid lines are scanned from column left to right
            fprintf(gameSave, '%d %d %d %d %d %d %d %d %d %d \n', gridShip);
            fprintf(gameSave, '%d %d %d %d %d %d %d %d %d %d \n', gridRef);
            
            %Performance variables written
            fprintf(gameSave, '%d \n', numGuess);
            fprintf(gameSave, '%d \n', myHits);
            
            %Status of each ship saved
            fprintf(gameSave, '%d \n', destroyer);
            fprintf(gameSave, '%d \n', submarine);
            fprintf(gameSave, '%d \n', cruiser);
            fprintf(gameSave, '%d \n', battleship); 
            fprintf(gameSave, '%d \n', aircraft_carrier);
            
            %Close file when done
            fclose(gameSave);
            
            disp('Game saved successfully!')
            pause(3)
            disp(' ')
            
            break
            
        end
        
        %Before restarting loop
        disp('Recallibrating coordinate system...')
        pause(3)
        clc
    end
    
    %%%% Different end screens depending on reason of while breaking
    %i.e lose or win
    
    %If saved file was created
    if saved == 1
        %Don't do anything, code skips win/lose condition stuff
        
        %If saved file was not created
    elseif saved == 0
        %Check if gridShip still has numbers in it
        nonzeros = [2,3,33,4,5];
        zeroCheck  = ismember(nonzeros,gridShip);
        
        if zeroCheck == 0
            
            disp('Congrats!')
            
            %Minimum amount of guesses = 17
            
            performance = 17/(numGuess);
            score = 100000*performance;
            
            fprintf('Your score is %.2f! Very cool! \n', score)
            disp('Note, best score you can achieve is 100000')
            disp(' ')
            
        elseif zeroCheck ==1
            clc
            disp('You lose!')
            disp('You must feel really bad about yourself, wah wah :(')
            disp(' ')
            
        end
    end
    
    %%%% ASKING IF YOU WANT TO PLAY AGAIN %%%%
    ask = input('Do you want to play again? (Y/N): ', 's');
    
    if ask == ('Y')
        %User wants to play again
        play = 1;
        
    elseif ask == ('N')
        %User doesn't want to play again
        %Thus, break the exterior loop
        play = 0;
        break
        
    end
    
    
end
disp(' ')
clc
disp('Thank you for playing Battleship!')

disp(' ')

disp('Credits')
disp('Created by - Joe Linogao')
pause(1)
disp('Code by - Joe Linogao')
pause(1)
disp('Crying by - Joe Linogao')
pause(1)
disp('Coffee machine by - Lavazza')
pause(3)
disp(' ')
disp('Oh I am sorry, the princess is another castle (or something like that)')





