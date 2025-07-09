class com.rockstargames.ScaleformUI.UIMenuView extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuViewBase
{
	var panelDataList;
	var panelItemList;
	var panelY;
	var sidePanelData;
	var ExtraSidePanelData;
	var windowsDataList;
	var extraWindowDataList;
	var windowsList;
	var windowY;
	var viewContainer;
	var sidePanelItem;
	function UIMenuView()
	{
		super();
		this.panelDataList = [];
		this.panelItemList = [];
		this.panelY = 0;
		this.sidePanelData = [];
		this.ExtraSidePanelData = [];
		this.windowsDataList = [];
		this.extraWindowDataList = [];
		this.windowsList = [];
		this.windowY = 0;
	}
	function addDisplayItem(i, _dataArray)
	{
		var _loc4_ = this.viewLinkageList[0];
		var _loc2_ = this.viewContainer.attachMovie(_loc4_, _loc4_ + i + "MC", i);
		_loc2_._y = this.itemY;
		var _loc3_ = com.rockstargames.ScaleformUI.items.UIMenuItem(_loc2_);
		_loc3_.data = _dataArray;
		this.itemList[i] = _loc3_;
		this.itemY += _loc2_.bgMC._height + this.rowSpacing;
	}
	function addItemSplice(i, _dataArray)
	{
		this.dataList.splice(i,0,_dataArray);
	}
	function addWindow(slotIndex, _dataArray)
	{
		this.windowsDataList[slotIndex] = _dataArray;
		this.extraWindowDataList[slotIndex] = new Array();
	}
	function displayWindows(menu)
	{
		var _loc2_ = 0;
		while (_loc2_ < this.windowsDataList.length)
		{
			this.addDisplayWindow(menu,_loc2_,this.windowsDataList[_loc2_]);
			_loc2_ += 1;
		}
	}
	function addDisplayWindow(mc, i, _dataArray)
	{
		var _loc2_ = undefined;
		switch (_dataArray[1])
		{
			case 0 :
				_loc2_ = mc.attachMovie("UIMenuHeritageWindow", "heritage_" + i, mc.getNextHighestDepth());
				break;
			case 1 :
				_loc2_ = mc.attachMovie("UIMenuDetailsWindow", "details_" + i, mc.getNextHighestDepth());
		}
		_loc2_.data = _dataArray;
		_loc2_.extraData = this.extraWindowDataList[i];
		_loc2_._y = this.windowY;
		this.windowY = this.windowY + _loc2_._height + 1;
		this.windowsList[i] = _loc2_;
	}
	function addSidePanel(_dataArray)
	{
		this.sidePanelData = _dataArray;
	}
	function displaySidePanel(mc, _menuOff, Orientation)
	{
		var _loc2_ = undefined;
		switch (this.sidePanelData[1])
		{
			case 0 :
				_loc2_ = mc.attachMovie("SideMissionPanel", "SideMissionPanelSide", mc.getNextHighestDepth());
				break;
			case 1 :
				_loc2_ = mc.attachMovie("colourPickerSide", "ColourPickerSide", mc.getNextHighestDepth());
		}
		_loc2_.data = this.sidePanelData;
		_loc2_.ExtraData = this.ExtraSidePanelData;
		_loc2_._y = 0;
		if (_loc2_._titleType == 2)
		{
			_loc2_._y -= 65;
		}
		if (_loc2_.LeftRightSide == 0)
		{
			var _loc4_ = 0 - _loc2_._width - 1;
			if (mc._x - 289 < _menuOff[0])
			{
				_loc4_ = 289;
			}
			_loc2_._x = _loc4_;
		}
		else if (_loc2_.LeftRightSide == 1)
		{
			_loc4_ = 289;
			if (mc._x + 288 + 289 > _menuOff[2] - _loc2_._width - 1)
			{
				_loc4_ = 0 - _loc2_._width - 1;
			}
			_loc2_._x = _loc4_;
		}
		else if (_loc2_.LeftRightSide == 2)
		{
			_loc2_._x = Orientation != 0 ? _menuOff[0] : _menuOff[2];
		}
		this.sidePanelItem = _loc2_;
	}
	function addPanel(i, _dataArray)
	{
		this.panelDataList[i] = _dataArray;
	}
	function displayPanels(mc)
	{
		var _loc2_ = 0;
		while (_loc2_ < this.panelDataList.length)
		{
			this.addDisplayPanel(mc,_loc2_,this.panelDataList[_loc2_]);
			_loc2_ += 1;
		}
	}
	function addDisplayPanel(mc, i, _dataArray)
	{
		Debug.Debug.Log("DYSPLAYING PANEL - " + arguments);
		var _loc3_ = undefined;
		switch (_dataArray[2])
		{
			case 0 :
				_loc3_ = mc.attachMovie("UIMenuColorPanel", "colorPanel_" + i, mc.getNextHighestDepth());
				break;
			case 1 :
				_loc3_ = mc.attachMovie("UIMenuPercentagePanel", "percentagePanel_" + i, mc.getNextHighestDepth());
				break;
			case 2 :
				_loc3_ = mc.attachMovie("UIMenuGridPanel", "gridPanel_" + i, mc.getNextHighestDepth());
				break;
			case 3 :
				_loc3_ = mc.attachMovie("UIMenuStatsPanel", "statsPanel_" + i, mc.getNextHighestDepth());
				break;
			case 4 :
				_loc3_ = mc.attachMovie("ColourPicker", "colourPicker_" + i, mc.getNextHighestDepth());
		}
		_loc3_._y = this.panelY;
		_loc3_.data = _dataArray;
		this.panelItemList[i] = _loc3_;
		this.panelY = this.panelY + _loc3_._height + 1;
	}
	function scrollHighlightStyle(targetIndex)
	{
		targetIndex = Math.max(0, Math.min(targetIndex, this.dataList.length - 1));
		var _loc2_ = 0;
		var _loc4_ = 0;
		if (targetIndex > this.topEdge + this.visibleItems - 1)
		{
			_loc4_ = _loc4_ + (targetIndex - (this.visibleItems - 1));
			this.topEdge = _loc4_;
			targetIndex = this.visibleItems - 1;
		}
		else if (targetIndex < this.topEdge)
		{
			_loc4_ = targetIndex;
			this.topEdge = _loc4_;
			targetIndex = 0;
		}
		else
		{
			_loc4_ = this.topEdge;
			targetIndex = targetIndex - this.topEdge;
		}
		_loc2_ = 0;
        this.itemY = 0;
		while (_loc2_ < this.itemList.length)
		{
			this.itemList[_loc2_].data = this.dataList[_loc4_ + _loc2_];
			this.itemList[_loc2_].highlighted = targetIndex == _loc2_;
            this.itemList[_loc2_]._y = this.itemY;
            this.itemY += this.itemList[_loc2_].bgMC._height + this.rowSpacing;
			_loc2_ = _loc2_ + 1;
		}
		this.highlightedItem = targetIndex;
	}
	function destroyPanels()
	{
		for (var _loc2_ in this.panelItemList)
		{
			this.panelItemList[_loc2_].removeMovieClip();
		}
		this.panelDataList = [];
		this.panelItemList = [];
	}
	function destroySidePanel()
	{
		this.sidePanelItem.removeMovieClip();
		this.sidePanelData = [];
		this.ExtraSidePanelData = [];
	}
	function destroyWindows()
	{
		for (var _loc2_ in this.windowsList)
		{
			this.windowsList[_loc2_].removeMovieClip();
		}
		this.windowsList = [];
		this.windowsDataList = [];
		this.extraWindowDataList = [];
		this.windowY = 0;
	}
	function destroy()
	{
		var _loc2_ = 0;
		while (_loc2_ < this.itemList.length)
		{
			this.itemList[_loc2_].removeMovieClip();
			_loc2_ += 1;
		}
		this.itemList = [];
		this.dataList = [];
		this.itemY = 0;
	}
}