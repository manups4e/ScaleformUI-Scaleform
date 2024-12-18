class com.rockstargames.PauseMenu.tabs.VehicleSelectionTab extends com.rockstargames.PauseMenu.tabs.BaseTab
{
	var _title;
	var ItemList;
	var scrollableContent;
	var viewHeight = 0;
	var viewMaskHeight = 430;
	var itemType;
	var rightBodyHovered = false;
	var SCROLL_DURATION = 0.1;
	var SCROLL_DY = 28.66;
	var itemHeight = 141.33333;
	var pictureTxd;
	var currentHover;
	var currentSelected;
	var visibleRowTop = 0;
	var visibleRowBot = 2;
	var scrollBase = undefined;
	var currentSelection;
	var HALF_ITEM = 141.333333 / 2;

	function VehicleSelectionTab(mc, m)
	{
		super(mc,m);
		this.rightItemUpMC = this._MC.attachMovie("pauseMenuWholeBody", "Whole_body_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		this.rightItemUpMC.bgMC._visible = false;
		this.rightItemUpMC.textMC._visible = false;
		this.scrollableContent = this.rightItemUpMC.createEmptyMovieClip("viewContainer", this.rightItemUpMC.getNextHighestDepth());
		this.rightItemUpMC.setMask(this.rightItemUpMC.maskMC);
		this.ItemList = new Array();
		this.rightBodyHovered = false;
		this.SetScrollBarArrows(true,3,0,2,true);
		this.currentSelected = 0;
	}



	function mOverST()
	{
		this.rightBodyHovered = true;
	}
	function mOutST()
	{
		this.rightBodyHovered = false;
	}

	function SetItemChecked(item, bool)
	{
		this.ItemList[item].SetSelection(bool);
	}

	function AddItem(_type, model, modelString, vehicleName, txd, txn, makeTxd, makeTxn, perfTxd, perfClass, bgTxd, bgTxn, isPesonal, className, locked, param15)
	{
		var item;
		switch (_type)
		{
			case 0 :
				item = new com.rockstargames.PauseMenu.items.VehicleItem(this, this.ItemList.length, model, modelString, vehicleName, txd, txn, makeTxd, makeTxn, perfTxd, perfClass, bgTxd, bgTxn, isPesonal, className, locked, param15);
				break;
		}
		this.ItemList.push(item);
		this.RefreshItems();
		this._MC.scrollBase.updateScroll();
	}

	function RefreshItems()
	{
		for (var i in this.ItemList)
		{
			var item = this.ItemList[i];
			var x = (i % 3) * 290 + 144;
			var y = Math.floor(i / 3) * 143.333333 + (141.333333 / 2);
			item.itemMC._x = x;
			item.itemMC._y = y;
			item.col = (i % 3);
			item.row = Math.floor(i / 3);
		}
		this.viewHeight = this.ItemList[this.ItemList.length - 1].itemMC._y + this.ItemList[this.ItemList.length - 1].itemMC.bgMC._height / 2 + 1;
		this._MC.scrollBase.updateScroll();
	}

	function HoverItem(idx)
	{
		this.currentSelected.Hovered = false;
		this.currentSelected = this.ItemList[idx];
		this.currentSelected.Hovered = true;
		var row = this.GetItemRow(idx);
		if (row < this.visibleRowTop)
		{
			this.visibleRowTop = row;
			this.visibleRowBot = row + 2;
		}
		else if (row > this.visibleRowBot)
		{
			this.visibleRowTop = row - 2;
			this.visibleRowBot = row;
		}
		this.scrollableContent._y = (-this.GetFirstItemAtRow(this.visibleRowTop)._y + this.HALF_ITEM);
		this._MC.scrollBase.updateScroll();
	}

	function SetIndex(idx)
	{
		if (this.ItemList[idx].Locked)
		{
			return;
		}
		this.currentSelected.Selected = false;
		this.currentSelected = this.ItemList[idx];
		this.currentSelected.Selected = true;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.currentSelected.itemMC,0.1,{_xscale:95, _yscale:95, onCompleteScope:this, onComplete:this.finishSelect});
		this._MC.scrollBase.updateScroll();
	}

	function finishSelect()
	{
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.currentSelected.itemMC,0.1,{_xscale:100, _yscale:100});
	}

	function GetItemColumn(idx)
	{
		return idx % 3;
	}

	function GetItemRow(idx)
	{
		return Math.floor(idx / 3);
	}

	function GetFirstItemAtRow(row)
	{
		for (var i in this.ItemList)
		{
			if (this.ItemList[i].row == row)
			{
				return this.ItemList[i].itemMC;
			}
		}
	}

	function scrollAll(targetIndex)
	{
		if (this.ItemList.length <= 9)
		{
			return;
		}
		var _loc2_ = this.scrollableContent._y;
		switch (targetIndex)
		{
			case 1 :
				_loc2_ = _loc2_ - this.SCROLL_DY;
				if (_loc2_ <= -(this.viewHeight - this.viewMaskHeight))
				{
					_loc2_ = -(this.viewHeight - this.viewMaskHeight);
				}
				break;
			case -1 :
				_loc2_ = _loc2_ + this.SCROLL_DY;
				if (_loc2_ >= 0)
				{
					_loc2_ = 0;
				}
				break;
		}
		this.scrollableContent._y = _loc2_;
		if (this.scrollableContent._y >= -1)
		{
			this.visibleRowTop = 0;
			this.visibleRowBot = 2;
			return;
		}
		// GO UP      
		if (this.scrollableContent._y > (-this.GetFirstItemAtRow(this.visibleRowTop)._y + this.HALF_ITEM))
		{
			if (this.scrollableContent._y >= (-this.GetFirstItemAtRow(this.visibleRowTop - 1)._y + this.HALF_ITEM))
			{
				this.visibleRowTop = this.visibleRowTop - 1;
				if (this.visibleRowTop < 0)
				{
					this.visibleRowTop = 0;
				}
				this.visibleRowBot = this.visibleRowTop + 2;
			}
		}
		else if (this.scrollableContent._y < (-this.GetFirstItemAtRow(this.visibleRowTop)._y + this.HALF_ITEM))
		{// GO DOWN
			if (this.scrollableContent._y <= (-this.GetFirstItemAtRow(this.visibleRowTop + 1)._y + this.HALF_ITEM))
			{
				this.visibleRowTop = this.visibleRowTop + 1;
				this.visibleRowBot = this.visibleRowTop + 2;
			}
		}
		Debug.Debug.Log("scrollY: " + this.scrollableContent._y + ", TopRow: " + this.visibleRowTop + ", RowBot: " + this.visibleRowBot);
	}

	function SetScrollBarArrows(visible, columns, scrollType, arrowPosition, override, xColOffset)
	{
		if (this.scrollBase == undefined)
		{
			this.scrollBase = this._MC.attachMovie("PM_ScrollBase", "scrollBase", this._MC.getNextHighestDepth());
		}
		if (!override)
		{
			this.scrollBase.setComponent(this);
		}
		this._MC.scrollBase.INIT_SCROLL_BAR(visible,columns,scrollType,arrowPosition,override,xColOffset);
		this._MC.scrollBase.updateScroll();
	}

	function SetScrollBar(currentPosition, maxPosition, maxVisible, caption, captionR)
	{
		if (this._MC.scrollBase != undefined)
		{
			this._MC.scrollBase.SET_SCROLL_BAR(currentPosition,maxPosition,maxVisible,caption,false,captionR);
		}
		this._MC.scrollBase.updateScroll();
	}
}