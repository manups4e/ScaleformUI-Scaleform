class com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_SIMPLE_HELP_LIST extends com.rockstargames.gtav.pauseMenu.pauseComponents.PauseMenuComponentBase
{
	var scrollMask;
	var containerMC;
	var imageContainer;
	var pictureTxd;
	var bgTXD;
	function PAUSE_MENU_SIMPLE_HELP_LIST()
	{
		super();
		this.dbgID = "PAUSE_MENU_SIMPLE_HELP_LIST";
		this.scrollMask._visible = false;
	}

	function INITIALISE(mc)
	{
		if (mc != undefined)
		{
			super.INITIALISE(mc);
		}
		else
		{
			this.CONTENT = this;
		}
		this.SET_FOCUS(false);
		this.imageContainer = this.CONTENT.createEmptyMovieClip("imageContent", 0);
		this.bgTXD = this.imageContainer.attachMovie("txdLoader", "bgTXD", this.imageContainer.getNextHighestDepth());
		this.pictureTxd = this.imageContainer.attachMovie("txdLoader", "picture", this.imageContainer.getNextHighestDepth());
		this.containerMC = this.CONTENT.createEmptyMovieClip("scrollContent", 1);
		this.containerMC.setMask(this.scrollMask);
		this.model = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuSimpleModel();
		this.model.createView(0,{id:0, x:0, y:0, rowSpacing:8, columnSpacing:0, maskHeight:this.scrollMask._height, titleHeight:this.titleHeight, container:this.containerMC, linkage:["missionHelpListItem"], visibleItems:15, selectstyle:com.rockstargames.ui.components.GUIView.SCROLLALL_SELECTSTYLE});
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.CONTENT.bgMC.onRollOver = this.rollOver;
		this.CONTENT.bgMC.onRollOut = this.rollOut;
		this.CONTENT.bgMC.onDragOut = this.rollOut;
	}

	function rollOver()
	{
		_level0.TIMELINE.MOUSE_COLUMN_SHIFT(0);
	}
	function rollOut()
	{
		_level0.TIMELINE.MOUSE_COLUMN_SHIFT(0);
	}

	function SET_TITLE(str)
	{
		this.model.addTitleToView(0,0,[0, 0, 0, 0, 0, true, str]);
		this.model.getCurrentView(0).itemList[0].labelMC.titleTF.htmlText = "<font face=\'$Font2\' size=\'" + 50 + "\'>" + str + "</font>";
		this.model.getCurrentView(0).itemY = this.model.getCurrentView(0).itemList[0]._height;
	}

	function DISPLAY_VIEW(viewIndex, itemIndex)
	{
		super.DISPLAY_VIEW.apply(this,arguments);
		this.model.getCurrentView().scrollToBottom();
		if (this.containerMC._height > this.scrollMask._height)
		{
			this.SET_SCROLL_BAR(0,0);
			com.rockstargames.ui.game.GameInterface.call("COLUMN_CAN_SCROLL",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,true);
		}
	}
	function SET_DATA_SLOT_EMPTY(viewIndex, itemIndex)
	{
		super.SET_DATA_SLOT_EMPTY(viewIndex,itemIndex);
		this.model.getCurrentView().viewContainer._y = 0;
		this.model.getCurrentView().index = 0;
	}
	function SET_FOCUS(isFocused)
	{
		this.columnIsFocused = isFocused;
		this.SEND_COLUMN_PARAMS();
	}
	function SET_INPUT_EVENT(direction)
	{
		if (direction == com.rockstargames.ui.game.GamePadConstants.DPADUP)
		{
			this.model.prevItem();
		}
		if (direction == com.rockstargames.ui.game.GamePadConstants.DPADDOWN)
		{
			this.model.nextItem();
		}
	}

	function SET_RIGHT_PICTURE(txd, txn)
	{
		if (txd != undefined && txd != "")
		{
			if (this.pictureTxd.textureDict == txd)
			{
				this.pictureTxd.init(com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME,txd,txn,288,430);
				this.pictureTxd.displayTxdResponse(txd);
				this.pictureLoaded();
			}
			else
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this.pictureTxd,txd,txn,288,430,this.pictureLoaded,this);
			}
		}
		else
		{
			if (this.pictureTxd.isLoaded)
			{
				this.pictureTxd.removeTxdRef();
			}
		}
	}

	function SET_BACKGROUND(txd, txn)
	{
		if (txd != undefined && txd != "")
		{
			this.CONTENT.bgMC._visible = false;
			if (this.bgTXD.textureDict == txd)
			{
				this.bgTXD.init(com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME,txd,txn,868,430);
				this.bgTXD.displayTxdResponse(txd);
				this.bgLoaded();
			}
			else
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this.bgTXD,txd,txn,868,430,this.bgLoaded,this);
			}
		}
		else
		{
			if (this.bgTXD.isLoaded)
			{
				this.bgTXD.removeTxdRef();
			}
			this.CONTENT.bgMC._visible = true;
		}
	}

	function pictureLoaded()
	{
		this.pictureTxd._x = 580;
		this.pictureTxd._width = 288;
	}
	function bgLoaded()
	{
		this.bgTXD._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.bgTXD,0.2,{_alpha:this.CONTENT.bgMC._alpha});
	}
}