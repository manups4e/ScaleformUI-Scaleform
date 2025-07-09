class com.rockstargames.ScaleformUI.panels.BasePanel extends MovieClip
{
	var parentItem;
	var _enabled;
	var _hovered = false;
	var _data;
	var ownIndex;
	var _type;
	var bgMC;
	
	function BasePanel()
	{
		super();
	}
	function set data(d)
	{
		this._data = d;
		this.parentItem = d[0];
		this.ownIndex = d[1];
		this._type = d[2];
	}

	function get data()
	{
		return this._data;
	}

	function setRightText(tf, str, autoShrink, sizeOffset, sizeOverride)
	{
		tf.wordWrap = false;
		tf.multiline = false;
		tf.html = true;
		tf.autoSize = "right";
		var _loc3_ = 0;
		if (sizeOffset != undefined)
		{
			_loc3_ = sizeOffset;
		}
		var _loc2_ = com.rockstargames.ui.utils.UIText.SIZE - _loc3_;
		if (sizeOverride != undefined)
		{
			_loc2_ = sizeOverride;
		}
		tf.htmlText = "<FONT SIZE=\'" + _loc2_ + "\'>" + str + "</FONT>";
		tf.verticalAlign = "center";
		if (autoShrink)
		{
			tf.textAutoSize = "shrink";
		}
	}

	function set isVisible(_h)
	{
		this._visible = _h;
	}

	function get isVisible()
	{
		return this._visible;
	}
}