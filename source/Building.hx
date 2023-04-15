package;

import flixel.FlxG;
import flixel.FlxSprite;

class Building extends FlxSprite {
	public function new() {
		super();
	}

	public function destroyBuilding() {
		this.kill();
	}

	override function update(elapsed:Float) {
		if (FlxG.mouse.justPressedMiddle && FlxG.mouse.overlaps(this)) {
			kill();
		}

		super.update(elapsed);
	}
}
