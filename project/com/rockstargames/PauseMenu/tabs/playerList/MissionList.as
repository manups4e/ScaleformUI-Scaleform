class com.rockstargames.PauseMenu.tabs.playerList.MissionList
{

	var _MC;
	var _parentMC;
	var DescriptionSprite;
	var EnableAnim = true;
	var AnimType = com.rockstargames.ui.tweenStar.Ease.LINEAR;
	var BodyMask;
	var scrollableContent;
	var _itemsOffset;
	var ItemList;
	var blipLayer;
	var _isVisible = false;
	var itemCount = 0;
	var Footer;
	var _activeItem = 0;
	var _minItem;
	var _maxItem;
	var MAX_ITEMS;
	var OFFSET;
	var type = "missions";
	var _id;
	var tot;

	function MissionList(parent, offset, id)
	{
		this._id = id;
		this.OFFSET = offset;
		this._minItem = 0;
		this.MAX_ITEMS = 12;
		this._maxItem = this.MAX_ITEMS;
		this.ItemList = new Array();
		this._parentMC = parent;
		this._MC = parent.CONTENT;
		this.BodyMask = this._MC.attachMovie("pauseMenuColumnBody", "Body_missions_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		this.BodyMask.maskMC._height = 0;
		this.BodyMask.bgMC._height = 0;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.BodyMask.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.BodyMask.bgMC._alpha = 0;
		this.scrollableContent = this.BodyMask.createEmptyMovieClip("viewContainer", this.BodyMask.getNextHighestDepth());
		this.BodyMask.setMask(this.BodyMask.maskMC);
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height;

		this.Footer = this._MC.attachMovie("MenuFooter", "footer_missions_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		this.Footer._visible = false;

		this.EnableAnim = false;
		this.AnimType = 0;
	}

	function AddItem(before, index, id, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13)
	{
		var item;
		if (id == 0)
		{
			item = new com.rockstargames.PauseMenu.tabs.playerList.mpFreemodeItem(this, index, param0, param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11, param12, param13);
		}

		var lastItem = this.ItemList[this.itemCount - 1];
		if (before)
		{
			item.itemMC._y = this.ItemList[0].itemMC._y - item.itemMC._height - 2.55;
			this.ItemList[this.itemCount - 1].Clear();
			this.ItemList.pop();
			this.itemCount = this.ItemList.unshift(item);
		}
		else
		{
			if (this.itemCount == 0)
			{
				item.itemMC._y = 0;
			}
			else
			{
				if (this.itemCount >= this.MAX_ITEMS)
				{
					this.ItemList[0].Clear();
					this.ItemList.shift();
					this.itemCount = this.ItemList.length;
				}
				item.itemMC._y = lastItem.itemMC._y + lastItem.itemMC._height + 2.55;
			}
			this.itemCount = this.ItemList.push(item);
		}
		this.updateItemsDrawing();
	}

	function RemoveItem(id)
	{
		this.ItemList[id].Clear();
		this.ItemList.splice(id,1);
		this.itemCount = this.ItemList.length;
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height + 2.55;
		this.updateItemsDrawing();
	}

	function ScrollMenu(targetIndex, delay, end, offset)
	{
		if (end == undefined)
		{
			end = false;
		}
		var time = 0.2;
		switch (delay)
		{
			case 150 :
				time = 0.2;
				break;
			case 140 :
				time = 0.09;
				break;
			case 130 :
				time = 0.087;
				break;
			case 120 :
				time = 0.083;
				break;
			case 110 :
				time = 0.08;
				break;
			case 100 :
				time = 0.05;
				break;
			case 90 :
				time = 0.03;
				break;
			case 80 :
				time = 0.02;
				break;
			case 70 :
				time = 0.01;
				break;
			case 60 :
				time = 0.007;
				break;
			case 50 :
				time = 0.003;
				break;
		}
		if (offset != undefined)
		{
			_loc2_ = offset;
		}
		else
		{
			var _loc2_ = this.scrollableContent._y;
			switch (targetIndex)
			{
				case 1 :
					_loc2_ = _loc2_ - 27.55;
					if (end)
					{
						_loc2_ = 0;
					}
					else
					{
						if (_loc2_ <= -this.scrollableContent._height - this.MaxHeight)
						{
							_loc2_ = -this.scrollableContent._height - this.MaxHeight;
						}
					}
					break;
				case -1 :
					_loc2_ = _loc2_ + 27.55;
					if (end)
					{
						_loc2_ = -(this.scrollableContent._height - this.MaxHeight);
					}
					else
					{
						if (_loc2_ >= 0)
						{
							_loc2_ = 0;
						}
					}
					break;
			}
		}
		if (this.EnableAnim)
		{
			com.rockstargames.ui.tweenStar.TweenStarLite.to(this.scrollableContent,time,{_y:_loc2_, onCompleteScope:this, onComplete:this.scrollComplete, onCompleteArgs:[targetIndex, end, _loc2_], ease:this.AnimType});
		}
		else
		{
			this.scrollableContent._y = _loc2_;
		}
	}

	function scrollComplete(dir, end, posy)
	{
		if (!end)
		{
			if (dir == 1)
			{
				if (this.scrollableContent._y != this.MaxHeight - (this.currentItem.itemMC._y + 27.55))
				{
					this.scrollableContent._y = this.MaxHeight - (this.currentItem.itemMC._y + 27.55);
				}
			}
			else if (dir == -1)
			{
				if (this.scrollableContent._y != -this.currentItem.itemMC._y)
				{
					this.scrollableContent._y = -this.currentItem.itemMC._y;
				}
			}
		}
	}

	function GoUp(val)
	{
		this.scrollableContent._y = -this.currentItem.itemMC._y;
		this.updateItemsDrawing();
		return this.currentSelection;
	}

	function GoDown(val)
	{
		this.scrollableContent._y = this.MaxHeight - (this.currentItem.itemMC._y + this.currentItem.itemMC._height + 2.55);
		this.updateItemsDrawing();
		return this.currentSelection;
	}

	function GoLeft()
	{
		var retVal = -1;
		this.updateItemsDrawing();
		return retVal;
	}

	function GoRight()
	{
		var retVal = -1;
		this.updateItemsDrawing();
		return retVal;
	}

	function updateItemsDrawing()
	{
		this.BodyMask._x = this.OFFSET;
		for (var item in this.ItemList)
		{
			this.ItemList[item].Selected = this.ItemList[item].highlighted = this._parentMC.Parent.Focus != 0 && (this._parentMC.currentColumn.column == this || (!this._parentMC.NewStyle && this._parentMC.Focus >= this._id)) && item == this.currentSelection;
		}
		if (this.currentSelection == 0)
		{
			this.scrollableContent._y = -this.currentItem.itemMC._y;
		}
		else if (this.currentSelection == this.MAX_ITEMS - 1)
		{
			this.scrollableContent._y = this.MaxHeight - (this.currentItem.itemMC._y + this.currentItem.itemMC._height + 2.55);
		}

		this.BodyMask.maskMC._height = this.BodyMask.bgMC._height = this.MaxHeight;
		this._itemsOffset = this.BodyMask._y + this.BodyMask.bgMC._height;
		this.updateDescription();
	}

	function updateDescription()
	{
		var offset = this._itemsOffset;
		if (this.Footer == undefined)
		{
			this.Footer = this._MC.attachMovie("MenuFooter", "footer_missions_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		}
		com.rockstargames.ui.utils.Debug.log("this.tot: " + this.tot + ", this.MAX_ITEMS: " + this.MAX_ITEMS);
		if (this.tot > this.MAX_ITEMS)
		{
			this.Footer._visible = this.tot > this.MAX_ITEMS;
			this.Footer._x = this.OFFSET;// cambierà in base alle necessità
			this.Footer._y = MaxHeight;
			offset += this.Footer._height + 1;
		}
		else
		{
			this.Footer._visible = false;
		}
	}

	function setCounter(act, maxItems)
	{
		this.tot = maxItems;
		var subFont = new TextFormat("$Font2", 12);
		if (this._parentMC.Focus < this._id || this._parentMC.Parent.Focus == 0)
		{
			subFont.align = "left";
			com.rockstargames.ui.utils.UIText.setSizedText(this.Footer.numItemsTF,maxItems,false,true);
		}
		else
		{
			this.Footer.numItemsTF.autoSize = "right";
			this.Footer.numItemsTF.text = act + "/" + maxItems;
			this.Footer.numItemsTF._x = 3.5;
			subFont.align = "right";
		}
		this.Footer.numItemsTF.setTextFormat(subFont);
		this.updateItemsDrawing();
	}

	function setMaxItems(max)
	{
		this.MAX_ITEMS = max;
		this._maxItem = max;
		this.updateItemsDrawing();
	}

	function set currentSelection(val)
	{
		this._activeItem = val;
		this.updateItemsDrawing();
	}

	function get currentSelection()
	{
		return this._activeItem;
	}

	function get currentItem()
	{
		return this.ItemList[this.currentSelection];
	}

	function get MaxHeight()
	{
		var _h = 0;

		var limit = this.itemCount;
		for (var i = 0; i < limit; i++)
		{
			_h += this.ItemList[i].itemMC.bgMC._height + 2.55;
		}
		return _h;
	}

	function ClearItems()
	{
		for (var i in this.ItemList)
		{
			this.ItemList[i].Clear();
		}
		this.ItemList = new Array();
		this.itemCount = 0;
		this._activeItem = 0;
	}

	function set IsVisible(v)
	{
		this._isVisible = v;
		this.BodyMask._visible = v;
		this.Footer._visible = v;
		this.DescriptionSprite._visible = v;
	}

	function get IsVisible()
	{
		return this._isVisible;
	}

	function Clear()
	{
		this.BodyMask.removeMovieClip();
		this.Footer.removeMovieClip();
		this.DescriptionSprite.removeMovieClip();
		for (var i in this.ItemList)
		{
			this.ItemList[i].Clear();
		}
		var _MC = null;
		var _parentMC = null;
		var DescriptionSprite = null;
		var EnableAnim = true;
		var AnimType = com.rockstargames.ui.tweenStar.Ease.LINEAR;
		var BodyMask = null;
		var scrollableContent = null;
		var _itemsOffset = 0;
		var ItemList = null;
		var blipLayer = null;
		var _isVisible = false;
		var itemCount = 0;
		var Footer = null;
		var _activeItem = 0;
		var _minItem = 0;
		var _maxItem = 0;
		var MAX_ITEMS = 0;
		var OFFSET = 0;
		var type = "missions";
		var _id = 0;
		var tot = 0;

	}
}