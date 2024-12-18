class com.rockstargames.gtav.levelDesign.PAUSEMENUHEADER extends com.rockstargames.gtav.levelDesign.BaseScriptUI
{
	var _customBannerLoaded = false;
	var PauseMenuHeader;
	static var MouseEnabled = true;

	function PAUSEMENUHEADER()
	{
		super();
		_global.gfxExtensions = true;
	}

	function INITIALISE(mc)
	{
		super.INITIALISE(mc);
		this.PauseMenuHeader = new com.rockstargames.PauseMenu.header.Header(this.CONTENT);
		this.CONTENT._alpha = 0;
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME = "PauseMenuHeader";
	}

	function SHOW_ARROWS()
	{
		this.PauseMenuHeader.menubar.SET_HEADER_ARROWS_VISIBLE(true,true);
	}

	function ENABLE_DYNAMIC_WIDTH(enabled)
	{
		this.PauseMenuHeader.DynamicWidthEnabled = enabled;
	}

	function SET_HEADER_TITLE(title, subtitle, isChallenge)
	{
		this.PauseMenuHeader.SetHeaderTitle(title,subtitle,isChallenge);
	}

	function SET_HEADER_DETAILS(str1, str2, str3, isSinglePlayer)
	{
		this.PauseMenuHeader.SetHeadingDetails(str1,str2,str3,isSinglePlayer);
	}

	function SET_HEADER_CHAR_IMG(txd, charTexturePath, show)
	{
		this.PauseMenuHeader.SetCharImg(txd,charTexturePath,show);
	}

	function SET_HEADER_CREW_IMG(txd, charTexturePath, show)
	{
		this.PauseMenuHeader.SetCrewImg(txd,charTexturePath,show);
	}

	function SET_HEADER_BG_IMG(txd, charTexturePath, show)
	{
		this.PauseMenuHeader.SetHeaderBGImg(txd,charTexturePath,show);
	}

	function SHIFT_CORONA_DESC(shiftDesc, hideTabs)
	{
		this.PauseMenuHeader.ShiftCoronaDesc(shiftDesc,hideTabs);
	}

	function SHOW_HEADING_DETAILS(show)
	{
		this.PauseMenuHeader.ShowHeadingDetails(show);
	}

	function ADD_HEADER_TAB(title, dim, color)
	{
		this.PauseMenuHeader.AddItem(title,dim,color);
	}

	function GO_LEFT()
	{
		this.PauseMenuHeader.menubar.onLeftArrowClick();
	}
	function GO_RIGHT()
	{
		this.PauseMenuHeader.menubar.onRightArrowClick();
	}

	function SET_TAB_INDEX(tab)
	{
		this.PauseMenuHeader.menubar.SET_CODE_MENU_INDEX(tab);
	}

	function SHOW_MENU(bool)
	{
		this.PauseMenuHeader.menubar._visible = bool;
	}

	function SET_MENU_HEADER_TEXT_BY_INDEX(menuIndex, label, widthSpan, forceUpper)
	{
		if (forceUpper != undefined)
		{
			if (forceUpper == true)
			{
				label = label.toUpperCase();
			}
		}
		this.PauseMenuHeader.menubar.SET_MENU_HEADER_TEXT_BY_INDEX(menuIndex,label,widthSpan);
	}
	function SET_ALL_HIGHLIGHTS(allHighlights, color)
	{
		if (allHighlights)
		{
			this.CONTENT.headerMC.bgMC.coronaMC._visible = true;
		}
		else
		{
			this.CONTENT.headerMC.bgMC.coronaMC._visible = false;
		}
		this.PauseMenuHeader.menubar.SET_ALL_HIGHLIGHTS(allHighlights,color);
	}


	function MOUSE_CLICK_EVENT()
	{
	}

	function DRAW_MENU()
	{
		this.CONTENT._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.CONTENT,0.2,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.CUBIC_IN});
	}

	function ADD_TXD_REF_RESPONSE(txd, strRef, success)
	{
		if (success == true)
		{
			var pMC = this.CONTENT.headerMC;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd);
			}
		}
	}
	function TXD_HAS_LOADED(txd, success, strRef)
	{
		if (success == true)
		{
			var pMC = this.CONTENT.headerMC;
			var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
			if (pMC != undefined)
			{
				il.displayTxdResponse(txd,success);
			}
		}
	}
	function TXD_ALREADY_LOADED(txd, strRef)
	{
		var pMC = this.CONTENT.headerMC;
		var il = com.rockstargames.ui.media.ImageLoaderMC(eval(pMC + "." + strRef));
		if (pMC != undefined)
		{
			il.displayTxdResponse(txd,true);
		}
	}

	function CLEAR_ALL()
	{
		for (var it in this.PauseMenuHeader.menubar.menuItemList)
		{
			var item = this.PauseMenuHeader.menubar.menuItemList[it];
			item.removeMovieClip();
		}
		this.PauseMenuHeader.menubar.headerContainerMC.removeMovieClip();
		this.PauseMenuHeader = new com.rockstargames.PauseMenu.header.Header(this.CONTENT);
	}
}