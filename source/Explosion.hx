package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Explosion extends FlxSprite {
	static inline var EXPLOSION_DURATION:Float = 3;

	public var scoreable:Bool = false;

	var timerRemaining:Float = EXPLOSION_DURATION;

	public function new(xPosition:Float, yPosition:Float, _scoreable:Bool = false, explosionSize:Int = 50) {
		super();

		scoreable = _scoreable;

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
