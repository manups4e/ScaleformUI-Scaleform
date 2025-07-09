class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuSimpleModel extends com.rockstargames.ui.components.GUIModel
{
	function PauseMenuSimpleModel()
	{
		super();
	}
	function createView(_viewIndex, _params)
	{
		var _loc2_ = this.viewList[_viewIndex];
		if (_loc2_ == undefined)
		{
			_loc2_ = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuSimpleView();
		}
		_loc2_.viewIndex = _viewIndex;
		_loc2_.params = _params;
		this.viewList[_viewIndex] = _loc2_;
	}

	function addTitleToView(_viewIndex, _slotIndex, _dataArray)
	{
		var __reg2 = this.getCurrentView(_viewIndex);
		__reg2.dataList.splice(_slotIndex,0,args);
		__reg2.addDisplayItemOnce(_itemIndex,_dataArray);
	}

	function removeDataFromSlot(_viewIndex, _slotIndex)
	{
		var _loc2_ = this.viewList[_viewIndex];
		_loc2_.destroy();
		this.viewIndex = 0;
	}
}