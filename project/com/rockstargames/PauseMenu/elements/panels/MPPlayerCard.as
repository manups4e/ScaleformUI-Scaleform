class com.rockstargames.PauseMenu.elements.panels.MPPlayerCard
{
	var DESC_TYPE_TXT:Number = 0;
	var DESC_TYPE_SC:Number = 1;
	var DESC_TYPE_INV_SENT:Number = 2;
	var startStatLabelAnim:Boolean = false;
	var delay:Number = 3;
	var itemMC;
	var RANK_TEXTFIELD_MAX_WIDTH;
	var RANK_TEXT_CENTER_X;
	var RANK_TEXT_DEFAULT_WIDTH;
	var RANK_TEXT_HEIGHT_MULTIPLIER;
	var RANK_TEXT_MAX_HEIGHT;
	var btnLayer;
	var crewEmblemMC;
	var dbgID;
	var playerColourEnum;
	var statID;
	var statMCs;
	var visible = true;
	var _MC;
	var parentMC;
	var collapsed;
	var descItems = [];
	var listDescItem = 0;

	function MPPlayerCard(parent, bCollapse)
	{
		this.parentMC = parent;
		this._MC = this.parentMC.parentMC._MC;
		this.collapsed = bCollapse;
		this.descItems = new Array();
		this.listDescItem = 0;
		if (this.collapsed)
		{
			this.itemMC = this._MC.attachMovie("playerComparisonCard", "MpPlayerCard", this._MC.getNextHighestDepth());
		}
		else
		{
			this.itemMC = this._MC.attachMovie("mpPlayerCard", "MpPlayerCard", this._MC.getNextHighestDepth());
		}
		this.statMCs = [];
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.headerBGMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.statsBGMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemMC.item0TF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemMC.item1TF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemMC.item2TF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		var _loc3_ = this.itemMC.vehiclePanelMC;
		_loc3_.titleTF.textAutoSize = "shrink";
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(_loc3_.titleTF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(_loc3_.wrapperMC.vehicleMC1,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(_loc3_.wrapperMC.vehicleMC2,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(_loc3_.wrapperMC.vehicleMC3,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(_loc3_.wrapperMC.vehicleMC4,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		if (_loc3_.wrapperMC.micMC)
		{
			com.rockstargames.ui.utils.Colour.ApplyHudColour(_loc3_.wrapperMC.micMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		}
		com.rockstargames.ui.utils.Colour.ApplyHudColour(_loc3_.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemMC.crewInfoMC.crewNameTF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		com.rockstargames.ui.utils.Colour.ApplyHudColourToTF(this.itemMC.crewInfoMC.rankNameTF,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_WHITE);
		this.itemMC._x = this.parentMC._parentMC.missionDetails.OFFSET + (this.collapsed ? 144 : 0);
		if (bCollapse)
		{
			this.RANK_TEXT_CENTER_X = 69;
			this.RANK_TEXT_DEFAULT_WIDTH = 46;
			this.RANK_TEXT_MAX_HEIGHT = 46;
			this.RANK_TEXT_HEIGHT_MULTIPLIER = 15;
			this.RANK_TEXTFIELD_MAX_WIDTH = 65;
			this.statID = "playerComparisonItem";
		}
		else
		{
			this.RANK_TEXT_CENTER_X = 46;
			this.RANK_TEXT_DEFAULT_WIDTH = 60;
			this.RANK_TEXT_MAX_HEIGHT = 46;
			this.RANK_TEXT_HEIGHT_MULTIPLIER = 15;
			this.RANK_TEXTFIELD_MAX_WIDTH = 70;
			this.statID = "statItem";
		}
		com.rockstargames.ui.utils.Localisation.setTextWithTranslation(_loc3_.titleTF,"VEH_ACCESS",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,false);
		com.rockstargames.ui.utils.UIText.setSizedText(_loc3_.titleTF,_loc3_.titleTF.text,true);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.descMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		this.updateFont(_loc3_.titleTF,"$Font2");
		this.itemMC.descMC._visible = false;
		this.itemMC.rankNumTF.textAutoSize = "shrink";
		this.itemMC.crewInfoMC.crewRankTF.textAutoSize = "shrink";
		this.itemMC.crewInfoMC._visible = false;
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.crewInfoMC.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
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

	function SET_TITLE()
	{
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.titleTF,arguments[0],true,false,18,18);
		this.updateFont(this.itemMC.titleTF,"$Font2");
		this.playerColourEnum = arguments[2];
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.ApplyHexColour(this.itemMC.titleBGMC,this.playerColourEnum);
		if (arguments[1] == "" || arguments[1] == undefined)
		{
			this.itemMC.crewInfoMC._visible = false;
			this.itemMC.crewTagMC._visible = false;
		}
		else
		{
			this.itemMC.crewTagMC.UNPACK_CREW_TAG(arguments[5]);
			this.itemMC.crewTagMC._x = this.itemMC.titleTF._x + this.itemMC.titleTF.textWidth + 10;
			this.itemMC.crewTagMC._visible = true;
			this.itemMC.crewInfoMC.crewTagMC.UNPACK_CREW_TAG(arguments[5]);
			var __reg4 = arguments[6];
			var __reg3 = arguments[7];
			if (__reg4 && __reg3)
			{
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.crewInfoMC.crewNameTF,arguments[1],true);
				com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.crewInfoMC.rankNameTF,arguments[4],true);
				this.itemMC.crewInfoMC.crewRankTF.text = arguments[8] == undefined ? "" : arguments[8];

				this.updateFont(this.itemMC.crewInfoMC.crewNameTF,"$Font2_cond");
				this.updateFont(this.itemMC.crewInfoMC.rankNameTF,"$Font2_cond");
				this.updateFont(this.itemMC.crewInfoMC.crewRankTF,"$Font2_cond");

				if (!this.crewEmblemMC)
				{
					var __reg6 = 41;
					if (this.itemMC.vehiclePanelMC._width > 150)
					{
						__reg6 = 10;
					}
					this.crewEmblemMC = this.itemMC.crewInfoMC.cMC.attachMovie("txdLoader", "playerCardCrewEmblemMC", this.itemMC.crewInfoMC.getNextHighestDepth(), {_x:__reg6, _y:9});
				}
				if (this.crewEmblemMC.textureFilename != __reg3 && this.crewEmblemMC.textureDict != __reg4)
				{
					if (this.crewEmblemMC.isLoaded)
					{
						this.crewEmblemMC.removeTxdRef();
					}
					this.crewEmblemMC.init(com.rockstargames.ScaleformUI.utils.MovieClipHandler.GFXNAME,__reg4,__reg3,61,61);
					var __reg7 = 3;
					var __reg5 = String(this.crewEmblemMC).split(".");
					var __reg8 = __reg5.slice(__reg5.length - __reg7).join(".");
					com.rockstargames.ui.tweenStar.TweenStarLite.removeTweenOf(this.crewEmblemMC);
					this.crewEmblemMC._alpha = 100;
					this.crewEmblemMC.addTxdRef(__reg8,this.txdloaded,this);
				}
				if (arguments[9] != undefined)
				{
					if (this.itemMC.crewInfoMC.rankBGMC)
					{
						com.rockstargames.ui.utils.Colour.Colourise(this.itemMC.crewInfoMC.rankBGMC,arguments[9],arguments[10],arguments[11],100);
					}
					this.itemMC.crewInfoMC._visible = true;
				}
			}
		}
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemMC.titleValTF,arguments[13] || "");
		this.updateFont(this.itemMC.titleValTF,"$Font2");

		if (this.itemMC.crewInfoMC._visible)
		{
			this.itemMC.descMC._visible = false;
		}
	}

	function txdloaded()
	{
		this.crewEmblemMC._alpha = 0;
		com.rockstargames.ui.tweenStar.TweenStarLite.to(this.crewEmblemMC,0.2,{_alpha:100});
	}

	function SetUpperPanel(args)
	{
		var rankN = args[0];
		var bool1 = args[1];
		var bool2 = args[2];
		var bool3 = args[3];
		var bool4 = args[4];
		var _icon = args[5];
		this.itemMC.vehiclePanelMC._visible = args[15];
		var __reg15 = this.itemMC.vehiclePanelMC.wrapperMC;
		var __reg19 = _icon;
		if (__reg19 > 0 && __reg15.micMC)
		{
			__reg15.micMC.gotoAndStop(__reg19 + 1);
		}
		__reg15.vehicleMC1._alpha = bool1 ? 100 : 30;
		__reg15.vehicleMC2._alpha = bool2 ? 100 : 30;
		__reg15.vehicleMC3._alpha = bool3 ? 100 : 30;
		__reg15.vehicleMC4._alpha = bool4 ? 100 : 30;
		var __reg20 = rankN;
		this.itemMC.rankNumTF._width = this.RANK_TEXT_DEFAULT_WIDTH * 0.5;
		this.itemMC.rankNumTF.text = __reg20;
		this.itemMC.rankNumTF._width = Math.min(this.RANK_TEXTFIELD_MAX_WIDTH, this.RANK_TEXT_DEFAULT_WIDTH + (this.RANK_TEXT_MAX_HEIGHT / this.itemMC.rankNumTF.textHeight - 1) * this.RANK_TEXT_HEIGHT_MULTIPLIER) * 0.5;
		this.itemMC.rankNumTF._x = this.RANK_TEXT_CENTER_X - this.itemMC.rankNumTF._width * 0.5;
		this.updateFont(this.itemMC.rankNumTF,"$Font2_cond_NOT_GAMERNAME");
		if (this.itemMC.rankEmblemMC)
		{
			var __reg21 = com.rockstargames.ui.utils.HudColour.getGlobeColID(__reg20);
			com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemMC.rankEmblemMC,__reg21);
		}
		var __reg13 = args.length;
		var __reg4 = 6;
		var __reg6 = 0;
		while (__reg4 < __reg13)
		{
			var __reg5 = this.itemMC["item" + __reg6 + "TF"];
			if (__reg5 != undefined)
			{
				var __reg9 = args[__reg4] == undefined ? "" : args[__reg4];
				com.rockstargames.ui.utils.UIText.setSizedText(__reg5,__reg9,true);
				this.updateFont(__reg5,"$Font2");
			}
			////// FARE CODICE PER CUSTOM ICONS                
			var __reg8 = args[__reg4 + 1];
			var __reg7 = this.itemMC["icon" + __reg6 + "MC"];
			__reg7.gotoAndStop(com.rockstargames.gtav.constants.MPIconLabels.lookUp(__reg8)[1]);
			if (__reg8 != com.rockstargames.gtav.constants.MPIconLabels.EMPTY[0])
			{
				__reg5._x = 82;
				if (__reg7)
				{
					com.rockstargames.ui.utils.Colour.ApplyHudColour(__reg7,args[__reg4 + 2]);
				}
			}
			////// FARE CODICE PER CUSTOM ICONS                
			__reg4 = __reg4 + 3;
			++__reg6;
		}
		this.startStatLabelAnim = false;
	}

	function AddStatItem(args)
	{
		var __reg14 = args[0];
		var _barVisible = args[4] != -1;
		var __reg12 = undefined;
		if (this.statMCs[__reg14])
		{
			__reg12 = this.statMCs[__reg14];
		}
		else
		{
			__reg12 = com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuPlayerCardItem(this.itemMC.attachMovie(this.statID, this.statID + __reg14 + "MC", __reg14));
			__reg12.bgMC._visible = false;
			__reg12._y = this.itemMC.headerBGMC._y + this.itemMC.headerBGMC._height + 2 + __reg14 * __reg12._height;
			this.statMCs[__reg14] = __reg12;
			var __reg23 = __reg12.isCompareWidth;
			var __reg11 = this.statMCs.length;
			var __reg10 = 200 / __reg11;
			var __reg18 = 5;
			if (__reg11 > __reg18)
			{
				var __reg16 = 4 - 2 * (__reg11 - __reg18);
				var __reg17 = 26 - 2 * (__reg11 - __reg18);
				var __reg24 = 26 - 2 * (__reg11 - __reg18);
				var __reg4 = 0;
				while (__reg4 < __reg11)
				{
					var __reg3;
					var __reg3 = com.rockstargames.gtav.pauseMenu.pauseMenuItems.multiplayer.PauseMPMenuPlayerCardItem(this.statMCs[__reg4]);
					__reg3.innerMC.titleTF._y = __reg3.innerMC.valTF._y = __reg16;
					__reg3.innerMC.progressBarMC._y = __reg17;
					__reg3.bgMC._height = __reg10;
					__reg3._y = this.itemMC.headerBGMC._y + this.itemMC.headerBGMC._height + 2 + __reg4 * __reg10;
					this.updateFont(__reg3.innerMC.titleTF,"$Font2");
					this.updateFont(__reg3.innerMC.valTF,"$Font2");
					++__reg4;
				}
			}
		}
		__reg12._visible = true;
		var _loc1_ = new com.rockstargames.ui.utils.HudColour();
		com.rockstargames.ScaleformUI.utils.MovieClipHandler.HexToARGB(this.playerColourEnum,_loc1_);
		__reg12.setCustomColour(_loc1_);
		__reg12.init(args.slice(1));
		if (!_barVisible)
		{
			__reg12.innerMC.progressBarMC._visible = false;
			//__reg12.innerMC.titleTF._y += 6;
			//__reg12.innerMC.valTF._y += 6;
		}
		this.updateFont(__reg12.innerMC.titleTF,"$Font2");
		this.updateFont(__reg12.innerMC.valTF,"$Font2");
		this.itemMC.vehiclePanelMC._y = Math.round(__reg12._y + __reg12._height);
		this.itemMC.crewInfoMC._y = this.itemMC.vehiclePanelMC._visible ? this.itemMC.vehiclePanelMC._y + 43 : Math.round(__reg12._y + __reg12._height) + 10;
		this.itemMC.descMC._y = this.itemMC.crewInfoMC._y;
		this.itemMC.statsBGMC._height = this.itemMC.crewInfoMC._y - 2 - this.itemMC.statsBGMC._y;
		this.setOffBlinking(__reg14);
	}

	function setOffBlinking(i)
	{
		if (i == 5 && !this.startStatLabelAnim)
		{
			var __reg2 = this.statMCs[0];
			if (__reg2.__get__isCompareWidth())
			{
				this.showStatCat();
				this.startStatLabelAnim = true;
			}
		}
	}

	function showStatCat()
	{
		var __reg4 = this.statMCs.length;
		var __reg2 = 0;
		while (__reg2 < __reg4)
		{
			var __reg3 = this.statMCs[__reg2];
			__reg3.blinkText(__reg3.lbl);
			++__reg2;
		}
		com.rockstargames.ui.tweenStar.TweenStarLite.delayCall(this.itemMC,this.delay,{onComplete:this.showStatVal, onCompleteScope:this});
	}

	function showStatVal()
	{
		var __reg4 = this.statMCs.length;
		var __reg2 = 0;
		while (__reg2 < __reg4)
		{
			var __reg3 = this.statMCs[__reg2];
			__reg3.blinkText(__reg3.val);
			++__reg2;
		}
		com.rockstargames.ui.tweenStar.TweenStarLite.delayCall(this.itemMC,this.delay,{onComplete:this.showStatCat, onCompleteScope:this});
	}

	function ADD_DETAILS_ITEM(id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10)
	{
		if (!this.collapsed)
		{
			var item = new com.rockstargames.PauseMenu.elements.items.FreemodeDetailsItem(this, this.listDescItem + 1, id, textLeft, textRight, param3, param4, param5, param6, param7, param8, param9, param10);
			if (this.listDescItem == 0)
			{
				item.itemMC._y = this.itemMC.descMC._y;
			}
			else if (this.listDescItem > 0)
			{
				item.itemMC._y = this.descItems[this.listDescItem - 1].itemMC._y + this.descItems[this.listDescItem - 1].itemMC._height;
			}
			this.listDescItem = this.descItems.push(item);
			this.itemMC.descMC._visible = true;
			this.itemMC.descMC.descTF._visible = false;
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
			this.itemMC.descMC.bgMC._height = h;
			this.itemMC.descMC.crewUpIconMC._visible = false;
			this.itemMC.descMC.crewTagMC._visible = false;
		}
	}

	function SET_DESCRIPTION(descStr, descType, crewTagStr, bCollapse)
	{
		if (descStr != "")
		{
			var __reg2 = this.itemMC.descMC;
			if (this.btnLayer)
			{
				this.btnLayer.removeMovieClip();
			}
			this.btnLayer = __reg2.createEmptyMovieClip("btnLayer", 1000);
			__reg2.crewUpIconMC._visible = descType == this.DESC_TYPE_SC;
			__reg2.crewTagMC._visible = descType == this.DESC_TYPE_INV_SENT;
			if (descType == this.DESC_TYPE_TXT)
			{
				__reg2.descTF._x = 5;
				__reg2.descTF._width = 278;
			}
			else
			{
				__reg2.descTF._x = 54;
				__reg2.descTF._width = 225;
				if (descType == this.DESC_TYPE_INV_SENT)
				{
					__reg2.crewTagMC.UNPACK_CREW_TAG(crewTagStr);
				}
			}
			var __reg4 = new com.rockstargames.ui.utils.Text();
			__reg4.setTextWithIcons(descStr,this.btnLayer,__reg2.descTF,0,13,6,false);
			if (bCollapse)
			{
				__reg2.descTF._width = __reg2.descTF._width - 144;
			}
			__reg2.bgMC._width = bCollapse ? 143 : 288;
			__reg2.bgMC._height = 79;
			__reg2._visible = !this.itemMC.crewInfoMC._visible;
			this.updateFont(__reg2.descTF,"$Font2");
			return;
		}
		__reg2._visible = false;
	}

	function set Visible(_f)
	{
		this.visible = _f;
		this.itemMC._visible = _f;
	}
	function get Visible()
	{
		return this.visible;
	}

	function Clear()
	{
		for (var i in this.descItems)
		{
			this.descItems[i].itemMC.Clear();
		}
		for (var i in this.statMCs)
		{
			this.statMCs[i].removeMovieClip();
		}
		this.itemMC.removeMovieClip();
	}
}