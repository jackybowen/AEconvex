clear all; close all; clc
fig = figure();
datacursormode on
 dcmObj = datacursormode(fig);
 set(dcmObj,'SnapToDataVertex','off','Enable','on')
 
loop = 1
while loop == 1
    waitforbuttonpress;
    point1 = getCursorInfo(dcmObj);
    x = point1.Position(1)
    y = point1.Position(2)
    z = point1.Position(3)
    % Write exit option
end