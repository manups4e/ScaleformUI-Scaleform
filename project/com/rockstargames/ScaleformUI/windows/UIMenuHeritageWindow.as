class com.rockstargames.ScaleformUI.windows.UIMenuHeritageWindow extends MovieClip
{
	var _parentMenu;
	var momIdx;
	var dadIdx;
	var _background;
	var _momSprite;
	var _dadSprite;
	var momMC;
	var dadMC;
	var bgMC;

	function UIMenuHeritageWindow()
	{
		super();
		this.bgMC._visible = false;
		this.momMC._visible = false;
		this.dadMC._visible = false;
		this._background = this.attachMovie("txdLoader", "heritageBG", this.getNextHighestDepth());
		this._dadSprite = this.attachMovie("txdLoader", "heritageDad", this.getNextHighestDepth(), {_x:124});
		this._momSprite = this.attachMovie("txdLoader", "heritageMom", this.getNextHighestDepth(), {_x:20});
	}
	function set data(d)
	{
		//parentMenu, id, mom, dad
		this._parentMenu = d[0];
		if (d[2] != undefined)
		{
			this.momIdx = d[2];
		}
		if (d[3] != undefined)
		{
			this.dadIdx = d[3];
		}
		if (this._background.textureDict == "pause_menu_pages_char_mom_dad")
		{
			this._background.init(com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME,"pause_menu_pages_char_mom_dad","mumdadbg",288,158);
			this._background.displayTxdResponse("pause_menu_pages_char_mom_dad");
		}
		else
		{
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this._background,"pause_menu_pages_char_mom_dad","mumdadbg",288,158);
		}
		this.setIndex(this.momIdx,this.dadIdx);
	}

	function setIndex(mom, dad)
	{
		this.momIdx = mom;
		this.dadIdx = dad;
		if (mom > 21)
		{
			this.momIdx = 21;
		}
		if (mom < 0)
		{
			this.momIdx = 0;
		}
		if (dad > 23)
		{
			this.dadIdx = 23;
		}
		if (dad < 0)
		{
			this.dadIdx = 0;
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this._dadSprite,"char_creator_portraits",this.dadIdx < 21 ? "male_" + this.dadIdx : "special_male_" + (this.dadIdx - 21),144,158,this.dadLoaded,this);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this._momSprite,"char_creator_portraits",this.momIdx < 21 ? "female_" + this.momIdx : "special_female_" + (this.momIdx - 21),144,158,this.momLoaded,this);
	}


	function momLoaded()
	{
		this._momSprite._x = 20;
	}
	function dadLoaded()
	{
		this._dadSprite._x = 124;
	}

	function set Width(w)
	{
		this._width = w;
	}


	function Clear()
	{
		if (this._background != undefined)
		{
			if (this._background.isLoaded)
			{
				this._background.removeTxdRef();
			}
		}
		if (this._dadSprite != undefined)
		{
			if (this._dadSprite.isLoaded)
			{
				this._dadSprite.removeTxdRef();
			}
		}
		if (this._momSprite != undefined)
		{
			if (this._momSprite.isLoaded)
			{
				this._momSprite.removeTxdRef();
			}
		}
		this.removeMovieClip();
	}
}