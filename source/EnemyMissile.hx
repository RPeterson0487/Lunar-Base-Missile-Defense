package;

import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

class EnemyMissile extends FlxSprite {
	public function new(xPosition:Float, yPosition:Float, target:Building) {
		super(xPosition, yPosition);

		makeGraphic(7, 7, FlxColor.RED);

		FlxVelocity.moveTowardsObject(this, target, 0, 10000);
	}
}
