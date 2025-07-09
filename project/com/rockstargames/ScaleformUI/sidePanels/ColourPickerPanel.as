class com.rockstargames.ScaleformUI.sidePanels.ColourPickerPanel extends MovieClip
{
	var LeftRightSide = 1;
	var menu;
	var panelTitle;
	var panelTitleColour;
	var BannerTitle;
	var colorsArray = [];
	var titleFreemode;
	var _titleType;
	var hovered = -1;
	var BannerSprite;
	var imgPlaceholderMC;
	var honeyComb;

	function ColourPickerPanel()
	{
		super();
	}

	function set data(d)
	{
		//menu, type, leftRight, titleType, panelTitle, panelColour
		this.menu = d[0];
		this.colorsArray = com.rockstargames.ScaleformUI.utils.ColorPanelColors.VEHICLE_COLORS;
		this.LeftRightSide = d[2];
		this.panelTitle = d[4];
		this.panelTitleColour = d[5];
		this._titleType = d[3];
		switch (d[3])
		{
			case 0 :
				this.gotoAndStop(1);
				this.BannerSprite._width = 288;
				var banner = this.BannerSprite.bannerBG.attachMovie("txdLoader", "bannerSpriteNew", this.BannerSprite.bannerBG.getNextHighestDepth());
				var alreadyLoaded = true;
				if (banner.textureFilename != this.menu._bannerTexture && banner.textureDict != this.menu._bannerTxd)
				{
					alreadyLoaded = false;
				}
				if (banner.isLoaded)
				{
					banner.removeTxdRef();
				}

				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(banner,this.menu._bannerTxd,this.menu._bannerTexture,288,65);

				var bannerFont = new TextFormat("$Font5", 31);
				bannerFont.align = "center";
				this.BannerTitle = this.BannerSprite.titleMC.labelTF;
				this.BannerTitle.embedFonts = true;
				this.BannerTitle.antiAliasType = "advanced";
				this.BannerTitle.selectable = false;
				if (this.panelTitle != undefined && this.panelTitle != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.BannerTitle,this.panelTitle,true,true,31,31);
				}
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.BannerSprite.bannerBG.bannerSpriteNew,this.menu.bannerColor);
				break;
			case 1 :
				this.gotoAndStop(2);
				this.BannerSprite.bannerBG._alpha = 100;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.BannerSprite.bannerBG,this.panelTitleColour);

				this.BannerTitle = this.BannerSprite.labelTF;
				if (this.panelTitle != undefined && this.panelTitle != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.BannerTitle,this.panelTitle,true,true,21,21);
					com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.BannerTitle,"$Font5");
				}
				//com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.BannerTitle,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);  
				break;
		}
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.imgPlaceholderMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.honeyComb.maskMC._alpha = 0;
		for (var i = 0; i < this.colorsArray.length; i++)
		{
			var col = this.colorsArray[i];
			var cell = this.honeyComb["colour_" + i];
			com.rockstargames.ui.utils.Colour.Colourise(cell,col.r,col.g,col.b,100);
			if (cell.mouseCatcher == undefined)
			{
				cell.attachMovie("mouseCatcher","mouseCatcher",cell.getNextHighestDepth(),{_x:-30.35, _y:-35, _width:cell._width, _height:cell._height});
				cell.mouseCatcher.setupGenericMouseInterface(i,20,this.onMouseEvent,[cell, i, this]);
			}
		}
	}

	function onMouseEvent(evtType, targetMC, args)
	{
		var cell = args[0];
		var id = args[1];
		var panel = args[2];
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				panel.mOutCP(id);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				panel.mOverCP(id);
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				panel.mOutCP(id);
		}

	}

	function mOverCP(id)
	{
		var cell = this.honeyComb["colour_" + id];
		cell.swapDepths(this.honeyComb.maskMC);
		cell._width += 30;
		cell._height += 30;
		this.hovered = id;
	}

	function mOutCP(id)
	{
		var cell = this.honeyComb["colour_" + id];
		cell.swapDepths(this.honeyComb.maskMC);
		cell._width -= 30;
		cell._height -= 30;
		this.hovered = -1;
	}

	function setTitle(title)
	{
		this.panelTitle = title;
		switch (this._titleType)
		{
			case 0 :
				var bannerFont = new TextFormat("$Font5", 31);
				bannerFont.align = "center";
				this.BannerTitle = this.BannerSprite.titleMC.labelTF;
				this.BannerTitle.embedFonts = true;
				this.BannerTitle.antiAliasType = "advanced";
				this.BannerTitle.selectable = false;
				if (this.panelTitle != undefined && this.panelTitle != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.BannerTitle,this.panelTitle,true,true,31,31);
				}
				break;
			case 1 :
				this.BannerTitle = this.BannerSprite.titleMC.labelTF;
				if (this.panelTitle != undefined && this.panelTitle != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.BannerTitle,this.panelTitle,true,true,12,12);
				}
				com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.BannerTitle,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
				break;
		}
	}


	function set isVisible(_v)
	{
		this._visible = _v;
	}
	function get isVisible()
	{
		return this._visible;
	}

	function Clear()
	{
		this.removeMovieClip();
	}

	function get Value()
	{
		return this.hovered;
	}
}