class com.rockstargames.PauseMenu.tabs.playerList.mpFreemodeItem
{
	var itemMC;
	var leftTextTF;
	var _parentMenu;
	var parentMC;
	var labelFont = [];
	var _hovered;
	var _highlighted;
	var bgMC;
	var _mainColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG;// HUD_COLOUR_PAUSE_BG
	var _highlightColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;// HUD_COLOUR_WHITE
	var ICON_W = 25;
	var ICON_H = 25;
	var inverseScrollSpeed;
	var goalX;
	var duration;
	var scrollTimeout;
	var leftIconColor;
	var rightIconColor;
	var RightIcon;
	var LeftIcon;
	var _leftIcon;
	var _rightIcon;
	var isActive;
	var _enabled;
	var isSeparator;

	function mpFreemodeItem(parentMenu, id, index, str, baseColor, highlightColor, iconL, colL, iconR, colR, checked, _enabled, jumpable)
	{
		this._parentMenu = parentMenu;
		this.parentMC = parentMenu.scrollableContent;
		this.itemMC = this.parentMC.attachMovie("mpFreemodeItem", "freemodeItem_" + this.parentMC.getNextHighestDepth(), this.parentMC.getNextHighestDepth());
		this.RightIcon = this.itemMC.attachMovie("txdLoader", "iconRight", this.itemMC.getNextHighestDepth(), {_x:258, _y:0});
		this.LeftIcon = this.itemMC.attachMovie("txdLoader", "iconLeft", this.itemMC.getNextHighestDepth(), {_x:233, _y:0});
		this.itemMC.checkMC.swapDepths(this.RightIcon);
		this.itemMC.checkMC._visible = false;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.checkMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN);
		this.leftTextTF = this.itemMC.labelMC.labelTF;
		this.bgMC = this.itemMC.bgMC;
		this._mainColor = baseColor;
		this._highlightColor = highlightColor;
		this.isSeparator = id == 1;

		if (str != undefined)
		{
			if (this.isSeparator)
			{
				this.leftTextTF.autoSize = "center";
			}
			else
			{
				this.leftTextTF.autoSize = true;
			}
			com.rockstargames.ui.utils.UIText.setSizedText(this.leftTextTF,str,false);
			this.itemMC.labelMC.setMask(this.itemMC.labelMC.maskMC);
			this.updateLabelWidth();
		}

		this.AddLeftTexture(iconL,colL);
		this.AddRightTexture(iconR,checked,colR);

