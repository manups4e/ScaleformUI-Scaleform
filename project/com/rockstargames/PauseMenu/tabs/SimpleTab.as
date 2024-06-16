class com.rockstargames.PauseMenu.tabs.SimpleTab extends com.rockstargames.PauseMenu.tabs.BaseTab
{
	var _title;
	var ItemList;
	var scrollableContent;
	var viewHeight = 0;
	var viewMaskHeight = 430;
	var itemType;
	var rightBodyHovered = false;
	var SCROLL_DURATION = 0.2;
	var SCROLL_DY = 27;
	var pictureTxd;

	function SimpleTab(mc, val)
	{
		super(mc,val);
		this.rightItemUpMC = this._MC.attachMovie("pauseMenuWholeBody", "Whole_body_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.rightItemUpMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.scrollableContent = this.rightItemUpMC.createEmptyMovieClip("viewContainer", this.rightItemUpMC.getNextHighestDepth());
		this.rightItemUpMC.setMask(this.rightItemUpMC.maskMC);
		this.rightItemUpMC.onRollOver = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOverST);
		this.rightItemUpMC.onRollOut = com.rockstargames.ui.utils.DelegateStar.create(this, this.mOutST);
		this.ItemList = new Array();
		this.rightBodyHovered = false;
	}

	function mOverST()
	{
		this.rightBodyHovered = true;
	}
	function mOutST()
	{
		this.rightBodyHovered = false;
	}

	function AddTitle(it, txt)
	{
		if (this._title == undefined)
		{
			this._title = new com.rockstargames.PauseMenu.items.BasicTabItem(this.scrollableContent);
			this._title.itemMC.labelMC.titleTF._width = 860;
			var size = 50;
			this._title.itemMC.labelMC.titleTF.autoSize = "left";
			this._title.itemMC.labelMC.titleTF.multiline = false;
			this._title.itemMC.labelMC.titleTF.htmlText = "<font face=\'$Font2\' size=\'" + size + "\'>" + txt + "</font>";
			this._title.itemMC._y = 5;
			this._title.snapBGGrid(this._title.bgMC);
		}
	}

	function AddItem(it, _type, param1, param2, param3, param4)
	{
		var item;
		switch (_type)
		{
			case 0 :
				item = new com.rockstargames.PauseMenu.items.BasicTabItem(this.scrollableContent, param1, param2, param3, param4);
				break;
		}
		item.itemMC.labelMC.titleTF._width = 850;
		this.ItemList.push(item);
		this.updateItemsHeight();
		this.scrollToBottom();
	}

	function AddPicture(txd, txn)
	{
		if (this.pictureTxd == undefined)
		{
			this.pictureTxd = this.rightItemUpMC.attachMovie("txdLoader", "picture", this.rightItemUpMC.getNextHighestDepth());
		}
		if (this.pictureTxd.isLoaded)
		{
			this.pictureTxd.removeTxdRef();
		}
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(this.pictureTxd,txd,txn,288,430,this.pictureLoaded,this);
	}

	function pictureLoaded()
	{
		this.pictureTxd._x = 580;
		this.updateLabels();
	}

	function updateLabels()
	{
		for (var it in this.ItemList)
		{
			this.ItemList[it].itemMC.labelMC.titleTF._width = 570;
		}
		this.updateItemsHeight();
	}

	function updateItemsHeight()
	{
		var _th = this._title == undefined ? 5 : this._title.itemMC._y + this._title.itemMC.bgMC._height;
		for (var it in this.ItemList)
		{
			var oldItemY = it > 0 ? this.ItemList[it - 1].itemMC._y : 0;
			var oldItemH = it > 0 ? this.ItemList[it - 1].itemMC._height : 0;
			if (it == 0)
			{
				this.ItemList[it].itemMC._y = _th + 2;
			}
			else
			{
				this.ItemList[it].itemMC._y = oldItemH + oldItemY;
			}
		}
		this.viewHeight = this.ItemList[this.ItemList.length - 1].itemMC._y + this.ItemList[this.ItemList.length - 1].itemMC.bgMC._height + 15;
	}

	function updateBackground(txd, txn)
	{
		if (txd == "" && txn == "")
		{
			this.rightItemUpMC.bgMC._visible = true;
			this.rightItemUpMC.textMC._visible = true;
			if (this.rightItemUpMC.txdLoader.isLoaded)
			{
				this.rightItemUpMC.txdLoader.removeMovieClip();
			}
			this.rightItemUpMC.removeMovieClip();
			return;
		}
		this.rightItemUpMC.bgMC._alpha = 0;
		this.rightItemUpMC.textMC._alpha = 0;
		this.rightItemUpMC.attachMovie("txdLoader","txdLoader",this.rightItemUpMC.getNextHighestDepth());
		this.scrollableContent.swapDepths(this.rightItemUpMC.txdLoader);
		if (this.rightItemUpMC.txdLoader.isLoaded)
		{
			this.rightItemUpMC.txdLoader.removeMovieClip();
		}
		this.SetClip(this.rightItemUpMC.txdLoader,txd,txn,868,430,this.bgLoaded);
	}

	function bgLoaded()
	{
		this.rightItemUpMC.txdLoader._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.rightItemUpMC.txdLoader,0.2,{_alpha:75});
	}

	function SetClip(targetMC, textureDict, textureName, w, h, callback)
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClip(targetMC,textureDict,textureName,w,h,callback,this);
	}

	function scrollToBottom()
	{
		if (this.viewHeight > this.viewMaskHeight)
		{
			this.scrollableContent._y = -(this.viewHeight - this.viewMaskHeight);
		}
	}


	function set isVisible(_v)
	{
		super.isVisible = _v;
		if (this.rightItemUpMC != undefined)
		{
			this.rightItemUpMC._visible = _v;
		}
	}

	function set focused(_f)
	{
		this.rightItemUpMC._alpha = _f ? 100 : 60;
		this._title.itemMC._alpha = _f ? 100 : 60;
		for (var it in this.ItemList)
		{
			this.ItemList[it]._alpha = _f ? 100 : 60;
		}
	}

	function get panelHovered():Boolean
	{
		return this.rightBodyHovered;
	}



	function scrollAll(targetIndex, tween)
	{
		if (tween == undefined)
		{
			tween = true;
		}

		var _loc2_ = this.scrollableContent._y;
		switch (targetIndex)
		{
			case 1 :
				_loc2_ = _loc2_ - this.SCROLL_DY;
				if (_loc2_ <= -(this.viewHeight - this.viewMaskHeight))
				{
					_loc2_ = -(this.viewHeight - this.viewMaskHeight);
				}
				break;
			case -1 :
				_loc2_ = _loc2_ + this.SCROLL_DY;
				if (_loc2_ >= 0)
				{
					_loc2_ = 0;
				}
				break;
		}
		if (tween)
		{
			com.rockstargames.ui.tweenStar.TweenStarLite.to(this.scrollableContent,this.SCROLL_DURATION,{_y:_loc2_, ease:com.rockstargames.ui.tweenStar.Ease.LINEAR});
		}
		else
		{
			this.scrollableContent._y = _loc2_;
		}
	}
	
	function Clear(){
		
	}
}