class com.rockstargames.PauseMenu.tabs.GalleryTab extends com.rockstargames.PauseMenu.tabs.BaseTab
{
	var galleryItems = [];
	var CONTENT;
	var visibleItems = 12;// 18?
	var model;
	var maxImgMC;
	var maxILMC;
	var preloadTxds;
	var scrollBase = undefined;
	var rightPanel;
	var curState = com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_EMPTY;

	function GalleryTab(mc, m)
	{
		super(mc,m);
		this.galleryItems = new Array();
		this.CONTENT = this._MC.attachMovie("spGallery", "gallery_tab_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		this.model = new com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryModel();
		this.model.createView(0,{id:0, rowSpacing:2, columnSpacing:2, batchCols:4, batchRows:3, batchW:143, document:this, container:this.CONTENT, linkage:["spGalleryItem"], visibleItems:18, selectstyle:com.rockstargames.ui.components.GUIView.FOCUS_SELECTSTYLE});
		this.maxImgMC = this.CONTENT.maxImgMC;
		this.maxImgMC._visible = false;
		this.maxILMC = this.maxImgMC.imgMC.attachMovie("txdLoader", "il", this.maxImgMC.imgMC.getNextHighestDepth());
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.descMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.maxImgMC.maxDefaultMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.maxImgMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.mapDimmerMc.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.mapBG,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.textContainerMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		this.preloadTxds = true;
		this.SetScrollBarArrows(true,2,2,2,true);
	}

	function getTxdData()
	{
		var _loc3_ = this.model.getCurrentView(0);
		var _loc2_ = {};
		_loc2_.txd = _loc3_.dataList[0][6];
		return _loc2_;
	}

	function SetRightDescription(desc)
	{
		var tf = this.CONTENT.mapDimmerMc.descTF;
		com.rockstargames.ui.utils.UIText.setDescText(tf,desc,undefined,true);
	}


	function SetDescription(max, _title, date, location, track, visible)
	{
		this.CONTENT.descMC._visible = visible;
		this.CONTENT.linesMC._visible = visible;
		this.CONTENT.textContainerMC._visible = visible;
		this.model.initMaxGalleryItems(max);
		var _loc3_ = this.CONTENT.textContainerMC;
		com.rockstargames.ui.utils.UIText.setSizedText(_loc3_.titleHeadingTF,_title == undefined ? "" : _title,true);
		com.rockstargames.ui.utils.UIText.setSizedText(_loc3_.dateTF,date == undefined ? "" : date,true);
		com.rockstargames.ui.utils.UIText.setSizedText(_loc3_.locationTF,location == undefined ? "" : location,true);
		com.rockstargames.ui.utils.UIText.setSizedText(_loc3_.trackTF,track == undefined ? "" : track,true);
	}
	function SetTitle(txd, txn, state)
	{
		var _loc2_ = this.model.getCurrentView().viewContainer;
		this.curState = state;
		switch (state)
		{
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_LOADED :
				this.maxImgMC.spinnerMC.stop();
				this.maxImgMC.spinnerMC._visible = false;
				this.CONTENT.frameMC._visible = true;
				this.ADD_TXD_REF(txd,txn);
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_TRANSITION :
				this.maxImgMC.spinnerMC.gotoAndPlay(this.maxImgMC.spinnerMC._currentframe == 1 ? 2 : this.maxImgMC.spinnerMC._currentframe);
				this.maxImgMC.spinnerMC._visible = true;
				this.CONTENT.frameMC._visible = false;
				if (this.maxILMC.isLoaded)
				{
					this.maxILMC.removeTxdRef();
				}
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_LOADING :
				this.maxImgMC.spinnerMC.gotoAndPlay(this.maxImgMC.spinnerMC._currentframe == 1 ? 2 : this.maxImgMC.spinnerMC._currentframe);
				this.maxImgMC.spinnerMC._visible = true;
				this.CONTENT.frameMC._visible = true;
				break;
			case com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuGalleryItem.ITEM_STATE_EMPTY :
			default :
				_loc2_._visible = true;
				this.maxImgMC._visible = false;
				this.CONTENT.frameMC._visible = false;
				if (this.maxILMC.isLoaded)
				{
					this.maxILMC.removeTxdRef();
				}
				return undefined;
		}
		_loc2_._visible = false;
		this.maxImgMC._visible = true;
	}

	function AddItem(_viewIndex, dataArray)
	{
		this.model.addDataToView(0,_viewIndex,dataArray);
		if (this.scrollBase != undefined)
		{
			this.scrollBase.updateScroll();
		}
	}

	function SET_INPUT_EVENT(direction)
	{
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				this.model.getCurrentView().moveVert(-1);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				this.model.getCurrentView().moveHorz(1);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				this.model.getCurrentView().moveVert(1);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				this.model.getCurrentView().moveHorz(-1);
		}
		return this.model.getCurrentView().index;
	}

	function ADD_TXD_REF(txd, txn)
	{
		if (this.maxILMC.isLoaded)
		{
			this.maxILMC.removeTxdRef();
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.maxILMC,txd,txn,578,322);
	}

   function ON_DESTROY()
   {
      this.model.getCurrentView().clearDescription();
      this.model.onDestroy();
   }
   function SET_DATA_SLOT_EMPTY(viewIndex, itemIndex)
   {
      this.ON_DESTROY();
   }

	function SET_HIGHLIGHT(highlightIndex, staticClear)
	{
		this.model.getCurrentView().highlightedItem = 0;
		this.model.getCurrentView().topEdge = 0;
		this.model.getCurrentView().index = 0;
		var _loc3_ = this.model.getCurrentView();
		_loc3_.highlightedItem = highlightIndex;
		_loc3_.index = highlightIndex;
		var _loc4_ = _loc3_.itemList[_loc3_.index];
		_loc4_.highlighted = true;
		_loc3_.setDescription();
	}
	function SET_COMPONENT_HIDDEN()
	{
		var _loc3_ = arguments[1];
		this.CONTENT.mapDimmerMC._visible = _loc3_;
	}
	function SET_FOCUS(isFocused)
	{
		if (isFocused)
		{
			var _loc3_ = this.model.getCurrentView();
			var _loc4_ = _loc3_.itemList[_loc3_.index];
			_loc4_.highlighted = true;
			_loc3_.setDescription();
		}
	}

	function SetScrollBarArrows(visible, columns, scrollType, arrowPosition, override, xColOffset)
	{
		if (this.scrollBase == undefined)
		{
			this.scrollBase = com.rockstargames.gtav.pauseMenu.pauseComponents.PM_ScrollBase(this.CONTENT.attachMovie("PM_ScrollBase", "scrollBase", this.CONTENT.getNextHighestDepth()));
		}
		if (!override)
		{
			this.scrollBase.setComponent(this);
		}
		this.scrollBase.INIT_SCROLL_BAR(visible,columns,scrollType,arrowPosition,override,xColOffset);
	}

	function SetScrollBar(currentPosition, maxPosition, maxVisible, caption)
	{
		if (this.scrollBase != undefined)
		{
			this.scrollBase.SET_SCROLL_BAR(currentPosition,maxPosition,maxVisible,caption);
		}
	}

	function set focused(_f)
	{
		super.focused = _f;
		this.CONTENT._alpha = _f ? 100 : 60;
		this.SET_FOCUS(_f);
	}

}