class com.rockstargames.ScaleformUI.UIMenuModel extends com.rockstargames.ui.components.GUIModel
{
   function UIMenuModel()
   {
      super();
   }
   function createView(_viewIndex, _params)
   {
      var _loc2_ = this.viewList[_viewIndex];
      if(_loc2_ == undefined)
      {
         _loc2_ = new com.rockstargames.ScaleformUI.UIMenuView();
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
   function addDataToViewSplice(_viewIndex, _itemIndex, _dataArray)
   {
      var _loc2_ = this.viewList[_viewIndex];
      _loc2_.addItemSplice(_itemIndex,_dataArray);
   }
   function displayPanels(mc, h)
   {
      this.getCurrentView().panelY = h;
      this.viewList[0].displayPanels(mc);
   }
   function AddPanelToView(_slotIndex, _dataArray)
   {
      this.getCurrentView().addPanel(_slotIndex,_dataArray);
   }
   function UpdatePanelToSlot(_itemIndex, _dataArray)
   {
      this.AddPanelToView(_itemIndex,_dataArray);
      var _loc2_ = this.getCurrentView(0);
      _loc2_.panelItemList[_itemIndex].data = _dataArray;
   }
   function AddSidePanelToView(_dataArray)
   {
      this.getCurrentView().addSidePanel(_dataArray);
   }
   function UpdateSidePanelToSlot(_dataArray)
   {
      this.AddSidePanelToView(_dataArray);
      var _loc2_ = this.getCurrentView(0);
      _loc2_.sidePanelItem.data = _dataArray;
   }
   function SetExtraSidePanelData(index, _dataArray)
   {
      var _loc2_ = this.getCurrentView(0);
      _loc2_.ExtraSidePanelData.push(_dataArray);
   }
   function displaySidePanel(mc, _off, orient)
   {
      this.viewList[0].displaySidePanel(mc,_off,orient);
   }
   function AddWindowToView(slotIndex, _dataArray)
   {
      this.getCurrentView().addWindow(slotIndex,_dataArray);
   }
   function SetExtraWindowDataSlot(winIndex, slotIndex, _dataArray)
   {
      var _loc2_ = this.getCurrentView(0);
      _loc2_.extraWindowDataList[winIndex][slotIndex] = _dataArray;
      if(_loc2_.windowsList[winIndex] != undefined)
      {
         _loc2_.windowsList[winIndex].extraData = _loc2_.extraWindowDataList[winIndex];
      }
   }
   function UpdateWindowSlot(slotIndex, _dataArray)
   {
      this.AddWindowToView(slotIndex,_dataArray);
      var _loc2_ = this.getCurrentView(0);
      _loc2_.windowsList[slotIndex].data = _dataArray;
   }
   function ShowWindows(mc)
   {
      this.viewList[0].displayWindows(mc);
   }
   function nextItem()
   {
      var _loc2_ = this.getCurrentView();
      do
      {
         var _loc3_ = _loc2_.index + 1;
         if(_loc3_ > _loc2_.maxitems - 1)
         {
            _loc3_ = 0;
         }
         this.setItem(_loc2_,_loc3_);
      }
      while(_loc2_.itemList[_loc2_.highlightedItem].type == 6 && _loc2_.itemList[_loc2_.highlightedItem].jumpable);
      
   }
   function prevItem()
   {
      var _loc2_ = this.getCurrentView();
      do
      {
         var _loc3_ = _loc2_.index - 1;
         if(_loc3_ < 0)
         {
            _loc3_ = _loc2_.maxitems - 1;
         }
         this.setItem(_loc2_,_loc3_);
      }
      while(_loc2_.itemList[_loc2_.highlightedItem].type == 6 && _loc2_.itemList[_loc2_.highlightedItem].jumpable);
      
   }
}
