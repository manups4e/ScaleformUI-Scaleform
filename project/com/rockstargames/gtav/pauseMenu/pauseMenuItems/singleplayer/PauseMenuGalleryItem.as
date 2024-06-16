class com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	static var ITEM_STATE_EMPTY = 0;
	static var ITEM_STATE_CORRUPTED = 1;
	static var ITEM_STATE_QUEUED = 2;
	static var ITEM_STATE_LOADING = 3;
	static var ITEM_STATE_LOADED = 4;
	static var ITEM_STATE_TRANSITION = 5;
	var mouse;

	function PauseMenuGalleryItem()
	{
		super();
		this.resetDisplay();
		this.attachMovie("mouseCatcher", "mouseItem", this.getNextHighestDepth(), {_width:this._width, _height:this._height});
	}
	function setBookmark(_b)
	{
		this.bookmarkMC._visible = _b;
	}
	function set data(_d)
	{
		super.data = _d;
		this.spinnerMC.stop();
		this.spinnerMC._visible = false;
		this.corruptedMC._visible = false;
		this.defaultMC._visible = false;
		this.bgMC._visible = false;
		switch (this.type)
		{
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_CORRUPTED :
				this.corruptedMC._visible = true;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_QUEUED :
				this.defaultMC._visible = true;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_LOADING :
				this.spinnerMC.gotoAndPlay(this.spinnerMC._currentframe == 1 ? 2 : this.spinnerMC._currentframe);
				this.spinnerMC._visible = true;
				this.defaultMC._visible = true;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_LOADED :
				this.defaultMC._visible = true;
				if (this.imageLoaderMC == undefined)
				{
					this.imageLoaderMC = this.ic.attachMovie("txdLoader", "il", this.ic.getNextHighestDepth(), {_x:0, _y:0});
				}
				this.ADD_TXD_REF(this.data[2],this.data[3]);
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_EMPTY :
			default :
				this.bgMC._visible = true;
		}
		this.bookmarkMC._visible = Boolean(this.data[5]);
		this.scIconMC._visible = this.data[8];
		this._alpha = 100;
		this.mouseItem.setupGenericMouseInterface(this.index,this.columnID,this.onMouseEvent,[this]);
	}
	function fadeOutComplete()
	{
		this.defaultMC._visible = false;
	}
	function onTXDRefAdded()
	{
		this.spinnerMC._visible = false;
		this.spinnerMC.gotoAndStop(1);
		this.imageLoaderMC._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.defaultMC,com.rockstargames.gtav.utils.GTAVUIConfig.DEFAULT_IMG_FADE_DURATION,{_alpha:0, onComplete:this.fadeOutComplete, onCompleteScope:this});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.imageLoaderMC,com.rockstargames.gtav.utils.GTAVUIConfig.DEFAULT_IMG_FADE_DURATION,{_alpha:100});
	}
	function ADD_TXD_REF(txd, txn)
	{
		if (this.imageLoaderMC.isLoaded)
		{
			this.imageLoaderMC.removeTxdRef();
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.maxILMC,txd,txn,578,322);
		this.imageLoaderMC.init("PauseMenu",txd,txn,189,106,-23);
		var splitPath = String(this.imageLoaderMC).split(".");
		var pathWithoutContent = splitPath.slice(2).join(".");
		this.imageLoaderMC.addTxdRef(pathWithoutContent,this.onTXDRefAdded,this);
	}
	function ON_DESTROY()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.defaultMC);
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.imageLoaderMC);
		this.imageLoaderMC.removeTxdRef();
		this.resetDisplay();
	}
	function mouseOver(b)
	{
		if (b)
		{
			if (!this.highlighted && this.type != com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_EMPTY)
			{
				this.bMC._alpha = 20;
			}
		}
		else
		{
			this.bMC._alpha = 0;
		}
	}
	
	function onMouseEvent(evtType, targetMC, args)
	{
		var item = args[0];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				item.mouseOver(false);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				item.mouseOver(true);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE :
				item.mouseOver(false);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				item.mouseOver(false);
				break;
		}
	}
	
	function mPress()
	{
		if (this.type != com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_EMPTY)
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
	function resetDisplay()
	{
		this.bookmarkMC._visible = false;
		this.highlightMC._visible = false;
		this.spinnerMC._visible = false;
		this.corruptedMC._visible = false;
		this.defaultMC._visible = false;
		this.bgMC._visible = true;
		this._alpha = 100;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.corruptedMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.defaultMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.highlightMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
	}
	function set highlighted(_h)
	{
		this._highlighted = _h;
		this.highlightMC._visible = this._highlighted;
	}
}