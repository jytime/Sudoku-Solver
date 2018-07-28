function m = findCorners(L)
% input: 
%        L is a 4*4 matrix; each row contains the location of two
%        points,representing one border
% output: four intersections
% this function will find the intersections of the four borders

% convert the point pairs to the cartesian coordinate expression
for i=1:4
    k(i)=(L(i,2)-L(i,4))/(L(i,1)-L(i,3));
    b(i)= L(i,2)-k(i)*L(i,1);
end

% from the cartesian coordinate expression,we can easily compute the intersections
p1(1)=(b(4)-b(1))/(k(1)-k(4));
p1(2)=k(1)*p1(1)+b(1);

p2(1)=(b(3)-b(1))/(k(1)-k(3));
p2(2)=k(1)*p2(1)+b(1);

p3(1)=(b(3)-b(2))/(k(2)-k(3));
p3(2)=k(3)*p3(1)+b(3);

p4(1)=(b(4)-b(2))/(k(2)-k(4));
p4(2)=k(4)*p4(1)+b(4);

% convert the four intersections into a output matrix
m = [p1;p2;p3;p4];
end