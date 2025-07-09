class com.rockstargames.ScaleformUIPause.pauseComponents.PAUSE_MENU_VEHICLE_SELECTION extends com.rockstargames.gtav.pauseMenu.pauseComponents.PauseMenuComponentBase
{
	var containerMC;
	var maxGridItems;
	var scrollMask;
	function PAUSE_MENU_VEHICLE_SELECTION()
	{
		super();
		this.dbgID = "PAUSE_MENU_VEHICLE_SELECTION";
		this.scrollMask._visible = false;
	}

	function INITIALISE(mc)
	{
		if (mc != undefined)
		{
			super.INITIALISE(mc);
		}
		else
		{
			this.CONTENT = this;
		}
		this.containerMC = this.CONTENT.createEmptyMovieClip("containerMC", this.getNextHighestDepth());
		this.containerMC.setMask(this.scrollMask);
		this.model = new com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionModel();
		this.model.createView(0,{id:0, x:0, y:0, rowSpacing:2, columnSpacing:2, batchCols:3, batchRows:3, batchW:288, batchH:142, container:this.containerMC, linkage:["vehicleItem"], visibleItems:9, maskHeight:430, selectstyle:com.rockstargames.ui.components.GUIView.FOCUS_SELECTSTYLE});
		this.CONTENT.bgMC._alpha = 0;// to be tested with and without
		//com.rockstargames.ui.utils.Colour.ApplyHudColour(this.CONTENT.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.CONTENT.bgMC.onRollOver = this.rollOver;
		this.CONTENT.bgMC.onRollOut = this.rollOut;
		this.CONTENT.bgMC.onDragOut = this.rollOut;
	}
	function rollOver()
	{
		_level0.TIMELINE.MOUSE_COLUMN_SHIFT(1);
	}
	function rollOut()
	{
		_level0.TIMELINE.MOUSE_COLUMN_SHIFT(0);
	}
	function SET_HIGHLIGHT(highlightIndex, staticClear)
	{
		var _loc3_ = com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView(this.model.getCurrentView());
		_loc3_.index = highlightIndex;
	}
	function SET_INPUT_EVENT(direction)
	{
		switch (direction)
		{
			case com.rockstargames.ui.game.GamePadConstants.DPADUP :
				com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView(this.model.getCurrentView()).moveVert(-1);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADRIGHT :
				com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView(this.model.getCurrentView()).moveHorz(1);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADDOWN :
				com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView(this.model.getCurrentView()).moveVert(1);
				break;
			case com.rockstargames.ui.game.GamePadConstants.DPADLEFT :
				com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView(this.model.getCurrentView()).moveHorz(-1);
		}
	}

	function UPDATE_DATA_SLOT(_viewIndex, _slotIndex)
	{
		var _loc3_ = arguments;
		this.model.updateSlot(0,_viewIndex,_loc3_);
	}

	function SCROLL_DIR()
	{
		var dir = arguments[0];
		com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuVehicleSelectionView(this.model.getCurrentView()).scrollContainer(dir);
	}
}