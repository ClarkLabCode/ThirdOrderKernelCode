function Analysis_Utils_PlotVelR_Binary(distribution, spatial_range, main_name, FWHM_bank, data_matrix, vel_range_bank)

velocity.distribution = distribution;
v_real_plot = [-fliplr(vel_range_bank), vel_range_bank];

n_FWHM = length(FWHM_bank);
n_vel = length(vel_range_bank);

% might not be very useful. but still include those.
r2     = zeros(n_FWHM,1);
r3     = zeros(n_FWHM,1);
r23    = zeros(n_FWHM,1);
r_best = zeros(n_FWHM,1);

%% first, plot the scatter plot.
%% reorganize the figure;;

MakeFigure;
for kk = 1:1:n_FWHM
    v2 = [data_matrix(:,kk).v2]; v2 = v2(:);
    v3 = [data_matrix(:,kk).v3]; v3 = v3(:);
    v_real = [data_matrix(:,kk).v_real]; v_real = v_real(:);
    a = corrcoef(v2, v_real); r2(kk) = a(1,2);
    a =  corrcoef(v3, v_real);r3(kk) = a(1,2);
    a =  corrcoef(v2 + v3, v_real); r23(kk) = a(1,2);
    % also compute what is the best weighting and what is the best
    % correlation.
    w = [v2, v3]\ v_real;
    v_best = [v2, v3] * w;
    a = corrcoef(v_best, v_real); r_best(kk) = a(1, 2);
    
    % plot the raw data.
    % also plot the correlation.
    % also plot the residual...
    subplot(4, length(FWHM_bank), kk );
    Utils_ScatterPlot_VReal_VEst(v_real, v2, velocity.distribution, FWHM_bank(kk));
    set(gca, 'XTick',[]);
    title(sprintf('FWHM%d', FWHM_bank(kk)));
    ConfAxis
    if kk == 1
        xlabel('real velocity')
        ylabel('K2');
    end
    title(sprintf('FWHM %d', FWHM_bank(kk)));
    subplot(4, length(FWHM_bank), kk + length(FWHM_bank));
    Utils_ScatterPlot_VReal_VEst(v_real, v3, velocity.distribution, FWHM_bank(kk));
    set(gca, 'XTick',[]);
    ConfAxis
    if kk == 1
        xlabel('real velocity')
        ylabel('K3');
    end
    subplot(4, length(FWHM_bank), kk + 2 * length(FWHM_bank));
    Utils_ScatterPlot_VReal_VEst(v_real, v3 + v2, velocity.distribution, FWHM_bank(kk));
    set(gca, 'XTick',[]);
    ConfAxis
    if kk == 1
        xlabel('real velocity')
        ylabel('K3 + K2');
    end
%     subplot(4, length(FWHM_bank), kk + 3 * length(FWHM_bank));
%     Utils_ScatterPlot_VReal_VEst(v_real - v2, v3, velocity.distribution, FWHM_bank(kk));
% %         Utils_ScatterPlot_VReal_VEst(v_real - v2, v3, 'uniform', FWHM_bank(kk),'one_bin', 2);
% % one_bin
%     set(gca, 'XTick',[]);
%     
%     ConfAxis
%     %         set(gca, 'XTick',1:2 * length(vel_range_bank),'XTickLabel', strsplit(num2str(v_real_plot)));
%     if kk == 1
%         xlabel('real - K2');
%         ylabel('K3');
%     end
end
special_name = sprintf('vel_scatter_%s_ave%d', velocity.distribution,spatial_range);
text_str = [main_name, ' ' special_name];
uicontrol('Style', 'text',...
    'String', text_str,... %replace something with the text you want
    'Units','normalized',...
    'Position', [0 0.9 0.15 0.1],'FontSize', 15);

MySaveFig_Juyue(gcf,main_name, special_name, 'nFigSave',2,'fileType',{'png','fig'});

%% second, plot the mean/std
v2_mean = zeros(2, n_vel,n_FWHM);
v3_mean = zeros(2,n_vel,n_FWHM);
v2_std = zeros(2,n_vel,n_FWHM);
v3_std = zeros(2,n_vel,n_FWHM);
v23_mean = zeros(2,n_vel,n_FWHM);
v23_std = zeros(2,n_vel,n_FWHM);
v_residual_mean = zeros(2,n_vel,n_FWHM);
v_residual_std = zeros(2,n_vel,n_FWHM);
v_real_range = zeros(2, n_vel,n_FWHM);

