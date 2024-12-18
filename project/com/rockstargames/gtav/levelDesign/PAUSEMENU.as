class com.rockstargames.gtav.levelDesign.PAUSEMENU extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var PauseMenu;
	static var MouseEnabled = true;
	function PAUSEMENU()
	{
		super();
		_global.gfxExtensions = true;
	}

	function INITIALISE(mc)
	{
		super.INITIALISE(mc);
		//this.getDisplayConfig(true);
		this.PauseMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT);
		this.CONTENT._alpha = 0;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME = "PauseMenu";
	}

	function ADD_TAB(type)
	{
		this.PauseMenu.AddTab(type);
	}

	function SET_FOCUS(foc)
	{
		this.PauseMenu.Focus = foc;
	}

	function UPDATE_BASE_TAB_BACKGROUND(txd, txn)
	{
		var curTab = this.PauseMenu.Tab;
		if (curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab)
		{
			curTab.updateBackground(txd,txn);
		}
	}

	function SET_BASE_TAB_RIGHT_PICTURE(txd, txn)
	{
		var curTab = this.PauseMenu.Tab;
		if ((curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab))
		{
			curTab.AddPicture(txd,txn);
		}
	}

	function UPDATE_LEFT_ITEM_RIGHT_BACKGROUND(item, txd, txn, resType)
	{
		var curTab = this.PauseMenu.Tab;
		if ((curTab instanceof com.rockstargames.PauseMenu.tabs.InfoTab))
		{
			var leftItem = curTab.LeftItemList[item];
			if (leftItem.itemType == 1 || leftItem.itemType == 2 || leftItem.itemType == 3)
			{
				leftItem.updateBackground(txd,txn,resType);
			}
		}
	}

	function SELECT_LEFT_ITEM_INDEX(item)
	{
		this.PauseMenu.currentTab.currentSelection = item;
	}

	function SELECT_RIGHT_ITEM_INDEX(item)
	{
		if (this.PauseMenu.currentTab.currentItem.itemType == 3)
		{
			if (this.PauseMenu.Focus == 2)
			{
				this.PauseMenu.currentTab.currentItem.currentSelection = item;
			}
		}
	}

	function ADD_LEFT_ITEM(type, str, enabled, param1, param2, param3, param4)
	{
		this.PauseMenu.AddLeftItem(type,str,enabled,param1,param2,param3,param4);
	}

	function ADD_RIGHT_TITLE(leftIndex, param1, param2, param3)
	{
		this.PauseMenu.AddRightTitle(leftIndex,param1,param2,param3);
	}

	function ADD_RIGHT_LIST_ITEM(leftIndex, type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		this.PauseMenu.AddRightItem(leftIndex,type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
	}

	function SET_RIGHT_SETTINGS_ITEM_VALUE(leftIndex, itemIndex, value)
	{
		this.PauseMenu.Tab.LeftItemList[leftIndex].ItemList[itemIndex].Value = value;
	}

	function UPDATE_COLORED_BAR_COLOR(leftIndex, itemIndex, hudColor)
	{
		this.PauseMenu.Tab.LeftItemList[leftIndex].ItemList[itemIndex].bar.updateColor(hudColor);
	}

	function UPDATE_RIGHT_ITEM_RIGHT_LABEL(leftIndex, itemIndex, label)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tab.LeftItemList[leftIndex].ItemList[itemIndex].itemTextRight,label);
	}

	function UPDATE_RIGHT_STATS_ITEM(leftIndex, itemIndex, label, rightLabel, hudColor)
	{
		this.PauseMenu.Tab.LeftItemList[leftIndex].ItemList[itemIndex].updateItem(label,rightLabel,hudColor);
	}

	function UPDATE_KEYMAP_ITEM(leftIndex, itemIndex, value1, value2)
	{
		this.PauseMenu.Tab.LeftItemList[leftIndex].ItemList[itemIndex].UpdateValues(value1,value2);
	}

	function UPDATE_LEFT_ITEM_LABELS(item, lbl, rtxt)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.PauseMenu.Tab.LeftItemList[item].leftTextTF,lbl,true,true);
		if (this.PauseMenu.Tab.LeftItemList[item]._type == 0)
		{
			this.PauseMenu.Tab.LeftItemList[item].SetRightText(rtxt);
		}
		this.PauseMenu.Tab.LeftItemList[item].refreshLabelFonts();
		this.PauseMenu.Tab.LeftItemList[item].updateLabelWidth();
	}

	function SET_LEFT_ITEM_LABEL_FONT(item, fName, fId)
	{
		this.PauseMenu.Tab.LeftItemList[item].leftItem.updateLabelFont(fName,fId);
	}
	function SET_LEFT_ITEM_RIGHT_LABEL_FONT(item, fName, fId)
	{
		this.PauseMenu.Tab.LeftItemList[item].updateRightLabelFont(fName,fId);
	}

	function UPDATE_LEFT_ITEM_LABEL(item, _label)
	{
		this.PauseMenu.Tab.LeftItemList[item].Label = _label;
	}

	function UPDATE_LEFT_ITEM_LABEL_RIGHT(item, _label)
	{
		this.PauseMenu.Tab.LeftItemList[item].SetRightText(_label);
	}

	function SET_LEFT_ITEM_LEFT_BADGE(item, badge)
	{
		this.PauseMenu.Tab.LeftItemList[item].SetLeftBadge(badge);
	}

	function SET_LEFT_ITEM_CUSTOM_LEFT_BADGE(item, txd, txn)
	{
		this.PauseMenu.Tab.LeftItemList[item].SetCustomLeftBadge(txd,txn);
	}

	function UPDATE_LEFT_ITEM_TITLE(item, txt, param1, param2)
	{
		this.PauseMenu.AddRightTitle(item,txt,param1,param2);
	}

	function SET_LEFT_ITEM_RIGHT_BADGE(item, badge)
	{
		this.PauseMenu.Tab.LeftItemList[item].SetRightBadge(badge);
	}

	function ENABLE_LEFT_ITEM(item, disable)
	{
		this.PauseMenu.Tab.LeftItemList[item].Enabled = disable;
	}

	function ENABLE_RIGHT_ITEM(litem, ritem, disable)
	{
		this.PauseMenu.Tab.LeftItemList[litem].ItemList[ritem].Enabled = disable;
	}

	function SET_INPUT_EVENT(direction)
	{
//		if (this.PauseMenu.Tab instanceof com.rockstargames.PauseMenu.tabs.VehicleSelectionTab)
//		{
//			return this.PauseMenu.Tab.SET_INPUT_EVENT(direction);
//		}
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				return this.PauseMenu.GoUp();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				return this.PauseMenu.GoDown();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				return this.PauseMenu.GoLeft();
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				return this.PauseMenu.GoRight();
				break;
			case com.rockstargames.ui.game.GamePadConstants.CROSS :

				switch (this.PauseMenu.Focus)
				{
					case 1 :
						if (this.PauseMenu.Tab instanceof com.rockstargames.PauseMenu.tabs.PlayerListTab)
						{
							var col = this.PauseMenu.Tab.getColumn("settings");
							if (col != undefined)
							{
								if (col.currentItem._type == 2)
								{
									col.currentItem.Checked = !col.currentItem.Checked;

								}
							}
						}
						break;
					case 2 :
						{
							var curItem = this.PauseMenu.currentTab.currentItem;
							if (curItem.currentItem._type == 4)
							{
								curItem.currentItem.Checked = !curItem.currentItem.Checked;
								com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
							}
						};
						break;
				}
				break;
		}
	}

	function SET_SCROLL_EVENT(direction, isJoyPad)
	{
		// -1 up , 1 down
		var focus = this.PauseMenu.Focus;
		if (focus == 1)
		{
			var curTab = this.PauseMenu.currentTab;
			var curItem = curTab.currentItem;
			if (curTab instanceof com.rockstargames.PauseMenu.tabs.InfoTab)
			{
				if (curItem.itemType == 1)
				{
					curItem.scrollAll(direction,true);
				}
			}
			else if (curTab instanceof com.rockstargames.PauseMenu.tabs.SimpleTab)
			{
				if (curTab.panelHovered || isJoyPad)
				{
					curTab.scrollAll(direction,true);
				}
			}
			else if (curTab instanceof com.rockstargames.PauseMenu.tabs.VehicleSelectionTab)
			{
				curTab.scrollAll(direction);
			}
		}
	}

	function MOUSE_CLICK_EVENT()
	{
		var _result = [];
		var focus = this.PauseMenu.Focus;
		var canIncrease = false;
		switch (focus)
		{
			case 0 :
				this.PauseMenu.Focus++;
				break;
			case 1 :
				var curTab = this.PauseMenu.currentTab;
				var _hoveredItem;
				if (curTab.currentItem.itemType == 3)
				{
					for (var j = 0; j < curTab.currentItem.ItemList.length; j++)
					{
						if (curTab.currentItem.ItemList[j]._hovered && !curTab.currentItem.ItemList[j]._highlighted)
						{
							curTab.currentItem.currentSelection = j;
							this.PauseMenu.Focus++;
							break;
						}
					}
				}

				for (var i = 0; i < curTab.LeftItemList.length; i++)
				{
					if (curTab.LeftItemList[i].leftItem._hovered && !curTab.LeftItemList[i].Selected)
					{
						curTab.currentSelection = i;
						break;
					}
				}


				break;
			case 2 :
				var curTab = this.PauseMenu.currentTab;
				var curItem = curTab.currentItem;

				for (var i = 0; i < curTab.LeftItemList.length; i++)
				{
					if (curTab.LeftItemList[i].leftItem._hovered && !curTab.LeftItemList[i].Selected)
					{
						this.PauseMenu.Focus--;
						curTab.currentSelection = i;
						break;
					}
				}


				for (var i = 0; i < curItem.ItemList.length; i++)
				{
					if (curItem.ItemList[i]._hovered)
					{
						if (!curItem.ItemList[i]._highlighted)
						{
							curItem.currentSelection = i;
						}
						else
						{
							if (curItem.ItemList[i]._type == 4)
							{
								curItem.ItemList[i].Checked = !curItem.ItemList[i].Checked;
							}
						}
					}
				}


				break;
		}
		com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");

		switch (focus)
		{
			case 0 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				break;
			case 1 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				_result.push(this.PauseMenu.currentTab.currentSelection);
				break;
			case 2 :
				_result.push(this.PauseMenu.Index);
				_result.push(this.PauseMenu.Focus);
				_result.push(this.PauseMenu.currentTab.currentSelection);
				_result.push(this.PauseMenu.currentTab.currentItem.currentSelection);
				_result.push(this.PauseMenu.currentTab.currentItem.currentItem.Value);
				break;

		}
		return _result.toString();
	}

	function CREATE_PLAYERS_TAB_COLUMNS(left, center, right)
	{
		this.PauseMenu.Tab.Initialize(left,center,right);
		this.PauseMenu.updateTabsDrawing();
	}

	function SET_PLAYERS_TAB_COLUMN_MAXITEMS(col, max)
	{
		this.PauseMenu.Tab.orderedColumns[col].column.setMaxItems(max);
	}

	function SET_PLAYERS_TAB_NEWSTYLE(bool)
	{
		this.PauseMenu.Tab.NewStyle = bool;
	}

	function ADD_PLAYERS_TAB_SETTINGS_ITEM(before, index, id, str, sub, enabled, blink, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.PauseMenu.Tab.AddSetting(before,index,id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYERS_TAB_PLAYER_ITEM(before, index, id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.PauseMenu.Tab.AddPlayerItem(before,index,id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYERS_TAB_MISSIONS_ITEM(before, index, id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
	{
		this.PauseMenu.Tab.AddMissionsItem(before,index,id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
	}

	function ADD_PLAYERS_TAB_STORE_ITEM(before, index, id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.PauseMenu.Tab.AddStoreItem(before,index,id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYERS_TAB_MISSION_PANEL_ITEM(itemType, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		this.PauseMenu.Tab.AddMissionPanelItem(itemType,textLeft,textRight,param3,param4,param5,param6,param7,param8,param9,param10);
	}

	function REMOVE_PLAYERS_TAB_MISSION_PANEL_ITEM(id)
	{
		this.PauseMenu.Tab.RemoveMissionPanelItem(id);
	}

	function ADD_PLAYERS_TAB_MISSION_PANEL_PICTURE(txd, txn)
	{
		this.PauseMenu.Tab.SetPanelPicture(txd,txn);
	}

	function SET_PLAYERS_TAB_MISSION_PANEL_TITLE(title)
	{
		this.PauseMenu.Tab.SetMissionPanelTitle(title);
	}

	function REMOVE_PLAYERS_TAB_PLAYER_ITEM(id)
	{
		this.PauseMenu.Tab.RemovePlayer(id);
	}

	function REMOVE_PLAYERS_TAB_MISSIONS_ITEM(id)
	{
		this.PauseMenu.Tab.RemoveMission(id);
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_LISTITEM_LIST(item, list, index)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].multiListItems = [];
			col.ItemList[item].multiListItems = list.split(",");
			col.ItemList[item].Value = index;
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_SELECTION(id)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.currentSelection = id;
		}
	}
	function SET_PLAYERS_TAB_PLAYERS_SELECTION(id)
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.currentSelection = id;
		}
	}
	function SET_PLAYERS_TAB_MISSIONS_SELECTION(id)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if ((col != undefined))
		{
			col.currentSelection = id;
		}
	}
	function SET_PLAYERS_TAB_STORE_SELECTION(id)
	{
		var col = this.PauseMenu.Tab.getColumn("store");
		if ((col != undefined))
		{
			col.currentSelection = id;
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_QTTY(current, max)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.setCounter(current,max);
		}
	}

	function SET_PLAYERS_TAB_PLAYERS_QTTY(current, max)
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.setCounter(current,max);
		}
	}

	function SET_PLAYERS_TAB_MISSIONS_QTTY(current, max)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if ((col != undefined))
		{
			col.setCounter(current,max);
		}
	}
	function SET_PLAYERS_TAB_STORE_QTTY(current, max)
	{
		var col = this.PauseMenu.Tab.getColumn("store");
		if ((col != undefined))
		{
			col.setCounter(current,max);
		}
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_STATUS(item, status, statusColor)
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ItemList[item].setStatus(status,statusColor);
		}
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL()
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ItemList[arguments[0]].addPanel(arguments.slice(1));
			col.updateItemsDrawing();
		}
	}

	function SET_PLAYERS_TAB_PLAYERS_STAT_PANEL_PERMANENT(item, bool)
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ItemList[item].permanentPanel = bool;
		}
	}

	function HIDE_PLAYERS_TAB_MISSION_PANEL(show)
	{
		if ((show == true))
		{
			var plCol = this.PauseMenu.Tab.getColumn("players");
			if ((((plCol != undefined) && plCol.IsPermanentPanel) || this.PauseMenu.Tab.currentColumn.type == "players"))
			{
				return;
			}
		}
		var col = this.PauseMenu.Tab.getColumn("panel");
		if ((col != undefined))
		{
			col.itemMC._visible = show;
		}
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL_STAT()
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ItemList[arguments[0]].panel.AddStatItem(arguments.slice(1));
		}
	}

	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL_DETAIL(item, id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ItemList[item].panel.ADD_DETAILS_ITEM(id,textLeft,textRight,param3,param4,param5,param6,param7,param8,param9,param10);
		}
	}
	function SET_PLAYERS_TAB_PLAYER_ITEM_PANEL_DESCRIPTION(item, desc, type, unused, collapse)
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ItemList[item].panel.SET_DESCRIPTION(desc,type,unused,collapse);
		}
	}

	function SET_PLAYERS_TAB_FOCUS(focus)
	{
		return this.PauseMenu.Tab.SetFocus(focus);
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_LABELS(item, lbl, rtxt)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			com.rockstargames.ui.utils.UIText.setSizedText(col.ItemList[item].leftTextTF,lbl,false,true);
			if (col.ItemList[item]._type == 0)
			{
				col.ItemList[item].SetRightText(rtxt);
			}
			col.ItemList[item].refreshLabelFonts();
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_LABEL_FONT(item, fName, fId)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].updateLabelFont(fName,fId);
		}
	}
	function SET_PLAYERS_TAB_SETTINGS_ITEM_RIGHT_LABEL_FONT(item, fName, fId)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].updateRightLabelFont(fName,fId);
		}
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_DESCRIPTION(item, desc)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].subtitle = desc;
			col.updateDescription();
		}
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_BLINK_DESC(item, blink)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].blinkDesc = blink;
		}
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_LABEL(item, txt)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			com.rockstargames.ui.utils.UIText.setSizedText(col.ItemList[item].leftTextTF,txt,false,true);
			col.ItemList[item].refreshLabelFonts();
		}
	}

	function UPDATE_PLAYERS_TAB_SETTINGS_ITEM_LABEL_RIGHT(item, _label)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].SetRightText(_label);
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_LEFT_BADGE(item, badge)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].SetLeftBadge(badge);
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_RIGHT_BADGE(item, badge)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].SetRightBadge(badge);
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_CUSTOM_LEFT_BADGE(item, txd, txn)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetCustomLeftBadge(txd,txn);
		}
	}

	function SET_PLAYERS_TAB_SETTINGS_ITEM_CUSTOM_RIGHT_BADGE(item, txd, txn)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetCustomRightBadge(txd,txn);
		}
	}

	function ENABLE_PLAYERS_TAB_SETTINGS_ITEM(item, disable)
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ItemList[item].Enabled = disable;
		}
	}

	function SET_PLAYERS_TAB_MISSION_ITEM_ENABLED(item, bool)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if ((col != undefined))
		{
			col.ItemList[item].Enabled = bool;
		}
	}

	function SET_PLAYERS_TAB_MISSION_ITEM_LEFT_ICON(item, icon, color)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if ((col != undefined))
		{
			col.ItemList[item].AddLeftTexture(icon,color);
		}
	}

	function SET_PLAYERS_TAB_MISSION_ITEM_RIGHT_ICON(item, icon, checked, color)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if ((col != undefined))
		{
			col.ItemList[item].AddRightTexture(icon,checked,color);
		}
	}

	function SET_PLAYERS_TAB_MISSION_ITEM_CUSTOM_LEFT_ICON(item, txd, txn)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].AddCustomLeftTexture(txd,txn);
		}
	}

	function SET_PLAYERS_TAB_MISSION_ITEM_CUSTOM_RIGHT_ICON(item, txd, txn, checked)
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].AddCustomRightTexture(txd,txn,checked);
		}
	}

	function CLEAR_PLAYERS_TAB_PLAYERS_COLUMN()
	{
		var col = this.PauseMenu.Tab.getColumn("players");
		if ((col != undefined))
		{
			col.ClearItems();
		}
	}
	function CLEAR_PLAYERS_TAB_SETTINGS_COLUMN()
	{
		var col = this.PauseMenu.Tab.getColumn("settings");
		if ((col != undefined))
		{
			col.ClearItems();
		}
	}
	function CLEAR_PLAYERS_TAB_MISSIONS_COLUMN()
	{
		var col = this.PauseMenu.Tab.getColumn("missions");
		if ((col != undefined))
		{
			col.ClearItems();
		}
	}
	function CLEAR_PLAYERS_TAB_STORE_COLUMN()
	{
		var col = this.PauseMenu.Tab.getColumn("store");
		if ((col != undefined))
		{
			col.ClearItems();
		}
	}
	function CLEAR_PLAYERS_TAB_MISSION_PANEL_ITEMS()
	{
		var col = this.PauseMenu.Tab.getColumn("panel");
		if ((col != undefined))
		{
			col.ClearItems();
		}
	}

	function SET_GALLERY_DESCRIPTION_LABELS(max, _title, date, location, track, visible)
	{
		this.PauseMenu.Tab.SetDescription(max,_title,date,location,track,visible);
	}

	function SET_GALLERY_SCROLL_LABEL(currentPosition, maxPosition, maxVisible, caption, captionR)
	{
		this.PauseMenu.Tab.SetScrollBar(currentPosition,maxPosition,maxVisible,caption,captionR);
	}

	function SET_GALLERY_TITLE(txd, txn, state)
	{
		this.PauseMenu.Tab.SetTitle(txd,txn,state);
	}

	function ADD_GALLERY_ITEM(_slotIndex)
	{
		this.PauseMenu.Tab.AddItem(_slotIndex,arguments);
	}

	function UPDATE_GALLERY_ITEM(_slotIndex)
	{
		this.PauseMenu.Tab.model.updateSlot(0,_slotIndex,arguments);
		if (this.PauseMenu.Tab.scrollBase != undefined)
		{
			this.PauseMenu.Tab.scrollBase.updateScroll();
		}
	}

	function ADD_VEHICLE_SELECTOR_ITEM(_type, model, modelString, vehicleName, txd, txn, makeTxd, makeTxn, perfTxd, perfClass, bgTxd, bgTxn, isPesonal, className, locked, param15)
	{
		this.PauseMenu.Tab.AddItem(_type,model,modelString,vehicleName,txd,txn,makeTxd,makeTxn,perfTxd,perfClass,bgTxd,bgTxn,isPesonal,className,locked,param15);
	}

	function HOVER_VEHICLE_SELECTOR_INDEX(index, isMouse)
	{
		this.PauseMenu.Tab.HoverItem(index);
	}
	function SELECT_VEHICLE_SELECTOR_INDEX(index)
	{
		this.PauseMenu.Tab.SetIndex(index);
	}
	function SET_VEHICLE_SELECTOR_ITEM_CHECKED(item, bool)
	{
		this.PauseMenu.Tab.SetItemChecked(item,bool);
	}

	function CLEAR_GALLERY()
	{
		this.PauseMenu.Tab.ON_DESTROY();
	}

	function SET_GALLERY_PANEL_HIDDEN(bool)
	{
		this.PauseMenu.Tab.SET_COMPONENT_HIDDEN(bool);
	}

	function SET_GALLERY_PANEL_DESCRIPTION(desc)
	{
		this.PauseMenu.Tab.SetRightDescription(desc);
	}

	function UPDATE_GALLERY_HIGHLIGHT(highlightIndex, staticClear)
	{
		this.PauseMenu.Tab.SET_HIGHLIGHT(highlightIndex,staticClear);
	}

	function DISPLAY_GALLERY()
	{
		this.PauseMenu.Tab.model.displayView(0,0);
	}

	function UPDATE_DRAWING()
	{
		this.PauseMenu.updateTabsDrawing();
	}

	function CLEAR_ALL()
	{
		this.PauseMenu.Clear();
		this.removeClipAndChildren(this.CONTENT._content_);
		this.removeAllObjects(this.PauseMenu);
		this.CONTENT.mouseCatcher.removeMovieClip();
		this.PauseMenu.Tab = null;
		this.PauseMenu = null;
		this.PauseMenu = new com.rockstargames.PauseMenu.TabView(this.CONTENT);
	}

	function removeClipAndChildren(clip:MovieClip):Void
	{
		for (var i in clip)
		{
			if (typeof clip[i] == "movieclip")
			{
				clip[i].swapDepths(0);
				// Bring the MovieClip to the topmost layer;
				removeClipAndChildren(clip[i]);
			}
		}
		clip.removeMovieClip();
	}

	function removeAllObjects(parent:Object):Void
	{
		for (var prop in parent)
		{
			// Check if the property is an object (not a primitive type like Number, String, etc.)
			if (typeof parent[prop] == "object")
			{
				// Remove the object by setting its reference to null
				parent[prop] = null;
			}
		}
	}

	function DRAW_MENU()
	{
		this.CONTENT._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
	}

	function FADE_IN()
	{
		this.CONTENT._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
	}

	function FADE_OUT()
	{
		this.CONTENT._alpha = 100;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:0, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
	}


	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		if (success == true)
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval((pMC + ".") + strRef));
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
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval((pMC + ".") + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd, strRef)
	{
		var pMC = this.CONTENT;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval((pMC + ".") + strRef));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}
}