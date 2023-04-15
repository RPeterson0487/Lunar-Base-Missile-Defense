package;

import flixel.util.FlxColor;

class City extends Building {
	public function new(citySize = 50) {
		super();

		makeGraphic(Std.int(citySize * .75), citySize, FlxColor.BLUE);
	}
}
