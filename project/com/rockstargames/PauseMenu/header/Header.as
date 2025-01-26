class com.rockstargames.PauseMenu.header.Header
{
	var CONTENT;
	var bgImgLoaderMC;
	var detailsXPositions = [868, 822, 775];
	var showChar = false;
	var showCrew = false;
	var bgLoaderList = new Array();
	var imgSize = 46;
	var detailsShown = true;
	var detailsCoronaLayout = false;
	var charImgLoaderMC;
	var charMC;
	var crewImgLoaderMC;
	var crewMC;
	var detailsMC;
	var menubar;
	var storedBGTxd;
	var _dynamicWidthEnabled = false;

	function Header(mc)
	{
		this.CONTENT = mc;
		this.menubar = this.CONTENT.attachMovie("menu", "menuMC", this.CONTENT.getNextHighestDepth(), {_y:60});
		this.menubar.INITIALIZE();
		this.detailsMC = this.CONTENT.headerMC.alldetailsMC.detailsMC;
		this.charMC = this.CONTENT.headerMC.alldetailsMC.charMC;
		this.crewMC = this.CONTENT.headerMC.alldetailsMC.crewMC;
		var __reg6 = 48;
		var __reg8 = {_visible:false, _xscale:__reg6, _yscale:__reg6, _y:0, _x:-32};
		this.charMC._visible = false;
		this.crewMC._visible = false;
		var __reg4 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg4);
		if (this.detailsMC != undefined)
		{
			com.rockstargames.ui.utils.Colour.Colourise(this.detailsMC,__reg4.r,__reg4.g,__reg4.b,__reg4.a);
		}
		if (mc.headerMC.titleMC != undefined)
		{
			com.rockstargames.ui.utils.Colour.Colourise(this.CONTENT.headerMC.titleMC,__reg4.r,__reg4.g,__reg4.b,__reg4.a);
		}
		var __reg5 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,__reg5);
		com.rockstargames.ui.utils.Colour.Colourise(this.crewMC.bgMC,__reg5.r,__reg5.g,__reg5.b,__reg5.a);
		com.rockstargames.ui.utils.Colour.Colourise(this.charMC.bgMC,__reg5.r,__reg5.g,__reg5.b,__reg5.a);
		this.CONTENT.headerMC.bgMC._visible = false;
		this.CONTENT.headerMC.bgMC.coronaMC._visible = false;
	}

	function AddItem(title, dim, color)
	{
		this.menubar.AddItem(title,dim,color);
	}

	function SetHeaderTitle(title, description, isChallenge)
	{
		var _loc2_ = this.CONTENT.headerMC.titleMC;
		var _loc9_ = false;
		if (description == "" || description == undefined)
		{
			_loc9_ = true;
		}
		if (_loc9_ == true)
		{
			if (title != undefined)
			{
				var size = 36;
				_loc2_.headingTF.autoSize = "left";
				_loc2_.headingTF.multiline = false;
				_loc2_.headingTF.htmlText = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + size + "\'>" + title + "</font>";
			}
			_loc2_._y = 16;
		}
		else
		{
			var _loc3_ = 34;
			var _loc5_ = 13;
			var _loc10_ = 65;
			_loc2_.headingTF.multiline = true;
			_loc2_.headingTF.wordWrap = true;
			_loc2_.headingTF.autoSize = "left";
			var _loc4_ = description.length;
			var _loc7_ = title.length;
			var _loc6_ = -1.6;
			if (_loc4_ < 146)
			{
				if (_loc7_ < 49)
				{
					_loc3_ = 36;
				}
				else
				{
					_loc3_ = 31;
				}
			}
			else if (_loc4_ > 146 && _loc4_ <= 219)
			{
				if (_loc7_ < 49)
				{
					_loc3_ = 32;
				}
				else
				{
					_loc3_ = 28;
				}
				_loc5_ = 12;
			}
			else if (_loc4_ > 219 && _loc4_ <= 316)
			{
				if (_loc7_ < 49)
				{
					_loc3_ = 32;
				}
				else
				{
					_loc3_ = 28;
				}
				_loc5_ = 12;
				_loc6_ = -2;
			}
			else if (_loc4_ > 316 && _loc4_ <= 430)
			{
				_loc3_ = 26;
				_loc5_ = 12;
				_loc6_ = -2.2;
			}
			else if (_loc4_ > 430)
			{
				_loc3_ = 26;
				_loc5_ = 11;
				_loc6_ = -3;
			}
			if (isChallenge)
			{
				_loc3_ = Math.max(com.rockstargames.gtav.utils.GTAVUIUtils.getFontSizeToFitSingle(title, _loc2_.headingTF), 13);
			}
			_loc2_.headingTF.leading = _loc6_;
			_loc2_.headingTF.htmlText = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + _loc3_ + "\'>" + title + "</font><br><font face=\'$Font2\' size=\'" + _loc5_ + "\'>" + description + "</font>";
			if (this.detailsCoronaLayout)
			{
				if (_loc2_.headingTF.textHeight == 53)
				{
					_loc10_ = 32;
				}
				else if (_loc2_.headingTF.textHeight == 67)
				{
					_loc10_ = 10;
				}
			}
			_loc2_._y = Math.max(-9, _loc10_ - _loc2_.headingTF.textHeight / 2);
		}
	}

	function ShiftCoronaDesc(shiftDesc, hideTabs)
	{
		this.detailsCoronaLayout = shiftDesc;
		var __reg5 = 5;
		var __reg2 = 0;
		for (__reg2 = 0; __reg2 < this.menubar.menuItemList.length; __reg2++)
		{
			this.menubar.menuItemList[__reg2].tabMC._visible = hideTabs;
		}
		this.CONTENT.headerMC.bgMC._height = this.menubar._y + __reg5;
	}
	function setDescWidth()
	{
		var __reg2 = 868;
		this.CONTENT.headerMC.titleMC.headingTF._width = __reg2;
	}

	function SetHeadingDetails(str1, str2, str3, isSingleplayer)
	{
		var _loc2_ = this.detailsMC;
		_loc2_.details1TF.autoSize = _loc2_.details1condTF.autoSize = "left";
		_loc2_.details1TF.wordWrap = _loc2_.details1condTF.wordWrap = false;
		_loc2_.details1TF.multiline = _loc2_.details1condTF.multiline = false;
		if (isSingleplayer)
		{
			_loc2_.details1condTF.text = "";
			_loc2_.details1TF.text = str1.toUpperCase();
		}
		else
		{
			_loc2_.details1condTF.text = "";
			_loc2_.details1TF.text = str1;
		}
		_loc2_.details1TF._x = -_loc2_.details1TF._width;
		_loc2_.details1condTF._x = -_loc2_.details1condTF._width;
		if (str2 != undefined)
		{
			var _loc7_ = str2.split(":").length > 1;
			if (!_loc7_)
			{
				_loc2_.details2TF.text = str2;
				_loc2_.details2TF.autoSize = "left";
				_loc2_.details2TF.wordWrap = false;
				_loc2_.details2TF.multiline = false;
				_loc2_.details2TF._x = -_loc2_.details2TF._width;
				_loc2_.timeTF.text = "";
			}
			else
			{
				var _loc3_ = str2.split(" ");
				var _loc5_ = _loc3_[_loc3_.length - 1];
				_loc3_.pop();
				var _loc6_ = _loc3_.join(" ");
				_loc2_.timeTF.text = _loc5_;
				_loc2_.timeTF.autoSize = "left";
				_loc2_.timeTF.wordWrap = false;
				_loc2_.timeTF.multiline = false;
				_loc2_.timeTF._x = -_loc2_.timeTF._width;
				_loc2_.details2TF.text = _loc6_;
				_loc2_.details2TF.autoSize = "left";
				_loc2_.details2TF.wordWrap = false;
				_loc2_.details2TF.multiline = false;
				_loc2_.details2TF._x = _loc2_.timeTF._x - _loc2_.details2TF._width;
			}
		}
		if (str3 != undefined)
		{
			_loc2_.details3TF.text = str3;
			_loc2_.details3TF.autoSize = "left";
			_loc2_.details3TF.wordWrap = false;
			_loc2_.details3TF.multiline = false;
			_loc2_.details3TF._x = -_loc2_.details3TF._width;
		}
		if (this.detailsShown)
		{
			this.setDescWidth();
		}
	}

	function ShowHeadingDetails(bool)
	{
		this.CONTENT.headerMC.alldetailsMC._visible = this.detailsShown = bool;
		if (this.detailsShown)
		{
			return;
		}
		this.setDescWidth();
	}

	function SetHeaderBGImg(txd, bgTexturePath, xPos)
	{
		this.storedBGTxd = txd;
		var __reg2 = this.CONTENT.headerMC.bgcontainerMC;
		if (txd != "")
		{
			if (this.bgImgLoaderMC == undefined)
			{
				this.bgImgLoaderMC = com.rockstargames.ui.media.ImageLoaderMC(__reg2.attachMovie("txdLoader", "bgImageMC", __reg2.getNextHighestDepth(), {_x:868 * xPos}));
			}
			if (this.bgImgLoaderMC.isLoaded == true)
			{
				this.bgImgLoaderMC.removeTxdRef();
			}
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.bgImgLoaderMC,txd,bgTexturePath,this.imgSize,this.imgSize,this.loadedBgImg,this);
		}
	}

	function loadedBgImg()
	{
		this.bgLoaderList.push(this.bgImgLoaderMC);
		var __reg2 = this.CONTENT.headerMC.bgcontainerMC;
		__reg2._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(__reg2,0.2,{_alpha:100});
	}

	function SetCrewImg(txd, crewTexturePath, show)
	{
		this.showCrew = show;
		if (this.showCrew)
		{
			if (txd != "")
			{
				if (this.crewImgLoaderMC == undefined)
				{
					this.crewImgLoaderMC = this.crewMC.attachMovie("txdLoader", "crewsImageMC", this.crewMC.getNextHighestDepth(), {_x:0 - this.imgSize});
				}
				if (this.crewImgLoaderMC.isLoaded == true)
				{
					this.crewImgLoaderMC.removeTxdRef();
				}
				this.crewImgLoaderMC.init("pausemenuheader",txd,crewTexturePath,this.imgSize,this.imgSize);
				var _loc3_ = 3;
				var _loc2_ = String(this.crewImgLoaderMC).split(".");
				var _loc4_ = _loc2_.slice(_loc2_.length - _loc3_).join(".");
				this.crewImgLoaderMC.addTxdRef(_loc4_,this.loadedCrewImg,this);
				this.crewImgLoaderMC._alpha = 0;
			}
			this.crewMC._visible = true;
		}
		else
		{
			this.crewMC._visible = false;
		}
		this.adjustHeaderPositions();
	}

	function loadedCrewImg()
	{
		var __reg2 = 0.2;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.crewImgLoaderMC,__reg2,{_alpha:100});
	}

	function SetCharImg(txd, charTexturePath, show)
	{
		this.showChar = show;
		if (this.showChar)
		{
			if (txd != "")
			{
				if (this.charImgLoaderMC == undefined)
				{
					this.charImgLoaderMC = this.charMC.attachMovie("txdLoader", "charImageMC", this.charMC.getNextHighestDepth(), {_x:0 - this.imgSize});
				}
				if (this.charImgLoaderMC.isLoaded == true)
				{
					this.charImgLoaderMC.removeTxdRef();
				}
				this.charImgLoaderMC.init("pausemenuheader",txd,charTexturePath,this.imgSize,this.imgSize);
				var _loc3_ = 3;
				var _loc2_ = String(this.charImgLoaderMC).split(".");
				var _loc4_ = _loc2_.slice(_loc2_.length - _loc3_).join(".");
				this.charImgLoaderMC.addTxdRef(_loc4_,this.loadedCharImg,this);
				this.charImgLoaderMC._alpha = 0;
			}
			this.charMC._visible = true;
		}
		else
		{
			this.charMC._visible = false;
		}
		this.adjustHeaderPositions();
	}

	function loadedCharImg()
	{
		var __reg2 = 0.2;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.charImgLoaderMC,__reg2,{_alpha:100});
	}

	function adjustHeaderPositions()
	{
		var __reg2 = 4;
		if (this.showChar == false && this.showCrew == false)
		{
			this.detailsMC._x = this.detailsXPositions[0];
			return;
		}
		if (this.showChar == false && this.showCrew == true)
		{
			this.crewMC._x = this.detailsXPositions[0];
			this.detailsMC._x = this.detailsXPositions[1] - __reg2;
			return;
		}
		if (this.showChar == true && this.showCrew == false)
		{
			this.charMC._x = this.detailsXPositions[0];
			this.detailsMC._x = this.detailsXPositions[1] - __reg2;
			return;
		}
		if (this.showChar == true && this.showCrew == true)
		{
			this.charMC._x = this.detailsXPositions[0];
			this.crewMC._x = this.detailsXPositions[1];
			this.detailsMC._x = this.detailsXPositions[2] - __reg2;
		}
	}

	function SetTextSize(isAsian, sizeOverride)
	{
		var __reg5 = 16;
		var __reg3 = 13;
		if (isAsian != undefined && isAsian == true)
		{
			__reg3 = __reg5;
		}
		if (sizeOverride != undefined)
		{
			if (sizeOverride > 18)
			{
				sizeOverride = 18;
			}
			if (sizeOverride < 13)
			{
				sizeOverride = 13;
			}
			__reg3 = sizeOverride;
		}
		com.rockstargames.ui.utils.UIText.SIZE = __reg3;
	}

	function BuildMenu()
	{
		//this.menubar.BUILD_MENU(arguments);
		var __reg3 = 5;
		this.CONTENT.headerMC.bgMC._height = this.menubar._y + __reg3;
	}
	function set DynamicWidthEnabled(_e)
	{
		_dynamicWidthEnabled = _e;
		this.menubar._dynamicWidth = _e;
	}
	function get DynamicWidthEnabled()
	{
		return _dynamicWidthEnabled;
	}

	function WEIGHT_MENU()
	{
		var _loc8_ = arguments.length;
		var _loc3_ = 0;
		while (_loc3_ < this.menubar.menuItemList.length)
		{
			var _loc4_ = this.menubar.menuItemList[_loc3_];
			var _loc6_ = arguments[_loc3_];
			_loc4_.resizeTabPx(_loc6_);
			_loc4_.width = _loc4_.mc.bgMC._width;
			if (_loc3_ > 0)
			{
				var _loc5_ = this.menubar.menuItemList[_loc3_ - 1];
				var _loc7_ = 2;
				_loc4_._x = _loc5_._x + _loc5_.mc.bgMC._width + _loc7_;
			}
			_loc3_ = _loc3_ + 1;
		}
	}

	function ClearTxds()
	{
		if (this.bgImgLoaderMC.isLoaded)
		{
			this.bgImgLoaderMC.removeTxdRef();
		}
		if (this.charImgLoaderMC.isLoaded)
		{
			this.charImgLoaderMC.removeTxdRef();
		}
		if (this.crewImgLoaderMC.isLoaded)
		{
			this.crewImgLoaderMC.removeTxdRef();
		}
	}
}