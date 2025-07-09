class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionModel extends com.rockstargames.ui.components.GUIModel
{
	function PauseMenuVehicleSelectionModel()
	{
		super();
	}

	function createView(_viewIndex, _params)
	{
		var _loc2_ = this.viewList[_viewIndex];
		if (_loc2_ == undefined)
		{
			_loc2_ = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView();
		}
		_loc2_.viewIndex = _viewIndex;
		_loc2_.params = _params;
		this.viewList[_viewIndex] = _loc2_;
	}
}