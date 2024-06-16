class com.rockstargames.PauseMenu.lobby.MissionPanel
{
	var itemMC;
	var imgLdr;
	var defaultPlaceholderA;
	var _mainMC;
	var listDescItem;
	var parentMC;
	var panelTitle;
	var panelTitleColour;
	var BannerTitle;
	var descItems = [];
	var titleFreemode;
	var _titleType;
	var type = "panel";
	var OFFSET;

	function MissionPanel(parent, offset, panelTitle, panelColour, txd, txn)
	{
		this.OFFSET = offset;
		this.parentMC = parent;
		this.listDescItem = 0;
		this.descItems = new Array();
		this._mainMC = parent.CONTENT;
		this.itemMC = this._mainMC.attachMovie("SideMissionPanel", "sideMissionPan_" + this._mainMC.getNextHighestDepth(), this._mainMC.getNextHighestDepth());
		this.itemMC._x = this.OFFSET;
		this.itemMC.verifiedMC._visible = this.itemMC.verifiedbgMC._visible = false;
		this.panelTitle = panelTitle;
		this.panelTitleColour = panelColour;

		this.titleFreemode = this.itemMC.attachMovie("freemodeTitleItem", "freemodeTitleItemMC", 1);
		this.titleFreemode._y = this.itemMC.descBG._y - this.titleFreemode.getHeight();
		this.titleFreemode.highlightTitle(false);
		com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.itemTextLeft,this.panelTitle,true,false,0,23);
		com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.labelMC.titleshadowTF,this.panelTitle,true,false,0,23);
		this.updateFont(this.titleFreemode.itemTextLeft,"$Font5");
		this.updateFont(this.titleFreemode.labelMC.titleshadowTF,"$Font5");
		this.titleFreemode.snapBGGrid(this.titleFreemode.bgMC);

		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.descBG,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.verifiedbgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.imgPlaceholderMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.defaultPlaceholderA = this.itemMC.imgPlaceholderMC._alpha;
		this.listDescItem = 0;

		if (((txd == "") && txn == ""))
		{
			this.itemMC.descBG._y = this.itemMC.descBG._y - this.itemMC.imgPlaceholderMC._height;
			this.itemMC.descBG._y = this.itemMC.descBG._y + this.titleFreemode.getHeight();
			this.titleFreemode._y = this.itemMC.descBG._y - this.titleFreemode.getHeight();
			this.itemMC.imgPlaceholderMC._visible = true;
		}
		else
		{
			this.setPicture(txd,txn);
		}
		this.updateDescBG();
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


	function setPicture(txd, txn)
	{
		if (this.imgLdr == undefined)
		{
			this.imgLdr = this.itemMC.imgMC.attachMovie("txdLoader", "imgLdr_" + this.itemMC.imgMC.getNextHighestDepth(), this.itemMC.imgMC.getNextHighestDepth());
		}
		var _loc12_ = false;
		if (this.imgLdr.textureDict == txd && this.imgLdr.textureFilename == txn)
		{
			_loc12_ = true;
			this.imgLdr.loadWithValidation("lobbymenu",txd,txn,3,288,160);
			this.transitionInBitmap();
		}
		else if (this.imgLdr.isLoaded)
		{
			this.imgLdr.removeTxdRef();
		}
		this.imgLdr.init("lobbymenu",txd,txn,288,160);
		var _loc7_ = 3;
		var _loc8_ = String(this.imgLdr).split(".");
		var _loc11_ = _loc8_.slice(_loc8_.length - _loc7_).join(".");
		this.imgLdr.requestTxdRef(_loc11_,_loc12_,this.transitionInBitmap,this);
	}

	function setTitle(title)
	{
		this.panelTitle = title;
		this.titleFreemode._y = this.itemMC.descBG._y - this.titleFreemode.getHeight();
		this.titleFreemode.highlightTitle(false);
		com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.itemTextLeft,this.panelTitle,true,false,0,23);
		com.rockstargames.ui.utils.UIText.setSizedText(this.titleFreemode.labelMC.titleshadowTF,this.panelTitle,true,false,0,23);
		this.titleFreemode.snapBGGrid(this.titleFreemode.bgMC);
		this.updateFont(this.titleFreemode.itemTextLeft,"$Font5");
		this.updateFont(this.titleFreemode.labelMC.titleshadowTF,"$Font5");
	}

	function AddItem(id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		var item = new com.rockstargames.PauseMenu.lobby.FreemodeDetailsItem(this, this.listDescItem + 1, id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10);
		if (this.listDescItem == 0)
		{
			item.itemMC._y = this.itemMC.descBG._y;
		}
		else if (this.listDescItem > 0)
		{
			item.itemMC._y = this.descItems[this.listDescItem - 1].itemMC._y + this.descItems[this.listDescItem - 1].itemMC._height;
		}
		this.listDescItem = this.descItems.push(item);
		this.updateDescBG();
	}

	function RemoveItem(id)
	{
		this.descItems.splice(id,1);
		for (var it in this.descItems)
		{
			if ((it == 0))
			{
				this.descItems[it].itemMC._y = this.itemMC.descBG._y;
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
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.itemMC.imgPlaceholderMC,0.3,{_alpha:0, ease:com.rockstargames.ui.tweenStar.Ease.QUADRATIC_OUT, onCompleteScope:this, onComplete:this.transitionComplete});
	}
	function transitionComplete()
	{
		this.itemMC.imgPlaceholderMC._alpha = this.defaultPlaceholderA;
		this.itemMC.imgPlaceholderMC._visible = false;
	}

	function updateDescBG()
	{
		var h = 0;
		for (var item in this.descItems)
		{
			if (this.descItems[item]._type == 4)
			{
				h += this.descItems[item].itemMC.bgMC._height;
			}
			else
			{
				h += 27;
			}
		}
		this.itemMC.descBG._height = h;
	}

	function updateItemsDrawing()
	{
		this.itemMC._x = this.OFFSET;// cambierà in base alla richiesta (x)
	}


	function set isVisible(_v)
	{
		this.itemMC._visible = _v;
	}
	function get isVisible()
	{
		return this.itemMC._visible;
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
		this.ClearItems();
		this.itemMC.removeMovieClip();
	}
}