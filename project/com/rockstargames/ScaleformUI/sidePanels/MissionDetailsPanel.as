class com.rockstargames.ScaleformUI.sidePanels.MissionDetailsPanel extends MovieClip
{
	var itemMC;
	var imgLdr;
	var defaultPlaceholderA;
	var _mainMC;
	var listDescItem;
	var LeftRightSide = 1;
	var menu;
	var panelTitle;
	var panelTitleColour;
	var BannerTitle;
	var descItems = [];
	var titleFreemode;
	var _titleType;
	var BannerSprite;
	var banner;
	var verifiedMC;
	var verifiedbgMC;
	var descBG;
	var imgPlaceholderMC;
	var imgMC;

	function MissionDetailsPanel()
	{
		super();
		this.descItems = new Array();
		this.banner = this.BannerSprite.bannerBG.attachMovie("txdLoader", "internbannerSprite_" + this.BannerSprite.bannerBG.getNextHighestDepth(), this.BannerSprite.bannerBG.getNextHighestDepth());
	}

	function set data(d)
	{
		//menu, type, leftRight, titleType, panelTitle, panelColour, txd, txn
		this.menu = d[0];
		this.listDescItem = 0;
		this.LeftRightSide = d[2];
		this.verifiedMC._visible = this.verifiedbgMC._visible = false;
		this.panelTitle = d[4];
		this.panelTitleColour = d[5];
		this._titleType = d[3];
		switch (d[3])
		{
			case 0 :
				this.gotoAndStop(1);
				this.BannerSprite._width = 288;
				this.BannerSprite._height = 65;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.banner,this.menu._bannerTxd,this.menu._bannerTexture,288,65,this);

				this.BannerTitle = this.BannerSprite.titleMC.labelTF;
				this.BannerTitle.embedFonts = true;
				this.BannerTitle.antiAliasType = "advanced";
				this.BannerTitle.selectable = false;
				if (this.panelTitle != undefined && this.panelTitle != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.BannerTitle,this.panelTitle,true,true,31,31);
				}
				this.updateFont(this.titleFreemode.itemTextLeft,"$Font2_cond_NOT_GAMERNAME");
				break;
			case 1 :
				this.gotoAndStop(2);
				this.BannerSprite.bannerBG._alpha = 100;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.BannerSprite.bannerBG,this.panelTitleColour);

				this.BannerTitle = this.BannerSprite.labelTF;
				if (this.panelTitle != undefined && this.panelTitle != "")
				{
					com.rockstargames.ui.utils.UIText.setSizedText(this.BannerTitle,this.panelTitle,true,true,20, 20);
				}
				com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.BannerTitle,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
				break;
			case 2 :
				this.BannerSprite._visible = false;
				if (this.titleFreemode == undefined)
				{
					this.titleFreemode = this.attachMovie("freemodeTitleItem", "freemodeTitleItemMC", 1);
				}
				this.titleFreemode._y = this.descBG._y - this.titleFreemode.getHeight();
				this.titleFreemode.highlightTitle(false);
				com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.itemTextLeft,this.panelTitle,true,false,0,23);
				com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.labelMC.titleshadowTF,this.panelTitle,true,false,0,23);
				this.updateFont(this.titleFreemode.itemTextLeft,"$Font5");
				this.updateFont(this.titleFreemode.labelMC.titleshadowTF,"$Font5");

				this.titleFreemode.snapBGGrid(this.titleFreemode.bgMC);
				break;
		}

		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.descBG,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.verifiedbgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.imgPlaceholderMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.defaultPlaceholderA = this.imgPlaceholderMC._alpha;
		this.listDescItem = 0;

		if (d[6] == "" && d[7] == "")
		{
			this.descBG._y = this.descBG._y - this.imgPlaceholderMC._height;
			if (d[3] == 2)
			{
				this.descBG._y = this.descBG._y + this.titleFreemode.getHeight();
				this.titleFreemode._y = this.descBG._y - this.titleFreemode.getHeight();
			}
			this.imgPlaceholderMC._visible = false;
		}
		else
		{
			this.setPicture(d[6],d[7]);
		}
		this.updateDescBG();
	}

	function set ExtraData(ed)
	{
		for (var i = 0; i < ed.length; i++)
		{
			var it = ed[i];
			//(id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
			this.AddItem(it[0],it[1],it[2],it[3],it[4],it[5],it[6],it[7],it[8],it[9],it[10]);
		}
	}

	function setPicture(txd, txn)
	{
		if (this.imgLdr == undefined)
		{
			this.imgLdr = this.imgMC.attachMovie("txdLoader", "imgLdr_" + this.imgMC.getNextHighestDepth(), this.imgMC.getNextHighestDepth());
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.imgLdr,txd,txn,288,160,this.transitionInBitmap,this);
	}

	function updateFont(tf, fontName)
	{
		tf.embedFonts = true;
		tf.antiAliasType = "advanced";
		tf.selectable = false;
		var newFont = tf.getTextFormat();
		newFont.font = fontName;
		tf.setNewTextFormat(newFont);
		tf.setTextFormat(newFont);
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
			case 2 :
				this.BannerSprite._visible = false;
				this.titleFreemode._y = this.descBG._y - this.titleFreemode.getHeight();
				this.titleFreemode.highlightTitle(false);
				com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.itemTextLeft,this.panelTitle,true,false,0,23);
				com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.labelMC.titleshadowTF,this.panelTitle,true,false,0,23);
				this.titleFreemode.snapBGGrid(this.titleFreemode.bgMC);
				break;
		}
	}

	function AddItem(id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var item = new com.rockstargames.ScaleformUI.sidePanels.FreemodeDetailsItem(this, this.listDescItem + 1, id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10);
		this.listDescItem = this.descItems.push(item);
		var i = 0;
		var itemY = this.descBG._y;
		while (i < this.descItems.length)
		{
			this.descItems[i].itemMC._y = itemY;
			itemY += this.descItems[i].itemMC._height;
			i = i + 1;
		}
		this.updateDescBG();
	}

	function RemoveItem(id)
	{
		this.descItems.splice(id,1);
		for (var it in this.descItems)
		{
			if ((it == 0))
			{
				this.descItems[it].itemMC._y = this.descBG._y;
			}
			else if ((it > 0))
			{
				this.descItems[it].itemMC._y = this.descItems[it - 1].itemMC._y + this.descItems[it - 1].itemMC._height;
			}
		}
		this.updateDescBG();
	}

	function transitionInBitmap()
	{
		this.imgLdr._alpha = 0;
		this.imgLdr._visible = true;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.imgLdr,0.3,{_alpha:100, ease:com.rockstargames.ui.tweenStar.Ease.QUADRATIC_OUT});
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.imgPlaceholderMC,0.3,{_alpha:0, ease:com.rockstargames.ui.tweenStar.Ease.QUADRATIC_OUT, onCompleteScope:this, onComplete:this.transitionComplete});
	}
	function transitionComplete()
	{
		this.imgPlaceholderMC._alpha = this.defaultPlaceholderA;
		this.imgPlaceholderMC._visible = false;
	}

	function updateDescBG()
	{
		var val = 0;
		for (var item in this.descItems)
		{
			val = val + this.descItems[item].itemMC.bgMC._height + 2;
		}
		this.descBG._height = val;
	}


	function set isVisible(_v)
	{
		this._visible = _v;
	}
	function get isVisible()
	{
		return this._visible;
	}

	function ClearItems()
	{
		if (this.descItems.length > 0)
		{
			for (var dd in this.descItems)
			{
				this.descItems[dd].Clear();
			}
		}
		this.descItems = new Array();
		this.listDescItem = 0;
	}

	function Clear()
	{
		if (this.descItems.length > 0)
		{
			for (var dd in this.descItems)
			{
				this.descItems[dd].Clear();
			}
		}
		this.removeMovieClip();

	}
}