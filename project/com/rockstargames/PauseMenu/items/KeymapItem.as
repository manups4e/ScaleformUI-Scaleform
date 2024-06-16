class com.rockstargames.PauseMenu.items.KeymapItem
{
	var itemMC;
	var itemTextLeft;
	var itemTextMid;
	var itemTextRight;
	var slot;
	function KeymapItem(mc, leftText, midText, rightText, _slot)
	{
		this.itemMC = mc.attachMovie("configurationListItem", "configuration_item_" + mc.getNextHighestDepth(), mc.getNextHighestDepth());
		this.itemTextLeft = this.itemMC.labelMC.titleTF;
		this.itemTextMid = this.itemMC.labelMC.value1;
		this.itemTextRight = this.itemMC.labelMC.value2;
		this.slot = _slot;
		this.itemTextLeft.autoSize = "none";
		this.itemTextLeft._width = 390;
		com.rockstargames.ui.utils.UIText.setSizedText(this.itemTextLeft,leftText,true);
		this.updateFont(this.itemTextLeft, "$Font2");

        if (this.itemTextMid.bg) 
        {
            com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemTextMid.bg, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
        }
        if (this.itemTextRight.bg) 
        {
            com.rockstargames.ui.utils.Colour.ApplyHudColour(this.itemTextRight.bg, com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
        }
        this.itemTextMid.bg._visible = true;
        this.itemTextRight.bg._visible = true;
        this.itemMC.bgMC._visible = false;

		this.setText(midText,this.itemTextMid,this.slot);
		this.setText(rightText,this.itemTextRight,this.slot);

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

	function setText(text, bindingItem, slot)
	{
		bindingItem.icons.removeMovieClip();
		bindingItem.iconsBG.removeMovieClip();
		if (text != undefined && text != "")
		{
			var __reg4 = bindingItem.createEmptyMovieClip("iconsBG", bindingItem.getNextHighestDepth());
			var __reg5 = bindingItem.createEmptyMovieClip("icons", bindingItem.getNextHighestDepth());
			com.rockstargames.ui.game.GameInterface.call("SET_FORMATTED_TEXT_WITH_ICONS",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,text,__reg5,bindingItem.valueTF,0,13,3,true,false,slot);
			com.rockstargames.ui.game.GameInterface.call("SET_FORMATTED_TEXT_WITH_ICONS",com.rockstargames.ui.game.GameInterface.GENERIC_TYPE,"~HUD_COLOUR_BLACK~" + text,__reg4,bindingItem.valueBorderTF,0,15,3,true,false,slot);
			this.updateFont(bindingItem.valueTF, "$Font2");
			this.updateFont(bindingItem.valueBorderTF, "$Font2");
			return;
		}
		com.rockstargames.ui.utils.UIText.setSizedText(bindingItem.valueTF,"");
		com.rockstargames.ui.utils.UIText.setSizedText(bindingItem.valueBorderTF,"");
	}
	
	function UpdateValues(midText, rightText)
	{
		this.setText(midText,this.itemTextMid,this.slot);
		this.setText(rightText,this.itemTextRight,this.slot);
	}
}