		this.itemMC.attachMovie("mouseCatcher","mouseCatcher",itemMC.getNextHighestDepth(),{_width:itemMC._width, _height:itemMC._height});
		this.itemMC.mouseCatcher.setupGenericMouseInterface(index,this._parentMenu._id,this.onMouseEvent,[this]);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.leftTextTF,"$Font2");
		this.initBaseMouseInterface();
		this.Enabled = _enabled;
	}

	function initBaseMouseInterface()
	{
		this.bgMC.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOver);
		this.bgMC.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOut);
	}
	// this function is called out of scope from the item itself, using this.something won't do anything!
	function onMouseEvent(evtType, targetMC, args)
	{
		var item = args[0];
		var menu = args[1];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				item.mOut();
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				item.mOver();
				break;
		}
	}

	function mOver()
	{
		if (!this._hovered)
		{
			this._hovered = true;
		}
		if (!this.highlighted)
		{
			var _loc1_ = new com.rockstargames.ui.utils.HudColour();
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._mainColor,_loc1_);
			com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,_loc1_.r,_loc1_.g,_loc1_.b,_loc1_.a - 20);
		}
	}

	function mOut()
	{
		if (this._hovered)
		{
			this._hovered = false;
		}
		if (!this.highlighted)
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.bgMC,this._mainColor);
		}
	}

	function updateLabelWidth()
	{
		var _w = 0;

		if (this.RightIcon.isLoaded)
		{
			_w = this.RightIcon._x - this.RightIcon._width;
		}
		else if (this.LeftIcon.isLoaded)
		{
			_w = this.LeftIcon._x - this.LeftIcon._width;
		}

		if (_w != 0)
		{
			this.itemMC.labelMC.maskMC._width = _w - this.itemMC.labelMC._x - 5;
		}
		else
		{
			if (this.isSeparator)
			{
				this.leftTextTF.autoSize = "center";
				this.itemMC.labelMC._x = (288 - this.itemMC.labelMC._width) / 2;
				this.leftTextTF._x = (this.itemMC.labelMC._width - this.leftTextTF._width) / 2;
			}
			else
			{
				this.itemMC.labelMC.maskMC._width = 280;
			}
		}
		this.checkScroll();
	}

	function checkScroll()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.itemMC.leftTextTF);
		if (this.leftTextTF.textWidth > this.itemMC.labelMC.maskMC._width)
		{
			this.inverseScrollSpeed = 1 / com.rockstargames.ScaleformUI.items.UIMenuItem.DEFAULT_SCROLL_SPEED;
			this.goalX = (this.leftTextTF._width - this.itemMC.labelMC.maskMC._width);
			this.duration = this.goalX * this.inverseScrollSpeed;
			this.scrollTimeout = setTimeout(this.startScroll, 2000, this);
		}
	}

	function startScroll(item)
	{
		item.inverseScrollSpeed = 1 / com.rockstargames.ScaleformUI.items.UIMenuItem.DEFAULT_SCROLL_SPEED;
		item.goalX = (item.leftTextTF._width - item.itemMC.labelMC.maskMC._width);
		item.duration = item.goalX * item.inverseScrollSpeed;
		var y = item._y;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(item.leftTextTF,item.duration,{_x:-item.goalX, _y:y, onCompleteScope:item, onComplete:item.completeScroll, onCompleteArgs:["scroll"]});
	}

	function goBackScroll(item)
	{
		item.inverseScrollSpeed = 1 / com.rockstargames.ScaleformUI.items.UIMenuItem.DEFAULT_SCROLL_SPEED;
		item.goalX = (item.leftTextTF._width - item.itemMC.labelMC.maskMC._width);
		item.duration = item.goalX * item.inverseScrollSpeed;
		var y = item._y;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(item.leftTextTF,item.duration,{_x:0, _y:y, onCompleteScope:item, onComplete:item.completeScroll, onCompleteArgs:["back"]});
	}

	function completeScroll(arg)
	{
		this.scrollTimeout = setTimeout(arg == "scroll" ? this.goBackScroll : this.startScroll, 3000, this);
	}

	function updateFont(font)
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.leftTextTF,font);
	}

	function AddLeftTexture(icon, color)
	{
		this._leftIcon = icon;
		if (icon == 0)
		{
			this.LeftIcon.removeTxdRef();
			return;
		}
		var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(icon, this.highlighted);
		var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(icon);
		this.leftIconColor = color;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.LeftIcon,sprite_txd,sprite_name,25,25,this.textureLeftAdded,this);
	}

	function AddRightTexture(icon, checked, color)
	{
		this._rightIcon = icon;
		if (checked)
		{
			this.itemMC.checkMC._visible = true;
		}
		if (icon == 0)
		{
			this.RightIcon.removeTxdRef();
			return;
		}
		var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(icon, this.highlighted);
		var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(icon);
		this.rightIconColor = color;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.RightIcon,sprite_txd,sprite_name,25,25,this.textureRightAdded,this);
	}

	function textureLeftAdded()
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.LeftIcon,this.leftIconColor);
		this.updateLabelWidth();
	}

	function textureRightAdded()
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.RightIcon,this.rightIconColor);
		this.itemMC.checkMC._x = 258 + 15;
		this.updateLabelWidth();
	}

	function get highlighted()
	{
		return this._highlighted;
	}
	function set highlighted(_h)
	{
		this._highlighted = _h;
		if (!_h)
		{
			if (this._hovered)
			{
				if (!this.highlighted)
				{
					var _loc1_ = new com.rockstargames.ui.utils.HudColour();
					com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._mainColor,_loc1_);
					com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,_loc1_.r,_loc1_.g,_loc1_.b,_loc1_.a - 20);
				}
			}
			else
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.bgMC,this._mainColor);
			}
		}
		else
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.bgMC,this._highlightColor);
		}

		if (this.LeftIcon.isLoaded)
		{
			if (com.rockstargames.ScaleformUI.utils.Badges.canChangeSprite(this._leftIcon))
			{
				this.LeftIcon.removeTxdRef();
				var txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(this._leftIcon);
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(this._leftIcon, _h);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.LeftIcon,txd,sprite_name,24,24,this.textureLeftAdded,this);
			}
			var color = com.rockstargames.ScaleformUI.utils.Badges.BadgeToColor(this._leftIcon, _h);
			if (color != -1)
			{
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.LeftIcon,color);
			}
		}

		if (this.RightIcon.isLoaded)
		{
			if (com.rockstargames.ScaleformUI.utils.Badges.canChangeSprite(this._rightIcon))
			{
				this.RightIcon.removeTxdRef();
				var txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(this._rightIcon);
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(this._rightIcon, _h);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.RightIcon,txd,sprite_name,24,24,this.textureLeftAdded,this);
			}
			var color = com.rockstargames.ScaleformUI.utils.Badges.BadgeToColor(this._rightIcon, _h);
			if (color != -1)
			{
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.RightIcon,color);
			}
		}
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.leftTextTF,this._enabled ? (!_h ? com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK) : com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY);
	}

	function Clear()
	{
		this.LeftIcon.removeTxdRef();
		this.RightIcon.removeTxdRef();
		this.itemMC.removeMovieClip();
	}

	function set enabled(e)
	{
		this.isActive = e;
	}
	function get enabled()
	{
		return this.isActive;
	}
	function set isVisible(_v)
	{
		this.itemMC._visible = _v;
	}
	function get isVisible()
	{
		return this.itemMC._visible;
	}

	function set Enabled(e)
	{
		this._enabled = e;
	}
	function get Enabled()
	{
		return this._enabled;
	}
}