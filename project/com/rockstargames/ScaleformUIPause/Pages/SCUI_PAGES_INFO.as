class com.rockstargames.ScaleformUIPause.Pages.SCUI_PAGES_INFO extends com.rockstargames.gtav.pauseMenuPages.PauseMenuBasePage
{
	var column1;
	var column2;
	var column3;
	var column4;
	var column5;
	function SCUI_PAGES_INFO()
	{
		super();
	}

	function setupPage()
	{
		super.setupPage();
		this.column1 = this.addColumn("verticalMenuList", 1, 0);
		this.column2 = this.addColumn("missionHelpList", 2, 290);
		this.column3 = this.addColumn("statsList", 3, 290);
		this.column4 = this.addColumn("settingsList", 4, 290);
		this.column5 = this.addColumn("configurationList", 5, 290);
		this.setupColumns(this.column1,this.column2,this.column3,this.column4,this.column5);
		this.setupColScroll([this.column1, this.column2, this.column3, this.column4, this.column5],[true, true, true, true, true]);
		this.setupColMouseNav([this.column1, this.column2, this.column3, this.column4, this.column5],[true, true, true, true, true]);
		this.setupColFooterScroll([this.column1, this.column2, this.column3, this.column4, this.column5],[-1, this.footerScrollOverride, this.footerScrollOverride, this.footerScrollOverride, this.footerScrollOverride]);
	}

	function stateChanged(id)
	{
		super.stateChanged(id);
		switch (id)
		{
			case 1 :
				this.columnList = [this.column1, this.column2];
				break;
			case 2 :
				this.columnList = [this.column1, this.column3];
				break;
			case 3 :
				this.columnList = [this.column1, this.column4];
				break;
			case 4 :
				this.columnList = [this.column1, this.column5];
				break;
			default :
				this.columnList = [this.column1];
				this.column2.ON_DESTROY();
				this.column3.ON_DESTROY();
				this.column4.ON_DESTROY();
				this.column5.ON_DESTROY();
		}
		this.showColumns();
	}
}