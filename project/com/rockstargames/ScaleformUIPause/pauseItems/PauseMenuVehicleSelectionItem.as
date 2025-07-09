class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	var Locked;
	var STAT_TWEEN_DURATION = 0.175;
	var centerX = 288 / 2;
	var centerY = 142 / 2;
	var borderMC;
	
	function PauseMenuVehicleSelectionItem()
	{
		super();
		this._bgMC.attachMovie("txdLoader","bgTxd",this._bgMC.getNextHighestDepth(),{_x:centerX, _y:centerY});
		this._bgMC.attachMovie("txdLoader","vehicleTxd",this._bgMC.getNextHighestDepth(),{_x:centerX, _y:centerY});
		this._bgMC.attachMovie("txdLoader","makeTxd",this._bgMC.getNextHighestDepth(),{_x:140, _y:2});
		this._bgMC.attachMovie("txdLoader","perfTxd",this._bgMC.getNextHighestDepth(),{_x:15, _y:125});
		this._bgMC.attachMovie("checkMark","selectionMC",this._bgMC.getNextHighestDepth(),{_x:270, _y:125});
		this._bgMC.selectionMC._width = 20;
		this._bgMC.selectionMC._height = 20;
		this._bgMC.attachMovie("txdLoader","keyIcon",this._bgMC.getNextHighestDepth(),{_x:241, _y:125});
		this.borderMC._visible = false;
	}

	function set data(_d)
	{
		super.data = _d;
		if (this.data[2] != undefined && this.data[2] != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this._bgMC.bgTxd,this.data[2],this.data[3],288,142,this.bgLoaded,this,true);
		}
		if (this.data[4] != undefined && this.data[4] != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this._bgMC.vehicleTxd,this.data[4],this.data[5],288 * 0.8,142 * 0.8,this.vehLoaded,this,true);
		}
		if (this.data[6] != undefined && this.data[6] != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this._bgMC.makeTxd,this.data[6],this.data[7],80,20,this.makeLoaded,this,false);
		}
		if (this.data[8] != undefined && this.data[8] != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this._bgMC.perfTxd,this.data[8],this.data[9],20,20,this.perfLoaded,this,true);
		}
		if (this.data[10] != undefined && this.data[10] == true)
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this._bgMC.keyIcon,"ui_lobby","key",20,20,this.keyLoaded,this,true);
		}
		this._bgMC.selectionMC._visible = this.data[11];
		com.rockstargames.ui.utils.UIText.setSizedText(this.vehNameTF,this.data[0],true,false,0,25);
		com.rockstargames.ui.utils.UIText.setSizedText(this.classTF,this.data[1],false,true,0,18);
		this.Locked = this.data[12];
		if (this.data[12])
		{
			var _aa = 120 / 255 * 100;
			this.vehNameTF._alpha = _aa;
			var _loc3_ = new com.rockstargames.ui.utils.HudColour();
			com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,_loc3_);
			com.rockstargames.ui.utils.Colour.Colourise(this._bgMC,_loc3_.r,_loc3_.g,_loc3_.b,_loc3_.a);
		}
	}

	function bgLoaded()
	{
		this._bgMC.bgTxd.txdDummy._x = -this._bgMC.bgTxd.txdDummy._width / 2;
		this._bgMC.bgTxd.txdDummy._y = -this._bgMC.bgTxd.txdDummy._height / 2;
		this._bgMC.bgTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this._bgMC.bgTxd,0.2,{_alpha:70});
	}
	function vehLoaded()
	{
		this._bgMC.vehicleTxd.txdDummy._x = -this._bgMC.vehicleTxd.txdDummy._width / 2;
		this._bgMC.vehicleTxd.txdDummy._y = -this._bgMC.vehicleTxd.txdDummy._height / 2;
		this._bgMC.vehicleTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this._bgMC.vehicleTxd,0.2,{_alpha:(this.Locked ? 120 / 255 * 100 : 100)});
	}
	function perfLoaded()
	{
		this._bgMC.perfTxd.txdDummy._x = -this._bgMC.perfTxd.txdDummy._width / 2;
		this._bgMC.perfTxd.txdDummy._y = -this._bgMC.perfTxd.txdDummy._height / 2;
		this._bgMC.perfTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this._bgMC.perfTxd,0.2,{_alpha:(this.Locked ? 120 / 255 * 100 : 100)});
	}
	function keyLoaded()
	{
		this._bgMC.perfTxd.txdDummy._x = -this._bgMC.perfTxd.txdDummy._width / 2;
		this._bgMC.perfTxd.txdDummy._y = -this._bgMC.perfTxd.txdDummy._height / 2;
		this._bgMC.perfTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this._bgMC.perfTxd,0.2,{_alpha:(this.Locked ? 120 / 255 * 100 : 100)});
	}
	function makeLoaded()
	{
		this._bgMC.makeTxd._x = 288 - 5 - 80;
		this._bgMC.makeTxd._y = 5;
		this._bgMC.makeTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this._bgMC.makeTxd,0.2,{_alpha:(this.Locked ? 120 / 255 * 100 : 100)});
	}

	function set highlighted(_h)
	{
		super.highlighted = _h;
		this.borderMC._visible = _h;
	}

	function createButton()
	{
		this.bMC.clear();
		this.bMC.beginFill(16777215);
		this.bMC.moveTo(0,0);
		this.bMC.lineTo(this._bgMC._width,0);
		this.bMC.lineTo(this._bgMC._width,this._bgMC._height);
		this.bMC.lineTo(0,this._bgMC._height);
		this.bMC.lineTo(0,0);
		this.bMC.endFill();
	}


//	function mOver()
//	{
//		
//	}
//
//	function mOut()
//	{
//
//	}
//
	function mPress()
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