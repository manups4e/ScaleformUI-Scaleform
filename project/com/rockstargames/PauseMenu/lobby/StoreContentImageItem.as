class com.rockstargames.PauseMenu.lobby.StoreContentImageItem
{
	var _parentMenu;
	var parentMC;
	var itemMC;
	var picMC;
	var txd_loader;
	var _highlighted = false;
	var _hovered = false;
	var TXD;
	var TXN;

	function StoreContentImageItem(parentMenu, index, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this._parentMenu = parentMenu;
		this.parentMC = parentMenu.scrollableContent;
		this.itemMC = this.parentMC.attachMovie("contentImageListItem4", "imgList_" + this.parentMC.getNextHighestDepth(), this.parentMC.getNextHighestDepth());
		this.picMC = this.itemMC.picMC;
		this.txd_loader = this.picMC.attachMovie("txdLoader", "imageMC", this.picMC.getNextHighestDepth());
		this.itemMC.newItemIndicator._visible = false;
		if (param2 == undefined || param2 == "")
		{
			this.itemMC.textBgMC._visible = false;
			this.itemMC.labelMC._visible = false;
		}
		this.itemMC.itemHilite._visible = false;
		this.TXD = param0;
		this.TXN = param1;
		this.LoadPicture(param0,param1);
		this.itemMC.attachMovie("mouseCatcher","mouseCatcher",itemMC.getNextHighestDepth(),{_width:itemMC._width, _height:itemMC._height});
		this.itemMC.mouseCatcher.setupGenericMouseInterface(index,this._parentMenu._id,this.onMouseEvent,[this]);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemMC.labelMC.titleTF,"$Font2");
		this.initBaseMouseInterface();
	}

	function initBaseMouseInterface()
	{
		this.picMC.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOver);
		this.picMC.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOut);
	}
	// this function is called out of scope of the item itself, use this.something won't do anything!
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
	}

	function mOut()
	{
		if (this._hovered)
		{
			this._hovered = false;
		}
	}

	function LoadPicture(txd, txn)
	{
		this.TXD = txd;
		this.TXN = txn;
		if (this.txd_loader == undefined)
		{
			this.txd_loader = this.picMC.attachMovie("txdLoader", "imageMC", this.picMC.getNextHighestDepth());
		}
		var _loc12_ = false;
		if (this.txd_loader.textureDict == txd && this.txd_loader.textureFilename == txn)
		{
			_loc12_ = true;
			var splitPath = String(this.txd_loader).split(".");
			var pathWithoutContent = splitPath.slice(2).join(".");
			this.txd_loader.loadWithValidation("lobbymenu",txd,txn,pathWithoutContent,288,160);
			this.imgLoaded();
		}
		else if (this.txd_loader.isLoaded)
		{
			this.txd_loader.removeTxdRef();
		}

		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.txd_loader,txd,txn,288,106,this.imgLoaded,this);
	}

	function imgLoaded()
	{
		this.txd_loader._width = 288;
		this.txd_loader._height = 106;
		this.txd_loader._visible = true;
		this.itemMC.blankImage._visible = false;
	}

	function get highlighted()
	{
		return this._highlighted;
	}
	function set highlighted(_h)
	{
		this._highlighted = _h;
		this.itemMC.itemHilite._visible = _h;
	}


	function Clear()
	{
		this.txd_loader.removeTxdRef();
		this.itemMC.removeMovieClip();
	}

}