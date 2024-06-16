class com.rockstargames.PauseMenu.tabs.BaseTab
{
	var _isFocused;
	var _isVisible;
	var enum;
	var LeftItemList;
	var _normDist = 290;
	var rightItemUpMC;
	var rightItemDownMC;
	var _MC;
	var Parent;
	function BaseTab(mc, m)
	{
		this.Parent = mc;
		this._MC = mc.CONTENT;
		this.LeftItemList = new Array();
	}

	function set focused(_f)
	{
		this._isFocused = _f;
	}
	function get focused()
	{
		return this._isFocused;
	}

	function set isVisible(_v)
	{
		this._isVisible = _v;
	}

	function get isVisible()
	{
		return this._isVisible;
	}
}