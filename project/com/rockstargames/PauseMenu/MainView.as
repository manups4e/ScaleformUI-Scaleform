class com.rockstargames.PauseMenu.MainView
{
	var CONTENT;
	var _focusLevel = 0;
	var _title;
	var _selected = 0;
	var _selectedItem;
	var centerItemCount;
	var DescriptionSprite;
	var EnableAnim;
	var AnimType;
	var RightItemList;
	var leftX = 0;
	var centerX = 290;
	var rightX = 580;
	var columnLeft;
	var columnCenter;
	var columnRight;
	var orderedColumns = [];
	var _idx;
	var _min;
	var _max;
	var _newStyle;
	var _isFocused = true;


	// i type sono le stringhe in initializeColumn(type, offset)
	function MainView(mc, leftType, centerType, rightType)
	{
		this.CONTENT = mc;
		this.InitializeColumns(leftType,centerType,rightType);
		this.SetPanelsOrder(0,1,2);
	}

	function InitializeColumns(left, center, right)
	{
		if (left != center && left != right && center != right)
		{
			this.columnLeft = this.initializeColumn(left, this.leftX);
			this.columnCenter = this.initializeColumn(center, this.centerX);
			this.columnRight = this.initializeColumn(right, this.rightX);
		}
		this.orderedColumns = new Array({id:0, type:left, column:this.columnLeft}, {id:1, type:center, column:this.columnCenter}, {id:2, type:right, column:this.columnRight});
	}

	function initializeColumn(type, offset)
	{
		switch (type)
		{
			case "settings" :
				return new com.rockstargames.PauseMenu.elements.columns.SettingsList(this, offset);
			case "players" :
				return new com.rockstargames.PauseMenu.elements.columns.PlayerList(this, offset);
			case "missions" :
				return new com.rockstargames.PauseMenu.elements.columns.MissionList(this, offset);
			case "store" :
				return new com.rockstargames.PauseMenu.elements.columns.ImageColumnList(this, offset);
			case "panel" :
				return new com.rockstargames.PauseMenu.elements.panels.MissionPanel(this, offset, "", "", "");
		}
	}

	function getColumn(type)
	{
		for (var c in this.orderedColumns)
		{
			if (this.orderedColumns[c].type == type)
			{
				return this.orderedColumns[c].column;
			}
		}
		return undefined;
	}

	function SetPanelsOrder(left, center, right)
	{
		if (left != center && left != right && center != right)
		{
			this.orderedColumns[0].id = 0;
			this.orderedColumns[1].id = 1;
			this.orderedColumns[2].id = 2;
			for (var it in this.orderedColumns)
			{
				switch (this.orderedColumns[it].id)
				{
					case 0 :
						this.orderedColumns[it].column.OFFSET = this.leftX;
						this.orderedColumns[it].column._id = 0;
						break;
					case 1 :
						this.orderedColumns[it].column.OFFSET = this.centerX;
						this.orderedColumns[it].column._id = 1;
						break;
					case 2 :
						this.orderedColumns[it].column.OFFSET = this.rightX;
						this.orderedColumns[it].column._id = 2;
						break;
				}
				this.orderedColumns[it].column.updateItemsDrawing();
			}
		}
	}

	function AddSetting(id, str, sub, enabled, blink, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		var col = this.getColumn("settings");
		if (col != undefined)
		{
			col.AddItem(id,str,sub,enabled,blink,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
		}
	}

	function AddPlayerItem(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		var col = this.getColumn("players");
		if (col != undefined)
		{
			col.AddItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
		}
	}

	function AddMissionsItem(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		var col = this.getColumn("missions");
		if (col != undefined)
		{
			col.AddItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
		}
	}
	function AddStoreItem(id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		var col = this.getColumn("store");
		if (col != undefined)
		{
			col.AddItem(id,param0,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13);
		}
	}

	function AddMissionPanelItem(id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var col = this.getColumn("panel");
		if (col != undefined)
		{
			col.AddItem(id,textLeft,textRight,param3,param4,param5,param6,param7,param8,param9,param10);
		}
	}

	function SetPanelPicture(txd, txn)
	{
		var col = this.getColumn("panel");
		if (col != undefined)
		{
			col.setPicture(txd,txn);
		}
	}

	function SetMissionPanelTitle(title)
	{
		var col = this.getColumn("panel");
		if (col != undefined)
		{
			col.setTitle(title);
		}
	}

	function GoUp(val)
	{
		var ret = -1;
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players" || this.currentColumn.type == "missions" || this.currentColumn.type == "store")
		{
			ret = this.currentColumn.column.GoUp(val);
		}
		return ret;
	}

	function GoDown(val)
	{
		var ret = -1;
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players" || this.currentColumn.type == "missions" || this.currentColumn.type == "store")
		{
			ret = this.currentColumn.column.GoDown(val);
		}
		return ret;
	}

	function GoLeft(val)
	{
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players" || this.currentColumn.type == "missions" || this.currentColumn.type == "store")
		{
			return this.currentColumn.column.GoLeft(val);
		}
	}

	function GoRight(val)
	{
		if (this.currentColumn.type == "settings" || this.currentColumn.type == "players" || this.currentColumn.type == "missions" || this.currentColumn.type == "store")
		{
			return this.currentColumn.column.GoRight(val);
		}
	}

	function fadeOutLobby()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:0, onComplete:com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf, onCompleteScope:this, onCompleteArgs:[this.CONTENT], ease:17});
	}
	function fadeInLobby()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:100, onComplete:com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf, onCompleteScope:this, onCompleteArgs:[this.CONTENT], ease:16});
	}

	function SetFocus(f)
	{
		var res;
		var goingLeft = f < this.Focus;
		if (this.NewStyle)
		{
			var oldSelection = this.currentColumn.column.currentSelection;
			var newSelection;
			if (this.orderedColumns[f].column.itemCount > 0)
			{
				newSelection = oldSelection;
			}
			else
			{
				newSelection = 0;
			}
			this.Focus = f;
			if (newSelection >= 0)
			{
				if (newSelection < this.currentColumn.column.itemCount)
				{
					res = newSelection;
					this.currentColumn.column.currentSelection = newSelection;
				}
				else
				{
					res = this.currentColumn.column.itemCount - 1;
					this.currentColumn.column.currentSelection = this.currentColumn.column.itemCount - 1;
				}

			}
			else
			{
				res = 0;
				this.currentColumn.column.currentSelection = 0;
			}
		}
		else
		{
			this.Focus = f;
			if (!goingLeft)
			{
				res = 0;
			}
			else
			{
				res = this.currentColumn.column.currentSelection;
			}
			this.currentColumn.column.currentSelection = res;
		}
		return res;
	}

	function set Focus(f)
	{
		this._focusLevel = f;
		if (this._focusLevel < 0)
		{
			this._focusLevel = this.orderedColumns.length - 1;
		}
		if (this._focusLevel > this.orderedColumns.length - 1)
		{
			this._focusLevel = 0;
		}
		switch (this.currentColumn.type)
		{
			case "settings" :
				var col = this.getColumn("players");
				var permanent;
				if (col != undefined)
				{
					permanent = col.IsPermanentPanel;
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}

				col = this.getColumn("missions");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("store");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("panel");
				if (col != undefined)
				{
					col.itemMC._visible = !permanent;
				}
				break;
			case "players" :
				var col = this.getColumn("settings");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}

				col = this.getColumn("missions");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("store");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("panel");
				if (col != undefined)
				{
					col.itemMC._visible = false;
				}
				break;
			case "missions" :
				var col = this.getColumn("settings");
				var permanent = false;
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("store");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("players");
				var permanent;
				if (col != undefined)
				{
					permanent = col.IsPermanentPanel;
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("panel");
				if (col != undefined)
				{
					col.itemMC._visible = !permanent;
				}
				break;
			case "store" :
				var col = this.getColumn("settings");
				var permanent = false;
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("missions");
				if (col != undefined)
				{
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("players");
				var permanent;
				if (col != undefined)
				{
					permanent = col.IsPermanentPanel;
					for (var i in col.ItemList)
					{
						col.ItemList[i].highlighted = false;
					}
					col.updateItemsDrawing();
				}
				col = this.getColumn("panel");
				if (col != undefined)
				{
					col.itemMC._visible = !permanent;
				}
				break;
		}
		this.currentColumn.column.updateItemsDrawing();
	}

	function finalize()
	{
		this.SetFocus(1);
		this.SetFocus(0);
	}

	function get Focus()
	{
		return this._focusLevel;
	}

	function set isVisible(_v)
	{
		super.isVisible = _v;
	}

	function set focused(_f)
	{
		super.focused = _f;
	}
	function get currentColumn()
	{
		var curr = "";
		for (var i in this.orderedColumns)
		{
			if (this._focusLevel == this.orderedColumns[i].id)
			{
				curr = this.orderedColumns[i];
				break;
			}
		}
		return curr;
	}

	function set NewStyle(ns)
	{
		this._newStyle = ns;
	}
	function get NewStyle()
	{
		return this._newStyle;
	}

	function GetColumnByType(strName)
	{
		for (var i in this.orderedColumns)
		{
			if (strName == this.orderedColumns[i].type)
			{
				return this.orderedColumns[i];
			}
		}
	}
}