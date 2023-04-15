package;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Turret extends Building {
	public function new(turretSize = 50) {
		super();

		makeGraphic(Std.int(turretSize * .75), turretSize, FlxColor.GREEN);
	}

	public function fireTurret(xPosition, yPosition, aimCoordinate:FlxPoint) {
		var outgoing = new TurretMissile(xPosition, yPosition, aimCoordinate);
		FlxG.state.add(outgoing);
	}
}
