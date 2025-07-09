class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuFriendsListModel extends com.rockstargames.ui.components.GUIModel
{
	function PauseMenuFriendsListModel()
	{
		super();
	}

	function createView(_viewIndex, _params)
	{
		var _loc2_ = this.viewList[_viewIndex];
		if (_loc2_ == undefined)
		{
			_loc2_ = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuFriendsListView();
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
	}
}