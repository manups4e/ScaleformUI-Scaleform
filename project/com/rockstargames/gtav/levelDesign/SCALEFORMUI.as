class com.rockstargames.gtav.levelDesign.SCALEFORMUI extends com.rockstargames.ui.core.BaseScreenLayout
{
	var menuContainer;
	var UIMenu;
	var TimerBarPool;
	var DispConf;
	var offset = [];
	var iActualWidth;
	static var MouseEnabled = true;
	static var IS_FADING = false;

	function SCALEFORMUI()
	{
		super();
		_global.gfxExtensions = true;
		this.getDisplayConfig(true);
	}

	function INITIALISE(mc)
	{
		super.INITIALISE(mc);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME = "ScaleformUI";
		this.menuContainer = this.CONTENT.createEmptyMovieClip("menuContainer", this.CONTENT.getNextHighestDepth());
		this.UIMenu = this.menuContainer.attachMovie("uimenu", "uimenu", this.menuContainer.getNextHighestDepth());
		this.UIMenu._visible = false;
		this.initScreenLayout();
		var signature = "Made by MANUPS4E";
		var signatureSub = "For the FiveM community. With Love 💓";
	}

	function SET_DISPLAY_CONFIG(_screenWidthPixels, _screenHeightPixels, _safeTopPercent, _safeBottomPercent, _safeLeftPercent, _safeRightPercent, _isWideScreen, _isHiDef, _isAsian, realWidth, realHeight)
	{
		this.isWideScreen = _isWideScreen;
		if (this.isWideScreen)
		{
			this.screenWidthPixels = 1280;
			this.screenHeightPixels = 720;
		}
		else
		{
			this.screenWidthPixels = 960;
			this.screenHeightPixels = 720;
		}
		this.isHiDef = _isHiDef;
		this.safeLeft = this.FOUR_THREE_PADDING + Math.round(_screenWidthPixels * _safeLeftPercent);
		this.safeRight = this.FOUR_THREE_PADDING + Math.round(_screenWidthPixels * _safeRightPercent);
		this.safeTop = Math.round(_screenHeightPixels * _safeTopPercent);
		this.safeBottom = Math.round(_screenHeightPixels * _safeBottomPercent);
		if (!this.isWideScreen)
		{
			Stage.scaleMode = "noBorder";
		}
		this.initScreenLayout();
	}

	function initScreenLayout()
	{
		//if (this.menuContainer != undefined)
		//{
		//this.menuContainer._x = this.safeLeft;
		//this.menuContainer._y = this.safeTop;
		//}
		this.UIMenu.UpdatePositions(this.safeLeft,this.safeTop,this.safeRight);
	}

	function SET_MENU_DATA()
	{
		this.UIMenu.data = arguments;
		if (!this.UIMenu._visible)
		{
			this.UIMenu._visible = true;
		}
	}

	function SET_DATA_SLOT(slotIndex)
	{
		this.UIMenu.AddItem(0,slotIndex,arguments);
	}

	function SET_DATA_SLOT_SPLICE(slotIndex)
	{
		this.UIMenu.AddItemSplice(0,slotIndex,arguments);
	}

	function ADD_SLOT(slotIndex)
	{
		this.UIMenu.AddSlot(0,slotIndex,arguments);
	}

	function UPDATE_DATA_SLOT(slotIndex)
	{
		this.UIMenu.UpdateItem(0,slotIndex,arguments);
	}

	function SET_DATA_SLOT_EMPTY(viewIndex)
	{
		this.UIMenu.clearItems();
	}

	function REMOVE_DATA_SLOT(slotIndex)
	{
		this.UIMenu.RemoveItem(slotIndex);
	}

	function SET_PANEL_DATA_SLOT(slotIndex, panIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.AddPanel(slotIndex,_loc3_);
	}

	function UPDATE_PANEL_DATA_SLOT(slotIndex, panIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.UpdatePanel(slotIndex,_loc3_);
	}

	function SET_PANEL_DATA_SLOT_EMPTY()
	{
		this.UIMenu.clearPanels();
	}

	function SET_SIDE_PANEL_DATA_SLOT(slotIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.AddSidePanel(slotIndex,_loc3_);
	}

	function UPDATE_SIDE_PANEL_DATA_SLOT(slotIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.UpdateSidePanel(slotIndex,_loc3_);
	}

	function SET_SIDE_PANEL_SLOT(slotIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.SetSidePanelSlot(slotIndex,_loc3_);
	}

	function SET_SIDE_PANEL_DATA_SLOT_EMPTY()
	{
		this.UIMenu.clearSidePanel();
	}

	function SHOW_SIDE_PANEL()
	{
		this.UIMenu.ShowSidePanel();
	}

	function GET_PICKER_COLOR(colorId)
	{
		var retVal = new Array();
		var color = com.rockstargames.ScaleformUI.utils.ColorPanelColors.GetVehColorById(colorId);
		retVal.push(color.r);
		retVal.push(color.g);
		retVal.push(color.b);
		return retVal.toString();
	}

	function SELECT_PANEL(item, colorID)
	{
		var retVal = new Array();
		if (this.UIMenu.model.getCurrentView().panelItemList.length > 0)
		{
			for (var i = 0; i < this.UIMenu.model.getCurrentView().panelItemList.length; i++)
			{
				var _panel = this.UIMenu.model.getCurrentView().panelItemList[i];
				if (_panel instanceof com.rockstargames.ScaleformUI.panels.UIMenuColorPickerPanel)
				{
					return i;
				}
				else
				{
					if (_panel._hovered)
					{
						if (_panel instanceof com.rockstargames.ScaleformUI.panels.UIMenuColorPanel)
						{
							retVal.push(i);
							retVal.push(_panel.Value);
							com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
							return retVal.toString();
						}
					}
				}
			}
		}
	}

	function SELECT_ITEM(item)
	{
		var _item = this.UIMenu.CurrentItem;
		var ret = _item.Select();
		if (_item._type != 3 && _item._type != 4)
		{
			com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
		}
		return ret;
	}

	function SET_INPUT_MOUSE_EVENT_CONTINUE()
	{
		var retVal = new Array();
		if (this.UIMenu.model.getCurrentView().panelItemList.length > 0)
		{
			for (var i = 0; i < this.UIMenu.model.getCurrentView().panelItemList.length; i++)
			{
				var _panel = this.UIMenu.model.getCurrentView().panelItemList[i];
				if (_panel._hovered)
				{
					_panel.SetCoords();
					retVal.push(i);
					retVal.push(_panel.Value);
					return retVal.toString();
				}
			}
		}
	}

	function SET_VISIBLE(bool, index)
	{
		this.UIMenu._visible = bool;
		if (bool)
		{
			this.UIMenu.Show(index);
			this.UIMenu.UpdatePositions(this.safeLeft,this.safeTop,this.safeRight);
		}
	}

	function CLICK_SCROLL_COLUMN_ARROW(dir, col)
	{
		var _loc4_ = [5, this.UIMenu._name, -1, dir];
		this.UIMenu.MOUSE_EVT.triggerEvent(_loc4_);

	}

	function IS_MOUSE_ON_MENU()
	{
		if (this.menuContainer != undefined)
		{
			return this.menuContainer.hitTest(_root._xmouse, _root._ymouse);
		}
		return false;
	}

	function SET_CURRENT_SELECTION(id)
	{
		this.UIMenu.CurrentSelection = id;
	}

	function SHOW_PANELS()
	{
		this.UIMenu.ShowPanels();
	}

	function SET_INPUT_EVENT(direction)
	{
		return this.UIMenu.InputEvent(direction);
	}

	function GET_MENU_POSITION_AND_SIZE()
	{
		return String(new Array(this.UIMenu._x, this.UIMenu._y, this.UIMenu.BannerSprite.bannerBG.bannerSprite._width, this.UIMenu.BannerSprite.bannerBG.bannerSprite._height));
	}

	function SET_WINDOWS_SLOT_DATA(slotIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.AddWindow(slotIndex,_loc3_);
	}

	function SET_WINDOWS_SLOT_EXTRA_DATA(slotIndex, dataIndex)
	{
		var _loc3_ = arguments.slice(2);
		this.UIMenu.AddWindowExtra(slotIndex,dataIndex,_loc3_);
	}

	function UPDATE_WINDOWS_SLOT_DATA(slotIndex)
	{
		var _loc3_ = arguments.slice(1);
		this.UIMenu.UpdateWindow(slotIndex,_loc3_);
	}

	function SET_WINDOWS_SLOT_DATA_EMPTY()
	{
		this.UIMenu.clearWindows();
	}

	function SHOW_WINDOWS()
	{
		this.UIMenu.ShowWindows();
	}

	function REFRESH_MENU()
	{
		this.UIMenu.RefreshMenu(arguments);
	}

	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		if (success == true)
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd);
			}
		}
	}

	function TXD_HAS_LOADED(txd, success, strRef)
	{
		if (success == true)
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd, strRef)
	{
		var pMC = this.CONTENT;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}
}