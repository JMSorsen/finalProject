function [] = radioactiveDecayOfCarbon_14()
    global gui;
    
    gui.amountDaughter = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.01 .01 .2 .1]);%allows the user to input numbers for Daughter values
    gui.titleDaughter = uicontrol('style','text','units','normalized','position', [.06 .11 .1 .05],'string','Daughter');%gives a title to the edit box
    gui.amountParent = uicontrol('style', 'edit', 'units', 'normalized', 'position', [.25 .01 .2 .1]);%gives a title to the edit box
    gui.titleParent = uicontrol('style','text','units','normalized','position', [.27 .11 .15 .05],'string','Parent');%allows the user to input numbers for Parent values
    gui.buttonDaughterAndParent = uicontrol('style', 'pushbutton', 'units', 'normalized', 'position', [.5 .01 .2 .1], 'string', 'Solve','callback',{@numberOfDaughterAndParent}); %pushes the button to run the function amountOfDaughterAndParent to solve the formula
    gui.useAmount = uicontrol('style','pushbutton','units','normalized','position',[.75 .01 .2 .1], 'string','Graph','callback',{@graphHL});%calls the function graphHL to graph the values
    gui.graphHL = plot(0,0);%creates the graph
    gui.graphHL.Parent.Position = [0.2 0.35 0.6 0.6];%position of graph
    
end

function [T] = numberOfDaughterAndParent(source,event)%to store the variable nD
    global gui;
    nD = str2num(gui.amountDaughter.String);
    nP = str2num(gui.amountParent.String);
    if nD < 0 %full if statement prevents the user from putting in inputs that do not work with the formula
        msgbox('Number input must be more than -1');
    elseif nP < 0
        msgbox('Number input must be more than -1');
    elseif nD > 100
        msgbox('Number input must be less than 100 in order to be a percent');
    elseif nP > 100
        msgbox('Number input must be less than 100 in order to be a percent');
    elseif nP < 0
        msgbox('Percentage of Parent is an incorrect input');
    elseif nP > 100
        msgbox('Percentage of Parent is an incorrect input');
    elseif nD < 0
        msgbox('Percentage of Daughter is an incorrect input');
    elseif nD > 100
        msgbox('Percentage of Daughter is an incorrect input');
    elseif isempty(nD) || isempty(nP)
        msgbox('Cannot be no value');
    else
        T = ((log10(nD/nP) + 1) / (0.693/5730));%the formula %lambda = log10(2) %the half life of carbon-14 is 5,730 years
        msgbox(sprintf('Value of T is %d, please press Graph to see the graph of the two points.\n',T));
    end
end
function [] = graphHL(source,event)%to put it all into one graph and graph the amount over time
    global gui;
    nD = str2num(gui.amountDaughter.String);
    nP = str2num(gui.amountParent.String);
    T = ((log10(nD/nP) + 1) / (0.693/5730));
    if isempty(nD)
        msgbox('Not enough Inputs: Missing Daughter','Graphing Error', 'error','modal');
    elseif isempty(nP)
        msgbox('Not enough Inputs: Missing Parent','Graphing Error', 'error','modal');
    else
        hold on;
        plot(T,nP,'bo');%to graph the parent amount
        hold on;
        plot(T,nD,'r*');%to graph the daughter amount
        title('Radioactive Isotope Decay');
        xlabel('Age(number of half-lives)');
        ylabel('Isotope Amount (%)');
        msgbox('Blue is Parent, Red is Daughter');
    end
end