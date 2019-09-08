function CDF_kerpars

kerfig=figure( ...
   'Visible','on', ...
   'Name','Kernel Parameters', ...
   'Units','Normalized',...
   'Tag','CDF_KERP',...
   'NumberTitle','off');

uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.3,.85,.4,.1], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.5,...
        'String','Kernel Parameters');

% kernel parameters
mf=findobj('Tag','CDF_MAIN');
udata=get(mf,'UserData');
K=udata.K;
k=K.k;nu=K.nu;mu=K.mu;
ks=num2str(k);
nus=num2str(nu);
mus=num2str(mu);
lb=K.support(1);lbs=num2str(lb);
ub=K.support(2);ubs=num2str(ub);
V=K.var; Vs=num2str(V);
beta=K.beta; bs=num2str(beta);
% list of parameters
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.7,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['Order of the kernel (k):']);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.6,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['Order of the derivative (\nu):']);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.5,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['Smoothness (\mu):']);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.4,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['Support:']);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.3,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['R(K):']);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.1,.2,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['beta_k:']);
% parameters
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.7,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',[ks]);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.6,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',[nus]);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.5,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',[mus]);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.4,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',['[',lbs,',',ubs,']']);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.3,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',[Vs]);
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.2,.6,.08], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.4,...
        'String',[bs]);

% Close button
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.8,0.1,.15,0.05], ...
        'String','Close', ...
        'Callback','delete(gcf)');
end % function
