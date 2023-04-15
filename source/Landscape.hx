package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Landscape extends FlxSprite {
	public function new(landscapeHeight = 75) {
		super();

		makeGraphic(FlxG.width, landscapeHeight, FlxColor.GRAY);
		y = FlxG.height - landscapeHeight;
	}
}
