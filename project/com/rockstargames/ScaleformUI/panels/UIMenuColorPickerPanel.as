class com.rockstargames.ScaleformUI.panels.UIMenuColorPickerPanel extends com.rockstargames.ScaleformUI.panels.BasePanel
{
	var colorsArray = [];
	var hovered = -1;
	var colorIncludedArray = [];
	var BannerSprite;
	var imgPlaceholderMC;
	var honeyComb;

	function UIMenuColorPickerPanel()
	{
		super();
	}

	function set data(d)
	{
		this.colorsArray = com.rockstargames.ScaleformUI.utils.ColorPanelColors.VEHICLE_COLORS;
		switch (this.data[3])
		{
			case 2 :// CHROMES AND METALS
				this.colorIncludedArray = com.rockstargames.ScaleformUI.utils.ColorPanelColors.VEHICLE_METALLIC;
				break;
			case 3 :// CHAMELEON
				this.colorIncludedArray = com.rockstargames.ScaleformUI.utils.ColorPanelColors.VEHICLE_CHAMELEON;
				break;
			default :
				this.colorIncludedArray = com.rockstargames.ScaleformUI.utils.ColorPanelColors.VEHICLE_COLORS;
				break;
		}
		//this.colorsArray.sort(compareColors);
		this.gotoAndStop(1);
		this.BannerSprite.removeMovieClip();
		this.imgPlaceholderMC._y = this.honeyComb._y = 0;

		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.imgPlaceholderMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.honeyComb.maskMC._alpha = 0;
		for (var i = 0; i < this.colorsArray.length; i++)
		{
			var col = this.colorsArray[i];
			var cell = this.honeyComb["colour_" + i];

			if (this.isIncluded(col.i))
			{
				com.rockstargames.ui.utils.Colour.Colourise(cell,col.r,col.g,col.b,100);
				if (cell.mouseCatcher == undefined)
				{
					cell.attachMovie("mouseCatcher","mouseCatcher",cell.getNextHighestDepth(),{_x:-35, _y:-40, _width:cell._width, _height:cell._height});
				}
				cell.mouseCatcher.setupGenericMouseInterface(col.i,14,this.onMouseEvent,[cell, col.i, this]);
			}
			else
			{
				cell._width = 35;
				cell._height = 40;
				com.rockstargames.ui.utils.Colour.Colourise(cell,col.r,col.g,col.b,25);
			}
		}
	}

	function isIncluded(id)
	{
		if (this.colorIncludedArray.length == this.colorsArray.length)
		{
			return true;
		}
		for (var i = 0; i < this.colorIncludedArray.length; i++)
		{
			if (this.colorIncludedArray[i] == id)
			{
				return true;
			}
		}
		return false;
	}

	function onMouseEvent(evtType, targetMC, args)
	{
		var cell = args[0];
		var id = args[1];
		var panel = args[2];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				panel.mOutCP(cell,id);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				if (panel.hovered != -1)
				{
					panel.mOutCP(panel.honeyComb["colour_" + panel.hovered],panel.hovered);
				}
				panel.mOverCP(cell,id);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				panel.mOutCP(cell,id);
		}
	}

	function mOverCP(cell, id)
	{
		cell.swapDepths(this.honeyComb.maskMC);
		cell._width += 30;
		cell._height += 30;
		this.hovered = id;
	}

	function mOutCP(cell, id)
	{
		cell.swapDepths(this.honeyComb.maskMC);
		cell._width -= 30;
		cell._height -= 30;
		this.hovered = -1;
	}

	function compareColors(color1:Object, color2:Object):Number
	{
		if (color1.a != color2.a)
		{
			return color1.a - color2.a;
		}
		else if (color1.r != color2.r)
		{
			return color1.r - color2.r;
		}
		else if (color1.g != color2.g)
		{
			return color1.g - color2.g;
		}
		else
		{
			return color1.b - color2.b;
		}
	}

	function set Value(_v)
	{
		if (this.hovered != -1)
		{
			this.mOutCP(this.honeyComb["colour_" + this.hovered],this.hovered);
		}
		this.hovered = _v;
		this.hovered = _v;
		if (_v == -1)
		{
			return;
		}
		this.mOverCP(this.honeyComb["colour_" + this.hovered],this.hovered);
	}
	function get Value()
	{
		return this.hovered;
	}

	function Clear()
	{
		this.removeMovieClip();
	}
}