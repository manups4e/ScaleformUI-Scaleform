class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView extends com.rockstargames.ui.components.GUIView
{
	var batchW = 0;
	var batchH = 142;
	var batchCols = 3;
	var batchRows = 3;
	var SCROLL_DY = 27;
	var SCROLL_DURATION = 0.2;
	var topRowIndex;

	function PauseMenuVehicleSelectionView()
	{
		super();
	}
	function set params(_p)
	{
		super.params = _p;
		this.visibleItems = _p.visibleItems;
		this.batchCols = _p.batchCols;
		this.batchRows = _p.batchRows;
		this.batchW = _p.batchW;
		this.batchH = _p.batchH;
		this.topRowIndex = 0;
	}

	function addDisplayItem(i, _dataArray)
	{
		var _loc4_ = this.viewLinkageList[0];
		var _loc2_ = this.viewContainer[_loc4_ + i + "MC"];
		if (_loc2_ != undefined)
		{
			com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionItem(_loc2_).dispose();
		}
		_loc2_ = this.viewContainer.attachMovie(_loc4_, _loc4_ + i + "MC", i);
		var _loc7_ = i % this.batchCols * (this.batchW + this.rowSpacing);
		var _loc6_ = Math.floor(i / this.batchCols) * (this.batchH + this.columnSpacing);
		_loc2_._x = _loc7_;
		_loc2_._y = _loc6_;
		var _loc5_ = com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionItem(_loc2_);
		_loc5_.data = _dataArray;
		this.itemList[i] = _loc5_;
		this.itemY = this.itemY + (this.batchH + this.rowSpacing);
	}

	function moveHorz(dir)
	{
		this.index = this.index + dir;
	}
	function moveVert(dir)
	{
		var _loc2_ = this.index + dir * this.batchCols;
		if (_loc2_ < 0)
		{
			_loc2_ = _loc2_ + this.batchCols * this.batchRows;
		}
		if (_loc2_ >= this.batchCols * this.batchRows)
		{
			_loc2_ = _loc2_ - this.batchCols * this.batchRows;
		}
		this.index = _loc2_;
	}

	function focusHighlightStyle(targetIndex)
	{
		var _loc3_ = undefined;
		var _loc2_ = 0;
		var _loc4_ = 0;
		var _loc5_ = this.viewContainer._height;
		var _loc6_ = -_loc5_ + this.viewMaskHeight;

		if (this.viewContainer._height > this.viewMaskHeight)
		{
			var containerPos = this.viewContainer._y;
			var targetItem = this.itemList[targetIndex];
			var itemTop = targetItem._y;
			var itemBottom = itemTop + this.batchH;

			// Se item selezionato esce sotto dal viewMask
			if (itemBottom + containerPos > this.viewMaskHeight)
			{
				// Scrolla verso l'alto per renderlo visibile in basso
				containerPos = this.viewMaskHeight - itemBottom;
			}
			else if (itemTop + containerPos < 0)
			{// Se item selezionato esce sopra dal viewMask

				// Scrolla verso il basso per renderlo visibile in alto
				containerPos = -itemTop;
			}
			// Clampa la posizione 
			if (containerPos < _loc6_)
			{
				containerPos = _loc6_;
			}
			else if (containerPos > 0)
			{
				containerPos = 0;
			}
			this.viewContainer._y = containerPos;
		}

		while (_loc2_ < this.itemList.length)
		{
			_loc3_ = this.itemList[_loc2_];
			_loc3_.highlighted = _loc2_ == targetIndex;
			_loc2_ = _loc2_ + 1;
		}
		this.highlightedItem = targetIndex;
	}


	function scrollContainer(dir)
	{
		var _loc3_ = this.viewContainer._height;
		if (_loc3_ > this.viewMaskHeight)
		{
			var _loc2_ = this.viewContainer._y;
			_loc2_ = _loc2_ - this.SCROLL_DY * dir;
			var _loc5_ = -_loc3_ + this.viewMaskHeight;
			if (_loc2_ < _loc5_)
			{
				_loc2_ = _loc5_;
			}
			else if (_loc2_ > 0)
			{
				_loc2_ = 0;
			}
			this.viewContainer._y = _loc2_;
		}
	}

	function GetItemColumn(idx)
	{
		return idx % 3;
	}

	function GetItemRow(idx)
	{
		return Math.floor(idx / 3);
	}
}