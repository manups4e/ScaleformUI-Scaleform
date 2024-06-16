class com.rockstargames.PauseMenu.header.BarItem extends MovieClip
{
	var _title;
	var mc;
	var tempColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_DIMMED;
	var isLocked:Boolean = false;
	var mIndex:Number = 0;
	var getNextHighestDepth;
	var PMB;
	var _highlight;
	var _menuenum;
	var _mywidth;
	var _rollover;
	var lockMC;
	var tabMC;
	var textMC;
	var warnAlertText;
	var _parentBar;

	function BarItem()
	{
		super();
		this.tabMC._alpha = 0;
		this.rollover = false;
		this.mycolour = -13799751;
	}

	function mRollOver()
	{
		if (!this.isLocked && !this.highlight)
		{
			this.rollover = true;
		}
	}
	function mRollOut()
	{
		if (!this.isLocked)
		{
			this.rollover = false;
		}
	}

	function set label(str)
	{
		this._title = str;
		var _loc3_ = this.mc.textMC;
		_loc3_.txtString._width = this.width;
		_loc3_.resetDelay();
		_loc3_.setDelayTimeout(120);
		_loc3_.txtString.text = str;
		//com.rockstargames.ui.utils.UIText.setSizedText(this.mc.textMC.txtString,str,true,false);
	}

	function get label()
	{
		return this._title;
	}

	function set highlight(h)
	{
		var __reg3 = new com.rockstargames.ui.utils.HudColour();
		var __reg4 = new com.rockstargames.ui.utils.HudColour();
		var __reg2 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg3);
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,__reg4);
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg2);
		this.mc.textMC.resetDelay();
		if (h)
		{
			this.tabMC._alpha = 100;
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.bgMC,__reg2.r,__reg2.g,__reg2.b,__reg2.a);
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.textMC,__reg3.r,__reg3.g,__reg3.b,__reg3.a);
			if (this.isLocked)
			{
				com.rockstargames.ui.utils.Colour.Colourise(this.lockMC,__reg3.r,__reg3.g,__reg3.b,__reg3.a);
			}
			this.mc.textMC.setDelayTimeout(120);
		}
		else
		{
			this.tabMC._alpha = 0;
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.bgMC,__reg4.r,__reg4.g,__reg4.b,__reg4.a);
			com.rockstargames.ui.utils.Colour.Colourise(this.mc.textMC,__reg2.r,__reg2.g,__reg2.b,__reg2.a);
			if (this.isLocked)
			{
				com.rockstargames.ui.utils.Colour.Colourise(this.lockMC,__reg2.r,__reg2.g,__reg2.b,__reg2.a);
			}
		}
		this._highlight = h;
	}

	function get highlight()
	{
		return this._highlight;
	}

	function set mycolour(col)
	{
		var __reg3 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(col,__reg3);
		com.rockstargames.ui.utils.Colour.Colourise(this.tabMC,__reg3.r,__reg3.g,__reg3.b,!this._highlight ? 0 : 100);
	}

	function set locked(l)
	{
		this.isLocked = Boolean(l);
		this.lockMC._alpha = this.isLocked ? 100 : 0;
		this._alpha = this.isLocked ? 50 : 100;
	}

	function set bespokeColour(cID)
	{
		if (cID != undefined && cID != false)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.mc.bgMC,cID);
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.mc.textMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		}
	}

	function setAlertText(warnStr, col)
	{
		if (this.warnAlertText)
		{
			this.warnAlertText.removeMovieClip();
		}
		if (warnStr != "")
		{
			this.warnAlertText = com.rockstargames.ui.components.UITextField(this.attachMovie("uiTextField", "uiTF", this.getNextHighestDepth(), {_y:1}));
			this.warnAlertText.init(17,com.rockstargames.gtav.utils.GTAVUIConfig.CONDENSED_FONT_NOT_GAMERNAME,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,true);
			this.warnAlertText.setText(warnStr);
			this.warnAlertText.setBgColour(col);
			this.warnAlertText._x = this.mc.bgMC._width * 0.5 + this.mc.textMC.txtString.textWidth * 0.5 + 5;
			this.warnAlertText._y = 7;
		}
	}

	function set width(w)
	{
		this.tabMC._width = this.mc.bgMC._width = this.mc.rolloverMC._width = this._mywidth = w;
		this.realignText();
	}

	function get width()
	{
		return this._mywidth;
	}

	function set rollover(h)
	{
		if (h)
		{
			this.mc.rolloverMC._alpha = 20;
		}
		else
		{
			this.mc.rolloverMC._alpha = 0;
		}
		this._rollover = h;
	}

	function set menuenum(m)
	{
		this._menuenum = m;
	}
	function get menuenum()
	{
		return this._menuenum;
	}

	function realignText(widthSpan)
	{
		var __reg2 = this._mywidth;
		if (widthSpan)
		{
			var __reg4 = 2;
			__reg2 = this._mywidth * widthSpan + __reg4 * (widthSpan - 1);
			this.tabMC._width = this.mc.bgMC._width = this.mc.rolloverMC._width = __reg2;
			this._mywidth = __reg2;
		}
		this.mc.textMC._x = __reg2 / 2 - this.mc.textMC.txtString._width / 2 - 1;
		this.lockMC._x = this.mc.textMC._x + this.mc.textMC.txtString._width + 5;
		this.mc.textMC.resetDelay();
		this.mc.textMC.setDelayTimeout(90);
	}

	function resizeTabPx(widthSpanPx)
	{
		this.tabMC._width = this.mc.bgMC._width = this.mc.rolloverMC._width = widthSpanPx;
		this.mc.textMC.txtString._x = widthSpanPx / 2 - this.mc.textMC.txtString._width / 2;
		this.lockMC._x = this.mc.textMC.txtString._x + this.mc.textMC.txtString._width + 5;
		if (this.warnAlertText)
		{
			this.warnAlertText._x = this.mc.bgMC._width * 0.5 + this.mc.textMC.txtString.textWidth * 0.5 + 5;
		}
	}

}