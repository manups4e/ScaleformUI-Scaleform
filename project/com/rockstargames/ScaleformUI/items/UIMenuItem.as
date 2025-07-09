class com.rockstargames.ScaleformUI.items.UIMenuItem extends com.rockstargames.ScaleformUI.items.BaseMenuItem
{
	static var CHECKBOX_STYLE_CROSS = 0;
	static var CHECKBOX_STYLE_TICK = 1;
	static var BASIC_ITEM = 0;
	static var LIST_ITEM = 1;
	static var CHECKBOX_ITEM = 2;
	static var SLIDER_ITEM = 3;
	static var PROGRESS_ITEM = 4;
	static var STATS_ITEM = 5;
	static var SEPARATOR_ITEM = 6;
	var mc;
	var _heritage = false;
	var bar;
	var checkbox;
	var tickStyle;
	var _checked;
	var rightTextTF;
	var rightText;
	var rightBadgeMC;
	var leftBadgeMC;
	var rightBadgeId = com.rockstargames.ScaleformUI.utils.Badges.NONE;
	var leftBadgeId = com.rockstargames.ScaleformUI.utils.Badges.NONE;
	var rightBadgeTxd;
	var rightBadgeTxn;
	var leftBadgeTxd;
	var leftBadgeTxn;
	var _data;
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
	var leftArrow;
	var Arrow;
	var _max;
	var _multiplier;
	var divider;
	var _sliderColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_FREEMODE;
	var _slider;
	var customLeftArrow;
	var customRightArrow;
	var hover = -1;
	var jumpable = false;
	var mouseCatcher;
	static var DEFAULT_SCROLL_SPEED = 50;
	var inverseScrollSpeed;
	var goalX;
	var duration;
	var scrollTimeout;
	var labelFont;
	var rightLabelFont;
	var rightTextY = 0;
	var rightTextX = 0;
	var rightArrow;
	var wasH = false;
	var bgMC;
	var labelMC;
	var separator;
	var labelX;
	var rightLabelX;
	var RlabelTF;
	var MOUSE_EVT;
	var storeFunc;
	var storeScope;
	var isSelectable;
	var darkbarMC;
	var maskMC;
	var darkmaskMC;
	var txt;
	var keepWhite;

	function UIMenuItem()
	{
		super();
		this.leftTextTF.antiAliasType = "advanced";
		this.leftTextTF.selectable = false;
		this.leftTextTF = this.labelMC.txtString;
		this.rightTextTF = this.RlabelTF;
		this.rightText = "";
		this.jumpable = false;
		this.bar = this.attachMovie("GenericColourBar", "progress_bar", this.getNextHighestDepth(), {_y:9.80});
		this.bar._visible = false;
		this.barMC = this.attachMovie("GenericColourBar", "darkbarMC", this.getNextHighestDepth());
		this.darkbarMC = this.attachMovie("GenericColourBar", "barMC", this.getNextHighestDepth());
		this.barMC._visible = this.darkbarMC._visible = false;
		this.separator = this.attachMovie("separator", "_separator_", this.getNextHighestDepth());
		this.rightBadgeMC = this.attachMovie("txdLoader", "RightBadge", this.getNextHighestDepth());
		this.leftBadgeMC = this.attachMovie("txdLoader", "LeftBadge", this.getNextHighestDepth());
		this.txt = new com.rockstargames.ui.utils.Text();
		//this.bMC.removeMovieClip();
	}

	function initStoreMethod(func, scope)
	{
		this.storeFunc = func;
		this.storeScope = scope;
	}

	function set data(d)
	{
		//label, blink, itemdata[]
		//parentMenu, index, id, str, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13
		//parentMenu, this.data[1], this.data[2], this.data[3], this.data[4], this.data[5], this.data[6], this.data[7], this.data[8], this.data[9], this.data[10], this.data[11], this.data[12], this.data[13], this.data[14], this.data[15], this.data[16]
		super.data = d;
		if (d[0] instanceof com.rockstargames.ScaleformUI.UIMenu)
		{
			this.MOUSE_EVT = new com.rockstargames.ui.mouse.MOUSE_EVENTS();
			this.MOUSE_EVT.INTERFACE_TYPE = 10;
			this.MOUSE_EVT.UI_MOVIE = 4;
			this.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER);
			this.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT);
			this.onDragOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_DRAG_OVER);
			this.onDragOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_DRAG_OUT);
			this.onPress = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS);
			this.onRelease = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE);
			this.onReleaseOutside = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE);
		}
		this.barMC._visible = this.darkbarMC._visible = false;
		this.darkmaskMC._visible = this.maskMC._visible = false;
		this.bar._visible = false;
		this.separator._visible = false;
		this.checkbox._visible = false;
		this.rightArrow._visible = this.leftArrow._visible = false;
		this.rightTextTF._visible = false;
		this._heritage = false;
		//this.rightBadgeMC.clearTxd();
		//this.leftBadgeMC.clearTxd();
		this.labelMC._x = 5;
		this.leftTextTF._x = 0;
		this.rightText = "";
		this.rightTextTF._x = 0;
		this.rightTextTF.text = "";
		this.leftArrow.gotoAndStop(1);
		this.rightArrow.gotoAndStop(1);
		//this.mouseCatcher.swapDepths(this.RLabelMC);
		this.rightTextTF.autoSize = "left";

		this.blinkDesc = this.data[1];
		this.bgMC._height = 25;
		this.rightTextTF._x = 271;
		switch (this.type)
		{
			case com.rockstargames.ScaleformUI.items.UIMenuItem.BASIC_ITEM :// base item
				this.rightTextTF._visible = true;
				this._mainColor = this.data[2];
				this._highlightColor = this.data[3];
				this.leftBadgeId = this.data[5];
				this.leftBadgeTxd = this.data[6];
				this.leftBadgeTxn = this.data[7];
				this.rightBadgeId = this.data[8];
				this.rightBadgeTxd = this.data[9];
				this.rightBadgeTxn = this.data[10];
				this.SetRightText(this.data[4]);
				this.updateLabelFont(this.data[11]);
				this.updateRightLabelFont(this.data[12]);
				this.keepWhite = this.data[13]
				this.snapLabels();
				break;
			case com.rockstargames.ScaleformUI.items.UIMenuItem.LIST_ITEM :// list item
				this.rightTextTF._visible = true;
				this.rightText = this.initialIndex;
				this.rightTextTF.autoSize = true;
				this._mainColor = this.data[2];
				this._highlightColor = this.data[3];
				this.leftBadgeId = this.data[4];
				this.leftBadgeTxd = this.data[5];
				this.leftBadgeTxn = this.data[6];
				this.rightBadgeId = -1;
				this.rightBadgeTxd = "";
				this.rightBadgeTxn = "";
				this.updateLabelFont(this.data[7]);
				this.updateRightLabelFont(this.data[8]);
				this.keepWhite = this.data[9]
				if (this.blipLayer)
				{
					this.blipLayer.removeMovieClip();
				}
				this.blipLayer = this.createEmptyMovieClip("blipLayer", 1000);
				var rLabel = com.rockstargames.ScaleformUI.utils.Functions.formatLabel(this.rightText, this.isSelectable, this.highlighted, this.keepWhite);
				this.txt.setTextWithIcons(rLabel,this.blipLayer,this.rightTextTF,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
				this.snapLabels();
				break;
			case com.rockstargames.ScaleformUI.items.UIMenuItem.CHECKBOX_ITEM :// checkbox item
				this.checkbox = this.checkbox;
				this.checkbox._visible = true;
				this.tickStyle = this.data[2];
				this.Checked = this.initialIndex;
				this._mainColor = this.data[3];
				this._highlightColor = this.data[4];
				this.leftBadgeId = this.data[5];
				this.leftBadgeTxd = this.data[6];
				this.leftBadgeTxn = this.data[7];
				this.rightBadgeId = -1;
				this.rightBadgeTxd = "";
				this.rightBadgeTxn = "";
				this.updateLabelFont(this.data[8]);
				this.keepWhite = this.data[9]
				this.snapLabels();
				break;
			case com.rockstargames.ScaleformUI.items.UIMenuItem.SLIDER_ITEM :// slider item
				this.rightArrow._x = 279.9;
				this.bar._visible = true;
				this.separator._visible = true;
				this._mainColor = this.data[4];
				this._highlightColor = this.data[5];
				this._sliderColor = this.data[6];
				this._multiplier = this.data[3];
				this.rightArrow._visible = this.leftArrow._visible = this.isSelectable;
				this._max = this.data[2];
				var steps = this._max;
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
				var colourIndex = this._sliderColor;
				if (colourIndex == undefined)
				{
					colourIndex = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN;
				}
				var _loc1_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._sliderColor,_loc1_);
				this.bar.initCustom(_loc1_,100);
				this.bar._visible = true;
				this.bar._alpha = !this.highlighted ? 75 : 100;
				this.bar.percent(50);
				this.sliderscale = this.initialIndex;
				this._heritage = this.data[7];
				this.bar._x = this.rightArrow._x - this.bar._width - 2;
				this.leftArrow._x = this.bar._x - 8;
				if (this._heritage)
				{
					this.leftArrow.gotoAndStop(2);
					this.rightArrow.gotoAndStop(2);
					this.rightArrow._x = 279.9 - 8;
					this.bar._x = this.rightArrow._x - this.bar._width - 8;
					this.leftArrow._x = this.bar._x - 8;
				}
				this.rightTextTF._visible = false;
				this.separator._x = this.bar._x + this.bar._width / 2;
				this.separator._y = this.bar._y + this.bar._height / 2;
				this.leftBadgeId = this.data[8];
				this.leftBadgeTxd = this.data[9];
				this.leftBadgeTxn = this.data[10];
				this.rightBadgeId = -1;
				this.rightBadgeTxd = "";
				this.rightBadgeTxn = "";
				this.updateLabelFont(this.data[11]);
				this.keepWhite = this.data[12]
				this.snapLabels();
				break;
			case com.rockstargames.ScaleformUI.items.UIMenuItem.PROGRESS_ITEM :// progress item
				this.bar.setFillX(0);
				this.rightArrow._x = 279.9;
				this.bar._visible = true;
				this._mainColor = this.data[4];
				this._highlightColor = this.data[5];
				this._sliderColor = this.data[6];
				this.rightArrow._visible = this.leftArrow._visible = this.isSelectable;
				this._multiplier = this.data[3];
				this._max = this.data[2];
				var steps = this._max;
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
				var colourIndex = this._sliderColor;
				if (colourIndex == undefined)
				{
					colourIndex = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN;
				}
				var _loc1_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._sliderColor,_loc1_);
				this.bar.initCustom(_loc1_,100);
				this.bar._visible = true;
				this.bar._alpha = !this.highlighted ? 75 : 100;
				this.bar._x = this.rightArrow._x - this.bar._width - 2;
				this.leftArrow._x = this.bar._x - 8;
				this.rightTextTF._visible = false;
				this.barscale = this.initialIndex;
				this.leftBadgeId = this.data[7];
				this.leftBadgeTxd = this.data[8];
				this.leftBadgeTxn = this.data[9];
				this.rightBadgeId = -1;
				this.rightBadgeTxd = "";
				this.rightBadgeTxn = "";
				this.updateLabelFont(this.data[10]);
				this.keepWhite = this.data[11]
				this.snapLabels();
				break;
			case com.rockstargames.ScaleformUI.items.UIMenuItem.STATS_ITEM :
				this.maskMC._y = this.darkmaskMC._y = 30;
				this.barMC._x = this.darkbarMC._x = this.maskMC._x;
				this.barMC._y = this.darkbarMC._y = this.maskMC._y;
				this.bgMC._height = 40;
				if (this.data[2] == 0)
				{
					this.darkmaskMC._visible = this.maskMC._visible = true;
					this.barMC.mc.baralphaMC._visible = false;
					this.barMC._height = 6;
					this.barMC.setMask(this.maskMC);
					this.darkbarMC._visible = true;
					this.darkbarMC.setMask(this.darkmaskMC);
					this.bgMC._height = 40;
				}
				else if (this.data[5] == 1)
				{
					this.darkmaskMC._visible = this.maskMC._visible = false;
					this.barMC.mc.baralphaMC._visible = true;
					this.barMC._height = 10;
					this.barMC.setMask(null);
					this.darkbarMC._visible = false;
					this.bgMC._height = 46;
				}
				if (this.barMC != undefined)
				{
					var _loc1_ = new com.rockstargames.ui.utils.HudColour();
					com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.data[3],_loc1_);
					this.barMC.initCustom(_loc1_,278);
					var __reg6 = com.rockstargames.gtav.utils.GTAVUIUtils.getAdjustedSegmentPct(Math.max(0, Math.min(this.initialIndex, 100)), 54, 2, 5);
					this.barMC.percent(__reg6,false);
				}
				if (this.darkbarMC != undefined)
				{
					var _loc1_ = new com.rockstargames.ui.utils.HudColour();
					com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.data[3],_loc1_);
					this.darkbarMC.initCustom(_loc1_,278);
					this.darkbarMC._alpha = 70;
					var __reg7 = com.rockstargames.gtav.utils.GTAVUIUtils.getAdjustedSegmentPct(Math.max(0, Math.min(this.initialIndex, 100)), 54, 2, 5);
					this.darkbarMC.percent(__reg7,false);
				}
				this._mainColor = this.data[4];
				this._highlightColor = this.data[5];
				this.keepWhite = this.data[6]
				break;
			case com.rockstargames.ScaleformUI.items.UIMenuItem.SEPARATOR_ITEM :// separator
				this.rightTextTF._visible = false;
				this.rightArrow._visible = this.leftArrow._visible = false;
				this.jumpable = this.data[2];
				this._mainColor = this.data[3];
				this._highlightColor = this.data[4];
				this.leftBadgeId = -1;
				this.leftBadgeTxd = "";
				this.leftBadgeTxn = "";
				this.rightBadgeId = -1;
				this.rightBadgeTxd = "";
				this.rightBadgeTxn = "";
				this.updateLabelFont(this.data[5]);
				this.keepWhite = this.data[6]
				this.snapLabels();
				break;
		}

		if (this.data[0] != undefined)
		{
			if (this.type == 6)
			{
				this.leftTextTF.autoSize = "center";
			}
			else
			{
				this.leftTextTF.autoSize = false;
			}
			if (this.labelMC.blipLayer)
			{
				this.labelMC.blipLayer.removeMovieClip();
			}
			this.labelMC.blipLayer = this.labelMC.createEmptyMovieClip("blipLayer", 1000);
			var lLabel = com.rockstargames.ScaleformUI.utils.Functions.formatLabel(this.data[0], this.isSelectable, this.highlighted, this.keepWhite);
			this.txt.setTextWithIcons(lLabel,this.labelMC.blipLayer,this.leftTextTF,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
		}


		if (!this.isSelectable)
		{
			this.rightArrow._visible = this.leftArrow._visible = false;
			if (this.type == 1)
			{
				this.rightTextTF._x = 288 - this.rightTextTF._width - 6;
			}
			else if (this.type == 3 || this.type == 4)
			{
				this.bar._alpha = 50;
			}
		}

		this.setIcon(this.leftBadgeId,this.leftBadgeMC,this.leftBadgeId == -1,this.leftBadgeTxd,this.leftBadgeTxn);
		this.setIcon(this.rightBadgeId,this.rightBadgeMC,this.rightBadgeId == -1,this.rightBadgeTxd,this.rightBadgeTxn);
		//this.SetLeftBadge(this.leftBadgeId,this.leftBadgeTxd,this.leftBadgeTxn);
		//this.SetRightBadge(this.rightBadgeId,this.rightBadgeTxd,this.rightBadgeTxn);
		this.labelMC.resetDelay();
		this.labelMC.setDelayTimeout(120);
		this.refreshLabelFonts();
		this.snapLabels();
	}

	function refreshLabelFonts()
	{
		this.updateLabelFont(this.labelFont[0],this.labelFont[1]);
		this.updateRightLabelFont(this.rightLabelFont[0],this.rightLabelFont[1]);
	}

	function updateLabelFont(fontName, fontId)
	{
		this.labelFont = new Array(fontName, fontId);
		this.leftTextTF.embedFonts = true;
		this.leftTextTF.antiAliasType = "advanced";
		this.leftTextTF.selectable = false;
		var newFont = this.leftTextTF.getTextFormat();
		newFont.font = this.labelFont[0];
		this.leftTextTF.setNewTextFormat(newFont);
		this.leftTextTF.setTextFormat(newFont);
		this.snapLabels();
	}

	function updateRightLabelFont(fontName, fontId)
	{
		this.rightLabelFont = new Array(fontName, fontId);
		this.rightTextTF.embedFonts = true;
		this.rightTextTF.antiAliasType = "advanced";
		this.rightTextTF.selectable = false;
		var newFont = this.rightTextTF.getTextFormat();
		newFont.font = this.rightLabelFont[0];
		this.rightTextTF.setNewTextFormat(newFont);
		this.rightTextTF.setTextFormat(newFont);
		this.snapLabels();
	}

	// this function is called out of scope of the item itself, use this.something won't do anything!
	function sendMouseEvent(id)
	{
		switch (id)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				this.mOut();
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				if (this.type == 6 && this.jumpable)
				{
					return;
				}
				this.mOver();
				break;
		}
		var idx = 0;
		// Get the mouse position relative to the parent
		var mouseX = _xmouse - this._x;
		var mouseY = _ymouse - this._y;

		// Check each child component
		if (this.type == 1 || this.type == 3 || this.type == 4)
		{
			if (this.bar.hitTest(_root._xmouse, _root._ymouse))
			{
				idx = 1;
			}
			else if (this.leftArrow.hitTest(_root._xmouse, _root._ymouse))
			{
				idx = 2;
			}
			else if (this.rightArrow.hitTest(_root._xmouse, _root._ymouse))
			{
				idx = 3;
			}
		}
		var _loc4_ = [id, this._name, idx, this.index];
		this.MOUSE_EVT.triggerEvent(_loc4_);
	}

	function snapLabels()
	{
		if (this.leftBadgeId != 0)
		{
			this.labelMC._x = 28.25;
		}
		else
		{
			if (this.type != 6)
			{
				this.labelMC._x = 5;
			}
		}
		if (this.type != 1)
		{
			this.rightTextTF._x = 288 - this.rightTextTF._width - 6;
			if (this.rightBadgeId != 0)
			{
				this.rightTextTF._x = this.rightBadgeMC._x - 5 - this.rightTextTF._width;
			}
		}
		else
		{
			if (this.highlighted)
			{
				this.rightArrow._visible = this.leftArrow._visible = this.isSelectable;
				this.rightTextTF._x = this.rightArrow._x - this.rightTextTF._width;
				this.leftArrow._x = this.rightTextTF._x - 6;
			}
			else
			{
				this.rightArrow._visible = this.leftArrow._visible = false;
				this.rightTextTF._x = 288 - this.rightTextTF._width - 6;
			}
			if (!this.isSelectable)
			{
				this.rightTextTF._x = 288 - this.rightTextTF._width - 6;
			}
		}
		this.rightTextTF._y = 2.35;
		this.leftTextTF._x = 0;
		switch (this.type)
		{
			case 0 :
				this.leftTextTF._width = this.rightTextTF._x - this.labelMC._x - 5;
				break;
			case 2 :
				this.leftTextTF._width = this.checkbox._x - this.labelMC._x - 5;
				break;
			case 1 :
			case 3 :
			case 4 :
				this.leftTextTF._width = this.leftArrow._x - this.labelMC._x - 5;
				break;
			case 6 :
				this.labelMC._x = (288 - this.labelMC._width) / 2;
				this.leftTextTF._x = (this.labelMC._width - this.leftTextTF._width) / 2;
				break;
		}
	}

	function SetRightText(str)
	{
		this.rightText = str;
		if (this.blipLayer)
		{
			this.blipLayer.removeMovieClip();
		}
		this.blipLayer = this.createEmptyMovieClip("blipLayer", 1000);
		var rLabel = com.rockstargames.ScaleformUI.utils.Functions.formatLabel(this.rightText, this.isSelectable, this.highlighted, this.keepWhite);
		this.txt.setTextWithIcons(rLabel,this.blipLayer,this.rightTextTF,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
		this.refreshLabelFonts();
		this.snapLabels();
	}

	function setIcon(frameStr, fMC, isCustom, txd, txn)
	{
		if (fMC == undefined)
		{
			return;
		}
		var textureName = isCustom ? txn : com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(frameStr, this.highlighted);
		var textureDict = isCustom ? txd : com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(frameStr);

		if (!isCustom && frameStr == com.rockstargames.ScaleformUI.utils.Badges.NONE)
		{
			fMC.removeTxdRef();
			return;
		}

		if (isCustom && (txd == undefined || txd == "" || txn == undefined || txn == ""))
		{
			fMC.removeTxdRef();
			return;
		}

		if (fMC.textureDict != textureDict)
		{
			if (this._parentMenu instanceof com.rockstargames.ScaleformUI.UIMenu)
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(fMC,textureDict,textureName,24,24,this.iconLoaded,this);
			}
			else
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(fMC,textureDict,textureName,24,24,this.iconLoaded,this);
			}
		}
		else
		{
			fMC.init(com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME,textureDict,textureName,24,24);
			fMC.displayTxdResponse(textureDict);
			this.iconLoaded();
		}
	}

	function iconLoaded()
	{
		this.rightBadgeLoaded();
		this.leftBadgeLoaded();
	}

	function rightBadgeLoaded()
	{
		this.rightBadgeMC._visible = true;
		this.rightBadgeMC._width = 24;
		this.rightBadgeMC._height = 24;
		this.rightBadgeMC._x = 263.5;
		this.rightBadgeMC._y = 0.5;
		var color = com.rockstargames.ScaleformUI.utils.Badges.BadgeToColor(this.rightBadgeId, this.highlighted);
		if (color != -1)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightBadgeMC,color);
		}
		this.snapLabels();
	}

	function leftBadgeLoaded()
	{
		this.leftBadgeMC._visible = true;
		this.leftBadgeMC._width = 24;
		this.leftBadgeMC._height = 24;
		this.leftBadgeMC._x = 0.5;
		this.leftBadgeMC._y = 0.5;
		var color = com.rockstargames.ScaleformUI.utils.Badges.BadgeToColor(this.leftBadgeId, this.highlighted);
		if (color != -1)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.leftBadgeMC,color);
		}
		this.snapLabels();
	}

	function checkLoaded()
	{
		this.checkbox._width = 24;
		this.checkbox._height = 24;
		this.checkbox._x = 263.5;
		this.checkbox._y = 0.5;
		this.checkbox._visible = true;
		//this.rightBadgeMC._alpha = 0;
		//com.rockstargames.ui.tweenStar.TweenStarLite.to(this.rightBadgeMC,0.2,{_alpha:100});
		this.snapLabels();
	}

	function checkLoaded_withAnim()
	{
		this.checkLoaded();
		this.checkbox._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.checkbox,0.2,{_alpha:100});
		this.snapLabels();
	}

	function addPanel(_panel)
	{
		this.panels.push(_panel);
	}

	function removePanel(id)
	{
		var panel = this.panels[id];
		panel.Clear();
		this.panels.splice(id,1);
	}

	function getSprite(_highlighted, _style, _checked)
	{
		return _highlighted ? (_checked ? (_style == com.rockstargames.ScaleformUI.items.UIMenuItem.CHECKBOX_STYLE_TICK ? "check_black" : "cross_black") : "empty_black") : _checked ? (_style == com.rockstargames.ScaleformUI.items.UIMenuItem.CHECKBOX_STYLE_TICK ? "check_white" : "cross_white") : "empty";
		//return _highlighted ? (_checked ? (_style == com.rockstargames.ScaleformUI.items.UIMenuCheckboxItem.CHECKBOX_STYLE_TICK ? "shop_box_tickb" : "shop_box_crossb") : "shop_box_blankb") : _checked ? (_style == com.rockstargames.ScaleformUI.items.UIMenuCheckboxItem.CHECKBOX_STYLE_TICK ? "shop_box_tick" : "shop_box_cross") : "shop_box_blank";
	}

	function addSidePanel(panel)
	{
		this.sidePanel = panel;
	}
	function removeSidePanel(panel)
	{
		this.sidePanel.itemMC.removeMovieClip();
	}

	function set Checked(val)
	{
		this._checked = val;

		var sprite_name = this.getSprite(this._highlighted, this.tickStyle, this._checked);
		//com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.checkbox,"commonmenu",sprite_name,24,24,this.checkLoaded_withAnim,this);
		this.checkbox.gotoAndStop(sprite_name);
		this.snapLabels();
	}

	function get Checked()
	{
		return _checked;
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
		this.bar.percent(this.selectedValue,false);
		this.snapLabels();
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
		this.bar.setFillX(50 * (this.selectedValue / 100));
		this.snapLabels();
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
		this.rightText = this.selectedValue;
		com.rockstargames.ui.utils.UIText.setSizedText(this.rightTextTF,this.rightText);
		this.rightTextTF.autoSize = true;
		this.snapLabels();
	}

	function get textIndex()
	{
		return this.selectedIndex;
	}

	function set highlighted(_h)
	{
		super.highlighted = _h;
		if (this.isSelectable)
		{
			if (_h)
			{
				if (this.type == 3 || this.type == 4)
				{
					this.rightArrow._visible = this.leftArrow._visible = true;
					if (this._heritage)
					{
						com.rockstargames.ui.utils.Colour.ApplyHudColour(this.leftArrow,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
						com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightArrow,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
					}
					this.bar._alpha = 100;
				}
				else if (this.type == 2)
				{
					var sprite_name = this.getSprite(true, this.tickStyle, this.Checked);
					//com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.checkbox,"commonmenu",sprite_name,24,24,this.checkLoaded,this);
					this.checkbox.gotoAndStop(sprite_name);
				}
			}
			else
			{
				if (this.type == 3 || this.type == 4)
				{
					this.rightArrow._visible = this.leftArrow._visible = false;
					if (this._heritage)
					{
						this.rightArrow._visible = this.leftArrow._visible = true;
						com.rockstargames.ui.utils.Colour.ApplyHudColour(this.leftArrow,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
						com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightArrow,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
					}
					this.bar._alpha = 50;
				}
				else if (this.type == 2)
				{
					var sprite_name = this.getSprite(false, this.tickStyle, this.Checked);
					//com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.checkbox,"commonmenu",sprite_name,24,24,this.checkLoaded,this);
					this.checkbox.gotoAndStop(sprite_name);
				}
				clearTimeout(this.scrollTimeout);
				com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.leftTextTF);
				this.leftTextTF._x = 0;
			}
			for (var _panel in this.panels)
			{
				this.panels[_panel].isVisible = _h;
			}
			if (this.sidePanel != undefined)
			{
				this.sidePanel.isVisible = _h;
			}
		}
		else
		{
			this.rightArrow._visible = this.leftArrow._visible = false;
			if (this.type == 1)
			{
				this.rightTextTF._x = 288 - this.rightTextTF._width - 6;
			}
			else if (this.type == 3 || this.type == 4)
			{
				this.bar._alpha = 50;
			}
		}
		this.setIcon(this.leftBadgeId,this.leftBadgeMC,this.leftBadgeId == -1,this.leftBadgeTxd,this.leftBadgeTxn);
		this.setIcon(this.rightBadgeId,this.rightBadgeMC,this.rightBadgeId == -1,this.rightBadgeTxd,this.rightBadgeTxn);
		if (this.data[0] != "")
		{
			if (this.labelMC.blipLayer)
			{
				this.labelMC.blipLayer.removeMovieClip();
			}
			this.labelMC.blipLayer = this.labelMC.createEmptyMovieClip("blipLayer", 1000);
			var lLabel = com.rockstargames.ScaleformUI.utils.Functions.formatLabel(this.data[0], this.isSelectable, _h, this.keepWhite);
			this.txt.setTextWithIcons(lLabel,this.labelMC.blipLayer,this.leftTextTF,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
		}
		if (this.rightText != undefined && this.rightText != "")
		{
			if (this.blipLayer)
			{
				this.blipLayer.removeMovieClip();
			}
			this.blipLayer = this.createEmptyMovieClip("blipLayer", 1000);
			var rLabel = com.rockstargames.ScaleformUI.utils.Functions.formatLabel(this.rightText, this.isSelectable, _h, this.keepWhite);
			this.txt.setTextWithIcons(rLabel,this.blipLayer,this.rightTextTF,0,com.rockstargames.ui.utils.UIText.SIZE,2,false);
		}
		this.refreshLabelFonts();
		this.snapLabels();
	}

	function changeColor(text, _h)
	{
		var colorToChange = "#F0F0F0";
		var newColor = "#000000";
		if (!_h)
		{
			colorToChange = "#000000";
			newColor = "#F0F0F0";
		}
		// Split the text into an array using the color as separator                                                                          
		var parts = text.split(colorToChange);

		// Join the parts back together using the new color
		return parts.join(newColor);
	}


	function mOverI(mc)
	{
		if (this.type == 2)
		{
			if (this.highlighted)
			{
				this.hover = 1;
				this._hovered = true;
			}
		}
		else if (mc == this.leftArrow)
		{
			this.hover = 0;
			this._hovered = true;
		}
		else if (mc == this.rightArrow)
		{
			this.hover = 1;
			this._hovered = true;
		}
	}
	function mOutI(mc)
	{
		if (this.type == 2)
		{
			if (this.highlighted)
			{
				this.hover = -1;
				this._hovered = false;
			}
		}
		else
		{
			this.hover = -1;
			this._hovered = false;
		}
	}

	function get Value()
	{
		var ret;
		switch (this.type)
		{
			case 0 :
				ret = -1;
				break;
			case 1 :
				ret = this.textIndex;
				break;
			case 2 :
				ret = this.Checked;
			case 3 :
				ret = this.sliderscale;
				break;
			case 4 :
				ret = this.barscale;
				break;
		}
		return ret;
	}

	function set Value(value)
	{
		switch (this.type)
		{
			case 1 :
				this.textIndex = value;
				break;
			case 2 :
				this.Checked = value;
			case 3 :
				this.sliderscale = value;
				break;
			case 4 :
				this.barscale = value;
				break;
		}
		this.snapLabels();
	}

	function Select()
	{
		if (this.isSelectable)
		{
			if (this.highlighted)
			{
				switch (this.type)
				{
					case 2 :
						if (this.hover == 1)
						{
							this.Checked = !this.Checked;
						}
						break;
					case 3 :
						var m = _xmouse;
						var val = (m - this.bar._x) / this.bar._width * this._max;
						if (val < 0 || val > this._max)
						{
							break;
						}
						this.sliderscale = Math.max(0, Math.min(val, this._max));
						break;
					case 4 :
						var m = _xmouse;
						var val = (m - this.bar._x) / this.bar._width * this._max;
						if (val < 0 || val > this._max)
						{
							break;
						}
						this.barscale = Math.max(0, Math.min(val, this._max));
						break;
				}
			}
		}
		this.snapLabels();
		return this.Value;
	}

	function set Width(w)
	{
		this._width = w;
		for (var pan in this.panels)
		{
			this.panels[pan].Width = w;
		}
	}

	function Clear()
	{
		clearTimeout(this.scrollTimeout);
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.leftTextTF);
		this.mouseCatcher.dispose();
		if (this.rightBadgeMC.isLoaded)
		{
			this.rightBadgeMC.removeTxdRef();
			this.rightBadgeMC.removeMovieClip();
		}
		if (this.leftBadgeMC.isLoaded)
		{
			this.rightBadgeMC.removeTxdRef();
			this.rightBadgeMC.removeMovieClip();
		}
		if (this.checkbox.isLoaded)
		{
			this.checkbox.removeTxdRef();
			this.checkbox.removeMovieClip();
		}
		for (var pan in this.panels)
		{
			this.panels[pan].Clear();
		}
		if (this.sidePanel != undefined)
		{
			this.sidePanel.Clear();
		}
		this.removeMovieClip();
	}
}