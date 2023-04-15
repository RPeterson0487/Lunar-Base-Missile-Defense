package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class City extends FlxSprite {
	public function new(citySize = 50) {
		super();

		makeGraphic(Std.int(citySize * .75), citySize, FlxColor.BLUE);
	}
}
