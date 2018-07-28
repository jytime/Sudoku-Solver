function p_out_cor=project2d(H,p_in)
% input: H      transformation matrix
%        p_in   the location of the input point, in the original planar
% output: 
%        p_out  the location of the projecte point,in the standard planar
% this function will project the points in the input image to the standard
% planar
    %% projection
    number=size(p_in,1);
    p_in_homo=[p_in ones(number,1)]';
    p_out=H*p_in_homo;
    
    %% ensure the output is a homogeneous point
    weight=p_out(3,:);
    p_out_norm = p_out./weight;
    p_out_cor=p_out_norm(1:2,:)';
end