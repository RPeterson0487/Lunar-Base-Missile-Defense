package;

import flixel.util.FlxColor;

class Turret extends Building {
	public function new(turretSize = 50) {
		super();

		makeGraphic(Std.int(turretSize * .75), turretSize, FlxColor.GREEN);
	}
}
