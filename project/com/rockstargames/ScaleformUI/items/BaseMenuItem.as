class com.rockstargames.ScaleformUI.items.BaseMenuItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	var disabledItemColor = [163, 159, 148];
	var isActive = true;
	var _highlighted;
	var bgMC;
	var subtitle;
	var _parentMenu;
	var leftTextTF;
	var leftText;
	var parentMC;
	var _mainColor = 1291845632;// com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG
	var _highlightColor = -986896;// com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE
	var _disabledColor = -6579301;// com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREY
	var _hovered = false;
	var hover = -1;
	var _enabled = true;
	var panels;
	var blinkDesc = false;
	var sidePanel;

	function BaseMenuItem()
	{
		super();
	}

	function set data(_p)
	{
		this._parentMenu = _p[0];
		this.index = _p[1];
		this.menuID = _p[2];
		this.uniqueID = _p[3];
		this.type = _p[4];
		this.initialIndex = _p[5];
		this.isSelectable = _p[6];
		if (_p.length >= 7)
		{
			this._data = _p.slice(7);
		}
		this.leftText = this._data[0];
		this.panels = new Array();
		this._hovered = false;
		this.Enabled = _p[this.isSelectable];
		this.blinkDesc = false;
	}
	function get data()
	{
		return this._data;
	}

	function mOver()
	{
		if (this.type == 6 && this.jumpable)
		{
			return;
		}
		super.mOver();
		if (!this._hovered)
		{
			this._hovered = true;
		}
		if (!this.highlighted)
		{
			var _loc1_ = new com.rockstargames.ui.utils.HudColour();
			if (this._parentMenu instanceof com.rockstargames.ScaleformUI.UIMenu)
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._highlightColor,_loc1_);
				com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,_loc1_.r,_loc1_.g,_loc1_.b,_loc1_.a - 80);
			}
			else
			{
				//com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._mainColor,_loc1_);
				//com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,_loc1_.r,_loc1_.g,_loc1_.b,_loc1_.a - 20);
			}
		}
	}
	function mOut()
	{
		if (this.type == 6 && this.jumpable)
		{
			return;
		}
		super.mOut();
		if (this._hovered)
		{
			this._hovered = false;
		}
		if (!this.highlighted)
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.bgMC,this._mainColor);

			if (this._mainColor == 1291845632)
			{
				this.bgMC._alpha = 0;
			}
		}
	}
	function mPress()
	{
		if (this.type == 6 && this.jumpable)
		{
			return;
		}
		super.mPress();
	}

	function getColour(col)
	{
		var _loc1_ = new com.rockstargames.ui.utils.HudColour();
		var _loc2_ = com.rockstargames.ui.utils.HudColour[col];
		if (isNaN(_loc2_))
		{
			_loc2_ = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_FREEMODE;
		}
		com.rockstargames.ui.utils.Colour.setHudColour(_loc2_,_loc1_);
		return _loc1_.r * 65536 + _loc1_.g * 256 + _loc1_.b;
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
					if (this._mainColor != 1291845632)
					{
						var _loc1_ = new com.rockstargames.ui.utils.HudColour();
						com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this._mainColor,_loc1_);
						com.rockstargames.ui.utils.Colour.Colourise(this.bgMC,_loc1_.r,_loc1_.g,_loc1_.b,_loc1_.a - 20);
					}
					else
					{
						this.bgMC._alpha = 0;
					}
				}
			}
			else
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.bgMC,this._mainColor);
				if (this._mainColor == 1291845632)
				{
					this.bgMC._alpha = 0;
				}
			}
		}
		else
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.bgMC,this._highlightColor);
		}
	}

	function get highlighted()
	{
		return this._highlighted;
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
		this._visible = _v;
	}
	function get isVisible()
	{
		return this._visible;
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