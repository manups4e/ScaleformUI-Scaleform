class com.rockstargames.gtav.levelDesign.LOBBYMENU extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var LobbyMenu;
	static var MouseEnabled = true;

	function LOBBYMENU()
	{
		super();
		_global.gfxExtensions = true;
	}

	function INITIALISE(mc)
	{
		super.INITIALISE(mc);
		this.CONTENT._alpha = 0;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME = "LobbyMenu";
	}

	function CREATE_MENU(left, center, right)
	{
		this.CONTENT._alpha = 0;
		this.LobbyMenu = new com.rockstargames.PauseMenu.MainView(this.CONTENT, left, center, right);
	}

	function SET_COLUMN_MAXITEMS(col, max)
	{
		this.LobbyMenu.orderedColumns[col].column.setMaxItems(max);
	}

	function SET_NEWSTYLE(bool)
	{
		this.LobbyMenu.NewStyle = bool;
	}

	function LOAD_MENU()
	{
		this.LobbyMenu.finalize();
	}

	function SET_PANELS_ORDER(left, center, right)
	{
		this.LobbyMenu.SetPanelsOrder(left,center,right);
	}

	function FADE_OUT()
	{
		this.LobbyMenu.fadeOutLobby();
	}

	function FADE_IN()
	{
		this.LobbyMenu.fadeInLobby();
	}

	function DRAW_MENU()
	{
		this.CONTENT._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
	}

	function ADD_LEFT_ITEM(id, str, sub, enabled, blink, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.LobbyMenu.AddSetting(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function ADD_PLAYER_ITEM(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.LobbyMenu.AddPlayerItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}
	function ADD_MISSIONS_ITEM(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13, param14)
	{
		this.LobbyMenu.AddMissionsItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14);
	}
	function ADD_STORE_ITEM(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		this.LobbyMenu.AddStoreItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
	}

	function REMOVE_PLAYER_ITEM(id)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.RemoveItem(id);
		}
	}
	function CLEAR_PLAYERS_COLUMN()
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ClearItems();
		}
	}
	function CLEAR_SETTINGS_COLUMN()
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ClearItems();
		}
	}
	function CLEAR_MISSIONS_COLUMN()
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ClearItems();
		}
	}
	function CLEAR_STORE_COLUMN()
	{
		var col = this.LobbyMenu.getColumn("store");
		if (col != undefined)
		{
			col.ClearItems();
		}
	}

	function CLEAR_MISSION_PANEL_ITEMS()
	{
		var col = this.LobbyMenu.getColumn("panel");
		if (col != undefined)
		{
			col.ClearItems();
		}
	}


	function UPDATE_SETTINGS_ITEM_LABELS(item, lbl, rtxt)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			com.rockstargames.ui.utils.UIText.setSizedText(col.ItemList[item].leftTextTF,lbl,false,true);
			if (col.ItemList[item]._type == 0)
			{
				col.ItemList[item].SetRightText(rtxt);
			}
			col.ItemList[item].refreshLabelFonts();
			col.ItemList[item].updateLabelWidth();
		}
	}

	function UPDATE_SETTINGS_LISTITEM_LIST(item, list, index)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].multiListItems = [];
			col.ItemList[item].multiListItems = list.split(",");
			col.ItemList[item].Value = index;
		}
	}

	function UPDATE_SETTINGS_ITEM_DESCRIPTION(item, desc)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].subtitle = desc;
			col.updateItemsDrawing();
		}
	}

	function UPDATE_SETTINGS_ITEM_BLINK_DESC(item, blink)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].blinkDesc = blink;
		}
	}

	function UPDATE_SETTINGS_ITEM_LABEL(item, txt)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			com.rockstargames.ui.utils.UIText.setSizedText(col.ItemList[item].leftTextTF,txt,true,true);
		}
	}

	function UPDATE_SETTINGS_ITEM_LABEL_RIGHT(item, _label)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetRightText(_label);
		}
	}

	function SET_SETTINGS_ITEM_LEFT_BADGE(item, badge)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetLeftBadge(badge);
		}
	}

	function SET_SETTINGS_ITEM_RIGHT_BADGE(item, badge)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetRightBadge(badge);
		}
	}

	function SET_SETTINGS_ITEM_CUSTOM_LEFT_BADGE(item, txd, txn)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetCustomLeftBadge(txd,txn);
		}
	}

	function SET_SETTINGS_ITEM_CUSTOM_RIGHT_BADGE(item, txd, txn)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].SetCustomRightBadge(txd,txn);
		}
	}


	function SET_SETTINGS_ITEM_LABEL_FONT(item, fontN, fontId)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].updateLabelFont(fontN,fontId);
		}
	}
	function SET_SETTINGS_ITEM_RIGHT_LABEL_FONT(item, fontN, fontId)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].updateRightLabelFont(fontN,fontId);
		}
	}

	function ENABLE_SETTINGS_ITEM(item, disable)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.ItemList[item].Enabled = disable;
		}
	}

	function SET_PLAYERS_STAT_PANEL_PERMANENT(item, bool)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].permanentPanel = bool;
		}
	}

	function HIDE_MISSION_PANEL(show)
	{
		if (show == true)
		{
			var plCol = this.LobbyMenu.getColumn("players");
			if ((plCol != undefined && plCol.IsPermanentPanel) || this.LobbyMenu.currentColumn.type == "players")
			{
				return;
			}
		}
		var col = this.LobbyMenu.getColumn("panel");
		if (col != undefined)
		{
			col.itemMC._visible = show;
		}
	}

	function ADD_MISSION_PANEL_ITEM(itemType, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		this.LobbyMenu.AddMissionPanelItem(itemType,textLeft,textRight,param3,param4,param5,param6,param7,param8,param9,param10);
	}

	function REMOVE_MISSION_PANEL_ITEM(id)
	{
		this.LobbyMenu.RemoveMissionPanelItem(id);
	}

	function ADD_MISSION_PANEL_PICTURE(txd, txn)
	{
		this.LobbyMenu.SetPanelPicture(txd,txn);
	}

	function SET_MISSION_PANEL_TITLE(title)
	{
		this.LobbyMenu.SetMissionPanelTitle(title);
	}

	function SET_PLAYER_ITEM_LABEL(item, label)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].Label = label;
		}
	}

	function SET_PLAYER_ITEM_COLOUR(item, colour, colorurTag)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].setColour(colour,colorurTag);
		}
	}

	function SET_PLAYER_ITEM_RANK(item, rank)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].setRank(rank);
		}
	}

	function SET_PLAYER_ITEM_CREW(item, crew)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].setCrew(crew);
		}
	}

	function SET_PLAYER_ITEM_STATUS(item, status, statusColor)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].setStatus(status,statusColor);
		}
	}

	function SET_PLAYER_ITEM_ICON_LEFT(item, icon, isCustom)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].setIconLeft(icon,isCustom);
		}
	}

	function SET_PLAYER_ITEM_ICON_RIGHT(item, icon, isCustom)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].setIconRight(icon,isCustom);
		}
	}

	// too many arguments to write.. using arguments[] array;
	//item, id, title, subtitle, titleColor, rankNum, bool1, bool2, bool3, bool4, _icon, param9, param10, param11, param12, param13
	function SET_PLAYER_ITEM_PANEL()
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[arguments[0]].addPanel(arguments.slice(1));
			col.updateItemsDrawing();
		}
	}

	// too many arguments to write.. using arguments[] array;
	function SET_PLAYER_ITEM_PANEL_STAT()
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[arguments[0]].panel.AddStatItem(arguments.slice(1));
		}
	}

	function SET_PLAYER_ITEM_PANEL_DETAIL(item, id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].panel.ADD_DETAILS_ITEM(id,textLeft,textRight,param3,param4,param5,param6,param7,param8,param9,param10);
		}
	}

	function SET_PLAYER_ITEM_PANEL_DESCRIPTION(item, desc, type, unused, collapse)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.ItemList[item].panel.SET_DESCRIPTION(desc,type,unused,collapse);
		}
	}

	function SET_SETTINGS_SELECTION(id)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.currentSelection = id;
		}
	}
	function SET_PLAYERS_SELECTION(id)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.currentSelection = id;
		}
	}
	function SET_MISSIONS_SELECTION(id)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.currentSelection = id;
		}
	}

	function SET_STORE_SELECTION(id)
	{
		var col = this.LobbyMenu.getColumn("store");
		if (col != undefined)
		{
			col.currentSelection = id;
		}
	}

	function SET_SETTINGS_QTTY(current, max)
	{
		var col = this.LobbyMenu.getColumn("settings");
		if (col != undefined)
		{
			col.setCounter(current,max);
		}
	}

	function SET_PLAYERS_QTTY(current, max)
	{
		var col = this.LobbyMenu.getColumn("players");
		if (col != undefined)
		{
			col.setCounter(current,max);
		}
	}

	function SET_MISSIONS_QTTY(current, max)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.setCounter(current,max);
		}
	}
	function SET_STORE_QTTY(current, max)
	{
		var col = this.LobbyMenu.getColumn("store");
		if (col != undefined)
		{
			col.setCounter(current,max);
		}
	}

	function SET_MISSION_ITEM_ENABLED(item, bool)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].Enabled = bool;
		}
	}

	function SET_MISSION_ITEM_LEFT_ICON(item, icon, color)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].AddLeftTexture(icon,color);
		}
	}

	function SET_MISSION_ITEM_RIGHT_ICON(item, icon, checked, color)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].AddRightTexture(icon,checked,color);
		}
	}

	function SET_MISSION_ITEM_CUSTOM_LEFT_ICON(item, txd, txn)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].AddCustomLeftTexture(txd,txn);
		}
	}

	function SET_MISSION_ITEM_CUSTOM_RIGHT_ICON(item, txd, txn, checked)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].AddCustomRightTexture(txd,txn,checked);
		}
	}

	function UPDATE_MISSION_ITEM_ICONS(item)
	{
		var col = this.LobbyMenu.getColumn("missions");
		if (col != undefined)
		{
			col.ItemList[item].refreshIcons();
		}
	}

	function SET_FOCUS(f)
	{
		return this.LobbyMenu.SetFocus(f);
	}

	function SET_INPUT_EVENT(direction, time)
	{
		var retVal = -1;
		var _result = new Array();
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				this.LobbyMenu.GoUp(time);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				this.LobbyMenu.GoDown(time);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				retVal = this.LobbyMenu.GoLeft(time);
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				retVal = this.LobbyMenu.GoRight(time);
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"NAV_LEFT_RIGHT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
			case com.rockstargames.ui.game.GamePadConstants.CROSS :
				var curItem = this.LobbyMenu.currentColumn.column.currentItem;
				if (this.LobbyMenu.currentColumn.type == "settings" && curItem._type == 2)
				{
					curItem.Checked = !curItem.Checked;
					com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET");
				}
				break;
			case com.rockstargames.ui.game.GamePadConstants.CIRCLE :
				com.rockstargames.ui.game.GameInterface.call("PLAY_SOUND",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"BACK","HUD_FRONTEND_DEFAULT_SOUNDSET");
				break;
		}
		_result.push(this.LobbyMenu.Focus,this.LobbyMenu.currentColumn.column.currentSelection,retVal);
		return _result.toString();
	}

	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		if (success == true)
		{
			var pMC = this.CONTENT;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
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
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}

	function TXD_ALREADY_LOADED(txd, strRef)
	{
		var pMC = this.CONTENT;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}


	function CLEAR_ALL()
	{
		this.LobbyMenu.columnLeft.Clear();
		this.LobbyMenu.columnCenter.Clear();
		this.LobbyMenu.columnRight.Clear();
		this.LobbyMenu = undefined;
	}
}