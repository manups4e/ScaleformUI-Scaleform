class com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_SIDE_MISSION_PANEL extends com.rockstargames.gtav.pauseMenu.pauseComponents.PauseMenuComponentBase
{
	var displayType = com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_SIDE_MISSION_PANEL.DISPLAY_TYPE_MISSION;
	static var DISPLAY_TYPE_MISSION = 0;
	static var DISPLAY_TYPE_STORE = 1;
	var CONTENT;
	var menuBlackAlphaColor;
	var scrollableContent;
	var imgLdr;
	var defaultPlaceholderA;
	var _mainMC;
	var listDescItem;
	var LeftRightSide = 1;
	var menu;
	var panelTitle;
	var panelTitleColour;
	var BannerTitle;
	var descItems = [];
	var titleFreemode;
	var _titleType;
	var BannerSprite;
	var banner;
	var verifiedMC;
	var verifiedbgMC;
	var descBG;
	var imgPlaceholderMC;
	var imgMC;

	function PAUSE_MENU_SIDE_MISSION_PANEL()
	{
		super();
		_global.gfxExtensions = true;
	}

	function INITIALISE(mc)
	{
		this.CONTENT = this;
		this.titleFreemode = this.CONTENT.attachMovie("freemodeTitleItem", "freemodeTitleItemMC", 1);
		this.titleFreemode._y = this.CONTENT.descBG._y - this.titleFreemode.getHeight();
		this.scrollableContent = this.CONTENT.createEmptyMovieClip("scrollContent", 0);
		this.scrollableContent._y = this.CONTENT.descBG._y;
		this.model = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuFreemodeDetailsModel();
		this.model.createView(0,{id:0, x:0, y:0, rowSpacing:2, columnSpacing:0, container:this.scrollableContent, visibleItems:10, linkage:["freemodeDetailsItem"], viewMaskHeight:430, selectstyle:com.rockstargames.ui.components.GUIView.SCROLL_SELECTSTYLE});
		this.CONTENT.verifiedMC._visible = this.CONTENT.verifiedbgMC._visible = false;
		this.CONTENT._visible = false;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.descBG,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.verifiedbgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.imgPlaceholderMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.defaultPlaceholderA = this.CONTENT.imgPlaceholderMC._alpha;
	}

	function SET_TITLE(str)
	{
		this.titleFreemode.highlightTitle(false);
		com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.itemTextLeft,str,true,false,0,23);
		com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.labelMC.titleshadowTF,str,true,false,0,23);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.titleFreemode.itemTextLeft,"$Font5");
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.titleFreemode.labelMC.titleshadowTF,"$Font5");
		this.titleFreemode.snapBGGrid(this.titleFreemode.bgMC);
		if (arguments[1] == "" && arguments[2] == "")
		{
//			this.CONTENT.descBG._y = this.CONTENT.descBG._y - this.CONTENT.imgPlaceholderMC._height;
//			this.CONTENT.descBG._y = this.CONTENT.descBG._y + this.titleFreemode.getHeight();
//			this.titleFreemode._y = this.CONTENT.descBG._y - this.titleFreemode.getHeight();
//			this.CONTENT.imgPlaceholderMC._visible = true;
		}
		else
		{
			if (this.imgLdr == undefined)
			{
				this.imgLdr = this.CONTENT.imgMC.attachMovie("txdLoader", "imgLdr_" + this.CONTENT.imgMC.getNextHighestDepth(), this.CONTENT.imgMC.getNextHighestDepth());
			}
			var _loc12_ = false;
			if (this.imgLdr.textureDict == arguments[1])
			{
				_loc12_ = true;
				var splitPath = String(this.imgLdr).split(".");
				var pathWithoutContent = splitPath.slice(5).join(".");
				this.imgLdr.loadWithValidation("ScaleformUIPause",arguments[1],arguments[2],pathWithoutContent,288,160);
				this.transitionInBitmap();
			}
			else if (this.imgLdr.isLoaded)
			{
				this.imgLdr.removeTxdRef();
			}

			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(this.imgLdr,arguments[1],arguments[2],288,160,this.transitionInBitmap,this);
		}
		this.updateDescBG();
	}

	function transitionInBitmap()
	{
		this.imgLdr._alpha = 0;
		this.imgLdr._visible = true;
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.imgLdr);
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.CONTENT.imgPlaceholderMC);
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.imgLdr,0.3,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.QUADRATIC_OUT});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT.imgPlaceholderMC,0.3,{_alpha:0, ease:com.rockstargames.ui.tweenStar.Ease.QUADRATIC_OUT, onCompleteScope:this, onComplete:this.transitionComplete});
	}
	function transitionComplete()
	{
		this.CONTENT.imgPlaceholderMC._alpha = this.defaultPlaceholderA;
		this.CONTENT.imgPlaceholderMC._visible = false;
	}
	function ON_DESTROY()
	{
		if (this.imgLdr.isLoaded == true)
		{
			this.imgLdr.removeTxdRef();
		}
		this.CONTENT._visible = false;
		if (this.imgLdr)
		{
			com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.imgLdr);
		}
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.CONTENT.imgPlaceholderMC);
	}
	function SET_DATA_SLOT_EMPTY(viewIndex, itemIndex)
	{
		super.SET_DATA_SLOT_EMPTY(viewIndex,itemIndex);
		if (this.imgLdr.isLoaded == true)
		{
			this.imgLdr.removeTxdRef();
		}
		this.updateDescBG();
		this.CONTENT._visible = false;
	}
	function DISPLAY_VIEW(viewIndex, itemIndex)
	{
		super.DISPLAY_VIEW(viewIndex,itemIndex);
		this.updateDescBG();
		this.CONTENT._visible = true;
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.CONTENT);
	}
	function updateDescBG()
	{
		switch (this.displayType)
		{
			case com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_SIDE_MISSION_PANEL.DISPLAY_TYPE_STORE :
				this.CONTENT.descBG._height = this.scrollableContent._height;
				break;
			case com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_SIDE_MISSION_PANEL.DISPLAY_TYPE_MISSION :
			default :
				var _loc3_ = this.model.getCurrentView().itemList;
				var _loc5_ = _loc3_.length;
				var _loc2_ = _loc3_[_loc3_.length - 1];
				var _loc6_ = _loc2_.leftlabelMC.titleTF.textHeight;
				var _loc7_ = 5;
				var _loc4_ = 243;
				if (_loc2_.type == 5)
				{
					_loc4_ = _loc2_._y + _loc2_.leftlabelMC._y + _loc6_ + _loc7_ * 2;
				}
				else
				{
					_loc4_ = 2 + 27 * (_loc5_ - 1) + 25;
				}
				this.CONTENT.descBG._height = _loc4_;
		}
	}
	function SET_FOCUS(isFocused)
	{
		super.SET_FOCUS(isFocused);
		this.titleFreemode.highlightTitle(Boolean(isFocused));
	}
	function getKeys()
	{
		if (Key.isDown(38))
		{
			this.SET_INPUT_EVENT(com.rockstargames.ui.game.GamePadConstants.DPADUP);
		}
		else if (Key.isDown(40))
		{
			this.SET_INPUT_EVENT(com.rockstargames.ui.game.GamePadConstants.DPADDOWN);
		}
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
}