for kk = 1:1:n_FWHM
    for jj = 1:1:n_vel
        v2 = data_matrix(jj, kk).v2;
        v3 = data_matrix(jj,kk).v3;
        v_real = data_matrix(jj,kk).v_real;
        v23 = v2 + v3;
        v_residual = v_real - v2;
        sign_bank = [-1, 1];
        for pp = 1:1:2
            if pp == 1
                ind = find(v_real < 0);
            else
                ind = find(v_real > 0);
            end
            v_real_range(pp, jj, kk) = v_real(ind(1));
            v2_mean(pp, jj, kk) = mean(v2(ind));
            v2_std(pp,jj,kk) = std(v2(ind));
            v3_mean(pp,jj, kk) = mean(v3(ind));
            v3_std(pp,jj,kk) = std(v3(ind));
            v23_mean(pp,jj, kk) = mean(v23(ind));
            v23_std(pp,jj,kk) = std(v23(ind));
            v_residual_mean(pp,jj,kk) = mean(v_residual(ind));
            v_residual_std(pp,jj,kk) = std(v_residual(ind));
        end
    end
end
%%
MakeFigure;
v_real_log = Utils_MoveToLogScale(v_real_range);
for kk = 1:1:n_FWHM
    v2_mean_this = v2_mean(:,:,kk); v2_mean_this = v2_mean_this(:);
    v3_mean_this = v3_mean(:,:,kk); v3_mean_this = v3_mean_this(:);
    v2_std_this = v2_std(:,:,kk); v2_std_this = v2_std_this(:);
    v3_std_this = v3_std(:,:,kk);v3_std_this = v3_std_this(:);
    v23_mean_this = v23_mean(:,:,kk); v23_mean_this = v23_mean_this(:);
    v23_std_this = v23_std(:,:,kk); v23_std_this = v23_std_this(:);
    v_residual_mean_this = v_residual_mean(:,:,kk); v_residual_mean_this = v_residual_mean_this(:);
    v_residual_std_this = v_residual_std(:,:,kk); v_residual_std_this = v_residual_std_this(:);
    v_real_range_this = v_real_log(:,:,kk); v_real_range_this = v_real_range_this(:);
    
    subplot(4, length(FWHM_bank), kk );
    MyScatter_DoubleErrBars(v_real_range_this,v2_mean_this, [], v2_std_this, '@scatter')
    title(sprintf('FWHM %d', FWHM_bank(kk)));
    set(gca, 'XTick',[]);
    box off
    if kk == 1
        
        ylabel('K2');
        xlabel('real velocity')
    end
    subplot(4, length(FWHM_bank), kk + length(FWHM_bank));
    MyScatter_DoubleErrBars(v_real_range_this,v3_mean_this, [], v3_std_this, '@scatter');
    set(gca, 'XTick',[]);
    box off
    if kk == 1
        ylabel('K3');
        xlabel('real velocity')
        
    end
    subplot(4, length(FWHM_bank), kk + 2 * length(FWHM_bank));
    MyScatter_DoubleErrBars(v_real_range_this,v23_mean_this, [], v23_std_this, '@scatter');
    set(gca, 'XTick',[]);
    box off
    if kk == 1
        ylabel('K3 + K2');
        xlabel('real velocity')
        
    end
%     subplot(4, length(FWHM_bank), kk + 3 * length(FWHM_bank));
%     MyScatter_DoubleErrBars(v_residual_mean_this, v3_mean_this, [], [], '@scatter')
%     set(gca, 'XTick',[]);
%     box off
%     if kk == 1
%         ylabel('K3');
%         xlabel('real - K2');
%         
%     end
    
end
special_name = sprintf('vel_mean_std_%s_ave%d', velocity.distribution,spatial_range);
text_str = [main_name, ' ' special_name];
uicontrol('Style', 'text',...
    'String', text_str,... %replace something with the text you want
    'Units','normalized',...
    'Position', [0 0.9 0.15 0.1],'FontSize', 15);

