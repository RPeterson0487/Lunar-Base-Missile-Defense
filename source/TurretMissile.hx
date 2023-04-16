package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.math.FlxVelocity;
import flixel.util.FlxColor;

class TurretMissile extends FlxSprite {
	static inline var MISSILESPEED = 100;

	var destination:FlxPoint;

	public function new(xPosition:Float, yPosition:Float, coordinate:FlxPoint) {
		super();

		destination = coordinate;

		makeGraphic(7, 7, FlxColor.BLUE);
		x = xPosition - (width / 2);
		y = yPosition;

		FlxVelocity.moveTowardsPoint(this, coordinate, MISSILESPEED);
	}

	override function update(elapsed:Float) {
		if (y <= destination.y) {
			var explode = new Explosion(destination.x, destination.y);
			(cast(FlxG.state, PlayState)).explosionGroup.add(explode);
			kill();
		}

		super.update(elapsed);
	}
}
