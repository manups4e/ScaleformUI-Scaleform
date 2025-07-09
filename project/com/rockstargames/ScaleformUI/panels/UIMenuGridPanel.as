class com.rockstargames.ScaleformUI.panels.UIMenuGridPanel extends com.rockstargames.ScaleformUI.panels.BasePanel
{
	var padding:Number = 0;
	var mx:Number = 0;
	var my:Number = 0;
	var _data;
	var _highlighted;
	var dotMC;
	var gridMC;
	var isAdjustable;
	var isSelectable;
	var itemTextRight;
	var labelMC;
	var _value;
	var txd_loader;
	var gridType;
	var _coords;
	var hovered = false;
	var mouse;
	var _grid;
	var MOUSE_EVT;

	function UIMenuGridPanel()
	{
		super();
		this._grid = this.gridMC.attachMovie("txdLoader", "gridPanel", this.gridMC.getNextHighestDepth());
		this.MOUSE_EVT = new com.rockstargames.ui.mouse.MOUSE_EVENTS();
		this.MOUSE_EVT.INTERFACE_TYPE = 10;
		this.MOUSE_EVT.UI_MOVIE = 4;
		this.padding = this.dotMC._x - this.gridMC._x;
		this.mx = this.gridMC._width - this.padding * 2;
	}

	function set data(d)
	{
		super.data = d;
		this._value = new Array();
		this.gridType = this.data[10];
		if (this.data[9] != undefined)
		{
			if (this.data[9])
			{
				if (this.dotMC._currentframe != 2)
				{
					this.dotMC.gotoAndStop(2);
				}
			}
			else if (this.dotMC._currentframe != 1)
			{
				this.dotMC.gotoAndStop(1);
			}
		}
		if (this.gridType == 1)
		{
			this.gridMC.gotoAndStop(this.gridType + 1);
			this.bgMC.gotoAndStop(this.gridType + 1);
			this.labelMC.gotoAndStop(this.gridType + 1);
		}
		else
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this._grid,"pause_menu_pages_char_mom_dad","nose_grid");
		}
		//upTx, rxTx, lxTx, downTx, valX, valY, animate, _hori
		this.my = this.gridMC._height - this.padding * 2;

		this.itemTextRight = this.labelMC.valueTF;
		this.isAdjustable = true;
		com.rockstargames.ui.utils.UIText.setSizedText(this.labelMC.upTF,this.data[3],true);
		com.rockstargames.ui.utils.UIText.setSizedText(this.labelMC.rightTF,this.data[4],true);
		com.rockstargames.ui.utils.UIText.setSizedText(this.labelMC.downTF,this.data[6],true);
		com.rockstargames.ui.utils.UIText.setSizedText(this.labelMC.leftTF,this.data[5],true);
		if (this.data[7] != undefined && this.data[8] != undefined)
		{
			this.Value = new Array(this.data[7], this.data[8]);
		}
		else
		{
			this.Value = new Array(0, 0);
		}
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.gridMC.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER);
		this.gridMC.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT);
		this.gridMC.onDragOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_DRAG_OVER);
		this.gridMC.onDragOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_DRAG_OUT);
		this.gridMC.onPress = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS);
		this.gridMC.onRelease = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE);
		this.gridMC.onReleaseOutside = com.rockstargames.ui.utils.DelegateStar.create(this, this.onMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE);
	}

	function onMouseEvent(id)
	{
		switch (id)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				this.mOutGP();
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				this.mOverGP();
				break;
		}
		var _loc4_ = [id, this._name, 12, 0];
		this.MOUSE_EVT.triggerEvent(_loc4_);
	}

	function mPressGP(mc)
	{
		com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"CONTINUOUS_SLIDER","HUD_FRONTEND_DEFAULT_SOUNDSET");
	}
	function mReleaseGP(mc)
	{
		com.rockstargames.ui.game.GameInterface.call("STOP_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE);
	}

	function mOverGP(mc)
	{
		this.hovered = true;
		this._hovered = true;

	}
	function mOutGP(mc)
	{
		this.hovered = false;
		this._hovered = false;
	}
	function onLoadInit(target_mc)
	{
		//target_mc.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverGP, target_mc);
		//target_mc.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutGP, target_mc);
		delete this.txd_loader;
	}

	function set Value(val)
	{
		this._value = val;
		if (this._value[0] > 1)
		{
			this._value[0] = 1;
		}
		if (this._value[0] < 0)
		{
			this._value[0] = 0;
		}
		if (this._value[1] > 1)
		{
			this._value[1] = 1;
		}
		if (this._value[1] < 0)
		{
			this._value[1] = 0;
		}
		this.dotMC._x = this.gridMC._x + this.padding + (this.mx * this._value[0]);
		if (this.data[10] == 0)
		{
			this.dotMC._y = this.gridMC._y + this.padding + (this.my * this._value[1]);
		}
		else
		{
			this.dotMC._y = this.gridMC._y + this.padding + (this.my * 0.5);
		}
	}
	function get Value()
	{
		return this._value;
	}

	function SetCoords()
	{
		var coords = [_xmouse, _ymouse];
//		if (this.data[10] == 0)
//		{
//			this.my = this.gridMC._height - this.padding * 2;
//			var offset = ((this._y + this.my) - this.padding * 2) - (this.gridMC._height / 2) - this.padding;
//			Debug.Debug.Log(offset);
//			coords[1] -= offset;
//		}
		var valX = (coords[0] - this.gridMC._x - this.padding) / this.mx;
		var valY = (coords[1] - this.gridMC._y - this.padding) / this.my;
		this.Value = new Array(valX, valY);
	}
	function get Coords()
	{
		return new Array(this.dotMC._x, this.dotMC._y);
	}

	function Select()
	{
		return this.Value.toString();
	}

	function Clear()
	{
		if (this.gridMC.gridPanel != undefined)
		{
			if (this.gridMC.gridPanel.isLoaded)
			{
				this.gridMC.gridPanel.removeTxdRef();
			}
		}
		this.removeMovieClip();
	}

}