% Derek Prince
% ECEN 3300 - Linear Systems
% Due: March 10th, 2017
% Project 1
% Ghetto Image Processing
% I also never ever use Matlab.

% MIT License
% 
% Copyright (c) 2017 Derek Prince
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.

% I don't think this code has any value but no license means no rights and
% why not. It's also a case of intentional negligence to delete a licence
% rather than not knowing that no license means no rights.

clear;clc;close all
%% warmup

% black 400x400 image
I = uint8(zeros(400));
% imshow(I);

% green 400x400 image
I2(:,:,1) = uint8(zeros(400));
I2(:,:,2) = uint8(255*ones(400));
I2(:,:,3) = uint8(zeros(400));
imshow(I2);
disp('Press any key to continue');
pause;

% image of self. 
MyImage = imread('DerekPrince.jpg');
imshow(MyImage);

clear;clc;
%% Self Image Shenanigans

% green image. 
MyImage = imread('DerekPrince.jpg');
MyGreenImage = MyImage;
MyGreenImage(:,:,1) = zeros; % red to zero
MyGreenImage(:,:,3) = zeros; % blue to zero
imshow(MyGreenImage);
disp('Press any key to continue');
pause;

% mysterious image.
% also known as pink.
MysteriousImage = MyImage;
MysteriousImage(:,:,1) = 255;
MysteriousImage(:,:,3) = 255;
imshow(MysteriousImage);

clear;clc;
%% Grayscale, etc.

MyImage = imread('DerekPrince.jpg');
MyBWImage = rgb2gray(MyImage);
imshow(MyBWImage);
disp('Press any key to continue');
pause;

% Flip horizontally

sz_x = size(MyImage,2); % grab the horizontal size
sz_y = size(MyImage,1); % grab the vertical size

for y = 1:sz_y
    for x = 1:sz_x
        MyFlipImg(y, x) = MyBWImage(y, (sz_x - x)+1);
    end
end
imshow(MyFlipImg)

% Alternatively, just run this single line. 
MyFlipImgEasy = flip(MyBWImage, 2);


% Yes, it is it's own inverse. 

clear;clc;
%% Blurring

MyImage = imread('DerekPrince.jpg');
MyBWImage = rgb2gray(MyImage);
PrevMyImage = MyBWImage;
sz_x = size(MyImage,2);
sz_y = size(MyImage,1);

for k = 1:100
   for y = 2:sz_y-1     % starts at 2 and ends one early to skip the border if/skip condition
      for x = 2:sz_x-1
          MyBWImage(y, x, 1:3) = uint8((double(PrevMyImage(y, x - 1)) + double(PrevMyImage(y, x))+ double(PrevMyImage(y, x + 1)) + double(PrevMyImage(y - 1, x)) + double(PrevMyImage(y + 1, x)))*0.2);
      end
   end
   PrevMyImage = MyBWImage;
   if ((k == 1) || (k == 5) || (k == 10) || (k == 100))
       msg = sprintf('k = %d', k);
       disp(msg);
       disp('Press any key to continue');
       imshow(MyBWImage);
       pause;
   end
end
%The image I used seems to be too low resolution to make a slow fade on the
%first iteration. I think putting emphasis on the center point might make
%this better.

%I lied. The above effect was from `overflow`, or more accurately just
%hitting the 8-bit cap. Casting to double for the sum fixed it.

%There is no inverse for blurring, it's impossible to always say what the
%exact value of all 5 neighboring locations are after averaging them. Which
%is what the inverting function would do. It would be nice if it existed
%though. Infinite resolution images and all that.

clear;clc;
%% Noisy

MyImage = imread('DerekPrince.jpg');
MyBWImage = rgb2gray(MyImage);

sz_x = size(MyImage,2);
sz_y = size(MyImage,1);
r = 100;

MyNoise = r*(rand(sz_y, sz_x) - 0.5*ones(sz_y, sz_x));

MyNoisyImage = uint8(double(MyBWImage) + MyNoise);

imshow(MyNoisyImage);

% Increasing r increases the leading coefficient on the noise assignment.
% This means that the effect is more emphasized as r increases.