MySaveFig_Juyue(gcf,main_name, special_name, 'nFigSave',2,'fileType',{'png','fig'});
% %% third, plot the color plot for mean value
% MakeFigure;
% v_real_range_new_format = Utils_OrganizeMatrix_for_ColorPlot(v_real_range);
% subplot(2,2,1)
% quickViewOneKernel(Utils_OrganizeMatrix_for_ColorPlot(v2_mean),1, 'labelFlag', false)
% set(gca, 'XTick',1:2 * length(vel_range_bank),'XTickLabel', strsplit(num2str(v_real_range_new_format(1,:))))
% set(gca, 'YTick', 1:length(FWHM_bank), 'YTickLabel', strsplit(num2str(FWHM_bank)));
% xlabel('real velocity');
% ylabel('FWHM');
% title('K2 Mean');     ConfAxis
% 
% subplot(2,2,2)
% quickViewOneKernel(Utils_OrganizeMatrix_for_ColorPlot(v3_mean),1, 'labelFlag', false)
% set(gca, 'XTick',1:2 * length(vel_range_bank),'XTickLabel', strsplit(num2str(v_real_range_new_format(1,:))))
% set(gca, 'YTick', 1:length(FWHM_bank), 'YTickLabel', strsplit(num2str(FWHM_bank)));
% xlabel('real velocity');
% ylabel('FWHM');
% title('K3 Mean');     ConfAxis
% 
% subplot(2,2,3)
% quickViewOneKernel(Utils_OrganizeMatrix_for_ColorPlot(v23_mean),1, 'labelFlag', false);
% set(gca, 'XTick',1:2 * length(vel_range_bank),'XTickLabel', strsplit(num2str(v_real_range_new_format(1,:))))
% set(gca, 'YTick', 1:length(FWHM_bank), 'YTickLabel', strsplit(num2str(FWHM_bank)));
% xlabel('real velocity');
% ylabel('FWHM');
% title('K2 + K3 Mean');     ConfAxis
% special_name = sprintf('vel_mean_colorplot_%s_ave%d', velocity.distribution,spatial_range);
% text_str = [main_name, ' ' special_name];
% uicontrol('Style', 'text',...
%     'String', text_str,... %replace something with the text you want
%     'Units','normalized',...
%     'Position', [0 0.9 0.15 0.1],'FontSize', 15);
% 
% MySaveFig_Juyue(gcf,main_name, special_name, 'nFigSave',2,'fileType',{'png','fig'});
% close all
end


function Utils_ScatterPlot_VReal_VEst(v_real, v, distribution, FWHM, varargin)
one_bin = 50;
for ii = 1:2:length(varargin)
    eval([varargin{ii} '= varargin{' num2str(ii+1) '};']);
end
switch distribution
    case 'gaussian'
        ScatterXYBinned(v_real, v, 15, one_bin, 'color','r','lineWidth',5,'markerType','o','setAxisLimFlag',1,'plotDashLineFlag',1, 'edge_distribution','histeq');
    case 'uniform'
        ScatterXYBinned(v_real, v, 15, one_bin, 'color','r','lineWidth',5,'markerType','o','setAxisLimFlag',1,'plotDashLineFlag',1, 'edge_distribution','linear');
    case 'binary'
        [v_real_log, ~, ~] = Utils_MoveToLogScale(v_real);
        scatter(v_real_log, v,'r.');
        %         set(gca, 'XTick', v_real_log_map,'XTickLabel',num2str(v_real_range));
        %         scatter(v_real, v, 'r.'); % log scale.
end
% xlabel('real velocity'); ylabel('estimated velocity');
% title(sprintf('FWHM%d', FWHM));

end

function [x,x_range,x_log_map] = Utils_MoveToLogScale(x)
% only works if x is larger than 1.
x_range = sort(unique(x(:)),'ascend');
x_sign = ones(length(x_range), 1);
x_sign(x_range < 0)  = - 1;
% make them into positive number.
x_positive = abs(x_range);
x_positive_log = log(x_positive);
x_log_map = x_positive_log .* x_sign;
% do the mapping now.
for ii = 1:1:length(x_range)
    x(x == x_range(ii)) = x_log_map(ii);
end
end

function v_new = Utils_OrganizeMatrix_for_ColorPlot(v)
[n_vel, n_p, n_fwhm] = size(v);
v_new = zeros(n_fwhm, n_vel * n_p);
for kk = 1:1:n_fwhm
    a = v(:,:,kk); % first row is the smallest FWHM
    v_new(kk, :) = [fliplr(a(1,:)), a(2,:)];
end

end