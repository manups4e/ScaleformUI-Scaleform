class com.rockstargames.PauseMenu.header.Header
{
	var CONTENT;
	var bgImgLoaderMC;
	var detailsXPositions = [868, 822, 775];
	var showChar:Boolean = false;
	var showCrew:Boolean = false;
	var bgLoaderList = new Array();
	var imgSize:Number = 46;
	var detailsShown:Boolean = true;
	var detailsCoronaLayout:Boolean = false;
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
		this.menubar.INITIALIZE(mc);
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

	function SetHeaderTitle(title, description, isChallenge)
	{
		var __reg2 = this.CONTENT.headerMC.titleMC;
		var __reg9 = false;
		if (description == "" || description == undefined)
		{
			__reg9 = true;
		}
		if (__reg9 == true)
		{
			if (title != undefined)
			{
				var size = 36;
				__reg2.headingTF.autoSize = "left";
				__reg2.headingTF.multiline = false;
				__reg2.headingTF.htmlText = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + size + "\'>" + title + "</font>";
			}
			__reg2._y = 16;
			return;
		}
		var __reg3 = 34;
		var __reg5 = 13;
		var __reg10 = 65;
		__reg2.headingTF.multiline = true;
		__reg2.headingTF.wordWrap = true;
		__reg2.headingTF.autoSize = "left";
		var __reg4 = description.length;
		var __reg7 = title.length;
		var __reg6 = -1.6;
		if (__reg4 < 146)
		{
			if (__reg7 < 49)
			{
				__reg3 = 36;
			}
			else
			{
				__reg3 = 31;
			}
		}
		else if (__reg4 > 146 && __reg4 <= 219)
		{
			if (__reg7 < 49)
			{
				__reg3 = 32;
			}
			else
			{
				__reg3 = 28;
			}
			__reg5 = 12;
		}
		else if (__reg4 > 219 && __reg4 <= 316)
		{
			if (__reg7 < 49)
			{
				__reg3 = 32;
			}
			else
			{
				__reg3 = 28;
			}
			__reg5 = 12;
			__reg6 = -2;
		}
		else if (__reg4 > 316 && __reg4 <= 430)
		{
			__reg3 = 26;
			__reg5 = 12;
			__reg6 = -2.2;
		}
		else if (__reg4 > 430)
		{
			__reg3 = 26;
			__reg5 = 11;
			__reg6 = -3;
		}
		if (isChallenge)
		{
			__reg3 = Math.max(com.rockstargames.gtav.utils.GTAVUIUtils.getFontSizeToFitSingle(title, __reg2.headingTF), 13);
		}
		__reg2.headingTF.leading = __reg6;
		__reg2.headingTF.htmlText = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + __reg3 + "\'>" + title + "</font><br><font face=\'$Font2\' size=\'" + __reg5 + "\'>" + description + "</font>";
		if (this.detailsCoronaLayout)
		{
			if (__reg2.headingTF.textHeight == 53)
			{
				__reg10 = 32;
			}
			else if (__reg2.headingTF.textHeight == 67)
			{
				__reg10 = 10;
			}
		}
		__reg2._y = Math.max(-9, __reg10 - __reg2.headingTF.textHeight / 2);
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(__reg2.headingTF, "$Font2_cond_NOT_GAMERNAME");
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
		var __reg2 = this.detailsMC;
		__reg2.details1TF.autoSize = __reg2.details1condTF.autoSize = "left";
		__reg2.details1TF.wordWrap = __reg2.details1condTF.wordWrap = false;
		__reg2.details1TF.multiline = __reg2.details1condTF.multiline = false;
		if (isSingleplayer)
		{
			__reg2.details1condTF.text = "";
			__reg2.details1TF.text = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + 18 + "\'>" + str1.toUpperCase() + "</font>";
		}
		else
		{
			__reg2.details1condTF.text = "";
			__reg2.details1TF.text = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + 18 + "\'>" + str1 + "</font>";
		}
		__reg2.details1TF._x = 0 - __reg2.details1TF._width;
		__reg2.details1condTF._x = 0 - __reg2.details1condTF._width;
		if (str2 != undefined)
		{
			var __reg7 = str2.split(":").length > 1;
			if (__reg7)
			{
				var __reg3 = str2.split(" ");
				var __reg5 = __reg3[__reg3.length - 1];
				__reg3.pop();
				var __reg6 = __reg3.join(" ");
				__reg2.timeTF.text = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + 18 + "\'>" + __reg5 + "</font>";
				__reg2.timeTF.autoSize = "left";
				__reg2.timeTF.wordWrap = false;
				__reg2.timeTF.multiline = false;
				__reg2.timeTF._x = 0 - __reg2.timeTF._width;
				__reg2.details2TF.text = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + 18 + "\'>" + __reg6 + "</font>";
				__reg2.details2TF.autoSize = "left";
				__reg2.details2TF.wordWrap = false;
				__reg2.details2TF.multiline = false;
				__reg2.details2TF._x = __reg2.timeTF._x - __reg2.details2TF._width;
			}
			else
			{
				__reg2.details2TF.text = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + 18 + "\'>" + str2 + "</font>";
				__reg2.details2TF.autoSize = "left";
				__reg2.details2TF.wordWrap = false;
				__reg2.details2TF.multiline = false;
				__reg2.details2TF._x = 0 - __reg2.details2TF._width;
				__reg2.timeTF.text = "";
			}
		}
		if (str3 != undefined)
		{
			__reg2.details3TF.text = "<font face=\'$Font2_cond_NOT_GAMERNAME\' size=\'" + 18 + "\'>" + str3 + "</font>";
			__reg2.details3TF.autoSize = "left";
			__reg2.details3TF.wordWrap = false;
			__reg2.details3TF.multiline = false;
			__reg2.details3TF._x = 0 - __reg2.details3TF._width;
		}
		if (!this.detailsShown)
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
			this.bgImgLoaderMC.init("PauseMenuHeader",txd,bgTexturePath);
			var __reg4 = 2;
			var __reg3 = String(this.bgImgLoaderMC).split(".");
			var __reg5 = __reg3.slice(__reg3.length - __reg4).join(".");
			this.bgImgLoaderMC.requestTxdRef(__reg5,false,this.loadedBgImg,this);
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
				this.crewImgLoaderMC.init("PauseMenuHeader",txd,crewTexturePath,this.imgSize,this.imgSize);
				var __reg3 = 3;
				var __reg2 = String(this.crewImgLoaderMC).split(".");
				var __reg4 = __reg2.slice(__reg2.length - __reg3).join(".");
				this.crewImgLoaderMC.requestTxdRef(__reg4,false,this.loadedCrewImg,this);
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
				this.charImgLoaderMC.init("PauseMenuHeader",txd,charTexturePath,this.imgSize,this.imgSize);
				var __reg3 = 3;
				var __reg2 = String(this.charImgLoaderMC).split(".");
				var __reg4 = __reg2.slice(__reg2.length - __reg3).join(".");
				this.charImgLoaderMC.addTxdRef(__reg4,this.loadedCharImg,this);
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

	function ClearTxds()
	{
		com.rockstargames.ui.utils.Debug.log("CLEAR_TXDS ----- ");
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