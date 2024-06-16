class com.rockstargames.PauseMenu.header.PauseMenuBar extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var CONTENT;
	var menuItemList = new Array();
	var visibleItems = 6;
	var totalMenuWidth = 868;
	var scrollingMenuWidth = 725;
	var menuItemWidth = 143;
	var menuItemSpacing = 2;
	var created = false;
	var menuIndex = 0;
	var startIndex = 0;
	var headerContainerMC;
	var leftArrowMouseCatcherMC;
	var rightArrowMouseCatcherMC;
	var allHighlightsOn;
	var _dynamicWidth = false;

	function PauseMenuBar()
	{
		super();
		this.menuItemList = new Array();
	}

	function INITIALIZE(mc, newmc)
	{
		if (newmc == undefined)
		{
			this.CONTENT = this;
		}
		else
		{
			super.INITIALISE(newmc);
		}
		this.headerContainerMC = this.CONTENT.createEmptyMovieClip("menuContainerMC", this.CONTENT.getNextHighestDepth());
	}

	function AddItem(_title, dim, color)
	{
		var menuItem = this.headerContainerMC.attachMovie("PauseBarMenuItem", "pauseBarMenuItem_" + this.menuItemList.length, this.headerContainerMC.getNextHighestDepth());
		menuItem.menuenum = this.menuItemList.length;
		menuItem.label = _title;
		menuItem.width = this.menuItemWidth;
		menuItem.realignText(dim);
		if (menuItem.menuenum == 0)
		{
			menuItem._x = 0;
		}
		else
		{
			menuItem._x = menuItemList[this.menuItemList.length - 1]._x + menuItemList[this.menuItemList.length - 1].width + this.menuItemSpacing;
		}
		menuItem.mycolour = color;
		if (menuItem.menuenum == this.menuIndex)
		{
			menuItem.highlight = true;
		}
		else
		{
			menuItem.highlight = false;
		}
		menuItem.rollover = false;
		menuItem.attachMovie("mouseCatcher","mouseCatcher",menuItem.getNextHighestDepth(),{_width:menuItem._width, _height:menuItem._height});
		menuItem.mouseCatcher.setupGenericMouseInterface(this.menuItemList.length,-1,this.onMouseEvent,[menuItem, this]);
		this.menuItemList.push(menuItem);
		if (_dynamicWidth && this.menuItemList.length < 6)
		{
			for (var i = 0; i < this.menuItemList.length; i++)
			{
				var it = this.menuItemList[i];
				it.width = this.totalMenuWidth / this.menuItemList.length;
				if (this.menuItemList.length > 1)
				{
					it.width -= this.menuItemSpacing;
				}
				menuItem.mouseCatcher._width = it.width;
				if (it.menuenum == 0)
				{
					it._x = 0;
				}
				else
				{
					it._x = this.menuItemList[i - 1]._x + this.menuItemList[i - 1].width + this.menuItemSpacing;
				}
				if (it.menuenum == this.menuIndex)
				{
					it.highlight = true;
				}
				else
				{
					it.highlight = false;
				}
			}
		}
 		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(menuItem.mc.textMC.txtString, "$Font2");
	}

	function onMouseEvent(evtType, targetMC, args)
	{
		var item = args[0];
		var bar = args[1];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				item.mRollOver();
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				item.mRollOut();
				break;
		}
	}

	function RemItem(idx)
	{

	}

	function SelectItem(item)
	{

	}

	function createArrowMouseCatcher(x, y, w, h, mPress)
	{
		var _loc2_ = this.CONTENT.createEmptyMovieClip("arrowCatcherMC" + this.CONTENT.getNextHighestDepth(), this.CONTENT.getNextHighestDepth());
		_loc2_.beginFill(16711935,100);
		_loc2_.moveTo(0,0);
		_loc2_.lineTo(w,0);
		_loc2_.lineTo(w,h);
		_loc2_.lineTo(0,h);
		_loc2_.lineTo(0,0);
		_loc2_.endFill();
		_loc2_._visible = true;
		_loc2_._alpha = 100;
		_loc2_._x = x;
		_loc2_._y = y;
		return _loc2_;
	}

	function removeArrowMouseCatcher(arrowCatcherMC)
	{
		arrowCatcherMC.mouseCatcher.dispose();
		arrowCatcherMC.removeMovieClip();
	}
	function onLeftArrowClick()
	{
		var _loc2_ = (this.menuIndex <= 0 ? this.menuItemList.length : this.menuIndex) - 1;
		this.SET_CODE_MENU_INDEX(_loc2_);
	}
	function onRightArrowClick()
	{
		var _loc2_ = (this.menuIndex + 1) % this.menuItemList.length;
		this.SET_CODE_MENU_INDEX(_loc2_);
	}

	function SET_CODE_MENU_INDEX(rollOverIndex)
	{
		var _loc7_ = 0;
		var __reg7 = 0;
		if (this.menuItemList.length > this.visibleItems)
		{
			if (this.menuIndex == 0 && rollOverIndex == this.menuItemList.length - 1)
			{
				this.startIndex = this.menuItemList.length - this.visibleItems;
				__reg7 = 0 - (rollOverIndex * (this.menuItemWidth + this.menuItemSpacing) - this.scrollingMenuWidth);
				this.scrollMenu(__reg7,0.333,com.rockstargames.ui.tweenStar.Ease.CUBIC_INOUT);
			}
			if (this.menuIndex == this.menuItemList.length - 1 && rollOverIndex == 0)
			{
				this.startIndex = 0;
				__reg7 = 0 - rollOverIndex * (this.menuItemWidth + this.menuItemSpacing);
				this.scrollMenu(__reg7,0.333,com.rockstargames.ui.tweenStar.Ease.CUBIC_INOUT);
			}
			if (rollOverIndex >= this.startIndex + this.visibleItems)
			{
				++this.startIndex;
				__reg7 = 0 - (rollOverIndex * (this.menuItemWidth + this.menuItemSpacing) - this.scrollingMenuWidth);
				this.scrollMenu(__reg7,0.2,com.rockstargames.ui.tweenStar.Ease.CUBIC_OUT);
			}
			if (rollOverIndex < this.startIndex)
			{
				--this.startIndex;
				__reg7 = 0 - rollOverIndex * (this.menuItemWidth + this.menuItemSpacing);
				this.scrollMenu(__reg7,0.2,com.rockstargames.ui.tweenStar.Ease.CUBIC_OUT);
			}
		}
		this.menuIndex = rollOverIndex;
		for (var i = 0; i < this.menuItemList.length; i++)
		{
			this.menuItemList[i].highlight = (i == this.menuIndex);
		}
		//com.rockstargames.ui.game.GameInterface.call("LAYOUT_CHANGED",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,0,0,rollOverIndex,1);
		var __reg8 = this.menuIndex == this.startIndex;
		var __reg9 = this.menuIndex - this.startIndex == this.visibleItems - 1;
		this.SET_HEADER_ARROWS_VISIBLE(__reg8,__reg9);
	}

	function SET_MENU_HEADER_TEXT_BY_INDEX(menuIndex, label, widthSpan)
	{
		var _loc2_ = this.menuItemList[menuIndex];
		_loc2_.label = label;
		_loc2_.realignText(widthSpan);
	}

	function SET_ALL_HIGHLIGHTS(hOn, color)
	{
		this.allHighlightsOn = hOn;
		for (var _loc2_ in this.menuItemList)
		{
			var _loc3_ = this.menuItemList[_loc2_];
			if (this.allHighlightsOn)
			{
				_loc3_.highlight = true;
			}
			else
			{
				_loc3_.highlight = this.menuIndex == _loc2_;
			}
			_loc3_.bespokeColour = color;
		}
	}

	function scrollMenu(x, duration, easetype)
	{
		if (!duration || duration == 0)
		{
			duration = 0.2;
		}
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.headerContainerMC,duration,{_x:x, ease:easetype});
	}

	function SET_HEADER_ARROWS_VISIBLE(isLeftArrowVisible, isRightArrowVisible)
	{
		com.rockstargames.ui.game.GameInterface.call("SET_HEADER_ARROW_VISIBLE",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,this.menuItemList.length > this.visibleItems,isLeftArrowVisible,isRightArrowVisible);
	}

}