% =========================================================================
% This is a sample code for testing our PAM algorithm
% for TenSR-based HSI denoising, Version 1.0
%-------------------------------------------------------------------
%%
clc;  clear all; 
addpath('data'); 
addpath(genpath('My_PAM'));
load data\WDC.mat;   
scene_name = 'WashingtonDC';
fprintf(['Test dataset: ',scene_name,'\n']);

for i_img=[1:5]  %% noise level select
%% Preprocess by FastHyDe
[Data_Pre, nSig,Ori_Data,psnr_f]=My_Pre(img_clean,i_img);
disp([ 'PSNR of PreData = ' num2str(psnr_f)]); disp(['Noise Level=' num2str(nSig)]);
%% Generate noise
[M, N, p] = size(Ori_Data);
OriData_noise=Ori_Data  + nSig*randn(M,N,p);
noiselevel = nSig*ones(1,p); 
%% Denoising by TenSRDe
tic
Par   = ParSet_My(255*mean(noiselevel));
[TenSRDe]= TenSRDe_Accu(OriData_noise*255, Ori_Data*255, Data_Pre*255, Par);  %TenSRDe denoisng function    
RUN_time= (toc)/60;
 %% Results show
[PSNR,SSIM] = evaluate(Ori_Data,TenSRDe,M,N);
MPSNR=mean(PSNR);
disp(['MPSNR=' num2str(mean(PSNR),'%5.3f')  ',MSSIM = ' num2str(mean(SSIM),'%5.4f')  ',Time=' num2str(mean(RUN_time ),'%5.3f')]);
fprintf('\n')
end