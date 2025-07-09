class com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	static var CHECKBOX_STYLE_CROSS = 0;
	static var CHECKBOX_STYLE_TICK = 1;
	var multiListIndex = 0;
	var multiListItems = new Array();
	var barIndex = 0;
	var barValsList = new Array();
	var tickStyle;
	var _checked;
	var _lastInList = false;
	var _isChanged = false;
	var _enabled;
	static var noneType = 0;
	static var textType = 1;
	static var progressType = 2;
	static var checkboxType = 3;
	static var voiceBarType = 4;
	static var strBlipType = 5;
	static var ruledType = 6;
	static var sliderType = 7;
	static var emptyType = 8;
	static var textType_tabbed = 10;
	static var sliderType_tabbed = 20;

	function PauseMenuSettingsTextItem()
	{
		super();
		this.itemTextRight = this.labelMC.valueTF;
		this.labelMC.rMC._visible = this.labelMC.lMC._visible = false;
		this.isAdjustable = true;
		this.defaultLabelColourEnum = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;
		this.checkbox = this.createEmptyMovieClip("checkBox_" + this.getNextHighestDepth(), this.getNextHighestDepth());
		_global.gfxExtensions = true;
	}
	function set data(_d)
	{
		super.data = _d;
		this._isChanged = _d[5] == 2;
		if (this._isChanged)
		{
			_d[5] = 1;
		}
		this.itemTextLeft._x = 5;
		if (this.blipLayer)
		{
			this.blipLayer.removeMovieClip();
		}
		if (this.blipLayerBG)
		{
			this.blipLayerBG.removeMovieClip();
		}
		if (this._data[0] != undefined)
		{
			if (this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.strBlipType)
			{
				this.blipLayerBG = this.createEmptyMovieClip("blipLayerBG", 1000);
				this.blipLayer = this.createEmptyMovieClip("blipLayer", 1002);
				var TextWithBlips = new com.rockstargames.ui.utils.Text();
				TextWithBlips.setTextWithIcons(this._data[0],this.blipLayer,this.itemTextLeft,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
				TextWithBlips.setTextWithIcons(this._data[0],this.blipLayerBG,this.itemTextLeft,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
				for (var eltName in this.blipLayerBG)
				{
					with (this.blipLayerBG[eltName])
					{
						_width = _width + 2;
						_height = _height + 2.5;
						_x = _x + 0.25;
						_y = _y + 0.5;
					}
				}
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.blipLayerBG,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
			}
			else
			{
				this.itemTextLeft.autoSize = "none";
				this.itemTextLeft._width = 390;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextLeft,this._data[0],true);
			}
		}
		if (this.fbMC != undefined)
		{
			this.fbMC.removeMovieClip();
		}
		var FacebookLinkage = -1155176764;
		if (this.menuID == FacebookLinkage + this.menuPrefOffset)
		{
			this.type = com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.facebookType;
		}
		this.maskMC._visible = false;
		this.checkbox._visible = false;
		this.barMC.setMask(null);
		var indentTabs = 0;
		if (this.type >= com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.sliderType_tabbed)
		{
			indentTabs = this.type - com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.sliderType_tabbed;
			this.type = com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.sliderType_tabbed;
		}
		else if (this.type >= com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.textType_tabbed)
		{
			indentTabs = this.type - com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.textType_tabbed;
			this.type = com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.textType;
		}
		var i = 0;
		while (i < indentTabs)
		{
			this.itemTextLeft._x += 5;
			i++;
		}
		switch (this.type)
		{
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.ruledType :
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.emptyType :
				var xp = 289 - this.itemTextLeft.textWidth * 0.5;
				this.itemTextLeft._x = Math.ceil(xp);
				this.barMC._visible = false;
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				this.isSelectable = 0;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.noneType :
				this.barMC._visible = false;
				if (this.data[1] != undefined && this.data[1] != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,this.data[1]);
				}
				else
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				}
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.strBlipType :
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.textType :
				this.multiListItems = this.data[1].split(",");
				this.barMC._visible = false;
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				this.textIndex = this.initialIndex;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.checkboxType :
				this.barMC._visible = false;
				this.checkbox._visible = true;
				this.tickStyle = this.data[1];
				this.checkbox._x = 540;
				this.Checked = this.data[2];
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.voiceBarType :
				this.maskMC._visible = true;
				this.barMC.setMask(this.maskMC);
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.sliderType_tabbed :
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.progressType :
				var steps = this.data[1];
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
				var colourIndex = this.data[2];
				if (colourIndex == undefined)
				{
					colourIndex = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN;
				}
				this.bar = new com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuColourBar(this.barMC);
				var _loc1_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(colourIndex,_loc1_);
				this.bar.initCustom(_loc1_);
				this.barMC._visible = true;
				this.barMC._alpha = !this.isSelectable ? 30 : 100;
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				this.barscale = this.initialIndex;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.sliderType :// SliderBar
				var steps = this.data[1];
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
				var colourIndex = this.data[2];
				if (colourIndex == undefined)
				{
					colourIndex = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN;
				}
				this.bar = new com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuColourBar(this.barMC);
				var _loc1_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(colourIndex,_loc1_);
				this.bar.initCustom(_loc1_);
				this.barMC._visible = true;
				this.barMC._alpha = !this.isSelectable ? 30 : 100;
				this.labelMC.lMC._visible = _loc0_ = false;
				this.labelMC.rMC._visible = _loc0_;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
				this.bar.percent(50);
				this.sliderscale = this.initialIndex;
				break;
			default :
				this.barMC._visible = false;
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,"");
		}
		var bgColour = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,bgColour);
		com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,bgColour.r,bgColour.g,bgColour.b,bgColour.a);
		var highlightColour = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,highlightColour);
		com.rockstargames.ui.utils.Colour.Colourise(this.highlightMC,highlightColour.r,highlightColour.g,highlightColour.b,highlightColour.a);
		if (this.isLastItem)
		{
			this.bgMC._height = _loc0_ = 25;
			this.highlightMC._height = _loc0_;
		}
		else
		{
			this.bgMC._height = 27;
			this.highlightMC._height = this.bgMC._height - 2;
		}
		this.bgMC._visible = false;
		this.highlighted = this._highlighted;
		this.displayAsChanged();
	}
	function get isEmptySpace()
	{
		return this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.emptyType;
	}
	function set isLastItem(l)
	{
		this._lastInList = l;
	}
	function get isLastItem()
	{
		return this._lastInList;
	}
	function initStoreMethod(func, scope)
	{
		this.storeFunc = func;
		this.storeScope = scope;
	}
	function set barscale(bi)
	{
		this.barIndex = bi;
		this.selectedIndex = this.barIndex;
		this.selectedValue = this.barValsList[this.barIndex];
		this.bar.percent(this.selectedValue);
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
		this.selectedIndex = this.multiListIndex;
		this.selectedValue = this.multiListItems[this.multiListIndex];
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,this.selectedValue);
		this.itemTextRight.autoSize = true;
		this.itemTextRight._x = this.labelMC.rMC._x - this.itemTextRight._width - 2;
		this.labelMC.lMC._x = this.itemTextRight._x - 2;
		this.labelMC.rMC._visible = this.labelMC.lMC._visible = true;
	}
	function stepVal(dir)
	{
		switch (this.type)
		{
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.strBlipType :
			case 1 :
				this.multiListIndex += dir;
				if (this.multiListIndex < 0)
				{
					this.multiListIndex = this.multiListItems.length - 1;
				}
				if (this.multiListIndex > this.multiListItems.length - 1)
				{
					this.multiListIndex = 0;
				}
				this.textIndex = this.multiListIndex;
				this.storeFunc.apply(this.storeScope,[this.index, this.multiListIndex]);
				this.setPref(this.multiListIndex);
				break;
			case 2 :
			case 4 :
				this.barIndex += dir;
				if (this.barIndex < 0)
				{
					this.barIndex = 0;
				}
				if (this.barIndex > this.barValsList.length - 1)
				{
					this.barIndex = this.barValsList.length - 1;
				}
				this.barscale = this.barIndex;
				this.storeFunc.apply(this.storeScope,[this.index, this.barIndex]);
				this.setPref(this.barIndex);
				break;
			case 7 :
				this.barIndex += dir;
				if (this.barIndex < 0)
				{
					this.barIndex = 0;
				}
				if (this.barIndex > this.barValsList.length - 1)
				{
					this.barIndex = this.barValsList.length - 1;
				}
				this.sliderscale = this.barIndex;
				this.storeFunc.apply(this.storeScope,[this.index, this.barIndex]);
				this.setPref(this.barIndex);
		}
		this.highlighted = this._highlighted;
	}
	function set isChanged(changed)
	{
		this._isChanged = changed;
		this.displayAsChanged();
	}
	function get isChanged()
	{
		return this._isChanged;
	}
	function setPrefMouse(val)
	{
		if (this.uniqueID >= 0 && this.uniqueID < this.menuPrefOffset)
		{
			com.rockstargames.ui.game.GameInterface.call("HANDLE_MOUSE_LEFT_RIGHT",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,this.uniqueID,val);
		}
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
		this.highlightMC._visible = _h;
		var _loc3_ = new com.rockstargames.ui.utils.HudColour();
		var _loc2_ = new com.rockstargames.ui.utils.HudColour();
		var _loc4_ = 100;
		var _loc5_ = false;
		if (this.isSelectable <= 0 || this.isSelectable == 2)
		{
			if (this.type != com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.ruledType && this.type != com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.emptyType)
			{
				_loc5_ = true;
				_loc4_ = !_h ? 30 : 60;
			}
		}
		if (_h)
		{
			com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,_loc3_);
			com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,_loc2_);
			if ((this.type == 1 || this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.strBlipType) && _loc5_ == false)
			{
				this.labelMC.rMC._visible = this.labelMC.lMC._visible = true;
				this.itemTextRight._x = this.labelMC.rMC._x - this.itemTextRight._width - 2;
				this.labelMC.lMC._x = this.itemTextRight._x - 2;
			}
			else
			{
				this.itemTextRight._x = this.highlightMC._width - this.itemTextRight._width - 6;
			}
		}
		else
		{
			com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,_loc3_);
			com.rockstargames.ui.utils.Colour.setHudColour(this.defaultLabelColourEnum,_loc2_);
			if (this.type == 1 || this.type == com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.strBlipType)
			{
				this.labelMC.rMC._visible = this.labelMC.lMC._visible = false;
			}
			this.itemTextRight._x = this.highlightMC._width - this.itemTextRight._width - 6;
		}
		if (this.type == 3)
		{
			var sprite_name = this.getSprite(_h, this.tickStyle, this.Checked);
			this.SetClip(this.checkbox,"commonmenu",sprite_name);
		}
		if (this.labelMC != undefined)
		{
			com.rockstargames.ui.utils.Colour.Colourise(this.labelMC,_loc2_.r,_loc2_.g,_loc2_.b,_loc4_);
		}
		this._highlighted = _h;
	}
	function mInit()
	{
		super.mInit();
		delete this.bMC.onRelease;
		delete this.bMC.onPress;
		this.bMC.onPress = gfx.utils.Delegate.create(this, this.mPress);
	}
	function mOver()
	{
		if (this.isSelectable)
		{
			_level0.TIMELINE.M_OVER_EVENT(this.index,this.columnID,this);
		}
	}
	function mOut()
	{
		if (this.isSelectable)
		{
			_level0.TIMELINE.M_OUT_EVENT(this.index,this.columnID);
		}
	}
	function mPress()
	{
		if (this.isSelectable)
		{
			var _loc2_ = this._xmouse;
			var _loc9_ = this._ymouse;
			var _loc5_ = false;
			var _loc4_ = false;
			var _loc6_ = 289;
			var _loc3_ = 40;
			if (this.type == 2 || this.type == 4 || this.type == 7)
			{
				_loc3_ = 71;
			}
			var _loc7_ = this.bgMC._width - _loc3_;
			var _loc8_ = this.bgMC._width - _loc3_;
			if (_loc2_ > _loc8_)
			{
				_loc4_ = true;
			}
			if (_loc2_ > _loc6_ && _loc2_ < _loc7_)
			{
				_loc5_ = true;
			}
			if (!this.highlighted)
			{
				_level0.TIMELINE.M_PRESS_EVENT(this.index,this.columnID,false);
			}
			else if (this.type == 0 || this.type == 1 || this.type == 3 || this.type == 5 || this.type == 6)
			{
				/*
				static var noneType = 0;
				static var textType = 1;
				static var progressType = 2;
				static var checkboxType = 3;
				static var voiceBarType = 4;
				static var strBlipType = 5;
				static var ruledType = 6;
				static var sliderType = 7;
				static var emptyType = 8;
				static var textType_tabbed = 10;
				static var sliderType_tabbed = 20;
				*/
				_level0.TIMELINE.M_PRESS_EVENT(this.index,this.columnID,true);
			}
			else if (_loc4_)
			{
				_level0.TIMELINE.clickRepeat.repeatStart(this,this.setPrefMouse,[1]);
				this.setPrefMouse(1);
			}
			else if (_loc5_)
			{
				_level0.TIMELINE.clickRepeat.repeatStart(this,this.setPrefMouse,[-1]);
				this.setPrefMouse(-1);
			}
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
		return _highlighted ? (_checked ? (_style == com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.CHECKBOX_STYLE_TICK ? "shop_box_tickb" : "shop_box_crossb") : "shop_box_blankb") : _checked ? (_style == com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuSettingsTextItem.CHECKBOX_STYLE_TICK ? "shop_box_tick" : "shop_box_cross") : "shop_box_blank";
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