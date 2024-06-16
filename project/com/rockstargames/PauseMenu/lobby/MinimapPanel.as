class com.rockstargames.PauseMenu.lobby.MinimapPanel
{
	var itemMC;
	var imgLdr;
	var defaultPlaceholderA;
	var _mainMC;
	var listDescItem;
	var parentMC;
	var panelTitle;
	var panelTitleColour;
	var BannerTitle;
	var descItems = [];
	var titleFreemode;
	var _titleType;
	var type = "minimap";
	var OFFSET;

	function MinimapPanel(parent, offset, panelTitle, panelColour, txd, txn)
	{
		this.OFFSET = offset;
		this.parentMC = parent;
		this._mainMC = parent.CONTENT;
		this.itemMC = this._mainMC.attachMovie("freemodeMap", "c"+this._mainMC.getNextHighestDepth()+"MC" , this._mainMC.getNextHighestDepth());
		this.itemMC._x = this.OFFSET;
		var minimap = com.rockstargames.gtav.pauseMenu.pauseComponents.PauseMenuComponentBase(this.itemMC);
		minimap.INITIALISE();
		minimap.SET_FOCUS(true);
		minimap.columnID = 1;
		minimap._visible = true;
        com.rockstargames.ui.game.GameInterface.call("CALL_METHOD_ON_MOVIE",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"MINIMAP","SET_MASK",[minimap]);
	}

	function set isVisible(_v)
	{
		this.itemMC._visible = _v;
	}
	function get isVisible()
	{
		return this.itemMC._visible;
	}

	function Clear()
	{
		this.itemMC.removeMovieClip();
	}
}