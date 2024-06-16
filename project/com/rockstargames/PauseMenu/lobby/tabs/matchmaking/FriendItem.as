class com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem
{
	var _label;
	var itemMC;
	var parentMC;
	var isColour = false;
	var kick = 0;
	static var AS_OFFLINE = 0;
	static var AS_ONLINE_DIFFERENT_SESSION = 1;
	static var AS_ONLINE_IN_SESSION = 2;
	static var AS_ONLINE_DIFFERENT_MATCH = 3;
	var _highlighted;
	var _view;
	var index;
	var initialIndex;
	var itemColour;
	var itemTextLeft;
	var type;
	var boolL;
	var boolR;
	var iconL;
	var iconR;
	var customIconL;
	var customIconR;
	var storedStatusColID;
	var crewTagMC;
	var uniqueID;
	var panel;
	var _MC;
	var permanentPanel = false;

	//PauseMPMenuFriendsListItem
	function FriendItem(parent, mc, index, _type, _label, hudColor, colorTabMC, icon_1, bool_icon_1, icon_2, bool_icon_2, status, statusColor, rank, crew, permanent)
	{
		this.parentMC = parent;
		this._MC = mc;
		this.itemMC = this._MC.attachMovie("mpFriendsListItem", "friendItem_" + this._MC.getNextHighestDepth(), this._MC.getNextHighestDepth());
		this.itemColour = new com.rockstargames.ui.utils.HudColour();
		this.type = _type;

		this.Label = _label;
		this.setColour(hudColor,colorTabMC);

		if (icon_1 != undefined)
		{
			this.setIconLeft(icon_1,bool_icon_1);
			this.iconL = icon_1;
			this.boolL = bool_icon_1;
		}
		if (icon_2 != undefined)
		{
			this.setIconRight(icon_2,bool_icon_2);
			this.iconR = icon_2;
			this.boolR = bool_icon_2;
		}

		this.setStatus(status,statusColor);
		this.setRank(rank);
		this.setCrew(crew);
		this.highlighted = this._highlighted;

		this.itemMC.attachMovie("mouseCatcher","mouseCatcher",this.itemMC.getNextHighestDepth(),{_width:this.itemMC._width, _height:this.itemMC._height});
		this.itemMC.mouseCatcher.setupGenericMouseInterface(index,this.parentMC._parentMC.GetColumnByType("players").id,this.onMouseEvent,[this]);
		this.permanentPanel = permanent;
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

	// this function is called out of scope of the item itself, use this.something won't do anything!
	function onMouseEvent(evtType, targetMC, args)
	{
		var item = args[0];
		var __reg2 = item.itemColour;
		switch (evtType)
		{
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OUT :
				if (!item._highlighted)
				{
					com.rockstargames.ui.utils.Colour.Colourise(item.itemMC.colourBGMC,__reg2.r,__reg2.g,__reg2.b,20);
				}
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_ROLL_OVER :
				if (!item._highlighted)
				{
					com.rockstargames.ui.utils.Colour.Colourise(item.itemMC.colourBGMC,__reg2.r,__reg2.g,__reg2.b,30);
				}
				//item.mOver();     
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_PRESS :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE :
				break;
			case com.rockstargames.ui.mouse.MOUSE_EVENTS.MOUSE_RELEASE_OUTSIDE :
				break;
		}

	}

	function set Label(_label)
	{
		this._label = _label;
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.labelMC.titleTF,_label,true,false,0,com.rockstargames.ui.utils.UIText.SIZE_GTAG);
		this.updateFont(this.itemMC.labelMC.titleTF,"$Font2_cond");
	}

	function get Label()
	{
		return this._label;
	}

	function setColour(hudColor, colorTabBool)
	{
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(hudColor,this.itemColour);
		this.isColour = hudColor != -1 && hudColor != 0;
		this.itemMC.colourBGMC._visible = this.isColour;
		var _loc6_ = colorTabBool;
		this.itemMC._visible = this.isColour && this.type != com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_OFFLINE;
		if (this.isColour)
		{
			if (this.type != com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_OFFLINE)
			{
				/*com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE*/
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.itemMC.tabMC,colorTabBool ? hudColor : -986896);
			}
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		}
	}

	function setRank(_r)
	{
		this.initialIndex = _r;
		this.setIconRight(this.iconR,this.boolR);
	}

	function setIconLeft(frameStr, isCustom)
	{
		this.iconL = frameStr;
		this.boolL = isCustom;
		if (isCustom == undefined)
		{
			isCustom = false;
		}
		if (!isCustom)
		{
			if (this.customIconL.isLoaded)
			{
				this.customIconL.removeTxdRef();
				this.customIconL.removeMovieClip();
			}
			var __reg3 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(frameStr)[1];
			this.itemMC.labelMC.platformMC.gotoAndStop(__reg3);
			if (this.itemMC.labelMC.platformMC.animIcon)
			{
				this.itemMC.labelMC.platformMC.animIcon.play();
			}
		}
		else
		{
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(0)[1];
			this.itemMC.labelMC.platformMC.gotoAndStop(__reg2);
			this.iconL = frameStr;
			if (frameStr != com.rockstargames.ScaleformUI.utils.Badges.NONE)
			{
				this.customIconL = this.itemMC.attachMovie("txdLoader", "icon_" + this.itemMC.getNextHighestDepth(), this.itemMC.getNextHighestDepth());
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(frameStr, false);
				var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(frameStr);
				this.SetClip(this.customIconL,sprite_txd,sprite_name,24,24,this.iconLoadedL);
			}
			else
			{
				if (this.customIconL.isLoaded)
				{
					this.customIconL.removeTxdRef();
					this.customIconL.removeMovieClip();
				}
			}
		}
	}

	function addPanel(args)
	{
		var id = args[0];
		if (this.panel)
		{
			this.panel.itemMC.removeMovieClip();
		}
		if (id == 0)
		{
			this.panel = new com.rockstargames.PauseMenu.lobby.tabs.MPPlayerCard(this, args[1]);
			this.panel.SET_TITLE(args[2],args[3],args[4]);
			this.panel.SetUpperPanel(args.slice(5));
		}
	}

	function setIconRight(frameStr, isCustom)
	{
		this.iconR = frameStr;
		this.boolR = isCustom;
		if (isCustom == undefined)
		{
			isCustom = false;
		}
		if (!isCustom)
		{
			if (this.customIconR.isLoaded)
			{
				this.customIconR.removeTxdRef();
				this.customIconR.removeMovieClip();
			}
			var __reg3 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(frameStr)[1];
			this.itemMC.labelMC.iconMC.gotoAndStop(__reg3);
			if (this.itemMC.labelMC.iconMC == this.itemMC.labelMC.iconMC)
			{
				if (__reg3 == "RANK_FREEMODE")
				{
					com.rockstargames.gtav.utils.GTAVUIUtils.colourRankIcon(this.itemMC.labelMC.iconMC.rankMC);
					if (this.initialIndex > 0 && this.itemMC.labelMC.valTF)
					{
						this.itemMC.labelMC.valTF.textAutoSize = "shrink";
						this.itemMC.labelMC.valTF.text = this.initialIndex;
					}
				}
				else
				{
					this.itemMC.labelMC.valTF.text = "";
				}
				this.updateFont(this.itemMC.labelMC.valTF,"$Font2_cond");
			}
			if (this.itemMC.labelMC.iconMC.animIcon)
			{
				this.itemMC.labelMC.iconMC.animIcon.play();
			}
		}
		else
		{
			var __reg2 = com.rockstargames.gtav.constants.MPIconLabels.lookUp(0)[1];
			this.itemMC.labelMC.iconMC.gotoAndStop(__reg2);
			this.iconR = frameStr;
			if (frameStr != com.rockstargames.ScaleformUI.utils.Badges.NONE)
			{
				this.customIconR = this.itemMC.attachMovie("txdLoader", "icon_" + this.itemMC.getNextHighestDepth(), this.itemMC.getNextHighestDepth());
				var sprite_name = com.rockstargames.ScaleformUI.utils.Badges.getSpriteNameById(frameStr, false);
				var sprite_txd = com.rockstargames.ScaleformUI.utils.Badges.GetSpriteDictionary(frameStr);
				this.SetClip(this.customIconR,sprite_txd,sprite_name,24,24,this.iconLoadedR);
			}
			else
			{
				if (this.customIconR.isLoaded)
				{
					this.customIconR.removeTxdRef();
					this.customIconR.removeMovieClip();
				}
			}
		}
	}

	function iconLoadedL()
	{
		this.customIconL._visible = true;
		this.customIconL._width = 24;
		this.customIconL._height = 24;
		this.customIconL._x = this.itemMC.labelMC.platformMC._x - 12;
		this.customIconL._y = this.itemMC.labelMC.platformMC._y - 12;
	}
	function iconLoadedR()
	{
		this.customIconR._visible = true;
		this.customIconR._width = 24;
		this.customIconR._height = 24;
		this.customIconR._x = this.itemMC.labelMC.iconMC._x - 12;
		this.customIconR._y = this.itemMC.labelMC.iconMC._y - 12;
	}

	function SetClip(targetMC, textureDict, textureName, w, h, callback)
	{
		var _loc12_ = true;
		if (targetMC.textureFilename != textureName && targetMC.textureDict != textureDict)
		{
			var _loc12_ = false;
		}
		targetMC.init("lobbymenu",textureDict,textureName,w,h);
		var _loc7_ = 4;
		var _loc5_ = String(targetMC).split(".");
		var _loc8_ = _loc5_.slice(_loc5_.length - _loc7_).join(".");
		com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(targetMC);
		targetMC._alpha = 100;
		targetMC.requestTxdRef(_loc8_,_loc12_,callback,this);
	}

	function setStatus(statusStr, statusColID)
	{
		if (statusStr)
		{
			this.itemMC.labelMC.statusMC._visible = true;
			this.itemMC.labelMC.statusMC.labelMC.itemTF.text = statusStr;
			this.updateFont(this.itemMC.labelMC.statusMC.labelMC.itemTF,"$Font2_cond");
			this.itemMC.labelMC.statusMC.bgMC._width = this.itemMC.labelMC.statusMC.labelMC.itemTF.textWidth + 10;
			this.itemMC.labelMC.statusMC.bgMC._x = 145 - this.itemMC.labelMC.statusMC.bgMC._width;
			var __reg2 = 112;
			if (this.itemMC.labelMC.platformMC._currentframe != 1 || this.iconL > 0)
			{
				__reg2 = 87;
			}
			this.itemMC.labelMC.statusMC._x = __reg2;
			this.storedStatusColID = statusColID;
			return;
		}
		this.itemMC.labelMC.statusMC._visible = false;
	}

	function setCrew(crew)
	{
		var __reg4 = crew;
		if (__reg4 == undefined || __reg4 == "")
		{
			if (this.crewTagMC)
			{
				this.crewTagMC._visible = false;
			}
		}
		else
		{
			if (this.crewTagMC == undefined)
			{
				this.crewTagMC = this.itemMC.attachMovie("CREW_TAG_MOVIECLIP", "crewTagMC", this.itemMC.getNextHighestDepth(), {_y:5, _xscale:70, _yscale:70});
			}
			this.crewTagMC.UNPACK_CREW_TAG(__reg4);
			this.crewTagMC._x = this.itemMC.labelMC.titleTF._x + this.itemMC.labelMC.titleTF.textWidth + 8;
			this.crewTagMC._visible = true;
		}
	}

	function set highlighted(_h)
	{
		var __reg11 = this.isColour ? this.itemMC.colourBGMC : this.itemMC.bgMC;
		var __reg2 = new com.rockstargames.ui.utils.HudColour();
		var __reg6 = new com.rockstargames.ui.utils.HudColour();
		var __reg4 = new com.rockstargames.ui.utils.HudColour();
		var __reg3 = new com.rockstargames.ui.utils.HudColour();
		var __reg5 = new com.rockstargames.ui.utils.HudColour();
		var __reg7 = 100;
		var __reg9 = 100;
		var __reg10 = 100;
		if (this.isColour)
		{
			if (this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_OFFLINE)
			{
				__reg7 = _h ? 100 : 0;
				__reg9 = _h ? 60 : 30;
				__reg10 = __reg9;
			}
			else if (this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_ONLINE_DIFFERENT_SESSION)
			{
				__reg7 = _h ? 60 : 20;
				__reg10 = _h ? 60 : 30;
			}
			else if (this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_ONLINE_IN_SESSION)
			{
				__reg7 = _h ? 100 : 20;
			}
			else if (this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_ONLINE_DIFFERENT_MATCH)
			{
				__reg7 = _h ? 60 : 20;
				__reg10 = 60;
			}
			com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg4);
		}
		if (_h)
		{
			if (this.isColour)
			{
				__reg2 = this.itemColour;
				if (this.type == com.rockstargames.PauseMenu.lobby.tabs.matchmaking.FriendItem.AS_OFFLINE)
				{
					com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg6);
				}
				else
				{
					com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg6);
				}
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg4);
			}
			else
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg6);
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg2);
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg4);
				__reg7 = __reg2.a;
			}
			if (this.storedStatusColID == undefined)
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg3);
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg5);
			}
			else
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg3);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.storedStatusColID,__reg5);
			}
		}
		else
		{
			com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg6);
			if (this.isColour)
			{
				__reg2 = this.itemColour;
			}
			else
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG,__reg2);
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg4);
				__reg7 = this.uniqueID == -1 ? 20 : __reg2.a;
			}
			if (this.storedStatusColID == undefined)
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK,__reg3);
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg5);
			}
			else
			{
				com.rockstargames.ui.utils.Colour.setHudColour(com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE,__reg3);
				com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.storedStatusColID,__reg5);
			}
		}

		com.rockstargames.ui.utils.Colour.Colourise(__reg11,__reg2.r,__reg2.g,__reg2.b,__reg7);
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.labelMC.titleTF,__reg6.r,__reg6.g,__reg6.b,__reg9);
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.labelMC.iconMC,__reg4.r,__reg4.g,__reg4.b,__reg4.a);
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.labelMC.statusMC.labelMC,__reg3.r,__reg3.g,__reg3.b,__reg3.a);
		com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.labelMC.statusMC.bgMC,__reg5.r,__reg5.g,__reg5.b,__reg5.a);
		if (this.crewTagMC)
		{
			this.crewTagMC._alpha = __reg9;
		}
		this._highlighted = _h;
	}

	function Clear()
	{
		this.itemMC.mouseCatcher.dispose();
		if (this.panel)
		{
			this.panel.itemMC.removeMovieClip();
		}
		this.itemMC.removeMovieClip();
	}

}