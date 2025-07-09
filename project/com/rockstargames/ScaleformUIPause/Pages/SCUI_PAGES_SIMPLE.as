class com.rockstargames.ScaleformUIPause.Pages.SCUI_PAGES_SIMPLE extends com.rockstargames.gtav.pauseMenuPages.PauseMenuBasePage
{
	var column0;
	public function SCUI_PAGES_SIMPLE()
	{
		super();
	}

	function setupPage()
	{
		super.setupPage();
		this.column0 = this.addColumn("simpleHelpList", 1, 0);
		this.setupColumns(this.column0);
		this.column0.canWheelScroll = true;
		this.column0.footerScrollOverrideIndex = this.footerScrollOverride;
	}

	function stateChanged(id)
	{
		super.stateChanged(id);
		this.columnList = [this.column0];
		this.showColumns();
	}
}