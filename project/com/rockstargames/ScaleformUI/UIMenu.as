class com.rockstargames.ScaleformUI.UIMenu extends MovieClip
{
	var BannerSprite;
	var bannerSpriteMC;
	var SubtitleSprite;
	var subtitleSprite;
	var CounterText;
	var itemsBG;
	var backgroundBody;
	var scrollableContent;
	var model;
	var Footer;
	var DescriptionSprite;
	var descriptionSprite;
	var MOUSE_EVT;
	var showing;
	var _data;
	var isItemless;
	var tempOff;
	var _menuTitle;
	var _menuSubtitle;
	var maxItemsOnScreen;
	var alternativeTitle;
	var countCol;
	var bannerColor;
	var bannerBGColor;
	var Orientation;
	var SubtitleText;
	var BannerTitle;
	var blipLayer;
	var _activeItem = 0;
	var itemCount = 0;
	var windowsCount = 0;
	var _minItem = 0;
	var _maxItem = 7;
	var isVisible = false;
	var _bannerTxd = "commonmenu";
	var _bannerTexture = "interaction_bgd";
	var _bodyTexture = "gradient_bgd";
	var _upAndDownArrows = "shop_arrows_upanddown";
	var _menuOff = [];
	var buildingType = 0;
	var slots = [];
	var descFont = 0;
	var totalItems = 0;
	var aligns = [];
	function UIMenu()
	{
		super();
		this.BannerSprite = this.bannerSpriteMC;
		this.BannerSprite.bannerBG.attachMovie("txdLoader","bannerBGSprite",this.BannerSprite.bannerBG.getNextHighestDepth());
		this.BannerSprite.bannerBG.attachMovie("txdLoader","bannerSprite",this.BannerSprite.bannerBG.getNextHighestDepth());
		this.SubtitleSprite = this.subtitleSprite;
		this.CounterText = this.SubtitleSprite.counterMC.labelTF;
		this.itemsBG = this.backgroundBody;
		this.itemsBG.maskMC._height = 0;
		this.itemsBG.bgMC._height = 0;
		this.itemsBG.bgMC._alpha = 0;
		this.itemsBG.attachMovie("txdLoader","bg_txd",this.itemsBG.getNextHighestDepth());
		this.itemsBG.setMask(this.itemsBG.maskMC);
		this.scrollableContent = this.itemsBG.createEmptyMovieClip("viewContainer", this.itemsBG.getNextHighestDepth());
		this.model = new com.rockstargames.ScaleformUI.UIMenuModel();
		this.Footer = this.attachMovie("UIMenu_ScrollBase", "footer", this.getNextHighestDepth());
		this.Footer.INIT_SCROLL_BAR(true,1,1,1,0);
		this.Footer.INIT_BUTTONS();
		this.DescriptionSprite = this.descriptionSprite;
		this.Footer._visible = false;
		this.DescriptionSprite._visible = false;
		this.MOUSE_EVT = new com.rockstargames.ui.mouse.MOUSE_EVENTS();
		this.MOUSE_EVT.INTERFACE_TYPE = 10;
		this.MOUSE_EVT.UI_MOVIE = 4;
		this.showing = false;
	}
	function set data(d)
	{
		this._data = d;
		this.isItemless = d[13];
		this.tempOff = new Array(d[2], d[3]);
		this._menuTitle = d[0];
		this._menuSubtitle = d[1];
		this.maxItemsOnScreen = d[7];
		this._minItem = 0;
		this._maxItem = this.maxItemsOnScreen;
		this.itemCount = 0;
		this.totalItems = d[8];
		this.alternativeTitle = d[4];
		this.countCol = d[9];
		this.descFont = [d[10], d[11]];
		this._bannerTxd = d[5];
		this._bannerTexture = d[6];
		this.bannerColor = d[12];
		this.bannerBGColor = -1;
		this.Orientation = d[17];
		this.BannerSprite.titleMC.labelTF.text = "";
		this.BannerSprite.titleMC.labelTF2.text = "";
		this.SubtitleText.text = "";
		if (d[5] != undefined && d[6] != undefined && d[5] != "" && d[6] != "")
		{
			if (d[15] != undefined && d[16] != undefined && d[15] != "" && d[16] != "")
			{
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.BannerSprite.bannerBG.bannerBGSprite,d[15],d[16],288,65,this.underBannerLoaded,this);
			}
			else
			{
				this.BannerSprite.bannerBG.bannerBGSprite.removeTxdRef();
			}
			this._bannerTxd = d[5];
			this._bannerTexture = d[6];
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.BannerSprite.bannerBG.bannerSprite,d[5],d[6],288,65,this.bannerLoaded,this);
		}
		if (this._menuTitle != undefined && this._menuTitle != "")
		{
			if (!this.alternativeTitle)
			{
				var _loc4_ = new TextFormat("$Font5", 31);
				_loc4_.align = "center";
				this.BannerTitle = this.BannerSprite.titleMC.labelTF;
				this.BannerTitle.embedFonts = true;
				this.BannerTitle.antiAliasType = "advanced";
				this.BannerTitle.selectable = false;
				com.rockstargames.ui.utils.UIText.setSizedText(this.BannerSprite.titleMC.labelTF,this._menuTitle,true,true,31,31);
				this.BannerTitle.setTextFormat(_loc4_);
			}
			else
			{
				_loc4_ = new TextFormat("$Font2_cond", 60);
				_loc4_.align = "left";
				this.BannerTitle = this.BannerSprite.titleMC.labelTF2;
				this.BannerTitle.embedFonts = true;
				this.BannerTitle.antiAliasType = "advanced";
				this.BannerTitle.selectable = false;
				com.rockstargames.ui.utils.UIText.setSizedText(this.BannerSprite.titleMC.labelTF2,this._menuTitle,true,true,60,60);
				this.BannerTitle.setTextFormat(_loc4_);
			}
		}
		this.SubtitleSprite._y = this.BannerSprite == undefined ? 0 : 65;
		this.SubtitleSprite._width = 288;
		this.SubtitleSprite._height = 25;
		this.SubtitleText = this.SubtitleSprite.subtitleMC.labelTF;
		this.SubtitleText.embedFonts = true;
		this.SubtitleText.autoSize = true;
		this.SubtitleText.antiAliasType = "advanced";
		this.SubtitleText.selectable = false;
		com.rockstargames.ui.utils.UIText.setSizedText(this.SubtitleText,"",false,true);
		if (this._menuSubtitle != undefined && this._menuSubtitle != "")
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.SubtitleText,this._menuSubtitle,false,true);
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.SubtitleText,"$Font2");
		}
		if (this.itemsBG.bg_txd.textureDict == "")
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.itemsBG.bg_txd,"commonmenu","gradient_bgd",288,25,this.resizeBackground,this);
		}
		this.CounterText.autoSize = "right";
		if (!d[18])
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.CounterText,"0/0",false,false);
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColourToTF(this.CounterText,d[9]);
		if (this.model.getCurrentView().windowsList.length == 0)
		{
			this.itemsBG._y = this.SubtitleSprite._y + this.SubtitleSprite._height - 1;
		}
		if (!d[18])
		{
			this.model.createView(0,{id:0, x:0, y:0, rowSpacing:2, columnSpacing:0, container:this.scrollableContent, linkage:["UIMenuItem"], visibleItems:this.maxItemsOnScreen, selectstyle:com.rockstargames.ui.components.GUIView.SCROLL_SELECTSTYLE});
			this.showing = false;
		}
		var _loc3_ = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,_loc3_);
		com.rockstargames.ui.utils.Colour.Colourise(this.DescriptionSprite.bgMC,_loc3_.r,_loc3_.g,_loc3_.b,_loc3_.a);
		if (this.isItemless)
		{
			this.itemsBG.removeMovieClip();
			this.Footer.removeMovieClip();
			this.CounterText.text = "";
			this.DescriptionSprite._visible = true;
			this.DescriptionSprite._y = this.SubtitleSprite._y + this.SubtitleSprite._height + 1;
			var _loc5_ = new com.rockstargames.ui.utils.Text();
			if (this.blipLayer)
			{
				this.blipLayer.removeMovieClip();
			}
			this.DescriptionSprite.descriptionMC.descText.wordWrap = true;
			this.DescriptionSprite.descriptionMC.descText.autoSize = true;
			this.blipLayer = this.DescriptionSprite.descriptionMC.createEmptyMovieClip("blipLayer", 1000, {_x:this.DescriptionSprite.descriptionMC.descText._x, _y:this.DescriptionSprite.descriptionMC.descText._y});
			_loc5_.setTextWithIcons(d[15],this.blipLayer,this.DescriptionSprite.descriptionMC.descText,this.descFont[1],13,2,false);
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.DescriptionSprite.descriptionMC.descText,this.descFont[0]);
			this.DescriptionSprite.bgMC._height = this.DescriptionSprite.descriptionMC.descText.textHeight + 12;
		}
		this.SetMenuOffset(d[2],d[3]);
	}
	function AddWindow(slotIndex, args)
	{
		args.unshift(this);
		this.model.AddWindowToView(slotIndex,args);
	}
	function UpdateWindow(slotIndex, args)
	{
		args.unshift(this);
		this.model.UpdateWindowSlot(slotIndex,args);
	}
	function AddWindowExtra(win, ind, args)
	{
		this.model.SetExtraWindowDataSlot(win,ind,args);
	}
	function AddItem(viewIndex, slotIndex, args)
	{
		args.unshift(this);
		this.model.addDataToView(viewIndex,slotIndex,args);
		var _loc2_ = this.resizeBackground();
		this.updateDescription(_loc2_);
		this.setCounter(this.model.getCurrentView().index + 1,this.model.getCurrentView().dataList.length);
	}
	function AddItemSplice(viewIndex, slotIndex, args)
	{
		args.unshift(this);
		this.model.addDataToViewSplice(viewIndex,slotIndex,args);
		var _loc2_ = this.resizeBackground();
		this.updateDescription(_loc2_);
		this.setCounter(this.model.getCurrentView().index + 1,this.model.getCurrentView().dataList.length);
	}
	function AddSlot(viewIndex, slotIndex, args)
	{
		args.unshift(this);
		this.model.addSlot(viewIndex,slotIndex,args);
		this.CurrentSelection = this.CurrentSelection;
	}
	function RemoveItem(slotIndex)
	{
		this.model.removeDataSlot(0,slotIndex);
	}
	function UpdateItem(viewIndex, slotIndex, args)
	{
		args.unshift(this);
		this.model.updateSlot(viewIndex,slotIndex,args);
		var _loc2_ = this.resizeBackground();
		this.updateDescription(_loc2_);
	}
	function AddPanel(slotIndex, args)
	{
		var _loc3_ = this.model.getCurrentView().itemList[slotIndex];
		args.unshift(_loc3_);
		this.model.AddPanelToView(args[1],args);
	}
	function UpdatePanel(slotIndex, args)
	{
		var _loc3_ = this.model.getCurrentView().itemList[slotIndex];
		args.unshift(_loc3_);
		this.model.UpdatePanelToSlot(args[1],args);
	}
	function RemovePanel(slotIndex, index)
	{
		var _loc2_ = this.model.getCurrentView().itemList[slotIndex];
		_loc2_.removePanel(index);
	}
	function AddSidePanel(slotIndex, args)
	{
		args.unshift(this);
		this.model.AddSidePanelToView(args);
	}
	function UpdateSidePanel(slotIndex, args)
	{
		args.unshift(this);
		this.model.UpdateSidePanelToSlot(args);
	}
	function SetSidePanelSlot(slotIndex, args)
	{
		this.model.SetExtraSidePanelData(slotIndex,args);
	}
	function SetBannerTexture(txd, txn)
	{
		this.BannerSprite.bannerBG.bannerSprite.removeTxdRef();
		if (txd == undefined || txd == "" || txn == undefined || txn == "")
		{
			return undefined;
		}
		this._bannerTxd = txd;
		this._bannerTexture = txn;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.BannerSprite.bannerBG.bannerSprite,txd,txn,288,65,this.bannerLoaded,this);
	}
	function SetBannerColor(color)
	{
		this.bannerColor = color;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.BannerSprite.bannerBG.bannerSprite,color);
	}
	function SetUnderBannerTexture(txd, txn)
	{
		this.BannerSprite.bannerBG.bannerBGSprite.removeTxdRef();
		if (txd == undefined || txd == "" || txn == undefined || txn == "")
		{
			return undefined;
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.BannerSprite.bannerBG.bannerBGSprite,txd,txn,288,65,this.underBannerLoaded,this);
	}
	function SetUnderBannerColor(color)
	{
		this.bannerBGColor = color;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.BannerSprite.bannerBG.bannerBGSprite,color);
	}
	function Show(index)
	{
		this.model.displayView(0);
		this.CurrentSelection = index;
		var _loc2_ = this.resizeBackground();
		this.updateDescription(_loc2_);
		this.setCounter(this.model.getCurrentView().index + 1,this.model.getCurrentView().dataList.length);
		this.showing = true;
	}
	function ShowPanels()
	{
		if (!this.CurrentItem.isSelectable)
		{
			return undefined;
		}
		var _loc3_ = this.resizeBackground();
		var _loc2_ = _loc3_ + this.BannerSprite._height + this.SubtitleSprite._height;
		if (this.model.getCurrentView().dataList.length > this.maxItemsOnScreen)
		{
			_loc2_ = this.Footer._y + this.Footer._height;
		}
		if (this.DescriptionSprite._visible)
		{
			_loc2_ = this.DescriptionSprite._y + this.DescriptionSprite._height;
		}
		if (this.CurrentItem.isSelectable)
		{
			this.model.displayPanels(this,_loc2_ + 1);
		}
	}
	function ShowWindows()
	{
		this.model.getCurrentView().windowY = this.BannerSprite._height + this.SubtitleSprite._height;
		this.model.ShowWindows(this);
		this.itemsBG._y = this.model.getCurrentView().windowY;
	}
	function ShowSidePanel()
	{
		if (!this.CurrentItem.isSelectable)
		{
			return undefined;
		}
		this.model.displaySidePanel(this,this._menuOff,this.Orientation);
	}
	function updateDescription(h)
	{
		var _loc2_ = 0;
		if (this.model.getCurrentView().windowY > 0)
		{
			_loc2_ = this.model.getCurrentView().windowY + h;
		}
		else
		{
			_loc2_ = this.BannerSprite._height + this.SubtitleSprite._height + h;
		}
		if (this.model.getCurrentView().dataList.length > this.maxItemsOnScreen)
		{
			if (this.Footer == undefined)
			{
				this.Footer = this.attachMovie("UIMenu_ScrollBase", "footer", this.getNextHighestDepth());
				this.Footer.INIT_SCROLL_BAR(true,1,1,1,0);
				this.Footer.INIT_BUTTONS();
			}
			this.Footer._visible = true;
			this.Footer._x = 0;
			this.Footer._y = _loc2_ + 1;
			_loc2_ = this.Footer._y + this.Footer._height;
		}
		else
		{
			this.Footer._visible = false;
		}
		var _loc3_ = new com.rockstargames.ui.utils.Text();
		if (this.blipLayer)
		{
			this.blipLayer.removeMovieClip();
		}
		this.DescriptionSprite.descriptionMC.descText.wordWrap = true;
		this.DescriptionSprite.descriptionMC.descText.autoSize = true;
		this.blipLayer = this.DescriptionSprite.descriptionMC.createEmptyMovieClip("blipLayer", 1000, {_x:this.DescriptionSprite.descriptionMC.descText._x, _y:this.DescriptionSprite.descriptionMC.descText._y});
		_loc3_.setTextWithIcons("UIMenu_Current_Description",this.blipLayer,this.DescriptionSprite.descriptionMC.descText,this.descFont[1],13,2,false,true);
		if (com.rockstargames.ScaleformUI.utils.Functions.trim(this.DescriptionSprite.descriptionMC.descText.text) != "" && this.DescriptionSprite.descriptionMC.descText.text != "undefined")
		{
			this.DescriptionSprite._x = 0;
			this.DescriptionSprite._y = _loc2_ + 1;
			this.DescriptionSprite._visible = true;
			if (this.CurrentItem.blinkDesc)
			{
				if (this.DescriptionSprite.iMC._currentframe == 1)
				{
					this.DescriptionSprite.iMC.gotoAndPlay(2);
				}
			}
			else
			{
				this.DescriptionSprite.iMC.gotoAndStop(1);
			}
			this.DescriptionSprite.bgMC._height = this.DescriptionSprite.descriptionMC.descText.textHeight + 12;
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.DescriptionSprite.descriptionMC.descText,this.descFont[0]);
		}
		else
		{
			this.DescriptionSprite._visible = false;
			this.DescriptionSprite.iMC.gotoAndStop(1);
		}
	}
	function underBannerLoaded()
	{
		this.BannerSprite.bannerBG.bannerBGSprite._width = 288;
		this.BannerSprite.bannerBG.bannerBGSprite._height = 65;
		if (this.bannerBGColor != -1)
		{
			this.SetUnderBannerColor(this.bannerBGColor);
		}
		else if (this.bannerColor != -1)
		{
			this.SetUnderBannerColor(this.bannerColor);
		}
		else
		{
			var _loc2_ = new com.rockstargames.ui.utils.HudColour();
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.bannerBGColor,_loc2_);
			this.BannerSprite.bannerBG.bannerBGSprite._alpha = _loc2_.a;
		}
	}
	function bannerLoaded()
	{
		this.BannerSprite.bannerBG.bannerSprite._width = 288;
		this.BannerSprite.bannerBG.bannerSprite._height = 65;
		if (this.bannerColor != -1)
		{
			this.SetBannerColor(this.bannerColor);
		}
		var _loc2_ = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.bannerColor,_loc2_);
		this.BannerSprite.bannerBG.bannerSprite._alpha = _loc2_.a;
	}
	function InputEvent(direction)
	{
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				this.model.prevItem();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				this.model.nextItem();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
		}
		var _loc2_ = this.resizeBackground();
		this.updateDescription(_loc2_);
		this.setCounter(this.model.getCurrentView().index + 1,this.model.getCurrentView().dataList.length);
		return this.model.getCurrentView().topEdge;
	}
	function colorCounter(colour)
	{
		this.countCol = colour;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColourToTF(this.CounterText,colour);
	}
	function setCounter(act, maxItems)
	{
		this.CounterText.autoSize = "right";
		com.rockstargames.ui.utils.UIText.setSizedText(this.CounterText,act + "/" + maxItems,false,false);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColourToTF(this.CounterText,this.countCol);
	}
	function resizeBackground()
	{
		var _loc4_ = this.model.getCurrentView().itemList;
		var _loc3_ = 0;
		var _loc2_ = 0;
		while (_loc2_ < _loc4_.length)
		{
			_loc3_ += _loc4_[_loc2_].bgMC._height + 2;
			_loc2_ += 1;
		}
		this.itemsBG.maskMC._height = this.itemsBG.bgMC._height = this.itemsBG.bg_txd._height = _loc3_ - 2;
		return _loc3_ - 2;
	}
	function UpdatePositions(safeLeft, safeTop, safeRight)
	{
		this.aligns = [safeLeft, safeTop, safeRight];
		this._menuOff = new Array(this.tempOff[0] + safeLeft, this.tempOff[1] + safeTop, safeRight - 288 - this.tempOff[0]);
		if (this.Orientation == 0)
		{
			this._x = this._menuOff[0];
			this._y = this._menuOff[1];
		}
		else if (this.Orientation == 1)
		{
			this._x = this._menuOff[2];
			this._y = this._menuOff[1];
		}
	}
	function SetMenuOffset(x, y)
	{
		this.tempOff = new Array(x, y);
		this._menuOff = new Array(this.tempOff[0] + this.aligns[0], this.tempOff[1] + this.aligns[1], this.aligns[2] - 288 - this.tempOff[0]);
		if (this.Orientation == 0)
		{
			this._x = this._menuOff[0];
			this._y = this._menuOff[1];
		}
		else if (this.Orientation == 1)
		{
			this._x = this._menuOff[2];
			this._y = this._menuOff[1];
		}
	}
	function clearItems()
	{
		this.model.getCurrentView().index = 0;
		this.model.getCurrentView().topEdge = 0;
		this.model.getCurrentView().destroyPanels();
		this.model.removeDataFromSlot(0);
		this.showing = false;
	}
	function clearWindows()
	{
		this.model.getCurrentView().destroyWindows();
	}
	function clearPanels()
	{
		this.model.getCurrentView().destroyPanels();
	}
	function clearSidePanel()
	{
		this.model.getCurrentView().destroySidePanel();
	}
	function RefreshMenu(args)
	{
		var _loc2_ = this.model.getCurrentView().dataList.slice();
		this.clearItems();
		this.model.getCurrentView().dataList = _loc2_.slice();
		this.Show(args[0],args[1]);
	}
	function set CurrentSelection(s)
	{
		if (!this.showing)
		{
			this.model.displayView(0);
			this.showing = true;
		}
		this.model.setItem(this.model.getCurrentView(),s);
		var _loc2_ = this.resizeBackground();
		this.updateDescription(_loc2_);
		this.setCounter(this.model.getCurrentView().index + 1,this.model.getCurrentView().dataList.length);
	}
	function get CurrentSelection()
	{
		return this.model.getCurrentSelection();
	}
	function get CurrentItem()
	{
		return this.model.getCurrentView().itemList[this.model.getCurrentView().highlightedItem];
	}
}