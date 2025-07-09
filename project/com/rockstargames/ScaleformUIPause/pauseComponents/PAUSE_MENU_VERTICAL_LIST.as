class com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_VERTICAL_LIST extends com.rockstargames.gtav.pauseMenu.pauseComponents.PauseMenuComponentBase
{
	var description;
	var blipLayer;
	function PAUSE_MENU_VERTICAL_LIST()
	{
		super();
		this.dbgID = "PAUSE_MENU_VERTICAL_LIST";
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
		this.model = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVerticalModel();
		this.model.createView(0,{id:0, x:0, y:0, rowSpacing:2, columnSpacing:0, container:this.CONTENT, linkage:["UIMenuItem"], visibleItems:10, selectstyle:com.rockstargames.ui.components.GUIView.SCROLL_SELECTSTYLE});
		var _loc3_ = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,_loc3_);
		com.rockstargames.ui.utils.Colour.Colourise(this.description.bgMC,_loc3_.r,_loc3_.g,_loc3_.b,_loc3_.a);
		this.description._visible = false;
	}

	function SET_MAX_ITEMS(maxItems)
	{
		Debug.Debug.Log("SET_MAX_ITEMS - " + arguments);
		this.model.getCurrentView().maxVisibleItems = maxItems;
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
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
				this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
			}
			else
			{
				this.description._y = _loc3_;
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
				this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
			}
			else
			{
				this.description._y = _loc3_;
			}
		}
	}

	function getHelpY()
	{
		var _loc6_ = 0;
		var _loc3_ = this.model.getCurrentView();
		var _loc4_ = _loc3_.itemList.length;
		var _loc2_ = 25;
		var _loc5_ = _loc3_.rowSpacing;
		return _loc6_ + _loc4_ * (_loc2_ + _loc5_);
	}

	function REMOVE_SLOT()
	{
		this.model.removeDataSlot(0,arguments[0]);
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		if (this.scrollBase._visible)
		{
			this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
		}
		else
		{
			this.description._y = _loc3_;
		}
		if (this.columnIsFocused)
		{
			this.SetDescription();
		}
		else
		{
			this.description._visible = false;
			this.description.iMC.gotoAndStop(1);
		}
	}

	function SET_FOCUS()
	{
		super.SET_FOCUS.apply(this,arguments);
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		if (this.scrollBase._visible)
		{
			this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
		}
		else
		{
			this.description._y = _loc3_;
		}
		if (this.columnIsFocused)
		{
			this.SetDescription();
		}
		else
		{
			this.description._visible = false;
			this.description.iMC.gotoAndStop(1);
		}
	}

	function SET_HIGHLIGHT(i)
	{
		var _loc2_ = this.model.getCurrentView();
		_loc2_.index = i;
		if (this.scrollBase != undefined)
		{
			this.scrollBase.updateScroll();
		}
		var _loc3_ = this.getHelpY();
		this.scrollBase._y = _loc3_;
		if (this.scrollBase._visible)
		{
			this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
		}
		else
		{
			this.description._y = _loc3_;
		}
		this.SetDescription();
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
			this.description._y = this.scrollBase._y + this.scrollBase._height + 2;
		}
		else
		{
			this.description._y = _loc3_;
		}
		this.SetDescription();
	}

	function SetDescription()
	{
		var textBlips = new com.rockstargames.ui.utils.Text();
		if (this.blipLayer)
		{
			this.blipLayer.removeMovieClip();
		}
		this.description.descriptionMC.descText.wordWrap = true;
		this.description.descriptionMC.descText.autoSize = true;
		this.blipLayer = this.description.descriptionMC.createEmptyMovieClip("blipLayer", 1000, {_x:this.description.descriptionMC.descText._x, _y:this.description.descriptionMC.descText._y});
		textBlips.setTextWithIcons("PauseMenu_Current_Description",this.blipLayer,this.description.descriptionMC.descText,0,13,2,false,true);
		if (com.rockstargames.ScaleformUI.utils.Functions.trim(this.description.descriptionMC.descText.text) != "" && this.description.descriptionMC.descText.text != "undefined")
		{
			this.description._visible = true;
			if (this.model.getCurrentView().itemList[this.model.getCurrentView().highlightedItem].blinkDesc)
			{
				if (this.description.iMC._currentframe == 1)
				{
					this.description.iMC.gotoAndPlay(2);
				}
			}
			else
			{
				this.description.iMC.gotoAndStop(1);
			}
			this.description.bgMC._height = this.description.descriptionMC.descText.textHeight + 12;
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.description.descriptionMC.descText,"$Font2");
		}
		else
		{
			this.description._visible = false;
			this.description.iMC.gotoAndStop(1);
		}
	}
}