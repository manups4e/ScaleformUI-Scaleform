class com.rockstargames.ScaleformUI.panels.UIMenuPercentagePanel extends com.rockstargames.ScaleformUI.panels.BasePanel
{
	var _slider;
	var _sliderColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;
	var _max = 100;
	var _value = 0;
	var _coords;
	var hover = -1;
	var opacityTF;
	var minTF;
	var maxTF;
	var mouseCatcher;

	function UIMenuPercentagePanel()
	{
		super();
		this._slider = this.attachMovie("GenericColourBar", "progress_bar", this.getNextHighestDepth(), {_x:4, _y:30});
		this.attachMovie("mouseCatcher","mouseCatcher",this.getNextHighestDepth(),{_width:this._width, _height:this._height});
	}
	
	function set data(d)
	{
		//parentItem, title, minText, maxText, startIndex		
		super.data = d;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.opacityTF.embedFonts = true;
		this.opacityTF.antiAliasType = "advanced";
		com.rockstargames.ui.utils.UIText.setSizedText(this.opacityTF,this.data[3],true,true);
		this.minTF.embedFonts = true;
		this.minTF.antiAliasType = "advanced";
		com.rockstargames.ui.utils.UIText.setSizedText(this.minTF,this.data[4],true,true);
		this.maxTF.embedFonts = true;
		this.maxTF.antiAliasType = "advanced";
		com.rockstargames.ui.utils.UIText.setSizedText(this.maxTF,this.data[5],true,true);
		this._slider.init(this._sliderColor,279,8);
		if (this.data[6] != undefined)
		{
			this.Value = this.data[6];
		}
		else
		{
			this.Value = 0;
		}
		this.mouseCatcher.setupGenericMouseInterface(0,11,this.onMouseEvent,[this]);
	}

	function onMouseEvent(evtType, targetMC, args)
	{
		var panel = args[0];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				panel.mOutPP();
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				panel.mOverPP();
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				break;
		}
	}

	function mOverPP(mc)
	{
		this._hovered = true;
	}
	function mOutPP(mc)
	{
		this._hovered = false;
	}
	function get Value()
	{
		return this._value;
	}

	function set Value(val)
	{
		this._value = Math.max(0, Math.min(val, this._max));
		this._slider.percent(this._value);
	}

	function SetCoords()
	{
		var m = _xmouse;
		var val = (m - this._slider._x) / this._slider._width * this._max;
		this._value = Math.max(0, Math.min(val, this._max));
		this._slider.percent(this._value);
	}
	function get Coords()
	{
		return this._slider._x + this._slider._width;
	}
	function Clear()
	{
		this.removeMovieClip();
	}
}