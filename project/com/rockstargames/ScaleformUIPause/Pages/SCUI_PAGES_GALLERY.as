class com.rockstargames.ScaleformUIPause.Pages.SCUI_PAGES_GALLERY extends com.rockstargames.gtav.pauseMenuPages.PauseMenuBasePage
{
	var column1;
	function SCUI_PAGES_GALLERY()
	{
		super();
	}
	function INITIALISE(mc)
	{
		this.timelineMC = mc;
		this.columnList = new Array();
		this.setupPage();
		this.stateChanged(0);
	}
	function setupPage()
	{
		super.setupPage();
		this.column1 = this.addColumn("spGallery", 1, 0);
		this.setupColumns(this.column1);
		this.setupColFooterScroll([this.column1],[this.footerScrollOverride]);
	}
	function stateChanged(id)
	{
		super.stateChanged(id);
		this.columnList = [this.column1];
		this.showColumns();
	}
	function onPageExit()
	{
		this.column1.ON_DESTROY();
	}
}