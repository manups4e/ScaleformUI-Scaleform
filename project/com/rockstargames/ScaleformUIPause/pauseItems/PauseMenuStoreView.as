class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuStoreView extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuViewBase
{
	function PauseMenuStoreView()
	{
		super();
	}

	function addDisplayItem(i, _dataArray)
	{
		var _loc4_ = this.viewLinkageList[0];
		var _loc2_ = this.viewContainer.attachMovie(_loc4_, _loc4_ + i + "MC", i);
		_loc2_._y = this.itemY;
		var _loc3_ = com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuStoreItem(_loc2_);
		_loc3_.setView(this);
		_loc3_.data = _dataArray;
		this.itemList[i] = _loc3_;
		this.itemY += _loc2_.itemHilite._height + this.rowSpacing;
	}

	function scrollHighlightStyle(targetIndex)
	{
		targetIndex = Math.max(0, Math.min(targetIndex, this.dataList.length - 1));
		var _loc2_ = 0;
		var _loc6_ = 0;
		if (targetIndex > this.topEdge + this.visibleItems - 1)
		{
			_loc6_ += targetIndex - (this.visibleItems - 1);
			this.topEdge = _loc6_;
			targetIndex = this.visibleItems - 1;
		}
		else if (targetIndex < this.topEdge)
		{
			_loc6_ = targetIndex;
			this.topEdge = _loc6_;
			targetIndex = 0;
		}
		else
		{
			_loc6_ = this.topEdge;
			targetIndex -= this.topEdge;
		}
		var _loc3_ = undefined;
		var _loc4_ = undefined;
		_loc2_ = 0;
		while (_loc2_ < this.itemList.length)
		{
			_loc3_ = this.itemList[_loc2_];
			_loc3_.data = this.dataList[_loc6_ + _loc2_];
			_loc4_ = targetIndex == _loc2_;
			if (_loc3_.highlighted != _loc4_)
			{
				_loc3_.highlighted = _loc4_;
			}
			_loc2_ = _loc2_ + 1;
		}
		this.highlightedItem = targetIndex;
	}
}