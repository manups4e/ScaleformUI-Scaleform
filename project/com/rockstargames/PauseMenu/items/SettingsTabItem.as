class com.rockstargames.PauseMenu.items.SettingsTabItem
{
	static var CHECKBOX_STYLE_CROSS = 0;
	static var CHECKBOX_STYLE_TICK = 1;
	var checkbox;
	var tickStyle;
	var _checked;
	var bar;
	var barMC;
	var bgMC;
	var maskMC;
	var labelMC;
	var itemMC;
	var sliderMC;
	var highlightMC;
	var itemTextLeft;
	var itemTextRight;
	var _type;
	var selectedIndex;
	var selectedValue;
	var defaultLabelColourEnum;
	var multiListIndex:Number = 0;
	var multiListItems = new Array();
	var barIndex:Number = 0;
	var barValsList = new Array();
	var index;
	var _highlighted;
	var txd_loader;
	var _checkBoxHovered;
	var _hovered;
	var _enabled = true;
	var labelFont = ["$Font2", 0];
	var rightLabelFont = ["$Font2", 0];

	function SettingsTabItem(mc, type, label, enabled, rightLabel, index, param5, param6, param7, param8, param9)
	{
		this.itemMC = mc.attachMovie("settingsListItem", "settings_item_" + mc.getNextHighestDepth(), mc.getNextHighestDepth());
		this.itemTextLeft = this.itemMC.labelMC.titleTF;
		this.itemTextRight = this.itemMC.labelMC.valueTF;
		this.itemMC.labelMC.rMC._visible = this.itemMC.labelMC.lMC._visible = false;
		this.defaultLabelColourEnum = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;
		this.barMC = this.itemMC.barMC;
		this.bgMC = this.itemMC.bgMC;
		this.sliderMC = this.itemMC.sliderMC;
		this.highlightMC = this.itemMC.highlightMC;
		this.maskMC = this.itemMC.maskMC;
		this.labelMC = this.itemMC.labelMC;
		this.sliderMC._visible = false;
		this._type = type;

		if (label != undefined)
		{
			this.itemTextLeft.autoSize = "none";
			this.itemTextLeft._width = 390;
			com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextLeft,label,true);
		}
		this.itemTextLeft._x = 5;
		this.maskMC._visible = false;
		this.barMC.setMask(null);
		switch (this._type)
		{
			case 0 :// item di base?
				this.barMC._visible = false;
				if (rightLabel != undefined && rightLabel != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,rightLabel);
				}
				else
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				}
				this.labelMC.rMC._visible = this.labelMC.lMC._visible = false;
				break;
			case 1 :// ListItem
				this.multiListItems = rightLabel.split(",");
				this.barMC._visible = false;
				this.labelMC.rMC._visible = this.labelMC.lMC._visible = false;
				this.textIndex = index;
				break;
			case 3 :// volume like? masked bar
				this.maskMC._visible = true;
				this.barMC.setMask(this.maskMC);
			case 2 :
				var steps = rightLabel;
				if (steps == "" || steps == undefined)
				{
					steps = 1;
				}
				this.barValsList = [];
				var i = 0;
				while (i < steps + 1)
				{
					this.barValsList.push(100 / steps * i);
					i++;
				}
				var colourIndex = index;
				if (colourIndex == undefined)
				{
					colourIndex = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN;
				}
				this.bar = new com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuColourBar(this.barMC);
				var _loc1_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(colourIndex,_loc1_);
				this.bar.initCustom(_loc1_);
				this.barMC._visible = true;
				this.barMC._alpha = !this.highlighted ? 30 : 100;
				var _loc0_ = false;
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				this.barscale = param5;
				break;
			case 4 :// checkbox
				this.barMC._visible = false;
				this.checkbox = this.itemMC.createEmptyMovieClip("checkBox_" + this.itemMC.getNextHighestDepth(), this.itemMC.getNextHighestDepth());
				this.tickStyle = rightLabel;
				this.checkbox._x = 540;
				this.Checked = index;
				break;
			case 5 :// slider item
				var steps = rightLabel;
				if (steps == "" || steps == undefined)
				{
					steps = 1;
				}
				this.barValsList = [];
				var i = 0;
				while (i < steps + 1)
				{
					this.barValsList.push(100 / steps * i);
					i++;
				}
				var colourIndex = index;
				if (colourIndex == undefined)
				{
					colourIndex = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN;
				}
				this.bar = new com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuColourBar(this.barMC);
				var _loc1_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(colourIndex,_loc1_);
				this.bar.initCustom(_loc1_);
				this.barMC._visible = true;
				this.barMC._alpha = !this.highlighted ? 30 : 100;
				var _loc0_ = false;
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				this.bar.percent(50);
				this.sliderscale = param5;
				break;
		}
		var __reg6 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,__reg6);
		com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,__reg6.r,__reg6.g,__reg6.b,__reg6.a);
		var __reg5 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg5);
		com.rockstargames.ui.utils.Colour.Colourise(this.highlightMC,__reg5.r,__reg5.g,__reg5.b,__reg5.a);
		this.bgMC._visible = false;
		this.highlighted = false;
		this.Enabled = enabled;
		//this.itemMC.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverItem, this.itemMC);
		//this.itemMC.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutItem, this.itemMC);
		//this.itemMC.onDragOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutItem, this.itemMC);
		this.refreshLabelFonts();
	}
	
	function refreshLabelFonts()
	{
		this.updateLabelFont(this.labelFont[0],this.labelFont[1]);
		this.updateRightLabelFont(this.rightLabelFont[0],this.rightLabelFont[1]);
	}
	
	function updateLabelFont(fontName, fontId)
	{
		this.labelFont = new Array(fontName, fontId);
		this.itemTextLeft.embedFonts = true;
		this.itemTextLeft.antiAliasType = "advanced";
		this.itemTextLeft.selectable = false;
		var newFont = this.itemTextLeft.getTextFormat();
		newFont.font = this.labelFont[0];
		this.itemTextLeft.setNewTextFormat(newFont);
		this.itemTextLeft.setTextFormat(newFont);
		//this.updateLabelWidth();
	}

	function updateRightLabelFont(fontName, fontId)
	{
		this.rightLabelFont = new Array(fontName, fontId);
		this.itemTextRight.embedFonts = true;
		this.itemTextRight.antiAliasType = "advanced";
		this.itemTextRight.selectable = false;
		var newFont = this.itemTextRight.getTextFormat();
		newFont.font = this.rightLabelFont[0];
		this.itemTextRight.setNewTextFormat(newFont);
		this.itemTextRight.setTextFormat(newFont);
		//this.updateLabelWidth();
	}

	function set barscale(bi)
	{
		this.barIndex = bi;
		if (this.barIndex > this.barValsList.length - 1)
		{
			this.barIndex = this.barValsList.length - 1;
		}
		else if (this.barIndex < 0)
		{
			this.barIndex = 0;
		}
		this.selectedIndex = this.barIndex;
		this.selectedValue = this.barValsList[this.barIndex];
		this.bar.percent(this.selectedValue,true);
	}

	function get barscale()
	{
		return this.selectedIndex;
	}

	function set sliderscale(bi)
	{
		this.barIndex = bi;
		if (this.barIndex > this.barValsList.length - 1)
		{
			this.barIndex = this.barValsList.length - 1;
		}
		else if (this.barIndex < 0)
		{
			this.barIndex = 0;
		}
		this.selectedIndex = this.barIndex;
		this.selectedValue = this.barValsList[this.barIndex];
		this.bar.setFillX(62 * (this.selectedValue / 100));
	}

	function get sliderscale()
	{
		return this.selectedIndex;
	}

	function set textIndex(ti)
	{
		this.multiListIndex = ti;
		if (this.multiListIndex > this.multiListItems.length - 1)
		{
			this.multiListIndex -= this.multiListItems.length;
		}
		else if (this.multiListIndex < 0)
		{
			this.multiListIndex += this.multiListItems.length;
		}
		this.selectedIndex = this.multiListIndex;
		this.selectedValue = this.multiListItems[this.multiListIndex];
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,this.selectedValue);
		this.itemTextRight.autoSize = true;
		this.itemTextRight._x = this.labelMC.rMC._x - this.itemTextRight._width - 2;
		this.labelMC.lMC._x = this.itemTextRight._x - 2;
		this.labelMC.rMC._visible = this.labelMC.lMC._visible = true;
		this.refreshLabelFonts();
	}

	function get textIndex()
	{
		return this.selectedIndex;
	}

	function set Checked(val)
	{
		this._checked = val;
		var sprite_name = this.getSprite(this._highlighted, this.tickStyle, this._checked);
		this.SetClip(this.checkbox,"commonmenu",sprite_name);
	}

	function get Checked()
	{
		return _checked;
	}


	function set highlighted(_h)
	{
		if (this._enabled)
		{
			this.itemMC.highlightMC._visible = _h;
			var __reg3 = new com.rockstargames.ui.utils.HudColour();
			var __reg2 = new com.rockstargames.ui.utils.HudColour();
			var __reg4 = 100;
			var __reg5 = false;
			if (_h)
			{
				if (this.itemMC.highlightMC._alpha < 100)
				{
					this.itemMC.highlightMC._alpha = 100;
				}
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,__reg3);
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg2);
				if (this._type == 1 && __reg5 == false)
				{
					this.labelMC.rMC._visible = this.labelMC.lMC._visible = true;
					this.itemTextRight._x = this.labelMC.rMC._x - this.itemTextRight._width - 2;
					this.labelMC.lMC._x = this.itemTextRight._x - 2;
				}
				else if (this._type == 2 || this._type == 3 || this._type == 5)
				{
					this.barMC._alpha = 100;
				}
				else if (this._type == 4)
				{
					var sprite_name = this.getSprite(true, this.tickStyle, this.Checked);
					this.SetClip(this.checkbox,"commonmenu",sprite_name);
				}
			}
			else
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg3);
				com.rockstargames.ui.utils.Colour.setHudColour(this.defaultLabelColourEnum,__reg2);
				if (this._type == 1)
				{
					this.labelMC.rMC._visible = this.labelMC.lMC._visible = false;
				}
				else if (this._type == 2 || this._type == 3 || this._type == 5)
				{
					this.barMC._alpha = 30;
				}
				else if (this._type == 4)
				{
					var sprite_name = this.getSprite(false, this.tickStyle, this.Checked);
					this.SetClip(this.checkbox,"commonmenu",sprite_name);
				}
				this.itemTextRight._x = this.highlightMC._width - this.itemTextRight._width - 6;
			}
			if (this.labelMC != undefined)
			{
				com.rockstargames.ui.utils.Colour.Colourise(this.labelMC,__reg2.r,__reg2.g,__reg2.b,__reg4);
			}
			com.rockstargames.ui.utils.Colour.Colourise(this.highlightMC,__reg3.r,__reg3.g,__reg3.b,__reg3);
		}
		this._highlighted = _h;
	}

	function mOverBox(mc)
	{
		if (this._highlighted)
		{
			this._checkBoxHovered = true;
		}
	}
	function mOutBox(mc)
	{
		if (this._highlighted)
		{
			this._checkBoxHovered = false;
		}
	}

	function mOverItem(mc)
	{
		if (this.Enabled)
		{
			this._hovered = true;
			if (!this._highlighted)
			{
				this.highlightMC._visible = true;
				this.highlightMC._alpha = 20;
			}
		}
	}
	function mOutItem(mc)
	{
		this._hovered = false;
		if (!this._highlighted)
		{
			this.highlightMC._visible = false;
			this.highlightMC._alpha = 100;
		}
	}

	function SetClip(targetMC, textureDict, textureName)
	{
		this.txd_loader = new MovieClipLoader();
		this.txd_loader.addListener(this);
		var _loc2_ = "img://" + textureDict + "/" + textureName;
		this.txd_loader.loadClip(_loc2_,targetMC);
	}
	function onLoadInit(target_mc)
	{
		target_mc._width = 24;
		target_mc._height = 24;
		target_mc._x = 540;
		target_mc._y = 0.5;
		//com.rockstargames.ui.utils.Colour.ApplyHudColour(target_mc,!this.highlighted ? this._textColor : this._textHighlightColor);
		this.checkbox.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverBox, this.checkbox);
		this.checkbox.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutBox, this.checkbox);
		delete this.txd_loader;
	}
	function getSprite(_highlighted, _style, _checked)
	{
		return _highlighted ? (_checked ? (_style == com.rockstargames.PauseMenu.items.SettingsTabItem.CHECKBOX_STYLE_TICK ? "shop_box_tickb" : "shop_box_crossb") : "shop_box_blankb") : _checked ? (_style == com.rockstargames.PauseMenu.items.SettingsTabItem.CHECKBOX_STYLE_TICK ? "shop_box_tick" : "shop_box_cross") : "shop_box_blank";
	}

	function get Value()
	{
		var ret;
		switch (this._type)
		{
			case 0 :
				ret = -1;
				break;
			case 1 :
				ret = this.textIndex;
				break;
			case 2 :
			case 3 :
				ret = this.barscale;
				break;
			case 4 :
				ret = this.Checked;
				break;
			case 5 :
				ret = this.sliderscale;
				break;
		}
		return ret;
	}

	function set Value(value)
	{
		switch (this._type)
		{
			case 1 :
				this.textIndex = value;
				break;
			case 2 :
			case 3 :
				this.barscale = value;
				break;
			case 4 :
				this.Checked = value;
				break;
			case 5 :
				this.sliderscale = value;
				break;
		}
	}

	function set Enabled(e)
	{
		this._enabled = e;
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemTextRight,this._enabled ? this.defaultLabelColourEnum : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemTextLeft,this._enabled ? this.defaultLabelColourEnum : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY);
	}
	function get Enabled()
	{
		return this._enabled;
	}
}