function norm_image=projectImage(H,I,r,w)
% input: H: transformation matrix
%        I: input binary image
%        w: width of the square puzzle in the standard planar
%        r: location of the left-top corner is (r,r) in the standard planar
% output: the projection in the standard planar

% preset the size of the projected image
norm_image=ones(2*r+w,2*r+w);

for i=1:size(I,1)
    for j=1:size(I,2)
        point=[j,i];
        % we only project the information pixels
        if I(i,j)==0
            % using the transformation matrix, project the point
            pro_point=project2d(H,point);
            % avoid the decimals
            pro_point=round(pro_point);
            x=pro_point(1);
            y=pro_point(2);
            norm_image(y,x)=0;
        end
    end
end
% just to ensure the output is a binary image
norm_image = imbinarize(norm_image);
end