class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuStoreItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	var txd_loader;
	var picMC;
	var TXD;
	var TXN;
	var itemHilite;
	
	function PauseMenuStoreItem()
	{
		super();
		_global.gfxExtensions = true;
		this.txd_loader = this.picMC.attachMovie("txdLoader", "imageMC", this.picMC.getNextHighestDepth());
	}

	function set data(d)
	{
		super.data = d;
		this.newItemIndicator._visible = false;
		if (this.data[2] == undefined || this.data[2] == "")
		{
			this.textBgMC._visible = false;
			this.labelMC._visible = false;
		}
		else
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.labelMC.titleTF,this.data[2],true,false,0,23);
		}
		this.TXD = this.data[0];
		this.TXN = this.data[1];
		this.LoadPicture(this.TXD,this.TXN);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.labelMC.titleTF,"$Font5");
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.textBgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.highlighted = this._highlighted;
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
			var pathWithoutContent = splitPath.slice(5).join(".");
			this.txd_loader.loadWithValidation("ScaleformUIPause",txd,txn,pathWithoutContent,288,160);
			this.imgLoaded();
		}
		else if (this.txd_loader.isLoaded)
		{
			this.txd_loader.removeTxdRef();
		}

		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this.txd_loader,txd,txn,288,106,this.imgLoaded,this);
	}

	function imgLoaded()
	{
		this.txd_loader._width = 288;
		this.txd_loader._height = 106;
		this.txd_loader._visible = true;
		this.picMC.blankImage._visible = false;
	}

	function set highlighted(_h)
	{
		this._highlighted = _h;
		this.itemHilite._visible = _h;
	}
}