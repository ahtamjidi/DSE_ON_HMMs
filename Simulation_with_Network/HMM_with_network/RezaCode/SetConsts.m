function SetConsts()
    global Consts
    %% Set Consts
    Consts.BaseRate = 1;
    Consts.MarkovRate = 360;
	Consts.ObsRate = 60;
    Consts.NetRate = 1;
    Consts.SimTime = 500*Consts.MarkovRate;
    Consts.PixelLen = 1;
    Consts.GT_InitState = 2;
    %% Check Consts
    %% Check Rates
    if mod(Consts.MarkovRate,Consts.BaseRate) ~=0
        error('Internal Error: MarkovRate should be an integer multiplier of the BaseRate!');
    end
    if mod(Consts.ObsRate,Consts.BaseRate) ~=0
        error('Internal Error: ObsRate should be an integer multiplier of the BaseRate!');
    end
    if mod(Consts.NetRate,Consts.BaseRate) ~=0
        error('Internal Error: NetRate should be an integer multiplier of the BaseRate!');
    end
    %%
end