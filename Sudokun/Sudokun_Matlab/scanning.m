function scanning(w,l)
% input: w the width of the processed image
%        l the length of the processed image
% this function will generate a laser scanning animation

%% draw the background grid
largeedge=max([w,l]);
space=round(largeedge/64);
% make the grid a bit larger than the image, so as to avoid vulnerabilities
m=1:space:1.1*largeedge;
% grid setting
I=meshgrid(m,m);
% draw the horizontal and vertical lines
plot(m,I,'g');
hold on
plot(I,m,'g');

%% scanning animation
% the step size of the scanning line
speed=12;
time=1;
% the number of scanning loops
loop=2;
while time<loop
    for i=1:round(w/speed)
        x=[0,l];
        y=[speed*i,speed*i];
        % draw a scanning line and keep refreshing it
        % we push it from the top to bottom
        h=line(x,y,'linewidth',2,'color','green');
        drawnow
        delete(h);
    end
    time=time+1;
end
end
