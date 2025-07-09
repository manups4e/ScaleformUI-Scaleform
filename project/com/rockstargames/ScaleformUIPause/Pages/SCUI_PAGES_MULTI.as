class com.rockstargames.ScaleformUIPause.Pages.SCUI_PAGES_MULTI extends com.rockstargames.gtav.pauseMenuPages.PauseMenuBasePage
{
	var columnsArray = ["verticalMenuList", "mpFriendsList", "missionList", "storeList", "SideMissionPanel", "mpPlayerModel"];
	var columnComparisonCard;
	var columnMPPlayerCard;
	public function SCUI_PAGES_MULTI()
	{
		super();
	}

	function setupPage()
	{
		super.setupPage();
		this.columnMPPlayerCard = this.addColumn("mpPlayerCard", 4, 580);
		this.columnComparisonCard = this.addColumn("playerComparisonCard", 5, 725);
		this.setupColumns();
	}

	function splitNumber(num)
	{
		var numberArray:Array = num.split("");
		for (var i:Number = 0; i < numberArray.length; i++)
		{
			numberArray[i] = parseInt(numberArray[i]);
		}
		return numberArray;
	}

	function stateChanged(id)
	{
		super.stateChanged(id);
		var ids = this.splitNumber(id);
		this.columnList = [];
		for (var i = 0; i < 3; i++)
		{
			this.columnList[i].removeMovieClip();
		}
		var column_1 = this.addColumn(this.columnsArray[ids[0]], 1, 0);
		var column_2 = this.addColumn(this.columnsArray[ids[1]], 2, 290);
		var column_3 = this.addColumn(this.columnsArray[ids[2]], 3, 580);
		this.setupColumns(column_1,column_2,column_3,this.columnMPPlayerCard,this.columnComparisonCard);
		this.setupColScroll([column_1, column_2, column_3],[true, true, true]);
		this.setupColMouseNav([column_1, column_2, column_3],[true, true, true]);
		this.setupColFooterScroll([column_1, column_2, column_3],[0, ids[1] == 5 ? this.footerScrollOverride : 1, ids[2] == 4 ? this.footerScrollOverride : 2]);
		this.columnList = [column_1, column_2, column_3, this.columnMPPlayerCard, this.columnComparisonCard];
		this.showColumns();
		this.columnMPPlayerCard.SHOW_COLUMN(false);
		this.columnComparisonCard.SHOW_COLUMN(false);
	}
}