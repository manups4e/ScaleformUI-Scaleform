class com.rockstargames.PauseMenu.tabs.InfoTab extends com.rockstargames.PauseMenu.tabs.BaseTab
{
	var _title;
	var _selected = 0;
	var _selectedItem;
	function InfoTab(mc, val)
	{
		super(mc,val);
	}

	function AddLeftItemToList(str, rightType, enabled, param1, param2, param3, param4)
	{
		var item = new com.rockstargames.PauseMenu.tabs.TabLeftItem(this, str, rightType, enabled, param1, param2, param3, param4);
		item.leftItem.itemMC._y = this.LeftItemList.length * 27;
		this.LeftItemList.push(item);
		this.updateItems();
	}

	function AddTitle(it, txt, param2, param3)
	{
		this.LeftItemList[it].AddTitle(txt,param2,param3);
	}

	function AddItem(it, _type, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		this.LeftItemList[it].AddItem(_type,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
	}

	function updateItems()
	{
		for (var item in this.LeftItemList)
		{
			this.LeftItemList[item].Selected = this.isVisible ? this.LeftItemList[item].Enabled ? (item == this.currentSelection) : false : false;
			this.LeftItemList[item].highlighted = this.focused ? this.LeftItemList[item].Enabled ? (item == this.currentSelection) : false : false;
			this.LeftItemList[item].updateItemList();
			if (this.LeftItemList[item].itemType == 2)
			{
				var list = this.LeftItemList[item].ItemList;
				for (var it in list)
				{
					var _loc3_ = new com.rockstargames.ui.utils.HudColour();
					com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,_loc3_);
					if (it % 2 == 1)
					{
						list[it].bgA = 20;
					}
					else
					{
						list[it].bgA = 0;
					}
					com.rockstargames.ui.utils.Colour.Colourise(list[it].itemMC.bgMC,_loc3_.r,_loc3_.g,_loc3_.b,list[it].bgA);
				}
			}
		}
	}

	function set isVisible(_v)
	{
		super.isVisible = _v;
		if (this.LeftItemList.length > 0)
		{
			for (var it in this.LeftItemList)
			{
				this.LeftItemList[it].isVisible = _v;
			}
		}
		if (_v)
		{
			this.updateItems();
		}
	}

	function set focused(_f)
	{
		super.focused = _f;
		if (this.LeftItemList.length > 0)
		{
			for (var it in this.LeftItemList)
			{
				this.LeftItemList[it].focused = _f;
			}
		}
		this.updateItems();
	}

	function get focused()
	{
		return super.focused;
	}

	function set currentSelection(val)
	{
		this._selected = val;
		if (this._selected > this.LeftItemList.length - 1)
		{
			this._selected -= this.LeftItemList.length;
		}
		if (this._selected < 0)
		{
			this._selected += this.LeftItemList.length;
		}
		this.updateItems();
	}

	function get currentSelection()
	{
		return this._selected;
	}

	function get currentItem()
	{
		return this.LeftItemList[this._selected];
	}
}