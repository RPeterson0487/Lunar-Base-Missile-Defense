package;

import flixel.FlxG;
import flixel.FlxSprite;

class Building extends FlxSprite {
	public function new() {
		super();
	}

	public function destroyBuilding() {
		var explode = new Explosion(x, y, 100);
		(cast(FlxG.state, PlayState)).explosionGroup.add(explode);
		kill();
	}
}
