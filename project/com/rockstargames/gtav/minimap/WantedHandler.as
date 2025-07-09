class com.rockstargames.gtav.minimap.WantedHandler extends MovieClip
{
	var otherMC;
	var _enable = false;
	function WantedHandler()
	{
		super();
	}
	
	function Init(mc)
	{
		this.otherMC = mc;
	}

	function onEnterFrame()
	{
		if (this._visible && this._enable)
		{
			if (this.otherMC != undefined)
			{
				if (this._currentframe < 31)
				{
					com.rockstargames.ui.utils.Colour.Colourise(this.otherMC,93,182,229,255);
				}
				else
				{
					com.rockstargames.ui.utils.Colour.Colourise(this.otherMC,93,182,229,255);
				}
			}
		}
	}
}