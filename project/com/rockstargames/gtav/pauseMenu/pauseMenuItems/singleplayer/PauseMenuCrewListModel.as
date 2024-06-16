class com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewListModel extends com.rockstargames.ui.components.GUIModel
{
   var menuItemStateIndex = 5;
   function PauseMenuCrewListModel()
   {
      super();
   }
   function createView(_viewIndex, _params)
   {
      var _loc2_ = this.viewList[_viewIndex];
      if(_loc2_ == undefined)
      {
         _loc2_ = new com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewListView();
      }
      _loc2_.viewIndex = _viewIndex;
      _loc2_.__set__params(_params);
      this.viewList[_viewIndex] = _loc2_;
   }
   function removeDataFromSlot(_viewIndex, _slotIndex)
   {
      var _loc2_ = this.viewList[_viewIndex];
      _loc2_.destroy();
      this.viewIndex = 0;
   }
   function nextItem()
   {
      var _loc3_ = (com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewListView)this.getCurrentView();
      var _loc7_ = 0;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.dataList.length)
      {
         var _loc2_ = _loc3_.__get__index() + 1 + _loc4_;
         if(_loc2_ > _loc3_.dataList.length - 1)
         {
            _loc2_ = _loc2_ - _loc3_.dataList.length;
         }
         var _loc6_ = _loc3_.dataList[_loc2_];
         var _loc5_ = _loc6_[this.menuItemStateIndex];
         if(_loc5_ == 1)
         {
            _loc7_ = _loc2_;
            break;
         }
         _loc4_ = _loc4_ + 1;
      }
      this.setItem(_loc3_,_loc7_);
   }
   function prevItem()
   {
      var _loc4_ = (com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewListView)this.getCurrentView();
      var _loc7_ = 0;
      var _loc3_ = 0;
      while(_loc3_ < _loc4_.dataList.length)
      {
         var _loc2_ = _loc4_.__get__index() - 1 - _loc3_;
         if(_loc2_ < 0)
         {
            _loc2_ = _loc4_.dataList.length + _loc2_;
         }
         var _loc6_ = _loc4_.dataList[_loc2_];
         var _loc5_ = _loc6_[this.menuItemStateIndex];
         if(_loc5_ == 1)
         {
            _loc7_ = _loc2_;
            break;
         }
         _loc3_ = _loc3_ + 1;
      }
      this.setItem(_loc4_,_loc7_);
   }
   function highlightNext()
   {
      var _loc3_ = (com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewListView)this.getCurrentView();
      var _loc7_ = 0;
      var _loc4_ = 0;
      while(_loc4_ < _loc3_.dataList.length)
      {
         var _loc2_ = _loc3_.__get__index() + _loc4_;
         if(_loc2_ > _loc3_.dataList.length - 1)
         {
            _loc2_ = _loc2_ - _loc3_.dataList.length;
         }
         var _loc6_ = _loc3_.dataList[_loc2_];
         var _loc5_ = _loc6_[this.menuItemStateIndex];
         if(_loc5_ == 1)
         {
            _loc7_ = _loc2_;
            break;
         }
         _loc4_ = _loc4_ + 1;
      }
      this.setItem(_loc3_,_loc7_);
   }
   function clearHighlight()
   {
      var _loc3_ = (com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewListView)this.getCurrentView();
      var _loc4_ = (com.rockstargames.gtav.pauseMenu.pauseMenuItems.singleplayer.PauseMenuCrewRanksView)_loc3_.__get__sidecarColumn();
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.itemList.length)
      {
         _loc3_.itemList[_loc2_].highlighted = false;
         _loc4_.itemList[_loc2_].highlighted = false;
         _loc2_ = _loc2_ + 1;
      }
   }
}
