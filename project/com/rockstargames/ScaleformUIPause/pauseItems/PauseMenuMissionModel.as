class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuMissionModel extends com.rockstargames.ui.components.GUIModel
{
	function PauseMenuMissionModel()
	{
		super();
	}
	function createView(_viewIndex, _params)
	{
		var _loc2_ = this.viewList[_viewIndex];
		if (_loc2_ == undefined)
		{
			_loc2_ = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuMissionView();
		}
		_loc2_.viewIndex = _viewIndex;
		_loc2_.params = _params;
		this.viewList[_viewIndex] = _loc2_;
	}
	function addDataToView(_viewIndex, _itemIndex, _dataArray)
	{
		var __reg2 = this.viewList[_viewIndex];
		__reg2.addItem(_itemIndex,_dataArray);
	}
	function updateSlot(_viewIndex, _itemIndex, _dataArray)
	{
		this.addDataToView(_viewIndex,_itemIndex,_dataArray);
		var __reg2 = this.getCurrentView(_viewIndex);
		var __reg3 = _itemIndex - __reg2.index + __reg2.highlightedItem;
		__reg2.itemList[__reg3].data = _dataArray;
	}
	function addSlot(_viewIndex, _itemIndex, _dataArray)
	{
		this.addDataToView(_viewIndex,_itemIndex,_dataArray);
		var __reg2 = this.getCurrentView(_viewIndex);
		__reg2.addDisplayItemOnce(_itemIndex,_dataArray);
	}
	function addDataToViewSplice(_viewIndex, _itemIndex, _dataArray)
	{
		var __reg2 = this.viewList[_viewIndex];
		__reg2.addItemSplice(_itemIndex,_dataArray);
	}
	function removeDataFromSlot(_viewIndex, _slotIndex)
	{
		var _loc2_ = this.viewList[_viewIndex];
		_loc2_.destroy();
		this.viewIndex = 0;
		var _loc3_ = this.getCurrentView();
	}
	function nextItem()
	{
		var __reg2 = this.getCurrentView();
		do
		{
			var __reg3 = __reg2.index + 1;
			if (__reg3 > __reg2.maxitems - 1)
			{
				__reg3 = 0;
			}
			this.setItem(__reg2,__reg3);
		} while (__reg2.itemList[__reg2.highlightedItem].type == 1 && __reg2.itemList[__reg2.highlightedItem].jumpable);
	}

	function prevItem()
	{
		var __reg2 = this.getCurrentView();
		do
		{
			var __reg3 = __reg2.index - 1;
			if (__reg3 < 0)
			{
				__reg3 = __reg2.maxitems - 1;
			}
			this.setItem(__reg2,__reg3);
		} while (__reg2.itemList[__reg2.highlightedItem].type == 1 && __reg2.itemList[__reg2.highlightedItem].jumpable);
	}
}