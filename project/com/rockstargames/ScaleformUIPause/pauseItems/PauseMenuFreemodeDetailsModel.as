class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuFreemodeDetailsModel extends com.rockstargames.ui.components.GUIModel
{
	function PauseMenuFreemodeDetailsModel()
	{
		super();
	}
	function createView(_viewIndex, _params)
	{
		var _loc2_ = this.viewList[_viewIndex];
		if (_loc2_ == undefined)
		{
			_loc2_ = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuFreemodeDetailsView();
		}
		_loc2_.viewIndex = _viewIndex;
		_loc2_.params = _params;
		this.viewList[_viewIndex] = _loc2_;
	}
	function removeDataFromSlot(_viewIndex, _slotIndex)
	{
		var _loc2_ = this.viewList[_viewIndex];
		_loc2_.destroy();
		this.viewIndex = 0;
		var _loc3_ = this.getCurrentView();
	}

}