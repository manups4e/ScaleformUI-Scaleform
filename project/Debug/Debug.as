class Debug.Debug
{
	/*
	    An enhanced custom logger class for ActionScript 2.0
	*/

	static var LOG_LEVEL_INFO:Number = 0;
	static var LOG_LEVEL_ALERT:Number = 1;
	static var LOG_LEVEL_WARNING:Number = 2;
	static var LOG_LEVEL_ERROR:Number = 3;

	static var COLOR_INFO:String = "^2";
	static var COLOR_ALERT:String = "^5";
	static var COLOR_WARNING:String = "^3";
	static var COLOR_ERROR:String = "^1";

	static function Log(msg:String):Void
	{
		LoggerBase(LOG_LEVEL_INFO, msg);
	}

	static function Alert(msg:String):Void
	{
		LoggerBase(LOG_LEVEL_ALERT, msg);
	}

	static function Warning(msg:String):Void
	{
		LoggerBase(LOG_LEVEL_WARNING, msg);
	}

	static function Error(msg:String):Void
	{
		LoggerBase(LOG_LEVEL_ERROR, msg);
	}

	static function LoggerBase(id:Number, msg:String):Void
	{
		var colour:String;
		var identifier:String;

		switch (id)
		{
			case LOG_LEVEL_INFO :
				colour = COLOR_INFO;
				identifier = "INFO";
				break;

			case LOG_LEVEL_ALERT :
				colour = COLOR_ALERT;
				identifier = "ALERT";
				break;

			case LOG_LEVEL_WARNING :
				colour = COLOR_WARNING;
				identifier = "WARNING";
				break;

			case LOG_LEVEL_ERROR :
				colour = COLOR_ERROR;
				identifier = "ERROR";
				break;

			default :
				colour = "^7"; // Default color: white
				identifier = "UNKNOWN";
				break;
		};

		var words:Array = msg.split(" ");
		for (var i:Number = 0; i < words.length; i++)
		{
			words[i] = colour + words[i];
		}

		var formattedMsg:String = "[" + identifier + "] " + words.join(" ") + "^7";

		com.rockstargames.ui.utils.Debug.log(formattedMsg);
	}
}