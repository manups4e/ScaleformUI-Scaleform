class com.rockstargames.ScaleformUI.windows.UIMenuDetailsWindow extends MovieClip
{
	var _parentMenu;
	var detail0;
	var detail1;
	var detail2;
	var _background;
	var DESC_TYPE_TXT = 0;
	var DESC_TYPE_SC = 1;
	var DESC_TYPE_INV_SENT = 2;
	var startStatLabelAnim = false;
	var leftEmblemMC;
	var wheelRadius;
	var currentAngle;
	var statsMaxDegrees = [];
	var PI_OVER_180 = 0.017453292519943295;
	var TextureID;
	var totalStats;
	var statWheelMC;
	var headerBGMC;
	var item0TF;
	var item1TF;
	var item2TF;
	var cMC;
	var rankEmblemMC;
	var rankEmblemBG;
	function UIMenuDetailsWindow()
	{
		super();
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.headerBGMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.item0TF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.item1TF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.item2TF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
	}
	function set data(d)
	{
		// parentMenu, id, d[2], d[3], d[4], txd, txn, x, y, w, h
		this.statsMaxDegrees = new Array  ;
		this.totalStats = 0;
		this.currentAngle = 0;
		this.statWheelMC.wheelMC.clear();
		this._parentMenu = d[0];
		this._background = this.headerBGMC;

		this.detail0 = this.item0TF;
		this.detail1 = this.item1TF;
		this.detail2 = this.item2TF;
		com.rockstargames.ui.utils.UIText.setSizedText(this.detail0,d[2],true,true);
		com.rockstargames.ui.utils.UIText.setSizedText(this.detail1,d[3],true,true);
		com.rockstargames.ui.utils.UIText.setSizedText(this.detail2,d[4],true,true);

		if (d[7] == undefined)
		{
			d[7] = 0;
		}
		if (d[8] == undefined)
		{
			d[8] = 0;
		}
		if (d[9] == undefined)
		{
			d[9] = 64;
		}
		if (d[10] == undefined)
		{
			d[10] = 64;
		}
		if (d[5] != undefined && d[5] != "" && d[6] != undefined && d[6] != "")
		{
			this.statWheelMC._visible = false;
			if (this.leftEmblemMC == undefined)
			{
				this.leftEmblemMC = this.cMC.attachMovie("txdLoader","leftEmblem",this.getNextHighestDepth());
			}
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipWithPos(this.leftEmblemMC,d[5],d[6],d[7],d[8],d[9],d[10],this.txdloaded,this);
		}
		else
		{
			this.TextureID = d[5];
			if (this.TextureID == "statWheel")
			{
				this.statWheelMC._visible = true;
				this.rankEmblemMC._visible = false;
				this.rankEmblemBG._visible = false;
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.statWheelMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.statWheelMC.bgFillMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
				this.statWheelMC.bgFillMC._alpha = 20;
				this.wheelRadius = this.statWheelMC.bgFillMC._width * 0.5;
				this.statWheelMC.createEmptyMovieClip("wheelMC",this.getNextHighestDepth(),{_x:0,_y:0});
				this.statWheelMC.wheelMC.setMask(this.statWheelMC.maskMC);
			}
			else
			{
				this.statWheelMC._visible = false;
				this.rankEmblemMC._visible = true;
				this.rankEmblemBG._visible = true;
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rankEmblemMC,116);
			}
		}
	}

	function set extraData(d)
	{
		this.clearStats();
		for (var i in d)
		{
			var stat = d[i];
			this.addStatToWheel(stat[0],stat[1]);
		}
	}

	function txdloaded()
	{
		this.rankEmblemMC._visible = false;
		this.rankEmblemBG._visible = false;
		this.leftEmblemMC._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.leftEmblemMC,0.2,{_alpha:100});
	}

	function clearStats()
	{
		this.statsMaxDegrees = [];
	}

	function addStatToWheel(pctComplete,statColourEnum)
	{
		pctComplete = Math.min(pctComplete,100);
		var stat = new com.rockstargames.ScaleformUI.windows.WheelStat(pctComplete,statColourEnum);
		this.statsMaxDegrees.push(stat);
		this.updateStatWheel();
	}

	function updateStatWheel()
	{
		this.currentAngle = 0;
		this.statWheelMC.wheelMC.clear();
		this.statWheelMC.wheelMC.removeMovieClip();
		this.totalStats = 0;
		this.statWheelMC.createEmptyMovieClip("wheelMC",this.getNextHighestDepth(),{_x:0,_y:0});
		this.statWheelMC.wheelMC.setMask(this.statWheelMC.maskMC);
		for (var i in this.statsMaxDegrees)
		{
			this.totalStats = this.totalStats + this.statsMaxDegrees[i].Percentage;
		}
		for (var stat in this.statsMaxDegrees)
		{
			if (this.statsMaxDegrees[stat].Percentage > 0)
			{
				var perc = this.statsMaxDegrees[stat].Percentage / this.totalStats;
				var loc = this.currentAngle + (perc * 360);
				this.drawArc(this.currentAngle,loc,this.statsMaxDegrees[stat].Colour);
				this.currentAngle = loc;
			}
		}
	}

	function updateStatistic(id,pctComplete,statColourEnum)
	{
		pctComplete = Math.min(pctComplete,100);
		this.statsMaxDegrees[id] = new com.rockstargames.ScaleformUI.windows.WheelStat(pctComplete,statColourEnum);
		this.updateStatWheel();
	}

	function drawArc(startAngle,endAngle,colourId)
	{
		endAngle = Math.min(endAngle,360);
		var _loc5_ = this.statWheelMC.wheelMC;
		var _loc6_ = new com.rockstargames.ui.utils.HudColour  ;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(colourId,_loc6_);
		_loc5_.moveTo(0,0);
		_loc5_.beginFill(com.rockstargames.ui.utils.Colour.RGBToHex(_loc6_.r,_loc6_.g,_loc6_.b),100);
		var _loc2_ = startAngle;
		var _loc4_ = 0.25;
		while ((_loc2_ <= endAngle))
		{
			this.lineToPtOnWheel(_loc2_);
			_loc2_ = _loc2_ + _loc4_;
		}
		if ((_loc2_ < endAngle + _loc4_))
		{
			this.lineToPtOnWheel(endAngle);
		}
		_loc5_.lineTo(0,0);
		_loc5_.endFill();
	}
	function lineToPtOnWheel(angle)
	{
		this.statWheelMC.wheelMC.lineTo(Math.sin((angle * this.PI_OVER_180)) * this.wheelRadius, -  Math.cos((angle * this.PI_OVER_180)) * this.wheelRadius);
	}

	function set Width(w)
	{
		this._width = w;
	}


	function Clear()
	{
		this.currentAngle = 0;
		this.statWheelMC.wheelMC.clear();
		this.totalStats = 0;
		if (this.leftEmblemMC != undefined)
		{
			if (this.leftEmblemMC.isLoaded)
			{
				this.leftEmblemMC.removeTxdRef();
			}
		}
		this.removeMovieClip();
	}
}