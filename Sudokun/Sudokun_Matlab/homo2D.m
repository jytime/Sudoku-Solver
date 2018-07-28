function H=homo2D(u2Trans, v2Trans,r,w)
% input: w: width of the square puzzle in the standard planar
%        r: location of the left-top corner is (r,r) in the standard planar
%        u2Trans,v2Trans: horizontal and vertical coordinates of the four
%        vertices in the input image
% output: the transformation matrix
%
% Computes the homography H applying the Direct Linear Transformation
% The transformation is such that
% p1 = H p2 
% Jianyuan Wang 2018.4.28
%
%r=100;
%w=9*16*8;
%w=9*16*3;
% convert to homogeneous coordinates by adding '1's
unit=ones(4,1);
% image coordinates in the Base image planar
uBase=[r+w,r,r,r+w]';
vBase=[r,r,r+w,r+w]';

p1=[uBase vBase unit]';

% image coordinates in the Trans image planar
p2=[u2Trans v2Trans unit]';

% To ensure the result is stable, we need to normalize the dataset before
% conducting DLT

% Function normalise2dpts() will normalise 2D homogeneous points, produced
% by Peter Kovesi, 2008
% It will return:    a matrix of transformed 2D homogeneous coordinates.
%                    a 3x3 transformation matrix, which records how we
%                    nomalised the coordinates.

[p1_norm, p1_trans]= normalise2dpts(p1);
[p2_norm, p2_trans]= normalise2dpts(p2);


% to compute the matrix H, we should construct matrix A
A=[];
tempA=[];
% for every point, we have only two linearly independent equations
% I combine them together and get a 12x9 matrix A
for i=1:4
    tempA=[zeros(1,3) (-1)*p2_norm(:,i)' p1_norm(2,i)*p2_norm(:,i)';
        p2_norm(:,i)' zeros(1,3) -p1_norm(1,i)*p2_norm(:,i)'];
    A=[A ;tempA];
end

% conduct SVD on matrix A
[U,S,V]=svd(A);
% the right-most-column of V is the h with least squares
h=V(:,end);
H=reshape(h,[3, 3])';

% denormalise H, according to the transformation matrixs
H = inv(p1_trans)*H*(p2_trans);

end