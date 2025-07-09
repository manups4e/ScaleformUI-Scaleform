class com.rockstargames.ScaleformUI.utils.Functions
{
	static var notColours = ["~n", "~h", "~bold", "~italic", "~ws", "~wanted_star", "~nrt", "~EX_R*", "~BLIP_", "~a", "~1", "~a_", "~1_", "~x", "~z", "~INPUT_", "~INPUTGROUP_", "~ACCEPT", "~CANCEL", "~PAD_UP", "~PAD_DOWN", "~PAD_LEFT", "~PAD_RIGHT", "~PAD_A", "~PAD_B", "~PAD_X", "~PAD_Y", "~PAD_START", "~PAD_BACK", "~PAD_LB", "~PAD_LT", "~PAD_RB", "~PAD_RT", "~PAD_DPAD_UP", "~PAD_DPAD_DOWN", "~PAD_DPAD_LEFT", "~PAD_DPAD_RIGHT", "~PAD_DPAD_NONE", "~PAD_DPAD_ALL", "~PAD_DPAD_UPDOWN", "~PAD_DPAD_LEFTRIGHT", "~PAD_LSTICK_UP", "~PAD_LSTICK_DOWN", "~PAD_LSTICK_LEFT", "~PAD_LSTICK_RIGHT", "~PAD_LSTICK_NONE", "~PAD_LSTICK_ALL", "~PAD_LSTICK_UPDOWN", "~PAD_LSTICK_LEFTRIGHT", "~PAD_LSTICK_ROTATE", "~PAD_RSTICK_UP", "~PAD_RSTICK_DOWN", "~PAD_RSTICK_LEFT", "~PAD_RSTICK_RIGHT", "~PAD_RSTICK_NONE", "~PAD_RSTICK_ALL", "~PAD_RSTICK_UPDOWN", "~PAD_RSTICK_LEFTRIGHT", "~PAD_RSTICK_ROTATE"];

	static function trim(str)
	{
		var result = "";

		// Remove leading whitespace
		while (str.length > 0 && str.charCodeAt(0) == 32)
		{
			str = str.substring(1);
		}

		result = str;

		// Remove trailing whitespace
		while (result.length > 0 && result.charCodeAt(result.length - 1) == 32)
		{
			result = result.substring(0, result.length - 1);
		}

		return result;
	}

	// Main formatting function
	static function formatLabel(value, _enabled, _selected, keepWhite)
	{
		var _formatLabel;
		// Handle the ternary operator for prefix
		if (value.charAt(0) == "~")
		{
			_formatLabel = value;
		}
		else
		{
			_formatLabel = "~s~" + value;
		}

		// Handle the nested ternary for color replacement
		if (!_enabled)
		{
			_formatLabel = com.rockstargames.ScaleformUI.utils.Functions.replaceRstarColorsWith(_formatLabel, "~c~");
		}
		else if (!keepWhite)
		{
			if (_selected)
			{
				_formatLabel = _formatLabel.split("~w~").join("~l~").split("~s~").join("~l~");
			}
			else
			{
				_formatLabel = _formatLabel.split("~l~").join("~s~");
			}
		}
		else
		{
			_formatLabel = "~w~" + com.rockstargames.ScaleformUI.utils.Functions.replaceRstarColorsWith(_formatLabel, "~w~");
		}

		return _formatLabel;
	}

	static function replaceRstarColorsWith(label, color)
	{
		if (label.indexOf("~") == -1)
		{
			return label;
		}

		var foundIndexes:Array = [];
		var i:Number = label.indexOf("~");
		while (i != -1)
		{
			foundIndexes.push(i);
			i = label.indexOf("~", i + 1);
		}

		var tmp:String = label;
		for (var i:Number = foundIndexes.length - 2; i > -1; i -= 2)
		{
			var index:Number = foundIndexes[i];
			var length:Number = foundIndexes[i + 1] - index + 1;

			var skip:Boolean = false;
			for (var j:Number = 0; j < notColours.length; j++)
			{
				if (tmp.substring(index, index + length).indexOf(com.rockstargames.ScaleformUI.utils.Functions.notColours[j]) == 0)
				{
					skip = true;
					break;
				}
			}

			if (skip)
			{
				continue;
			}

			var charStr:String = "";
			if (tmp.charAt(index + 2) == "~")
			{
				charStr = tmp.substring(index, index + length);
			}
			else if (tmp.substring(index, 11) == "~HUD_COLOUR")
			{
				charStr = tmp.substring(index, index + length);
			}
			else if (tmp.substring(index, 4) == "~HC_")
			{
				charStr = tmp.substring(index, index + length);
			}

			if (charStr != "")
			{
				tmp = tmp.split(charStr).join(color);
			}
		}

		return tmp;
	}

}