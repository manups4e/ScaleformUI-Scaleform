class com.rockstargames.gtav.levelDesign.PAUSEMENU extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuContentBase
{
	var CONTENT;
	var clickRepeat;
	var currentPage;
	var mListener;
	var ref;
	var lastHoveredItem;
	var context;
	var errorImgMC;
	var contextMenu;
	var bFullMenuWarningScreen;
	var errorMsg;
	var blipLayer;
	var content;
	var columnWidth = 288;
	var canHeaderAdvance = true;
	var isLoggedSC = false;
	var mOn = true;
	var mClickOn = true;
	var mRollOverOn = true;
	var mScrollType = 0;
	var debugCol = false;
	var debugColIndex = 0;
	var isAsianLang = false;
	var secondClickCancel = true;
	var canHighlightAll = true;
	var footerScrollOverride = 99;
	var sendClickEventOnly = false;
	var MOUSE_EVT;
	var mouseEventTriggered;
	var menuData;
	function PAUSEMENU()
	{
		super();
		this.dbgID = "PAUSEMENU";
		_global.gfxExtensions = true;
	}
	function INITIALISE(mc)
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME = "ScaleformUIPause";
		super.INITIALISE(mc);
		this.dbgOn = Boolean(1);
		this.debug = Boolean(1);
		var _loc3_ = this.CONTENT.createEmptyMovieClip("clickRepeatMC", this.CONTENT.getNextHighestDepth());
		this.clickRepeat = new com.rockstargames.gtav.pauseMenu.pauseComponents.ClickRepeat(_loc3_);
		this.INIT_M_AUX();
	}
	function SET_MENU_LEVEL(_menuLevel)
	{
		this.menuLevel = _menuLevel;
	}
	function dbg(dbgStr)
	{
		if (this.dbgOn)
		{
			var _loc2_ = "  " + dbgStr;
			Debug.Debug.Log(_loc2_);
			if (this.localdebug)
			{
				trace(_loc2_);
			}
		}
	}

	function set debug(d)
	{
		this.debugCol = d;
	}
	function get debug()
	{
		return this.debugCol;
	}

	function LOCK_MOUSE_SUPPORT(_mClickOn, _mRollOverOn)
	{
		if (_mClickOn != undefined)
		{
			this.mClickOn = _mClickOn;
		}
		if (_mRollOverOn != undefined)
		{
			this.mRollOverOn = _mRollOverOn;
		}
	}

	// debug mouse to be tested
	function INIT_M_AUX()
	{
		if (this.mOn)
		{
			this.MOUSE_EVT = new com.rockstargames.ui.mouse.MOUSE_EVENTS();
			this.MOUSE_EVT.INTERFACE_TYPE = 10;
			this.MOUSE_EVT.UI_MOVIE = 4;
			if (this.mListener)
			{
				Mouse.removeListener(this.mListener);
				this.mListener = null;
			}
			this.mListener = new Object();
			this.mListener.ref = this;
			this.mListener.onMouseWheel = function(delta, target)
			{
				this.ref.DELTA_MOUSE_WHEEL(delta);
			};
			this.mListener.onMouseUp = function()
			{
				this.ref.clickRepeat.repeatStop();
			};
			Mouse.addListener(this.mListener);
		}
	}
	function DELTA_MOUSE_WHEEL(delta)
	{
		var _loc5_ = this.menuLevel - 1;
		var _loc2_ = this.GET_COLUMN(_loc5_);
		if (!_loc2_)
		{
			return undefined;
		}
		var _loc4_ = _loc2_.columnIsFocused;
		if (_loc4_ && _loc2_.canWheelScroll)
		{
			switch (this.mScrollType)
			{
				case 0 :
					this.MENU_INTERACTION(delta <= 0 ? com.rockstargames.ui.game.GamePadConstants.DPADDOWN : com.rockstargames.ui.game.GamePadConstants.DPADUP,false);
					com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
					break;
				case 1 :
					var _loc3_ = this.GET_COLUMN(this.mScrollType);
					_loc3_.SET_INPUT_EVENT.apply(_loc3_,[delta <= 0 ? 9 : 8]);
			}
		}
		var col = this.GET_COLUMN(this.menuLevel - 1);
		var _loc4_ = [delta <= 0 ? 11 : 10, "FREAKING MOUSE EVENT", this.mScrollType, col.model.getCurrentView().index];
		this.MOUSE_EVT.triggerEvent(_loc4_);
		if (this.inContext)
		{
			this.MENU_INTERACTION(delta <= 0 ? com.rockstargames.ui.game.GamePadConstants.DPADDOWN : com.rockstargames.ui.game.GamePadConstants.DPADUP,false);
			com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET");
		}
	}
	function MOUSE_COLUMN_SHIFT(_mScrollType)
	{
		this.mScrollType = _mScrollType;
	}

	function RESET_MOUSE_EVENT()
	{
		this.menuData = [];
	}

	function GET_MOUSE_EVENT()
	{
		if (this.menuData.length > 0)
		{
			return String(this.menuData);
		}
		else
		{
			return "";
		}
	}

	function PRESS_SHIFT_DEPTH(dir)
	{
		Debug.Debug.Log("PRESS_SHIFT_DEPTH " + dir + " : mClickOn: " + this.mClickOn);
		if (!this.mOn)
		{
			return undefined;
		}
		if (!this.mClickOn)
		{
			return undefined;
		}
		if (dir == 1)
		{
			if (this.inTopMenu)
			{
				this.MENU_SHIFT_DEPTH(1,false,false);
			}
		}
	}
	function M_OVER_EVENT(index, colID, pmb)
	{
		if (this.lastHoveredItem != undefined && this.lastHoveredItem.onMouseMove != undefined)
		{
			delete this.lastHoveredItem.onMouseMove;
		}
		this.lastHoveredItem = pmb;
		this.lastHoveredItem.onMouseMove = com.rockstargames.ui.utils.DelegateStar.create(this.lastHoveredItem, this.lastHoveredItem.mOver);
		this.FILTER_M_EVENT(index,colID,0,false,pmb);
		var _loc4_ = [9, "FREAKING MOUSE EVENT", colID, this.GET_COLUMN(colID).model.getCurrentView().itemList[index].index];
		this.MOUSE_EVT.triggerEvent(_loc4_);
	}
	function M_OUT_EVENT(index, colID)
	{
		if (this.lastHoveredItem != undefined && this.lastHoveredItem.onMouseMove != undefined)
		{
			delete this.lastHoveredItem.onMouseMove;
		}
		this.FILTER_M_EVENT(index,colID,-1,false);
		var _loc4_ = [8, "FREAKING MOUSE EVENT", colID, this.GET_COLUMN(colID).model.getCurrentView().itemList[index].index];
		this.MOUSE_EVT.triggerEvent(_loc4_);
	}
	function M_PRESS_EVENT(index, colID, advance, bIgnoreStateChange)
	{
		this.FILTER_M_EVENT(index,colID,1,advance,undefined,bIgnoreStateChange);
	}
	function FILTER_M_EVENT(index, colID, action, advance, pmb, bIgnoreStateChange)
	{
		if (!this.mOn)
		{
			return undefined;
		}
		if (!this.inTopMenu)
		{
			var _loc7_ = this.menuLevel - 1;
			var _loc5_ = this.GET_COLUMN(_loc7_);
			if (this.canHighlightAll)
			{
				_loc5_ = this.GET_COLUMN(colID);
			}
			if (this.inContext)
			{
				_loc5_ = this.context;
			}
			if (!_loc5_)
			{
				return undefined;
			}
			var _loc9_ = _loc5_.columnIsFocused;
			var _loc10_ = _loc5_.canMouseNav;
			this.dbg("---->FILTER_M_EVENT <---- action: " + action);
			this.dbg("Column ID: " + colID + " == Menu Level: " + _loc7_);
			this.dbg(" ");
			if (this.secondClickCancel)
			{
				if (_loc10_ && action == 1)
				{
					var _loc6_ = colID - _loc7_;
					this.dbg("diff : " + _loc6_);
					this.dbg("************************ MENU STATE " + this.menuState);
					this.dbg("sendClickEventOnly " + this.sendClickEventOnly);
					if (_loc6_ == -1)
					{
						if (!this.sendClickEventOnly)
						{
							this.restartInteractState();
							this.MENU_SHIFT_DEPTH(-1,false,false);
							this.restartInteractState();
							this.MENU_INTERACTION(com.rockstargames.ui.game.GamePadConstants.DPADUP,true,index);
						}
						this.CLICK_PAUSE_MENU_ITEM(index,colID);
						com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"BACK","HUD_FRONTEND_DEFAULT_SOUNDSET");
						return undefined;
					}
					if (_loc6_ == 1)
					{
						if (!this.sendClickEventOnly)
						{
							this.restartInteractState();
							this.MENU_SHIFT_DEPTH(1,false,false);
							this.restartInteractState();
							this.MENU_INTERACTION(com.rockstargames.ui.game.GamePadConstants.DPADUP,true,index);
						}
						this.CLICK_PAUSE_MENU_ITEM(index,colID);
						return undefined;
					}
					if (_loc6_ != 0 && Math.abs(_loc6_) > 1)
					{
						this.dbg("column to column click over a greater span");
						this.CLICK_PAUSE_MENU_ITEM(index,colID);
						return undefined;
					}
					this.dbg("colID " + colID);
					if (this.inContext && colID != 99)
					{
						this.dbg("Close submenu");
						this.inContext = false;
						this.restartInteractState();
						this.MENU_INTERACTION(com.rockstargames.ui.game.GamePadConstants.DPADUP,true,index);
						return undefined;
					}
				}
			}
			var _loc8_ = _loc9_ && colID == _loc7_ && !this.inContext || this.inContext && colID == 99;
			if (this.canHighlightAll)
			{
				_loc8_ = !this.inContext || this.inContext && colID == 99;
			}
			this.dbg("menuLevel? : " + this.menuLevel);
			this.dbg("colID? : " + colID);
			this.dbg("colFocused? : " + _loc9_);
			this.dbg("progress? : " + _loc8_);
			if (_loc8_)
			{
				switch (action)
				{
					case -1 :
						if (!this.mRollOverOn)
						{
							return undefined;
						}
						this.MENU_ROLLOVER_HIGHLIGHT(_loc5_,false,index);
						break;
					case 0 :
						if (!this.mRollOverOn)
						{
							return undefined;
						}
						if (pmb != null && pmb != undefined)
						{
							this.MENU_ROLLOVER_HIGHLIGHT(_loc5_,false,index);
							pmb.mouseOver(true);
						}
						break;
					case 1 :
						this.dbg("Menu Action is 1 so i'm going to check these");
						this.dbg("this.mClickOn: " + this.mClickOn);
						this.dbg("this.isTopMenu: " + this.isTopMenu);
						this.dbg("advance: " + advance);
						if (!this.mClickOn)
						{
							return undefined;
						}
						this.CLICK_PAUSE_MENU_ITEM(index,colID);
						break;
				}
			}
		}
	}

	function CLICK_PAUSE_MENU_ITEM(index, colID)
	{
		com.rockstargames.ui.utils.Debug.log("---->CLICK_PAUSE_MENU_ITEM <----");
		var _loc4_ = this.GET_COLUMN(colID);
		var _loc3_ = _loc4_.model.getCurrentView().itemList[index];
		com.rockstargames.ui.utils.Debug.log(" CLICK_PAUSE_MENU_ITEM ------------------------- args: " + arguments);
		com.rockstargames.ui.utils.Debug.log(" pmb -------------------------  " + _loc3_);
		if (_loc3_)
		{
			if (_loc3_.menuID != undefined && _loc3_.uniqueID != undefined)
			{
				com.rockstargames.ui.utils.Debug.log(" ------------------------- pmb.menuID: " + _loc3_.menuID);
				com.rockstargames.ui.utils.Debug.log(" ------------------------- pmb.uniqueID: " + _loc3_.uniqueID);
				com.rockstargames.ui.game.GameInterface.call("CLICK_PAUSE_MENU_ITEM",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,index,_loc3_.menuID,_loc3_.uniqueID);
				var _loc4_ = [5, "FREAKING MOUSE EVENT", colID, _loc3_.index];
				this.MOUSE_EVT.triggerEvent(_loc4_);
			}
		}
	}
	function CLICK_SCROLL_COLUMN_ARROW(scrollDirEnum, colID)
	{
		com.rockstargames.ui.utils.Debug.log(" ");
		com.rockstargames.ui.utils.Debug.log(" CLICK_SCROLL_COLUMN_ARROW ------------------------- args: " + arguments);
		var _loc3_ = this.menuLevel - 1;
		com.rockstargames.ui.utils.Debug.log(" colLevel " + _loc3_ + " = colID: " + colID);
		if (_loc3_ == colID || colID == this.footerScrollOverride)
		{
			com.rockstargames.ui.game.GameInterface.call("HANDLE_SCROLL_CLICK",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,scrollDirEnum,colID);
		}
		var _loc4_ = [5, "FREAKING MOUSE EVENT", 1000 + colID, scrollDirEnum];
		this.MOUSE_EVT.triggerEvent(_loc4_);
		this.menuData = [5, colID + 1000, scrollDirEnum];
	}
	function CLEAR_ALL_HOVER()
	{
		var _loc4_ = this.currentPage.columnList.length;
		if (_loc4_ != undefined && _loc4_ > 0)
		{
			var _loc2_ = 0;
			while (_loc2_ < _loc4_)
			{
				var _loc3_ = this.GET_COLUMN(_loc2_);
				this.MENU_ROLLOVER_HIGHLIGHT(_loc3_,false,-1);
				_loc2_ = _loc2_ + 1;
			}
		}
		com.rockstargames.ui.game.GameInterface.call("HOVER_PAUSE_MENU_ITEM",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,-1,-1,-1);
	}

	/////////////////////////////////////////////////////////////////////////////////

	function GET_HOVERED_COLUMN()
	{
		return this.mScrollType;
	}

	function CALL_CUSTOM_COLUMN_FUNCTION()
	{
		var _loc5_ = arguments[0];
		var _loc4_ = arguments[1];
		var _loc3_ = this.GET_COLUMN(_loc5_);
		this.dbg("CALL_CUSTOM_COLUMN_FUNCTION columnMC: " + _loc3_ + " | function: " + _loc4_ + " | args: " + arguments.slice(2));
		if (_loc3_ != undefined)
		{
			_loc3_[_loc4_].apply(_loc3_,arguments.slice(2));
		}
	}


	function SET_COLUMN_INPUT_EVENT()
	{
		var _loc5_ = arguments[0];
		var _loc4_ = arguments[1];
		var _loc3_ = this.GET_COLUMN(_loc5_);
		this.dbg("SET_COLUMN_INPUT_EVENT columnMC: " + _loc3_ + " | inputID: " + _loc4_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_INPUT_EVENT.apply(_loc3_,arguments.slice(1));
		}
	}
	function GET_COLUMN_SELECTION()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("GET_COLUMN_SELECTION columnMC: " + _loc3_ + " | selection: " + _loc3_.model.getCurrentSelection());
		if (_loc3_ != undefined)
		{
			return _loc3_.model.getCurrentSelection();
		}
	}
	function SET_COLUMN_TITLE()
	{
		var _loc4_ = arguments[0];
		var _loc5_ = arguments[1];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_COLUMN_TITLE columnMC: " + _loc3_ + " | columnTitle params: " + arguments);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_TITLE.apply(_loc3_,arguments.slice(1));
		}
	}
	function SET_DESCRIPTION()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_DESCRIPTION columnIndex: " + _loc4_ + " | description params: " + arguments);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_DESCRIPTION.apply(_loc3_,arguments.slice(1));
		}
	}

	function SET_COLUMN_FOCUS()
	{
		var _loc10_ = arguments[0];
		var _loc4_ = true;
		var _loc12_ = false;
		var _loc8_ = true;
		if (arguments[1] != undefined)
		{
			_loc4_ = arguments[1];
		}
		if (arguments[2] != undefined)
		{
			_loc12_ = arguments[2];
		}
		if (arguments[3] != undefined)
		{
			_loc8_ = arguments[3];
		}
		this.dbg("columnIndex " + _loc10_);
		this.dbg("highlighted " + _loc4_);
		this.dbg("moveFocus " + _loc12_);
		this.dbg("prevHightlight " + _loc8_);
		var _loc5_ = this.GET_COLUMN(_loc10_);
		if (_loc5_ != undefined)
		{
			_loc5_.SET_FOCUS.apply(_loc5_,[_loc4_]);
			if (_loc12_)
			{
				var _loc9_ = this.menuState;
				var _loc14_ = this.menuLevel;
				var _loc15_ = _loc10_ + 1;
				if (!_loc8_)
				{
					this.MENU_SET_FOCUS(false);
				}
				this.menuLevel = _loc15_;
				this.MENU_SET_FOCUS(_loc4_);
				var _loc6_ = -1;
				_loc5_ = this.GET_COLUMN(this.menuLevel - 1);
				this.MENU_CHANGE_STATE(_loc5_);
				if (_loc5_ != undefined)
				{
					var _loc3_ = this.getSelectedMenuItem(_loc5_);
					_loc6_ = _loc3_.uniqueID;
				}
				this.dbg("----------------------------------- ");
				this.dbg("oldMenuState " + _loc9_);
				this.dbg("oldMenuLevel " + _loc14_);
				this.dbg("targetLevel " + _loc15_);
				this.dbg("uniqueID " + _loc6_);
				this.dbg("----------------------------------- ");
				if (_loc6_ != undefined)
				{
					this.menuUniqueID = _loc6_;
					var _loc7_ = this.menuLevel - _loc14_;
					this.dbg("DIRECTION AFTER SET COLUMN FOCUS " + _loc7_);
					if (_loc7_ > 0)
					{
						var _loc11_ = this.getSelectedMenuItem(this.GET_COLUMN(this.menuLevel));
						var _loc13_ = -1;
						if (_loc11_.menuID != undefined || _loc11_.menuID != null)
						{
							_loc13_ = _loc11_.menuID;
						}
						_loc3_ = this.getSelectedMenuItem(_loc5_);
						if (_loc3_ != undefined)
						{
							com.rockstargames.ui.game.GameInterface.call("TRIGGER_PAUSE_MENU_EVENT",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,_loc3_.menuID,_loc3_.uniqueID,_loc13_);
							this.dbg("TRIGGER_PAUSE_MENU_EVENT | currMenuItem.menuID: " + _loc3_.menuID + " | currMenuItem.uniqueID: " + _loc3_.uniqueID + " nextMenuID: " + _loc13_);
						}
					}
					else
					{
						com.rockstargames.ui.game.GameInterface.call("LAYOUT_CHANGED",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,_loc9_,this.menuState,this.menuUniqueID,_loc7_);
						this.dbg("---->LAYOUT_CHANGED oldMenuState: " + _loc9_ + " | menuState: " + this.menuState + " | menuUniqueID: " + this.menuUniqueID + " | dir: " + _loc7_);
					}
					com.rockstargames.ui.game.GameInterface.call("IS_NAVIGATING_CONTENT",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,true);
				}
				this.menuLevelOld = this.menuLevel;
			}
		}
	}

	function SET_COLUMN_STATE()
	{
		this.dbg("SET_COLUMN_STATE -----> " + arguments);
		var _loc3_ = this.GET_COLUMN(arguments[0]);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_STATE.apply(_loc3_,arguments.slice(1));
		}
	}

	function SET_COLUMN_HIGHLIGHT()
	{
		var _loc7_ = arguments[0];
		var _loc6_ = arguments[1];
		var _loc9_ = false;
		var _loc4_ = false;
		if (arguments[3] != undefined)
		{
			_loc4_ = arguments[3];
		}
		var _loc5_ = false;
		if (arguments[4] != undefined)
		{
			_loc5_ = arguments[4];
		}
		var _loc3_ = this.GET_COLUMN(_loc7_);
		this.dbg("SET_COLUMN_HIGHLIGHT -----> " + arguments);
		this.dbg("SET_COLUMN_HIGHLIGHT columnIndex: " + _loc7_);
		this.dbg("SET_COLUMN_HIGHLIGHT highlightIndex: " + _loc6_);
		this.dbg("SET_COLUMN_HIGHLIGHT scriptSetUnqID " + _loc4_);
		this.dbg("SET_COLUMN_HIGHLIGHT scriptSetMenuState " + _loc5_);
		this.dbg("SET_COLUMN_HIGHLIGHT -----> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_HIGHLIGHT.apply(_loc3_,[_loc6_]);
			_loc3_.SEND_COLUMN_PARAMS();
			var _loc8_ = this.getSelectedMenuItem(_loc3_);
			if (_loc4_ == true)
			{
				this.menuUniqueID = _loc8_.uniqueID;
				this.dbg("*****************");
				this.dbg("menuUniqueID set to " + this.menuUniqueID);
				this.dbg("*****************");
			}
			if (_loc5_ == true)
			{
				this.menuState = _loc8_.menuID;
				this.dbg("*****************");
				this.dbg("menuState set to " + this.menuUniqueID);
				this.dbg("*****************");
			}
		}
	}
	function REBUILD_COLUMN()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("INIT_COLUMN_SCROLL ____> arguments: " + arguments);
		if (_loc3_ != undefined)
		{
			_loc3_.REFRESH.apply(_loc3_,arguments.slice(1));
		}
	}
	function SET_COLUMN_MAX_ITEMS()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_COLUMN_MAX_ITEMS ____> arguments: " + arguments);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_MAX_ITEMS.apply(_loc3_,arguments.slice(1));
		}
	}
	function INIT_COLUMN_SCROLL()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("INIT_COLUMN_SCROLL ____> arguments: " + arguments);
		if (_loc3_ != undefined)
		{
			_loc3_.INIT_SCROLL_BAR.apply(_loc3_,arguments.slice(1));
		}
	}
	function SET_COLUMN_SCROLL()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_COLUMN_SCROLL ____> arguments: " + arguments);
		this.dbg("SET_COLUMN_SCROLL ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_SCROLL_BAR.apply(_loc3_,arguments.slice(1));
		}
	}
	function SET_COLUMN_CAN_JUMP()
	{
		var _loc5_ = arguments[0];
		var _loc4_ = arguments[1];
		var _loc3_ = this.GET_COLUMN(_loc5_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_COLUMN_CAN_JUMP.apply(_loc3_,[_loc4_]);
		}
	}
	function ALLOW_CLICK_FROM_COLUMN()
	{
		var _loc5_ = arguments[0];
		var _loc3_ = arguments[1];
		this.dbg("---->ALLOW_CLICK_FROM_COLUMN <---- " + arguments);
		if (_loc3_ != undefined)
		{
			if (_loc3_)
			{
				this.sendClickEventOnly = true;
			}
			else
			{
				this.sendClickEventOnly = false;
			}
		}
		var _loc4_ = this.GET_COLUMN(_loc5_);
		if (_loc4_ != undefined)
		{
			_loc4_.canMouseNav = _loc3_;
		}
	}
	function SET_CONTROL_LABELS()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_CONTROL_LABELS.apply(_loc3_,arguments);
		}
	}
	function SET_CONTROL_IMAGE()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_CONTROL_IMAGE.apply(_loc3_,arguments);
		}
	}
	function SET_VIDEO_MEMORY_BAR()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_VIDEO_MEMORY_BAR.apply(_loc3_,arguments);
		}
	}
	function SET_VIDEO_MEMORY_BAR_2()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_VIDEO_MEMORY_BAR_2.apply(_loc3_,arguments);
		}
	}
	function SET_TIP_TEXT()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_TIP_TEXT.apply(_loc3_,arguments);
		}
	}
	function SET_DISPLAY_MICS()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.DISPLAY_MIC.apply(_loc3_,arguments);
		}
	}
	function SET_PLAYERLIST_ICON()
	{
		var _loc3_ = this.GET_COLUMN(1);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_ICON.apply(_loc3_,arguments);
		}
	}
	function SET_DATA_SLOT()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_DATA_SLOT - " + arguments);
		this.dbg("SET_DATA_SLOT ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_DATA_SLOT.apply(_loc3_,arguments.slice(1));
		}
	}
	function SET_DATA_SLOT_SPLICE()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_DATA_SLOT_SPLICE - " + arguments);
		this.dbg("SET_DATA_SLOT_SPLICE ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_DATA_SLOT_SPLICE.apply(_loc3_,arguments.slice(1));
		}
	}

	function UPDATE_SLOT()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("UPDATE_SLOT - " + arguments);
		this.dbg("UPDATE_SLOT ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.UPDATE_SLOT.apply(_loc3_,arguments.slice(1));
		}
	}
	function ADD_SLOT()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("ADD_SLOT - " + arguments);
		this.dbg("ADD_SLOT ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.ADD_SLOT.apply(_loc3_,arguments.slice(1));
		}
	}
	function REMOVE_SLOT()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("REMOVE_SLOT - " + arguments);
		this.dbg("REMOVE_SLOT ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.REMOVE_SLOT.apply(_loc3_,arguments.slice(1));
		}
	}
	
	function DISPLAY_DATA_SLOT()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("DISPLAY_DATA_SLOT : " + arguments);
		this.dbg("DISPLAY_DATA_SLOT ____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.DISPLAY_VIEW.apply(_loc3_,[0]);
		}
		if (!this.isReadyToRender)
		{
			com.rockstargames.ui.game.GameInterface.call("PAUSE_MENU_READY_TO_RENDER",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE);
			this.isReadyToRender = true;
		}
	}
	function SET_DATA_SLOT_EMPTY()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SET_DATA_SLOT_EMPTY " + arguments);
		this.dbg("SET_DATA_SLOT_EMPTY _____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.SET_DATA_SLOT_EMPTY.apply(_loc3_,[0]);
		}
	}

	function MENU_STATE(id)
	{
		var _loc3_ = this.menuState;
		this.dbg("--- DYNAMIC EXTERNAL LOAD FROM **NOT XML** --- menuLevel: " + this.menuLevel);
		this.storedMenuState = id;
		var _loc4_ = true;
		if (this.menuLevel == 0)
		{
			this.menuState = this.menuList[this.menuIndex];
			this.MENU_STATE_LOAD(_loc3_);
			_loc4_ = false;
		}
		if (_loc4_)
		{
			this.currentPage.stateChanged(this.storedMenuState);
			this.MENU_STATE_LOAD(_loc3_);
		}
	}

	function SHOW_COLUMN()
	{
		var _loc4_ = arguments[0];
		var _loc3_ = this.GET_COLUMN(_loc4_);
		this.dbg("SHOW_COLUMN " + arguments);
		this.dbg("SHOW_COLUMN _____> columnMC: " + _loc3_);
		if (_loc3_ != undefined)
		{
			_loc3_.SHOW_COLUMN.apply(_loc3_,arguments.slice(1));
		}
	}
	function SHOW_AND_CLEAR_COLUMNS()
	{
		var _loc6_ = arguments.length;
		if (_loc6_ % 2 != 0)
		{
			this.dbg("AN IMPROPER NUMBER OF ARGUMENTS WAS PASSED INTO SHOW_AND_CLEAR_COLUMNS");
			return undefined;
		}
		var _loc3_ = 0;
		while (_loc3_ < _loc6_)
		{
			var _loc4_ = arguments[_loc3_];
			var _loc5_ = arguments[_loc3_ + 1];
			this.SET_DATA_SLOT_EMPTY(_loc4_);
			this.SHOW_COLUMN(_loc4_,_loc5_);
			_loc3_ += 2;
		}
	}
	function LOAD_CHILD_PAGE(gfxFilePath, _menustate, inceptDir)
	{
		this.dbg("LOAD_CHILD_PAGE: " + arguments);
		this.KILL_PAGE();
		this.menuLevel = 0;
		if (inceptDir > 0)
		{
			this.menuceptionDepth += inceptDir;
		}
		this.storedMenuState = _menustate;
		this.LOAD_PAGE(gfxFilePath);
	}

	function LOAD_PAGE(gfxFilePath)
	{
		this.dbg("--------------LOAD_PAGE--------> " + gfxFilePath);
		var thisObj = this;
		this.pageLoaderObject = new Object();
		// Create container movie clip
		this.pageLoaderObject._path = gfxFilePath;
		this.pageLoaderObject._mc = this.content.createEmptyMovieClip("pageContainerMC", this.content.getNextHighestDepth());
		// Initialize listener
		this.pageLoaderObject._listener = new Object();
		this.pageLoaderObject._listener.thisObj = thisObj;
		this.pageLoaderObject._listener.onLoadError = function(errorCode)
		{
			Debug.Debug.Error("Error attaching movie clip: " + errorCode);
		};
		// Attach movie clip from library
		var success = this.pageLoaderObject._mc.attachMovie(gfxFilePath, "TIMELINE", this.pageLoaderObject._mc.getNextHighestDepth(), this.pageLoaderObject._listener);
		if (!success)
		{
			Debug.Debug.Error("Failed to attach movie clip: " + gfxFilePath);
		}
		else
		{
			success.INITIALISE(this.pageLoaderObject._mc.TIMELINE);
			this.LOADED_PAGE();
		}
	}
	function KILL_PAGE()
	{
		this.dbg("KILL_PAGE " + this.currentPage);
		this.dbg("pageLoaderObject._mc " + this.pageLoaderObject._mc);
		this.SHOW_WARNING_MESSAGE(false);
		if (this.errorImgMC.isLoaded)
		{
			this.errorImgMC.removeTxdRef();
		}
		this.SHOW_CONTEXT_MENU(false);
		if (this.pageLoaderObject._mc != undefined)
		{
			this.currentPage.onPageExit();
			this.pageLoaderObject._mc.removeMovieClip();
		}
		this.pageLoaderObject = null;
		this.currentPage = null;
	}
	function LOADED_PAGE()
	{
		super.LOADED_PAGE();
		this.PAGE_FADE_IN();
	}
	function PAGE_FADE_IN()
	{
		this.errorMsg._alpha = this.content._alpha = this.context._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.errorMsg,0.3,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.content,0.3,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.context,0.3,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
	}

	function MENU_STATE_LOAD(oldMenuState)
	{
		this.dbg("------->MENU_STATE_LOAD with, menuState: " + this.menuState + " oldMenuState: " + oldMenuState);
		var _loc3_ = 1;
		this.dbg("******** CALL -- LAYOUT_CHANGED with oldMenuState: " + oldMenuState + " menuState: " + this.menuState + " menuUniqueID: " + this.menuUniqueID + " dir");
		if (this.menuUniqueID == undefined)
		{
			this.menuUniqueID = -1;
			this.dbg("********  menuUniqueID was undefined so chnaged to " + this.menuUniqueID);
		}
		com.rockstargames.ui.game.GameInterface.call("LAYOUT_CHANGED",com.rockstargames.ui.game.GameInterface.PAUSE_TYPE,oldMenuState,this.menuState,this.menuUniqueID,_loc3_);
	}
	function SET_CONTENT_SCALED(isScaled, tlx, tly, brx, bry)
	{
		this.currentPage.setScaledContent(true,tlx,tly,brx,bry);
	}
	function SET_DISPLAY_CONFIG(_screenWidthPixels, _screenHeightPixels, _safeTopPercent, _safeBottomPercent, _safeLeftPercent, _safeRightPercent, _isWideScreen)
	{
		this.currentPage.setDisplayConfig(_screenWidthPixels,_screenHeightPixels,_safeTopPercent,_safeBottomPercent,_safeLeftPercent,_safeRightPercent,_isWideScreen);
	}
	function SET_INPUT_EVENT(inputID)
	{
		if (this.inTopMenu)
		{
			return undefined;
		}
		this.dbg("inputID " + inputID);
		switch (inputID)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				this.MENU_INTERACTION(inputID);
		}
	}
	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		Debug.Debug.Log("ADD_TXD_REF_RESPONSE - " + arguments);
		if (success == true)
		{
			var pMC = this.CONTENT.contentMC.pageContainerMC.TIMELINE;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd);
			}
		}
	}

	function TXD_HAS_LOADED(txd, success, strRef)
	{
		Debug.Debug.Log("TXD_HAS_LOADED - " + arguments);
		if (success == true)
		{
			var pMC = this.CONTENT.contentMC.pageContainerMC.TIMELINE;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd, strRef)
	{
		Debug.Debug.Log("TXD_ALREADY_LOADED - " + arguments);
		var pMC = this.CONTENT.contentMC.pageContainerMC.TIMELINE;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(((pMC + ".") + strRef)));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}
}