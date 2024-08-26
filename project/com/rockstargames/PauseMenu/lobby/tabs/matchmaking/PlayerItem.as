class com.rockstargames.PauseMenu.lobby.tabs.matchmaking.PlayerItem
{
	static var VEHICLE_ITEM:Number = 0;
	static var PLAYER_BET_ITEM:Number = 1;
	static var PLAYER_ITEM:Number = 2;
	var _isStandalone:Boolean = true;
	var txdCallbackDepth:Number = -1;
	var _highlighted;
	var avatarImg;
	var hBGColour;
	var initialIndex;
	var isAnimating;
	var isSelectable;
	var kickAnim;
	var leftIconColour;
	var nonSelectAlpha;
	var rightIconColour;
	var selectAlpha;
	var type;
	var uniqueID;
	var parentMC;
	var itemMC;
	var customIcon;
	var customIcon_s;
	var customIcon_t;
	var friend_crew_avatar = false;
	var rank;
	var crewTagMC;
	
	//PauseMPMenuMatchmakingCardItem
	function PlayerItem(mc, _type, _label, hudColor, iconL, iconR, rankIcon, txd, txn, friendOrCrew, rank)
	{
		com.rockstargames.ui.utils.Debug.log("Addin player to player list: (" + arguments + ")");
		this.parentMC = mc;
		this.type = _type;
		this.itemMC = this.parentMC.attachMovie("mpMMCardItem", "cardItem_" + this.parentMC.getNextHighestDepth(), this.parentMC.getNextHighestDepth());
		this.hBGColour = new com.rockstargames.ui.utils.HudColour();
		this.leftIconColour = new com.rockstargames.ui.utils.HudColour();
		this.rightIconColour = new com.rockstargames.ui.utils.HudColour();
		this.selectAlpha = 100;
		this.nonSelectAlpha = 30;
		this.kickAnim = 0;
		this.isAnimating = false;
		this.itemMC.labelMC.nameTF.textAutoSize = "shrink";
		this.itemMC.rankNumTF.textAutoSize = "shrink";
		this.itemMC.oddsTF.textAutoSize = "shrink";
		var __reg6 = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg6);
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.bgMC,__reg6.r,__reg6.g,__reg6.b,50);
		this.itemMC.groupBGMC._visible = false;
		this.itemMC.groupNumTF._visible = false;
		this.itemMC.colourIconL._visible = this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.PlayerItem.VEHICLE_ITEM;
		this.itemMC.colourIconR._visible = this.itemMC.colourIconL._visible;
		this.itemMC.colourStrokeMC._visible = false;
		this.itemMC.eyeMC._visible = false;
		if (this.itemMC.crewTagMC)
		{
			this.itemMC.crewTagMC._visible = false;
		}
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.carIconBGMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
		this.itemMC.rankNumTF.text = this.initialIndex;
		this.itemMC.rankBGMC._visible = false;
		this.itemMC.carIconBGMC._visible = false;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.labelMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		this.itemMC.betMC._visible = false;
		this.itemMC.oddsTF._visible = false;
		this.setLabel(_label);
		this.setItemColour(hudColor);
		this.setAvatarImg(txd,txn);
		this.setRank(rank);
		this.setIconLeft(iconL,this.itemMC.icon1MC,true);
		this.setIconCenter(iconR,this.itemMC.icon2MC,true);
		this.setIconRight(rankIcon,this.itemMC.icon3MC,false);
		this.placeBet("1000$");

		this.formatNameTF();
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


	function setLabel(_label)
	{
		if (_label == "")
		{
			_label = "-";
		}
		this.itemMC.labelMC.titleTF.text = this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.PlayerItem.VEHICLE_ITEM ? _label : "";
		this.itemMC.labelMC.nameTF.text = this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.PlayerItem.VEHICLE_ITEM ? "" : _label;
		this.updateFont(this.itemMC.labelMC.titleTF, "$Font2_cond");
		this.updateFont(this.itemMC.labelMC.nameTF, "$Font2_cond");
	}

	function isSpectator(_s)
	{
		this.itemMC.eyeMC._visible = _s;
	}

	function placeBet(betText, odds)
	{
		if (betText)
		{
			this.itemMC.betMC._visible = true;
			this.itemMC.betMC.labelMC.itemTF.text = betText;
			this.itemMC.betMC.bgMC._width = this.itemMC.betMC.labelMC.itemTF.textWidth + 10;
			this.itemMC.betMC.bgMC._x = 145 - this.itemMC.betMC.bgMC._width;
		}
		else
		{
			this.itemMC.betMC._visible = false;
		}
		if (odds)
		{
			this.itemMC.oddsTF._visible = true;
			this.itemMC.oddsTF.text = odds;
		}
		else
		{
			this.itemMC.oddsTF._visible = false;
		}
		this.itemMC.betMC.bgMC._visible = true;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.betMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_GREEN);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.betMC.labelMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		this.updateFont(this.itemMC.betMC.labelMC.itemTF, "$Font2_cond");
		this.formatNameTF();
	}

	function setRank(rank)
	{
		this.itemMC.rankNumTF.text = rank == undefined ? "" : String(rank);
		this.updateFont(this.itemMC.rankNumTF, "$Font2_cond");
	}

	function setItemColour(hudColour)
	{
		com.rockstargames.ui.utils.Colour.setHudColour(hudColour,this.hBGColour);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.hostMC,hudColour);
		var __reg2 = this.highlighted ? this.selectAlpha : this.nonSelectAlpha;
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.highlightBGMC,this.hBGColour.r,this.hBGColour.g,this.hBGColour.b,__reg2);
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.groupBGMC,this.hBGColour.r,this.hBGColour.g,this.hBGColour.b,__reg2);
	}

	function setIconLeft(iconEnum, iconMC, isCustom)
	{
		if (isCustom == undefined)
		{
			isCustom = false;
		}
		if (!isCustom)
		{
			if (this.customIcon.isLoaded)
			{
				this.customIcon.removeTxdRef();
				this.customIcon.removeMovieClip();
			}
			if (iconEnum == undefined)
			{
				iconEnum = 0;
			}
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(iconEnum)[1];
			iconMC.gotoAndStop(__reg2);
			if (__reg2 == "RANK_FREEMODE")
			{
				com.rockstargames.gtav.utils.GTAVUIUtils.colourRankIcon(iconMC.rankMC);
			}
			if (iconMC.animIcon)
			{
				iconMC.animIcon.play();
			}
		}
		else
		{
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(0)[1];
			iconMC.gotoAndStop(__reg2);
			if (iconEnum != com.rockstargames.ScaleformUI.utils.Badges.NONE)
			{
				this.customIcon = this.itemMC.attachMovie("txdLoader", "icon_" + this.itemMC.getNextHighestDepth(), this.itemMC.getNextHighestDepth());
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(iconEnum, false);
				var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(iconEnum);
				this.SetClip(this.customIcon,sprite_txd,sprite_name,24,24,this.iconLoaded);
			}
			else
			{
				if (this.customIcon.isLoaded)
				{
					this.customIcon.removeTxdRef();
					this.customIcon.removeMovieClip();
				}
			}
		}
	}

	function setIconCenter(iconEnum, iconMC, isCustom)
	{
		if (isCustom == undefined)
		{
			isCustom = false;
		}
		if (!isCustom)
		{
			if (this.customIcon_s.isLoaded)
			{
				this.customIcon_s.removeTxdRef();
				this.customIcon_s.removeMovieClip();
			}
			if (iconEnum == undefined)
			{
				iconEnum = 0;
			}
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(iconEnum)[1];
			iconMC.gotoAndStop(__reg2);
			if (__reg2 == "RANK_FREEMODE")
			{
				com.rockstargames.gtav.utils.GTAVUIUtils.colourRankIcon(iconMC.rankMC);
			}
			if (iconMC.animIcon)
			{
				iconMC.animIcon.play();
			}
		}
		else
		{
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(0)[1];
			iconMC.gotoAndStop(__reg2);
			if (iconEnum != com.rockstargames.ScaleformUI.utils.Badges.NONE)
			{
				this.customIcon_s = this.itemMC.attachMovie("txdLoader", "icon_" + this.itemMC.getNextHighestDepth(), this.itemMC.getNextHighestDepth());
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(iconEnum, false);
				var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(iconEnum);
				this.SetClip(this.customIcon_s,sprite_txd,sprite_name,24,24,this.iconLoaded_s);
			}
			else
			{
				if (this.customIcon_s.isLoaded)
				{
					this.customIcon_s.removeTxdRef();
					this.customIcon_s.removeMovieClip();
				}
			}
		}
	}

	function setIconRight(iconEnum, iconMC, isCustom)
	{
		if (isCustom == undefined)
		{
			isCustom = false;
		}
		if (!isCustom)
		{
			if (this.customIcon_t.isLoaded)
			{
				this.customIcon_t.removeTxdRef();
				this.customIcon_t.removeMovieClip();
			}
			if (iconEnum == undefined)
			{
				iconEnum = 0;
			}
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(iconEnum)[1];
			iconMC.gotoAndStop(__reg2);
			if (__reg2 == "RANK_FREEMODE")
			{
				com.rockstargames.gtav.utils.GTAVUIUtils.colourRankIcon(iconMC.rankMC);
			}
			if (iconMC.animIcon)
			{
				iconMC.animIcon.play();
			}
		}
		else
		{
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(0)[1];
			iconMC.gotoAndStop(__reg2);
			if (iconEnum != com.rockstargames.ScaleformUI.utils.Badges.NONE)
			{
				this.customIcon_t = this.itemMC.attachMovie("txdLoader", "icon_" + this.itemMC.getNextHighestDepth(), this.itemMC.getNextHighestDepth());
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(iconEnum, false);
				var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(iconEnum);
				this.SetClip(this.customIcon_t,sprite_txd,sprite_name,24,24,this.iconLoaded_t);
			}
			else
			{
				if (this.customIcon_t.isLoaded)
				{
					this.customIcon_t.removeTxdRef();
					this.customIcon_t.removeMovieClip();
				}
			}
		}
	}


	function iconLoaded()
	{
		this.customIcon._visible = true;
		this.customIcon._width = 24;
		this.customIcon._height = 24;
		this.customIcon._x = this.itemMC.icon1MC._x - 12;
		this.customIcon._y = this.itemMC.icon1MC._y - 12;
	}

	function iconLoaded_s()
	{
		this.customIcon_s._visible = true;
		this.customIcon_s._width = 24;
		this.customIcon_s._height = 24;
		this.customIcon_s._x = this.itemMC.icon2MC._x - 12;
		this.customIcon_s._y = this.itemMC.icon2MC._y - 12;
	}

	function iconLoaded_t()
	{
		this.customIcon_t._visible = true;
		this.customIcon_t._width = 24;
		this.customIcon_t._height = 24;
		this.customIcon_t._x = this.itemMC.icon3MC._x - 12;
		this.customIcon_t._y = this.itemMC.icon3MC._y - 12;
	}

	function SetClip(targetMC, textureDict, textureName, w, h, callback)
	{
		var _loc12_ = true;
		if (targetMC.textureFilename != textureName && targetMC.textureDict != textureDict)
		{
			var _loc12_ = false;
		}
		targetMC.init("lobbymenu",textureDict,textureName,w,h);
		var _loc7_ = 2;
		var _loc5_ = String(targetMC).split(".");
		var _loc8_ = _loc5_.slice(_loc5_.length - _loc7_).join(".");
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(targetMC);
		targetMC._alpha = 100;
		targetMC.requestTxdRef(_loc8_,_loc12_,callback,this);
	}


	function setAvatarImg(txd, txn)
	{
		if (txd != undefined && txn != undefined)
		{
			if (txd != "" && txn != "")
			{
				this.ADD_TXD_REF(txd,txn);
			}
		}
	}

	function setCrewTag(crewTagStr)
	{
		if (crewTagStr && crewTagStr != "")
		{
			if (!this.crewTagMC)
			{
				this.crewTagMC = this.itemMC.attachMovie("CREW_TAG_MOVIECLIP", "crewTagMC", this.itemMC.getNextHighestDepth(), {_y:5, _xscale:70, _yscale:70});
			}
			this.crewTagMC.UNPACK_CREW_TAG(crewTagStr);
			this.crewTagMC._visible = true;
		}
	}

	function formatNameTF()
	{
		var __reg2 = 210 - (this.itemMC.crewTagMC._visible ? this.itemMC.crewTagMC._width : 0) - (this.itemMC.betMC._visible ? this.itemMC.betMC.bgMC._width : 0);
		this.itemMC.labelMC.nameTF._width = __reg2;
		this.itemMC.crewTagMC._x = this.itemMC.labelMC._x + this.itemMC.labelMC.nameTF._x + this.itemMC.labelMC.nameTF.textWidth + 10;
	}

	function animateKick(doAnimate)
	{
		if (doAnimate)
		{
			com.rockstargames.ui.tweenStar.TweenStarLite.delayCall(this.itemMC.rankNumTF,1,{onCompleteScope:this, onComplete:this.kickflip});
			this.isAnimating = true;
			return;
		}
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.itemMC.rankNumTF);
		this.isAnimating = false;
	}

	function kickflip()
	{
		this.kickAnim < 1 ? this.kickAnim++ : (this.kickAnim = 0);
		if (this.kickAnim)
		{
			this.itemMC.icon3MC.gotoAndStop("KICK");
			//this.itemMC.icon3MC.numTF.text = this.__get__data()[8];
			this.itemMC.rankNumTF._visible = false;
		}
		else
		{
			//this.itemMC.icon3MC.gotoAndStop(this.__get__data()[3][2]);
			this.itemMC.rankNumTF._visible = true;
		}
		this.animateKick(true);
	}

	function set highlighted(_h)
	{
		var __reg2 = _h ? this.selectAlpha : this.nonSelectAlpha;
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.highlightBGMC,this.hBGColour.r,this.hBGColour.g,this.hBGColour.b,__reg2);
		if (this.itemMC.groupBGMC._visible)
		{
			this.itemMC.groupNumTF._alpha = __reg2 + 25;
			com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.groupBGMC,this.hBGColour.r,this.hBGColour.g,this.hBGColour.b,__reg2);
		}
		this._highlighted = _h;
	}

	function set isStandalone(_s)
	{
		this._isStandalone = _s;
	}

	function get isStandalone()
	{
		return this._isStandalone;
	}

	function ADD_TXD_REF(txd, txn)
	{
		if (this.avatarImg == undefined)
		{
			this.avatarImg = this.itemMC.attachMovie("avatarImage", "a", this.itemMC.getNextHighestDepth(), {_x:25, _y:0});
		}
		var __reg4 = "LobbyMenu";
		if (this.avatarImg.textureDict == txd)
		{
			if (this.avatarImg.isLoaded)
			{
				if (this.avatarImg.textureFilename != txn)
				{
					this.avatarImg.init(__reg4,txd,txn,25,25);
					this.avatarImg.displayTxdResponse(txd);
				}
			}
			return;
		}
		if (this.avatarImg.isLoaded)
		{
			this.avatarImg.removeTxdRef();
		}
		this.avatarImg.init(__reg4,txd,txn,25,25);
		var __reg2 = 2;
		if (this.txdCallbackDepth != -1)
		{
			__reg2 = this.txdCallbackDepth;
		}
		var __reg5 = this.avatarImg.splitPath(String(this.avatarImg), __reg2);
		this.avatarImg.requestTxdRef(__reg5,true);
	}
	
	function Clear(){
		this.avatarImg.removeTxdRef();
		this.itemMC.removeMovieClip();
	}

	function ON_DESTROY()
	{
		this.animateKick(false);
		if (this.avatarImg != undefined && this.avatarImg.isLoaded)
		{
			this.avatarImg.removeTxdRef();
		}
	}
}