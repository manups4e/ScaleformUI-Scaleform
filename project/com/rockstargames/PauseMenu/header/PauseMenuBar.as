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
	var menuContainer;
	var allHighlightsOn;
	var _dynamicWidth = false;
	var leftArrowMouseCatcherMC;
	var rightArrowMouseCatcherMC;

	function PauseMenuBar()
	{
		super();
		this.menuItemList = new Array();
	}

	function INITIALIZE(mc)
	{
		if (mc != undefined)
		{
			super.INITIALISE(mc);
		}
		else
		{
			this.CONTENT = this;
		}
		this.menuContainer = this.CONTENT.createEmptyMovieClip("menuContainerMC", this.CONTENT.getNextHighestDepth());
		this.rightArrowMouseCatcherMC = this.createArrowMouseCatcher((this.menuItemWidth + this.menuItemSpacing) * this.visibleItems, 8, 20, 20, this.onRightArrowClick);
		this.leftArrowMouseCatcherMC = this.createArrowMouseCatcher(-20 - this.menuItemSpacing, 8, 20, 20, this.onLeftArrowClick);
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
		_loc2_._alpha = 0;
		_loc2_._x = x;
		_loc2_._y = y;
		_loc2_.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER, x < 0 ? -1 : 1, 1000, _loc2_._name);
		_loc2_.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT, x < 0 ? -1 : 1, 1000, _loc2_._name);
		_loc2_.onRelease = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE, x < 0 ? -1 : 1, 1000, _loc2_._name);
		_loc2_.onPress = com.rockstargames.ui.utils.DelegateStar.create(this, this.sendMouseEvent, com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS, x < 0 ? -1 : 1, 1000, _loc2_._name);
		return _loc2_;
	}
	function sendMouseEvent(id, itemId, context, name)
	{
		var arr = [id, name, context, itemId];
		var mouseEvt = new com.rockstargames.ui.mouse.MOUSE_EVENTS();
		mouseEvt.UI_MOVIE = com.rockstargames.ui.mouse.MOUSE_EVENTS.UI_MOVIE_GENERIC;
		mouseEvt.INTERFACE_TYPE = mouseEvt.SF_BASE_CLASS_MOUSE;
		mouseEvt.triggerEvent(arr);
	}

	function AddItem(_title, dim, color)
	{
		var menuItem = this.menuContainer.attachMovie("PauseBarMenuItem", "pauseBarMenuItem_" + this.menuItemList.length, this.menuContainer.getNextHighestDepth());
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
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(menuItem.mc.textMC.txtString,"$Font2");
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
				//menuItem.mouseCatcher._width = it.width;
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
		if(this.menuItemList.length > 1){
			this.SET_HEADER_ARROWS_VISIBLE(true, true);
		}
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
		var _loc2_ = 0;
		var __reg7 = 0;
		if (this.menuItemList.length > this.visibleItems)
		{
			// rollover from 0 to max (on left)
			if (this.menuIndex == 0 && rollOverIndex == this.menuItemList.length - 1)
			{
				this.startIndex = this.menuItemList.length - this.visibleItems;
				__reg7 = 0 - (rollOverIndex * (this.menuItemWidth + this.menuItemSpacing) - this.scrollingMenuWidth);
				this.scrollMenu(__reg7,0.333,com.rockstargames.ui.tweenStar.Ease.CUBIC_INOUT);
			}
			// rollover from max to 0 (on right)   
			if (this.menuIndex == this.menuItemList.length - 1 && rollOverIndex == 0)
			{
				this.startIndex = 0;
				__reg7 = 0 - rollOverIndex * (this.menuItemWidth + this.menuItemSpacing);
				this.scrollMenu(__reg7,0.333,com.rockstargames.ui.tweenStar.Ease.CUBIC_INOUT);
			}
			// going right or setting any value > this maxVisible   
			if (rollOverIndex >= this.startIndex + this.visibleItems)
			{
				this.startIndex = rollOverIndex - (this.visibleItems - 1);
				__reg7 = 0 - (rollOverIndex * (this.menuItemWidth + this.menuItemSpacing) - this.scrollingMenuWidth);
				this.scrollMenu(__reg7,0.2,com.rockstargames.ui.tweenStar.Ease.CUBIC_OUT);
			}
			// going left or setting any value < this startIndex   
			if (rollOverIndex < this.startIndex)
			{
				this.startIndex = rollOverIndex;
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
		_loc2_ = 0;
		while (_loc2_ < this.menuItemList.length)
		{
			var _loc3_ = this.menuItemList[_loc2_];
			var _loc5_ = _loc2_ < this.startIndex || _loc2_ >= this.startIndex + this.visibleItems;
			if (_loc5_)
			{
				if (_loc3_.hasMouse)
				{
					_loc3_._visible = false;
					_loc3_.removeMouse();
				}
			}
			else if (!_loc3_.hasMouse)
			{
				_loc3_._visible = true;
				_loc3_.addMouse();
			}
			_loc2_ = _loc2_ + 1;
		}
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
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.menuContainer,duration,{_x:x, ease:easetype});
	}
	function SET_HEADER_ARROWS_VISIBLE(isLeftArrowVisible, isRightArrowVisible)
	{
		com.rockstargames.ui.game.GameInterface.call("SET_HEADER_ARROW_VISIBLE",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,true,isLeftArrowVisible,isRightArrowVisible);
	}
}