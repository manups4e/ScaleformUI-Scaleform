class com.rockstargames.PauseMenu.tabs.TabLeftItem
{
	var _selected;
	var leftItem;
	var rightMenuUp;
	var rightMenuDown;
	var _isvisible;
	var _title;
	var ItemList;
	var _selectedItem;
	var _selectedIndex = 0;
	var _MC;
	var scrollableContent;
	var viewHeight = 0;
	var viewMaskHeight = 430;
	var itemType;
	var rightBodyHovered = false;
	var SCROLL_DURATION = 0.2;
	var SCROLL_DY = 27;
	var footerMC;
	var parentTab;
	var ResType;
	function TabLeftItem(parent, leftLabel, type, enabled, param1, param2, param3, param4)
	{
		this.parentTab = parent;
		this._MC = this.parentTab._MC;
		this.ItemList = new Array();
		var protoMenu = {imNotUIMenu:true, scrollableContent:this._MC}; 
		this.leftItem = new com.rockstargames.ScaleformUI.items.UIMenuItem(0, this.parentTab.LeftItemList.length, leftLabel, "", protoMenu, enabled, false, param1, param2, param3, param4);
		this.leftItem.itemMC.attachMovie("mouseCatcher","mouseCatcher",this.leftItem.itemMC.getNextHighestDepth(),{_width:this.leftItem.itemMC._width, _height:this.leftItem.itemMC._height});
		this.leftItem.itemMC.mouseCatcher.setupGenericMouseInterface(this.parentTab.LeftItemList.length,1,this.onMouseEvent,[this.leftItem, this, 1]);

		this.leftItem.highlighted = false;
		this.itemType = type;
		switch (type)
		{
			case 0 :
				this.rightMenuUp = this._MC.createEmptyMovieClip("empty", this._MC.getNextHighestDepth() + 1000);
				break;
			case 1 :
			case 2 :
				this.rightMenuUp = this._MC.attachMovie("pauseMenuRightBody", "right_body_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightMenuUp.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
				this.scrollableContent = this.rightMenuUp.createEmptyMovieClip("viewContainer", this.rightMenuUp.getNextHighestDepth());
				this.rightMenuUp.setMask(this.rightMenuUp.maskMC);
				this.rightMenuUp._x = 290;
				this.rightMenuUp.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverRB);
				this.rightMenuUp.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutRB);
				this.rightBodyHovered = false;
				this.rightMenuUp._visible = false;
				break;
			case 3 :
				this.rightMenuUp = this._MC.attachMovie("pauseMenuRightBody", "right_body_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightMenuUp.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
				this.scrollableContent = this.rightMenuUp.createEmptyMovieClip("viewContainer", this.rightMenuUp.getNextHighestDepth());
				this.rightMenuUp.setMask(this.rightMenuUp.maskMC);
				this.rightMenuUp._x = 290;
				//this.rightMenuUp.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverRB);
				//this.rightMenuUp.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutRB);
				this.rightBodyHovered = false;
				this.rightMenuUp._visible = false;
				break;
			case 4 :
				this.rightMenuUp = this._MC.attachMovie("pauseMenuRightKeymap", "right_body_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
				this.rightMenuUp._x = 290;
				var _loc3_ = new com.rockstargames.ui.utils.HudColour();
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,_loc3_);
				com.rockstargames.ui.utils.Colour.Colourise(this.rightMenuUp.bgMC,_loc3_.r,_loc3_.g,_loc3_.b,_loc3_.a);
				break;
		}
		this.footerMC = this._MC.attachMovie("footer", "footer_mc_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.footerMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.footerMC._x = 290;
		this.footerMC._y = 432;
		this.footerMC._visible = false;
		this.Enabled = enabled;
	}

	function AddTitle(txt, param1, param2)
	{
		if (this.itemType != 0 && this.itemType != 2 && this.itemType != 3 && this.itemType != 4)
		{
			this._title = new com.rockstargames.PauseMenu.items.BasicTabItem(this.scrollableContent);
			var size = 50;
			this._title.itemMC.labelMC.titleTF.autoSize = "left";
			this._title.itemMC.labelMC.titleTF.multiline = false;
			this._title.itemMC.labelMC.titleTF.htmlText = "<font face=\'$Font2\' size=\'" + size + "\'>" + txt + "</font>";
			this._title.itemMC._y = 5;
			this._title.snapBGGrid(this._title.bgMC);
		}
		else if (this.itemType == 4)
		{
			this._title = this.rightMenuUp.attachMovie("configurationList", "conf_list_" + this.rightMenuUp.getNextHighestDepth(), this.rightMenuUp.getNextHighestDepth(), {_x:0, _y:0});
			this.rightMenuUp.bgMC._y = 27;
			this._title.title.valueTF.text = txt;
			this._title.value1.valueTF.text = param1;
			this._title.value2.valueTF.text = param2;
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this._title.title.bg,com.rockstargames.ui.utils.HudColourLite.HUD_COLOUR_PAUSE_BG);
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this._title.value1.bg,com.rockstargames.ui.utils.HudColourLite.HUD_COLOUR_PAUSE_BG);
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this._title.value2.bg,com.rockstargames.ui.utils.HudColourLite.HUD_COLOUR_PAUSE_BG);
			this.updateFont(this._title.title.valueTF,"$Font2");
			this.updateFont(this._title.value1.valueTF,"$Font2");
			this.updateFont(this._title.value2.valueTF,"$Font2");
		}
	}

	function updateBackground(txd, txn, resType)
	{
		if (txd == "" && txn == "")
		{
			this.rightMenuUp.bgMC._visible = true;
			this.rightMenuUp.textMC._visible = true;
			if (this.rightMenuUp.txdLoader.isLoaded)
			{
				this.rightMenuUp.txdLoader.removeMovieClip();
			}
			this.rightMenuUp.customTxd.removeMovieClip();
			return;
		}
		this.ResType = resType;
		this.rightMenuUp.bgMC._alpha = 0;
		this.rightMenuUp.textMC._alpha = 0;
		this.rightMenuUp.attachMovie("txdLoader","txdLoader",this.rightMenuUp.getNextHighestDepth());
		this.scrollableContent.swapDepths(this.rightMenuUp.txdLoader);
		if (this.rightMenuUp.txdLoader.isLoaded)
		{
			this.rightMenuUp.txdLoader.removeMovieClip();
		}
		this.SetClip(this.rightMenuUp.txdLoader,txd,txn,576,430,this.bgLoaded);
	}

	function bgLoaded()
	{
		if (this.ResType != 0)
		{
			if (this.ResType == 1)
			{
				this.rightMenuUp.maskMC._height = this.rightMenuUp.bgMC._height;
			}
			else
			{
				this.rightMenuUp.txdLoader._height = this.rightMenuUp.bgMC._height;
			}
		}
		this.rightMenuUp.txdLoader._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.rightMenuUp.txdLoader,0.2,{_alpha:75});
	}

	function SetClip(targetMC, textureDict, textureName, w, h, callback)
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(targetMC, textureDict, textureName, w, h, callback, this);
	}

	function updateFont(tf, fontName)
	{
		tf.embedFonts = true;
		tf.antiAliasType = "advanced";
		tf.selectable = false;
		var newFont = tf.getTextFormat();
		newFont.font = fontName;
		tf.setNewTextFormat(newFont);
		tf.setTextFormat(newFont);
	}


	function AddItem(_type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		if (this.itemType != 0)
		{
			var item;
			switch (_type)
			{
				case 0 :
					item = new com.rockstargames.PauseMenu.items.BasicTabItem(this.scrollableContent, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					break;
				case 1 :
					item = new com.rockstargames.PauseMenu.items.StatsTabItem(this.scrollableContent, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					break;
				case 2 :
					item = new com.rockstargames.PauseMenu.items.SettingsTabItem(this.scrollableContent, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					item.itemMC.attachMovie("mouseCatcher","mouseCatcher",item.itemMC.getNextHighestDepth(),{_width:item.itemMC._width, _height:item.itemMC._height});
					item.itemMC.mouseCatcher.setupGenericMouseInterface(this.ItemList.length,2,this.onMouseEvent,[item, this, 2]);
					break;
				case 3 :
					item = new com.rockstargames.PauseMenu.items.KeymapItem(this.rightMenuUp, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10);
					break;
			}
			this.ItemList.push(item);
			this.updateItemsHeight();
			//this.scrollToBottom();
		}
	}

	function updateItemsHeight()
	{
		var _th = (this._title == undefined) ? (this.itemType == 2 || this.itemType == 3) ? 0 : 5 : this._title.itemMC._y + this._title.itemMC.bgMC._height;
		for (var it in this.ItemList)
		{
			var oldItemY = (it > 0) ? this.ItemList[it - 1].itemMC._y : 0;
			var oldItemH = (it > 0) ? this.ItemList[it - 1].itemMC._height : 0;
			if (it == 0)
			{
				this.ItemList[it].itemMC._y = (_th > 0) ? _th + 2 : _th;
				if (this.itemType == 4)
				{
					this.ItemList[it].itemMC._y = this.rightMenuUp.bgMC._y;
				}
			}
			else
			{
				this.ItemList[it].itemMC._y = oldItemH + oldItemY;
				if (this.itemType == 4)
				{
					this.ItemList[it].itemMC._y = this.ItemList[it].itemMC._y + 2;
				}
			}
		}
		this.viewHeight = this.ItemList[this.ItemList.length - 1].itemMC._y + this.ItemList[this.ItemList.length - 1].itemMC.bgMC._height;
		if (this.itemType != 0 || this.itemType != 1 || this.itemType != 4)
		{
			this.rightMenuUp.bgMC._height = (this.viewHeight < this.viewMaskHeight) ? this.viewHeight : this.viewMaskHeight;
		}
		if (this.itemType == 4)
		{
			this.rightMenuUp.bgMC._height = this.viewHeight - (this._title == undefined ? 0 : 27);
		}
	}

	function scrollToBottom()
	{
		if (this.itemType != 4)
		{
			if (this.viewHeight > this.viewMaskHeight)
			{
				this.scrollableContent._y = -(this.viewHeight - this.viewMaskHeight);
			}
		}
	}

	function onMouseEvent(evtType, targetMC, args)
	{
		var item = args[0];
		var leftItem = args[1];
		var parentTab = leftItem.parentTab;
		if (!parentTab.focused)
		{
			if (args[2] == 1)
			{
				item.mOut();
			}
			else if (args[2] == 2)
			{
				item.mOutItem();
			}
			return;
		}

		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				if (args[2] == 1)
				{
					if (item._type == 6)
					{
						if (item.jumpable)
						{
							return;
						}
					}
					item.mOver();
				}
				else if (args[2] == 2)
				{
					item.mOverItem();
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				if (args[2] == 1)
				{
					item.mOut();
				}
				else if (args[2] == 2)
				{
					item.mOutItem();
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				item.mOut();
				break;
		}
	}

	function mOverRB()
	{
		this.rightBodyHovered = true;
	}
	function mOutRB()
	{
		this.rightBodyHovered = false;
	}

	function set isVisible(_v)
	{
		this._isvisible = _v;
		this.leftItem.isVisible = _v;
		if (this.itemType != 0)
		{
			this.rightMenuUp._visible = _v;
			this._title.itemMC._visible = _v;
			for (var it in this.ItemList)
			{
				this.ItemList[it].isVisible = _v;
			}
		}
		this.updateItemsHeight();
	}

	function get isVisible()
	{
		return this._isvisible;
	}

	function set Selected(_v)
	{
		this._selected = _v;
		this.leftItem.highlighted = _v;
		if (this.itemType != 0)
		{
			this.rightMenuUp._visible = _v;
			this._title.itemMC._visible = _v;
			for (var it in this.ItemList)
			{
				this.ItemList[it].isVisible = _v;
			}
			this.footerMC._visible = (_v && (this.viewHeight > this.viewMaskHeight));
		}
	}
	function get Selected()
	{
		return this._selected;
	}

	function set focused(_f)
	{
		this.leftItem.itemMC._alpha = _f ? 100 : 60;
		if (this.itemType != 0)
		{
			this.rightMenuUp._alpha = _f ? 100 : 60;
			this._title.itemMC._alpha = _f ? 100 : 60;
			for (var it in this.ItemList)
			{
				this.ItemList[it]._alpha = _f ? 100 : 60;
			}
		}
	}

	function get panelHovered():Boolean
	{
		return this.rightBodyHovered;
	}

	function set highlighted(_h)
	{
		this.leftItem.highlighted = _h;
	}

	function get highlighted()
	{
		return this.leftItem.highlighted;
	}

	function scrollAll(targetIndex, tween)
	{
		if (tween == undefined)
		{
			tween = true;
		}

		if (this.viewHeight > this.viewMaskHeight)
		{
			var _loc2_ = this.scrollableContent._y;
			switch (targetIndex)
			{
				case 1 :
					_loc2_ = this.scrollableContent._y - 27;
					if (_loc2_ <= -(this.viewHeight - this.viewMaskHeight))
					{
						_loc2_ = -(this.viewHeight - this.viewMaskHeight);
					}
					break;
				case -1 :
					_loc2_ = this.scrollableContent._y + 27;
					if (_loc2_ >= 0)
					{
						_loc2_ = 0;
					}
					break;
			}
			if (tween)
			{
				com.rockstargames.ui.tweenStar.TweenStarLite.to(this.scrollableContent,this.SCROLL_DURATION,{_y:_loc2_, ease:com.rockstargames.ui.tweenStar.Ease.LINEAR});
			}
			else
			{
				this.scrollableContent._y = _loc2_;
			}
		}
	}

	function updateItemList()
	{

		for (var it in this.ItemList)
		{
			this.ItemList[it].highlighted = (com.rockstargames.PauseMenu.TabView.FOCUS_LEVEL == 2) ? (it == this.currentSelection) : false;
		}
	}

	function set currentSelection(i)
	{
		if (this.itemType == 3)
		{
			this._selectedIndex = i;
			if (this._selectedIndex < 0)
			{
				this._selectedIndex += this.ItemList.length;
			}
			if (this._selectedIndex > this.ItemList.length - 1)
			{
				this._selectedIndex -= this.ItemList.length;
			}
			this.updateItemList();
		}
	}

	function get currentSelection()
	{
		if (this.itemType == 3)
		{
			return this._selectedIndex;
		}
		return undefined;
	}

	function get currentItem()
	{
		if (this.itemType == 3)
		{
			return this.ItemList[this.currentSelection];
		}
		return undefined;
	}

	function set Label(_l)
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.leftItem.leftTextTF,_l,false);
		this.leftItem.refreshLabelFonts();
		this.leftItem.updateLabelWidth();
	}

	function set RightLabel(_l)
	{
		this.leftItem.SetRightText(_l);
	}

	function SetLeftBadge(i)
	{
		this.leftItem.SetLeftBadge(i);
	}

	function SetRightBadge(i)
	{
		this.leftItem.SetRightBadge(i);
	}

	function set Enabled(e)
	{
		this.leftItem.Enabled = e;
	}

	function get Enabled()
	{
		return this.leftItem.Enabled;
	}
}