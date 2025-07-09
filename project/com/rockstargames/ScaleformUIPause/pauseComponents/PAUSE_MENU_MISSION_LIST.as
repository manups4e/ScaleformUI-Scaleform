class com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_MISSION_LIST extends com.rockstargames.gtav.pauseMenu.pauseComponents.PauseMenuComponentBase
{
	function PAUSE_MENU_MISSION_LIST()
	{
		super();
		this.dbgID = "PAUSE_MENU_MISSION_LIST";
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
		this.model = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuMissionModel();
		this.model.createView(0,{id:0, x:0, y:0, rowSpacing:2, columnSpacing:0, container:this.CONTENT, linkage:["mpFreemodeItem"], visibleItems:10, selectstyle:com.rockstargames.ui.components.GUIView.SCROLL_SELECTSTYLE});
	}

	function SET_MAX_ITEMS(maxItems)
	{
		Debug.Debug.Log("SET_MAX_ITEMS - " + arguments);
		this.model.getCurrentView().maxVisibleItems = maxItems;
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
	}

	function SET_DATA_SLOT_SPLICE(_viewIndex, _slotIndex)
	{
		this.model.addDataToView(0,_viewIndex,arguments);
		if (this.scrollBase != undefined)
		{
			this.scrollBase.updateScroll();
		}
	}

	function INIT_SCROLL_BAR(visible, columns, scrollType, arrowPosition, override, xColOffset)
	{
		super.INIT_SCROLL_BAR(visible,columns,scrollType,arrowPosition,override,xColOffset);
		if (this.scrollBase != undefined)
		{
			var _loc3_ = this.getHelpY();
			this.scrollBase._y = _loc3_;
			if (this.scrollBase._visible)
			{
				this.scrollBase._y + this.scrollBase._height + 2;
			}
		}
	}

	function SET_SCROLL_BAR(currentPosition, maxPosition, maxVisible, caption, forceInvisible)
	{
		super.SET_SCROLL_BAR(currentPosition,maxPosition,maxVisible,caption,forceInvisible);
		if (this.scrollBase != undefined)
		{
			var _loc3_ = this.getHelpY();
			this.scrollBase._y = _loc3_;
			if (this.scrollBase._visible)
			{
				this.scrollBase._y + this.scrollBase._height + 2;
			}
		}
	}
	function REMOVE_SLOT()
	{
		this.model.removeDataSlot(0,arguments[0]);
	}

	function getHelpY()
	{
		var _loc6_ = 0;
		var _loc3_ = this.model.getCurrentView();
		var _loc4_ = _loc3_.visibleItems;
		var _loc2_ = 25;
		var _loc5_ = _loc3_.rowSpacing;
		return _loc6_ + _loc4_ * (_loc2_ + _loc5_);
	}

	function SET_FOCUS()
	{
		super.SET_FOCUS.apply(this,arguments);
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		if (this.scrollBase._visible)
		{
			this.scrollBase._y + this.scrollBase._height + 2;
		}
	}

	function SET_HIGHLIGHT(i)
	{
		var _loc2_ = this.model.getCurrentView();
		if (_loc2_.itemList[i].type == 1)
		{
			return;
		}
		_loc2_.index = i;
		if (this.scrollBase != undefined)
		{
			this.scrollBase.updateScroll();
		}
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		if (this.scrollBase._visible)
		{
			this.scrollBase._y + this.scrollBase._height + 2;
		}
	}
	function SET_INPUT_EVENT(direction)
	{
		var _loc2_ = 0;
		if (direction == com.rockstargames.ui.game.GamePadConstants.DPADUP)
		{
			this.model.prevItem();
		}
		if (direction == com.rockstargames.ui.game.GamePadConstants.DPADDOWN)
		{
			this.model.nextItem();
		}
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		if (this.scrollBase._visible)
		{
			this.scrollBase._y + this.scrollBase._height + 2;
		}
	}

}