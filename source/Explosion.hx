package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Explosion extends FlxSprite {
	static inline var EXPLOSION_DURATION:Float = 3;

	var timerRemaining:Float = EXPLOSION_DURATION;

	public function new(xPosition:Float, yPosition:Float, explosionSize:Int = 50) {
		super();

		makeGraphic(explosionSize, explosionSize, FlxColor.ORANGE);
		x = xPosition - (width / 2);
		y = yPosition - (height / 2);
	}

	override function update(elapsed:Float) {
		timerRemaining -= elapsed;
		if (timerRemaining <= 0) {
			kill();
			timerRemaining += EXPLOSION_DURATION;
		}

		super.update(elapsed);
	}
}
