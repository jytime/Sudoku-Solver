function [ puzzle ] = recognizeOcr(cropped_imgs, check_num)
%recognizing digits by OCR
%input:  cropped_imgs 28*28*1*81 matrix -- 81 28*28 digit images
%        check_mun 9*9 binary matrix -- if there is a number here, 1 for 'yes'
%output: puzzle 9*9 double matrix -- result of recongizing

    %count the number of digits
    [~, ~, ~, digNum] = size(cropped_imgs);
    %build a larger background to store each image, for improving the
    %proformance of OCR
    background = zeros(100,100,1,digNum);
    %put images in the mid of background
    background(37:37+27,37:37+27,:,:) = cropped_imgs;
    %get width of sudo, 9
    width = sqrt(digNum);
    %9*9 recongnized result matrix 
    puzzle = zeros(width, width);
    
    %reconize digit one by one
    for i = 1 : width
        for j = 1 : width
            %check if there has a digit, for time saving
            %if not, we move to next one
            if check_num(i,j)
                k = (i-1)*width+j;
                %matlab inbuild OCR method
                result = ocr(background(:, :, :, k), 'CharacterSet', '123456789', 'TextLayout', 'Block');
                recog_text = result.Text;
                
                %get the result of recognizing
                %if there is no resulr here, we put '0' in
                if ~isnan(recog_text)
                    recog_digit = recog_text(1);
                    if ~isstrprop(recog_digit, 'digit')
                        recog_digit = '0';
                    end
                else
                    recog_digit = '0';
                end
                %string to double
                recog_digit = str2double(recog_digit);
                %save the result
                puzzle(i, j) = recog_digit;
            end
        end
    end
    
%%  outout 9*9 images for testing
%     figure
%     for i=1:width
%         for j=1:width
%             k = (i-1)*9+j;
%             subplot(9,9,k);
%             imshow(cropped_imgs(:,:,:,k));
%             title(puzzle(k));
%         end
%     end
end

