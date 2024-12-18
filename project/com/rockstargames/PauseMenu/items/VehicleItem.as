class com.rockstargames.PauseMenu.items.VehicleItem
{

	var itemMC;
	var Model;
	var ModelString;
	var VehicleName;
	var TextureName;
	var TextureDict;
	var MakeDictName;
	var MakeTextureName;
	var PerfDict;
	var PerfClass;
	var BgDict;
	var BgTexture;
	var IsPersonalVehicle;
	var ClassName;
	var parentMC;
	var _selected;
	var _hovered;
	var _locked;
	var Checked;
	var row;
	var col;

	function VehicleItem(mc, index, model, modelString, vehicleName, txd, txn, makeTxd, makeTxn, perfTxd, perfClass, bgTxd, bgTxn, isPesonal, className, locked, checked)
	{
		this.parentMC = mc;
		this.Model = model;
		this.ModelString = modelString;
		this.VehicleName = vehicleName;
		this.TextureName = txd;
		this.TextureDict = txn;
		this.MakeDictName = makeTxd;
		this.MakeTextureName = makeTxn;
		this.PerfDict = perfTxd;
		this.PerfClass = perfClass;
		this.BgDict = bgTxd;
		this.BgTexture = bgTxn;
		this.IsPersonalVehicle = isPesonal;
		this.ClassName = className;
		this.Locked = locked;
		this.Checked = checked;

		var centerX = 288 / 2;
		var centerY = 141.3 / 2;

		this.itemMC = this.parentMC.scrollableContent.attachMovie("vehicleItem", "vehicle_item_" + model, this.parentMC.scrollableContent.getNextHighestDepth());
		this.itemMC.borderMC._visible = false;

		this.itemMC.bgMC.attachMovie("txdLoader","bgTxd",this.itemMC.bgMC.getNextHighestDepth(),{_x:centerX, _y:centerY});
		this.itemMC.bgMC.attachMovie("txdLoader","vehicleTxd",this.itemMC.bgMC.getNextHighestDepth(),{_x:centerX, _y:centerY});
		this.itemMC.bgMC.attachMovie("txdLoader","makeTxd",this.itemMC.bgMC.getNextHighestDepth(),{_x:140, _y:2});
		this.itemMC.bgMC.attachMovie("txdLoader","perfTxd",this.itemMC.bgMC.getNextHighestDepth(),{_x:15, _y:125});

		if (bgTxd != undefined && bgTxd != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.itemMC.bgMC.bgTxd,bgTxd,bgTxn,288,141.3,this.bgLoaded,this,true);
		}
		if (txd != undefined && txd != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.itemMC.bgMC.vehicleTxd,txd,txn,288 * 0.8,141.3 * 0.8,this.vehLoaded,this,true);
		}
		if (makeTxd != undefined && makeTxd != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.itemMC.bgMC.makeTxd,makeTxd,makeTxn,80,20,this.makeLoaded,this,false);
		}
		if (perfTxd != undefined && perfTxd != "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.itemMC.bgMC.perfTxd,perfTxd,perfClass,20,20,this.perfLoaded,this,true);
		}

		this.itemMC.bgMC.attachMovie("checkMark","selectionMC",this.itemMC.bgMC.getNextHighestDepth(),{_x:270, _y:125});
		this.itemMC.bgMC.selectionMC._width = 20;
		this.itemMC.bgMC.selectionMC._height = 20;
		this.itemMC.bgMC.selectionMC._visible = checked;

		if (isPesonal != undefined && isPesonal == true)
		{
			this.itemMC.bgMC.attachMovie("txdLoader","keyIcon",this.itemMC.bgMC.getNextHighestDepth(),{_x:241, _y:125});
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.itemMC.bgMC.keyIcon,"ui_lobby","key",20,20,this.keyLoaded,this,true);
		}

		com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.vehNameTF,vehicleName,true,false,0,25);
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.classTF,className,false,true,0,18);
		this.itemMC.attachMovie("mouseCatcher","mouseCatcher",this.itemMC.getNextHighestDepth(),{_x:-144, _y:-70.65, _width:288, _height:141.33333});
		this.itemMC.mouseCatcher.setupGenericMouseInterface(index,4000,this.onMouseEvent,[this]);

		if (this.Locked)
		{
			var _aa = 120 / 255 * 100;
			this.itemMC.vehNameTF._alpha = _aa;
		}
	}

	function SetSelection(bool)
	{
		this.itemMC.bgMC.selectionMC._visible = bool;
	}

	// fixare aggiungendo controlli alla tab!! (preso da GameItem)
	function onMouseEvent(evtType, targetMC, args)
	{
		var item = args[0];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				if (!item.Locked)
				{
					item.parentMC.currentHover.Hovered = false;
					item.Hovered = false;
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				if (!item.Locked)
				{
					item.Hovered = true;
					item.parentMC.currentHover.Hovered = false;
					item.parentMC.currentHover = item;
					item.parentMC.currentHover.Hovered = true;
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS :
				if (!item.Locked)
				{
					com.rockstargames.ui.tweenStar.TweenStarLite.to(item.itemMC,0.1,{_xscale:95, _yscale:95});
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE :
				if (!item.Locked)
				{
					item.parentMC.currentSelected.Selected = false;
					item.parentMC.currentSelected = item;
					item.parentMC.currentSelected.Selected = true;
					com.rockstargames.ui.tweenStar.TweenStarLite.to(item.itemMC,0.1,{_xscale:100, _yscale:100});
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				com.rockstargames.ui.tweenStar.TweenStarLite.to(item.itemMC,0.1,{_xscale:100, _yscale:100});
				if (!item.Locked)
				{
					item.parentMC.currentSelected.Selected = false;
					item.Selected = false;
				}
				break;
		}
	}

	function bgLoaded()
	{
		this.itemMC.bgMC.bgTxd.txdDummy._x = -this.itemMC.bgMC.bgTxd.txdDummy._width / 2;
		this.itemMC.bgMC.bgTxd.txdDummy._y = -this.itemMC.bgMC.bgTxd.txdDummy._height / 2;
		this.itemMC.bgMC.bgTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.itemMC.bgMC.bgTxd,0.2,{_alpha:70});
	}
	function vehLoaded()
	{
		this.itemMC.bgMC.vehicleTxd.txdDummy._x = -this.itemMC.bgMC.vehicleTxd.txdDummy._width / 2;
		this.itemMC.bgMC.vehicleTxd.txdDummy._y = -this.itemMC.bgMC.vehicleTxd.txdDummy._height / 2;
		this.itemMC.bgMC.vehicleTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.itemMC.bgMC.vehicleTxd,0.2,{_alpha:(this.Locked?120 / 255 * 100:100)});
	}
	function perfLoaded()
	{
		this.itemMC.bgMC.perfTxd.txdDummy._x = -this.itemMC.bgMC.perfTxd.txdDummy._width / 2;
		this.itemMC.bgMC.perfTxd.txdDummy._y = -this.itemMC.bgMC.perfTxd.txdDummy._height / 2;
		this.itemMC.bgMC.perfTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.itemMC.bgMC.perfTxd,0.2,{_alpha:(this.Locked?120 / 255 * 100:100)});
	}
	function keyLoaded()
	{
		this.itemMC.bgMC.perfTxd.txdDummy._x = -this.itemMC.bgMC.perfTxd.txdDummy._width / 2;
		this.itemMC.bgMC.perfTxd.txdDummy._y = -this.itemMC.bgMC.perfTxd.txdDummy._height / 2;
		this.itemMC.bgMC.perfTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.itemMC.bgMC.perfTxd,0.2,{_alpha:(this.Locked?120 / 255 * 100:100)});
	}
	function makeLoaded()
	{
		this.itemMC.bgMC.makeTxd._x = 288 - 5 - 80;
		this.itemMC.bgMC.makeTxd._y = 5;
		this.itemMC.bgMC.makeTxd._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.itemMC.bgMC.makeTxd,0.2,{_alpha:(this.Locked?120 / 255 * 100:100)});
	}

	function set Hovered(_s)
	{
		this._hovered = _s;
		for (var i in this.parentMC.ItemList)
		{
			var item = this.parentMC.ItemList[i];
			item.itemMC.borderMC._visible = false;
		}
		this.itemMC.borderMC._visible = _s;
	}
	function get Hovered()
	{
		return this._hovered;
	}

	function set Selected(_s)
	{
		this._selected = _s;
	}

	function get Selected()
	{
		return this._selected;
	}

	function set Locked(_l)
	{
		this._locked = _l;
		this.itemMC.mouseCatcher.isMouseEnabled = _l;
	}
	function get Locked()
	{
		return this._locked;
	}

}