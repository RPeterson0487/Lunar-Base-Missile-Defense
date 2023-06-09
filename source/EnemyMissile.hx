package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

class EnemyMissile extends FlxSprite {
	public function new(xPosition:Float, yPosition:Float, target:Building) {
		super(xPosition, yPosition);

		makeGraphic(7, 7, FlxColor.RED);

		FlxVelocity.moveTowardsObject(this, target, 0, 10000);
	}

	public function explode(scoreable:Bool = false, ?explosionSize:Int) {
		var explosion = new Explosion(x, y, scoreable, explosionSize);
		(cast(FlxG.state, PlayState)).explosionGroup.add(explosion);
		kill();
	}
}
