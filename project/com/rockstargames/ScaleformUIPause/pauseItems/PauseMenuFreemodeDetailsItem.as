class com.rockstargames.ScaleformUIPause.pauseItems.PauseMenuFreemodeDetailsItem extends com.rockstargames.gtav.pauseMenu.pauseMenuItems.PauseMenuBaseItem
{
	var outlineMC;
	var basetextW = 266;
	var itemTextRight;
	var bgMC;
	var labelMC;
	var crewTagMC;
	function PauseMenuFreemodeDetailsItem()
	{
		super();
		_global.gfxExtensions = true;
		this.outlineMC._visible = false;
		this.itemTextRight = this.labelMC.valueTF;
		this.itemTextLeft = this.leftlabelMC.titleTF;
		this.basetextW = this.itemTextLeft._width;
		this.bgMC._visible = false;
		this.labelMC.scIconMC._visible = false;
		if (this.checkMC)
		{
			this.checkMC._visible = false;
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.checkMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN);
		}
		this.labelMC.nameTF.textAutoSize = "shrink";
		this.iconMC.attachMovie("txdLoader","badge",this.iconMC.getNextHighestDepth());
	}

	function set data(d)
	{
		super.data = d;
		if (this.data[1] != undefined)
		{
			com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextRight,this.data[1],true);
		}
		this.snapBGGrid(this.bgMC);
		if (this.type >= 0 && this.type < 4)
		{
			if (this.index % 2 == 1)
			{
				com.rockstargames.ui.utils.Colour.ApplyHudColour(this.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
				this.bgMC._alpha = 20;
				this.bgMC._height = 25;
				this.bgMC._y = 2;
				this.bgMC._visible = true;
			}
		}

		switch (this.type)
		{
			case 0 :
			case 1 :
				this.setIcon(0,this.iconMC.badge);
				this.itemTextRight._width = 288 - (this.itemTextLeft._x + this.itemTextLeft.textWidth + 25);
				this.itemTextRight._x = 288 - this.itemTextRight._width - 6;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextLeft,this.data[2]);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextRight,this.data[3]);
				break;
			case 2 :
				this.setIcon(this.data[2],this.iconMC.badge);
				this.iconMC._x = 261;
				this.iconMC._y = 3;
				var _loc8_ = 5;
				this.itemTextRight._x = this.iconMC._x - this.iconMC.badge._width - 132 - _loc8_;
				var _loc7_ = com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE;
				if (this.data[3] != undefined)
				{
					_loc7_ = this.data[3];
				}
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.iconMC,_loc7_);
				if (this.data[4] != undefined)
				{
					if (this.checkMC)
					{
						this.checkMC._visible = this.data[4];
					}
				}
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextLeft,this.data[5]);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextRight,this.data[6]);
				break;
			case 3 :
				this.setIcon(0,this.iconMC.badge);
				this.labelMC.nameTF.text = this.data[1];
				this.itemTextRight._visible = false;
				var _loc4_ = this.data[2];
				if (_loc4_ == undefined || _loc4_ == "")
				{
					if (this.crewTagMC)
					{
						this.crewTagMC._visible = false;
					}
				}
				else
				{
					if (!this.crewTagMC)
					{
						this.crewTagMC = this.attachMovie("CREW_TAG_MOVIECLIP", "crewTagMC", this.getNextHighestDepth(), {_y:5, _xscale:60, _yscale:60});
					}
					this.crewTagMC.UNPACK_CREW_TAG(_loc4_);
					this.crewTagMC._visible = true;
					this.crewTagMC._x = 288 - this.crewTagMC._width + 3;
					this.labelMC.nameTF._x = this.crewTagMC._x - 6 - this.labelMC.nameTF._width;
				}
				if (this.data[3])
				{
					this.labelMC.scIconMC._visible = true;
					this.labelMC.nameTF._x = 124;
				}
				else
				{
					this.labelMC.scIconMC._visible = false;
				}
				break;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextLeft,this.data[4]);
			case 4 :
				this.setIcon(0,this.iconMC.badge);
				this.outlineMC._visible = true;
				this.leftlabelMC._y = this.bgMC._y = this.labelMC._y = 2;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextLeft,this.data[2]);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextRight,this.data[3]);
				break;
			case 5 :
				this.setIcon(0,this.iconMC.badge);
				this.outlineMC._visible = true;
				var _loc9_ = this.data[0];
				var _loc5_ = this.itemTextLeft.getTextFormat();
				_loc5_.size = com.rockstargames.ui.utils.UIText.SIZE;
				this.itemTextLeft.setNewTextFormat(_loc5_);
				this.itemTextLeft.wordWrap = true;
				this.itemTextLeft.multiline = true;
				this.itemTextLeft.autoSize = true;
				this.itemTextLeft.text = _loc9_;
				if (this.itemTextLeft._height > 100)
				{
					this.itemTextLeft.autoSize = false;
					this.itemTextLeft._height = 100;
					while (this.itemTextLeft.textHeight > this.itemTextLeft._height)
					{
						var _loc3_ = this.itemTextLeft.text.substr(0, this.itemTextLeft.text.length - 4) + "...";
						this.itemTextLeft.text = _loc3_;
					}
					this.itemTextLeft.autoSize = true;
				}
				this.itemTextLeft._y = -2;
				this.itemTextRight._visible = false;
				this.bgMC._height = this.itemTextLeft.textHeight <= 0 ? 0 : this.itemTextLeft.textHeight + 16;
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.UpdateFont(this.itemTextLeft,this.data[2]);
		}
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.leftlabelMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.labelMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
	}
	function snapBGGrid(bgMC)
	{
		var _loc2_ = Math.ceil(this.itemTextLeft.textHeight / 27);
		bgMC._height = _loc2_ * 27 - 2;
	}

	function setIcon(id, fMC)
	{
		if (id != com.rockstargames.ScaleformUI.utils.Badges.NONE)
		{
			var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(id, this._highlighted);
			var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(id);
			com.rockstargames.ScaleformUI.utils.MovieClipHandler.SetClipPM(fMC,sprite_txd,sprite_name,20,20);
		}
		else
		{
			if (fMC.isLoaded)
			{
				fMC.removeTxdRef();
			}
		}
	}

	function set highlighted(_h)
	{
		this._highlighted = _h;
	}
	function mOver()
	{
	}
	function mOut()
	{
	}
	function mPress()
	{
	}

}