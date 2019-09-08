function CDF_datainput


mf=findobj('Tag','CDF_MAIN');udata=get(mf,'UserData');X=udata.X;f=udata.f;
ddata=struct('X',X,'f',f);

datafig=figure( ...
   'Visible','on', ...
   'Name','Data Input', ...
   'Units','Normalized',...
   'Tag','CDF_DATA',...
   'NumberTitle','off');

set(datafig,'UserData',ddata);

uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.4,.875,.2,.1], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.5,...
        'String','Data Input');


% The LAOD1 button
LoadStr1='clear all;if exist(''CDF_tempsavedata.mat'')==2,load CDF_tempsavedata; save CDF_tempinputdata; prom=char(who);XVH=findobj(''Tag'',''XvarHndl'');if length(prom)==0, prom=char(zeros(1,0)); else set(XVH,''Enable'',''on''); OKH=findobj(''Tag'',''OKvarHndl''); set(OKH,''Enable'',''on''); end, set(XVH,''String'',prom);end';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,.75,.4,0.07], ...
        'String','Load data from workspace', ...
        'Callback',LoadStr1);

% The LAOD2 button
LoadStr2='clear all;uiload; save CDF_tempinputdata; prom=char(who);XVH=findobj(''Tag'',''XvarHndl'');if length(prom)==0, prom=char(zeros(1,0)); else set(XVH,''Enable'',''on''); OKH=findobj(''Tag'',''OKvarHndl''); set(OKH,''Enable'',''on'');  end, set(XVH,''String'',prom);';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,.65,.4,0.07], ...
        'String','Load data from file', ...
        'Callback',LoadStr2);


% The SIMULATION button
%SimulStr='CDF_randtool;delete(gcf);CDF_datadraw;clear all;';
SimulStr='CDF_randtool;';
uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,.55,.4,0.07], ...
        'String','Make simulation', ...
        'Callback',SimulStr);

% The Function string
uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.05,.425,.4,.075], ...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'String',' True distribution function (variable denote as ''x''):');

fs=char(f);
uicontrol( ...
        'Tag','FsaveHndl',...
        'Style','edit', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.5,.45,.4,0.075], ...
        'BackgroundColor',[0.9 0.9 0.9], ...
        'ForegroundColor',[0 0 0], ...
        'String',fs);


% Name of the random variable
    uicontrol( ...
        'Style','text', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.5,.6,.3,.1], ...
        'HorizontalAlignment','left',...
        'BackgroundColor',[0.8 0.8 0.8], ...
        'ForegroundColor',[0 0 0], ...
        'FontSize',0.3,...
        'String','Name of the random variable (X):');

    prom=char(zeros(1,0));
    XvarHndl=uicontrol( ...
        'Tag','XvarHndl', ...
        'Style','popup', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[.8,.6,.05,.1], ...
        'String',prom, ...
        'FontSize',0.3,...
        'Enable','off', ...
        'Callback','');
%        'CreateFcn',['x_def=',promdbl(1,:),';'],...
    

top=0.005;
% button OK
OKStr1='clear all; Xp=load(''CDF_tempinputdata'');  mf=findobj(''Tag'',''CDF_MAIN'');udata=get(mf,''UserData'');';
OKStr2='xvh=findobj(''Tag'',''XvarHndl'');Xval=get(xvh,''Value'');Xnames=get(xvh,''String'');callstr=[''udata.X=Xp.'',Xnames(Xval,:),'';''];eval(callstr);';
OKStr3='X=udata.X;  minX=min(X);maxX=max(X); DX=maxX-minX; xx=linspace(minX-0.1*DX,maxX+0.1*DX,201); bounds=[min(X),max(X)];udata.xx=xx;udata.bounds=bounds;';
OKStr4='fsh=findobj(''Tag'',''FsaveHndl'');fs=get(fsh,''String'');fs=deblank(fs);if length(fs)>0,fs=strrep(fs,''.*'',''*'');fs=strrep(fs,''./'',''/'');fs=strrep(fs,''.^'',''^'');fs=strrep(fs,''*'',''.*'');fs=strrep(fs,''/'',''./'');fs=strrep(fs,''^'',''.^'');udata.f=inline(fs);else udata.f=[]; end;set(mf,''UserData'',udata);'; 
OKStr5='LoH=udata.LoH;nL=length(LoH);for ii=3:6, set(LoH(ii),''Enable'',''on''); end,for ii=7:nL, set(LoH(ii),''Enable'',''off''); end;ca=get(mf,''CurrentAxes'');cla(ca,''reset''); delete CDF_tempinputdata.mat; set(gcf,''CloseRequestFcn'',''closereq'');close(gcf);clear all;';
    OKHndl=uicontrol( ...
        'Tag','OKvarHndl', ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.86,top+0.025,.125,0.075], ...
        'String','OK', ...
        'Enable','off', ...
        'Callback',[OKStr1,OKStr2,OKStr3,OKStr4,OKStr5]);

% button Cancel
CancelStr='set(gcf,''CloseRequestFcn'',''closereq'');close(gcf);clear all;';
    CancelHndl=uicontrol( ...
        'Style','push', ...
        'Units','normalized', ...
        'FontUnits','normalized',...
        'Position',[0.05,top+0.025,.125,0.075], ...
        'String','Cancel', ...
        'Callback',CancelStr);


set(datafig,'Position',[0.1059 0.1655 0.7700 0.6898]);