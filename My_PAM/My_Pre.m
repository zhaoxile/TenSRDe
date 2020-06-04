function [Data_Pre, sigma,img_clean,psnr_fast]=My_Pre(img_clean,i_img)

    addpath('My_PAM\BM3D');

    p_subspace = 10;              % PARAMETER_FastHyDe: Dimension of the subspace of FastHyDe
    [row, column, band] = size(img_clean);
    N=row*column;
% 
    for i =1: band  %% scaler to [0 1]
        y = img_clean(:, :, i) ;
        max_y = max(y(:));
        min_y = min(y(:));
        y =  (y - min_y)./ (max_y - min_y);
        img_clean(:, :, i) = y;
    end
        
        % zero-mean Gaussian noise is added to all the bands of the Washington DC Mall
        % and Pavia city center data.
        % The noise standard deviation values are 0.02, 0.04, 0.06, 0.08, and 0.10, respectively.
        noise_type='additive';
        iid = 1; %It is true that noise is i.i.d.
        switch i_img
            case 1
                sigma = 0.02;randn('seed',0);
            case 2
                sigma = 0.04;randn('seed',i_img*N);
            case 3
                sigma = 0.06;randn('seed',i_img*N);
            case 4
                sigma = 0.08;randn('seed',i_img*N);
            case 5
                sigma = 0.1;randn('seed',i_img*N);
        end

        
        noise = sigma.*randn(size(img_clean));
        img_noisy=img_clean+noise;              %generate noisy image

    [Data_Pre] = FastHyDe(img_noisy,  noise_type, iid, p_subspace);
    psnr_fast=psnr(Data_Pre,img_clean);
end