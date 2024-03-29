function Figure5H_Supplementary_5_3_CD_kernelPerformance_fixedskewness()

synthetic_flag_bank = ones(11, 1); % natural scene are the first. from most negative to the most positive.
synthetic_type_bank = {'pixel_dist_fixedskew_125_neg',...
    'pixel_dist_fixedskew_1_neg',...
    'pixel_dist_fixedskew_075_neg',...
    'pixel_dist_fixedskew_050_neg',...
    'pixel_dist_fixedskew_025_neg',...
    'pixel_dist_ivar',...
    'pixel_dist_fixedskew_025',...
    'pixel_dist_fixedskew_050',...
    'pixel_dist_fixedskew_075',...
    'pixel_dist_fixedskew_1',...
    'pixel_dist_fixedskew_125'};

% x_tick_str = mat2cell(num2str([-1.25:0.25:1.25]'));
x_tick_str = {'-1.25','-1','-0.75','-0.5','-0.25','-0','0.25','0.5','0.75','1','1.25'};
x_value = [-5:1:5];
data_symmetric_set = summary_of_different_manipulation_groups(synthetic_flag_bank, synthetic_type_bank, [], x_tick_str, x_value, 0);

%% save data tmp? not necessary...
NS_Sweep_Contrast_Velocity(data_symmetric_set,...
                            'x_tick',2:2:length(x_value),...
                            'x_tick_str', x_tick_str,...
                            'condition_discard', [],... 
                            'x_value', x_value,...
                            'x_label_str','skewness',...
                            'paper_plot_flag', 1);
end
% MySaveFig_Juyue(gcf, 'SyntheticAcrossScene_fixedskew_rstim_meansub_ivar','group_by_order','nFigSave',2,'fileType',{'fig', 'pdf'});