class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuMissionItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	var bgMC;
	var _mainColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG;// HUD_COLOUR_PAUSE_BG
	var _highlightColor = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;// HUD_COLOUR_WHITE
	var ICON_W = 24;
	var ICON_H = 24;
	var isCustomLeft;
	var isCustomRight;
	var leftIconColor;
	var rightIconColor;
	var RightIcon;
	var LeftIcon;
	var _leftIcon;
	var _rightIcon;
	var isActive;
	var _enabled;
	var isSeparator;
	var rightIcon_ICON;
	var leftIcon_ICON;
	var rightChecked;
	var labelMC;
	var jumpable;

	function PauseMenuMissionItem()
	{
		super();
		_global.gfxExtensions = true;
		this.RightIcon = this.attachMovie("txdLoader", "iconRight", this.getNextHighestDepth(), {_x:271, _y:this.bgMC._height / 2});
		this.LeftIcon = this.attachMovie("txdLoader", "iconLeft", this.getNextHighestDepth(), {_x:246, _y:this.bgMC._height / 2});
		this.checkMC.swapDepths(this.RightIcon);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.checkMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN);
		this.itemTextLeft = this.labelMC.txtString;
	}

	function set data(_d)
	{
		super.data = _d;
		if (this.data[0] != undefined)
		{
			if (this.type == 1)
			{
				this.itemTextLeft.autoSize = "center";
			}
			else
			{
				this.itemTextLeft.autoSize = false;
			}
			com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextLeft,this.data[0],false);
		}
		this._mainColor = this.data[1];
		this._highlightColor = this.data[2];
		this.isCustomLeft = this.data[3] == -1;
		this.isCustomRight = this.data[4] == -1;
		this.leftIconColor = this.data[5];
		this.rightIconColor = this.data[6];
		if (this.type == 0)
		{
			this.setIcon(this.data[3],this.LeftIcon,this.isCustomLeft,this.data[7],this.data[8]);
			this.setIcon(this.data[4],this.RightIcon,this.isCustomRight,this.data[9],this.data[10]);
			this.checkMC._visible = this.data[11];
		}
		else
		{
			this.checkMC._visible = false;
		}
		this.jumpable = this.data[12];
		this.updateLabelWidth();
		this.labelMC.resetDelay();
		this.labelMC.setDelayTimeout(120);
		this.Enabled = _enabled;
	}

	function updateFont(font)
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextLeft,font);
	}

	function setIcon(frameStr, fMC, isCustom, txd, txn)
	{
		var dictName = isCustom ? txn : com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(frameStr, this.highlighted);
		var textureDict = isCustom ? txd : com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(frameStr);

		if(fMC == this.LeftIcon)
			this.leftIcon_ICON = frameStr;
		else
			this.rightIcon_ICON = frameStr;

		if (!isCustom && frameStr == com.rockstargames.ScaleformUI.utils.Badges.NONE)
		{
			fMC.removeTxdRef();
			return;
		}

		if (fMC.textureDict != textureDict)
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(fMC,textureDict,dictName,24,24,this.iconLoaded,this,true);
		}
		else
		{
			fMC.init(com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME,textureDict,dictName,24,24);
			fMC.displayTxdResponse(textureDict);
			this.iconLoaded();
		}
	}
	function iconLoaded()
	{
		this.LeftIcon._visible = true;
		this.LeftIcon._width = 24;
		this.LeftIcon._height = 24;
		var color = com.rockstargames.ScaleformUI.utils.Badges.BadgeToColor(this.leftIcon_ICON, this.highlighted);
		if (color != -1)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.LeftIcon,color);
		}
		this.RightIcon._visible = true;
		this.RightIcon._width = 24;
		this.RightIcon._height = 24;
		color = com.rockstargames.ScaleformUI.utils.Badges.BadgeToColor(this.rightIcon_ICON, this.highlighted);
		if (color != -1)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.RightIcon,color);
		}

	}

	function updateLabelWidth()
	{
		var _w = 0;
		this.itemTextLeft._x = 0;
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
			this.itemTextLeft._width = _w - this.labelMC._x - 5;
		}
		else
		{
			if (this.type == 1)
			{
				this.labelMC._x = (288 - this.labelMC._width) / 2;
				this.itemTextLeft._x = (this.labelMC._width - this.itemTextLeft._width) / 2;
			}
			else
			{
				this.itemTextLeft._width = 280;
			}
		}
	}

	function set highlighted(_h)
	{
		super.highlighted = _h;
	}

	function mOver()
	{
		if (this.type == 0 || (this.type == 1 && this.jumpable))
		{
			_level0.TIMELINE.M_OVER_EVENT(this.index,this.columnID,this);
		}
	}
	function mOut()
	{
		if (this.type == 0 || (this.type == 1 && this.jumpable))
		{
			_level0.TIMELINE.M_OUT_EVENT(this.index,this.columnID);
		}
	}
	function mPress()
	{
		if (this.type == 0 || (this.type == 1 && this.jumpable))
		{
			if (!this.highlighted)
			{
				_level0.TIMELINE.M_PRESS_EVENT(this.index,this.columnID,false);
			}
			else
			{
				_level0.TIMELINE.M_PRESS_EVENT(this.index,this.columnID,true);
			}
		}
	}
}