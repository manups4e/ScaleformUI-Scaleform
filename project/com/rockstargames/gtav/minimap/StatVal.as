class com.rockstargames.gtav.minimap.StatVal extends MovieClip
{
	var StartAngle;
	var EndAngle;
	var centerX = 75.5;
	var centerY = 75.5;
	var Radius = 75.5;
	var Colour;
	var MaskMC;
	var textureMC;
	var mc;
	var IsBigMode;

	function StatVal()
	{
		super();
		this.init();
	}

	function init(mc)
	{
		if (mc != undefined)
		{
			this.mc = mc;
		}
		else
		{
			this.mc = this;
		}
		if (this.mc.textureMC != undefined)
		{
			this.mc.textureMC.removeMovieClip();
		}
	}

	function RemoveTexture()
	{
		this.mc.textureMC.removeMovieClip();
	}

	function txdLoaded()
	{
		com.rockstargames.ui.utils.Colour.Colourise(this,255,255,255,100);
		this.mc.textureMC._x = 0;
		this.mc.textureMC._y = 0;
		this.mc.textureMC._width = 153.65;
		this.mc.textureMC._height = 152.2;
		if (this.IsBigMode)
		{
			this.mc.textureMC._x = 0;
			this.mc.textureMC._y = 0;
			this.mc.textureMC._width = 143.6;
			this.mc.textureMC._height = 142.4;
		}
	}

	function updateData(value)
	{
		this.centerX = value;
		this.centerY = value;
		this.Radius = value;
	}

	function createInitialMask(startAngle, endAngle)
	{
		// Check if MaskMC already exists and remove it
		if (this.mc.MaskMC != undefined)
		{
			this.mc.MaskMC.removeMovieClip();
		}
		// Create a new emptyMovieClip for the this.mc.MaskMC                                                   ;     
		this.createEmptyMovieClip("MaskMC",2);

		this.StartAngle = startAngle;
		this.EndAngle = endAngle;

		drawFilledCircle(this.mc.MaskMC,this.centerX,this.centerY,this.Radius,startAngle,endAngle);// Full circle initially


		this.setMask(this.mc.MaskMC);
	}

	function drawFilledCircle(mask, centerX, centerY, radius, startAngle, endAngle)
	{
		var numSegments = 360;
		var adjustedStartAngle = (startAngle + 90) % 360;
		var adjustedEndAngle = (endAngle + 90) % 360;

		mask.clear();
		mask.beginFill(0xFF0000);

		var angleDifference = (((adjustedEndAngle - adjustedStartAngle) + 360) % 360);

		var startPointX = centerX + radius * Math.cos(((adjustedStartAngle * Math.PI) / 180));
		var startPointY = centerY - radius * Math.sin(((adjustedStartAngle * Math.PI) / 180));

		mask.moveTo(startPointX,startPointY);

		var segmentAngle = angleDifference / numSegments;
		for (var i = 1; i <= numSegments; i++)
		{
			var angle = adjustedStartAngle + i * segmentAngle;
			var pointX = centerX + radius * Math.cos(((angle * Math.PI) / 180));
			var pointY = centerY - radius * Math.sin(((angle * Math.PI) / 180));

			mask.lineTo(pointX,pointY);
		}

		mask.lineTo(centerX,centerY);
		mask.endFill();

	}


	function updateMask(percent, adjustStart)
	{
		var centerX = this.centerX;
		var centerY = this.centerY;
		var radius = this.Radius;
		var startAngle = this.StartAngle;
		var endAngle = this.EndAngle;
		var newPerc = 100 - percent;
		var totalDegrees = endAngle - startAngle;
		var adjustedAngle = newPerc * totalDegrees / 100;
		var baseAngle = adjustStart ? startAngle : endAngle;
		var newAngle = adjustStart ? baseAngle + adjustedAngle : baseAngle - adjustedAngle;

		if (adjustStart)
		{
			newAngle = Math.max(this.StartAngle, Math.min(newAngle, this.EndAngle));
			startAngle = newAngle;
		}
		else
		{
			newAngle = Math.min(this.EndAngle, Math.max(newAngle, this.StartAngle));
			endAngle = newAngle;
		}

		drawFilledCircle(this.mc.MaskMC,this.centerX,this.centerY,this.Radius,startAngle,endAngle);
	}
}