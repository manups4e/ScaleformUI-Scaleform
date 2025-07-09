class com.rockstargames.ScaleformUI.panels.UIMenuStatsPanel extends com.rockstargames.ScaleformUI.panels.BasePanel
{
	var _items;
	function UIMenuStatsPanel()
	{
		super();
		this._items = [];
		com.rockstargames.ui.utils.Colour.ApplyHudColour(this.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
	}

	function set data(d)
	{
		super.data = d;
		var statistics = d[3].split(",");
		this.clearStats();
		for (var i in statistics)
		{
			var s = statistics[i].split(":");
			this.addStat(s[0],s[1]);
		}
	}

	function clearStats()
	{
		for (var i in this._items)
		{
			this._items[i].removeMovieClip();
		}
		this._items = [];
	}

	function addStat(_label, _value)
	{
		var statistic = this.attachMovie("StatsPanelItem", "statsItem_" + this._items.length, this.getNextHighestDepth());
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_PAUSE_BG);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.statsBar.barBG,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_BLACK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.statsBar.item1.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_GREY_DARK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.statsBar.item2.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_GREY_DARK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.statsBar.item3.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_GREY_DARK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.statsBar.item4.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_GREY_DARK);
		com.rockstargames.ui.utils.Colour.ApplyHudColour(statistic.statsBar.item5.bgMC,com.rockstargames.ui.utils.HudColour.HUD_COLOUR_MENU_GREY_DARK);
		com.rockstargames.ui.utils.UIText.setSizedText(statistic.labelTF,_label,false,true);
		statistic._y = 25 * (this._items.length);
		var loc = this._items.push(statistic);
		this.bgMC._height = 25 * (this._items.length);
		var val = 0;
		if (_value != undefined)
		{
			val = _value;
		}
		this.setStat(loc - 1,val);
	}

	function setStat(id, val)
	{
		var bar = this._items[id].statsBar;
		bar.item1.progressMC._width = 0;
		bar.item2.progressMC._width = 0;
		bar.item3.progressMC._width = 0;
		bar.item4.progressMC._width = 0;
		bar.item5.progressMC._width = 0;
		var _value = val;
		if (_value > 100)
		{
			_value = 100;
		}
		else if (val < 0)
		{
			_value = 0;
		}
		if (_value <= 20)
		{
			bar.item1.progressMC._width = bar.item1.bgMC._width / 20 * _value;
		}
		else if (_value > 20 && _value <= 40)
		{
			bar.item1.progressMC._width = bar.item1.bgMC._width;
			bar.item2.progressMC._width = bar.item2.bgMC._width / 20 * (_value - 20);
		}
		else if (_value > 40 && _value <= 60)
		{
			bar.item1.progressMC._width = bar.item1.bgMC._width;
			bar.item2.progressMC._width = bar.item2.bgMC._width;
			bar.item3.progressMC._width = bar.item3.bgMC._width / 20 * (_value - 40);
		}
		else if (_value > 60 && _value <= 80)
		{
			bar.item1.progressMC._width = bar.item1.bgMC._width;
			bar.item2.progressMC._width = bar.item2.bgMC._width;
			bar.item3.progressMC._width = bar.item3.bgMC._width;
			bar.item4.progressMC._width = bar.item4.bgMC._width / 20 * (_value - 60);
		}
		else if (_value > 80)
		{
			bar.item1.progressMC._width = bar.item1.bgMC._width;
			bar.item2.progressMC._width = bar.item2.bgMC._width;
			bar.item3.progressMC._width = bar.item3.bgMC._width;
			bar.item4.progressMC._width = bar.item4.bgMC._width;
			bar.item5.progressMC._width = bar.item5.bgMC._width / 20 * (_value - 80);
		}
		//this._items[id].statsBar.               
		//this._slider._width = this._sliderBG._width / this._max * this._value;

	}

	function Clear()
	{
		this.removeMovieClip();
	}

}