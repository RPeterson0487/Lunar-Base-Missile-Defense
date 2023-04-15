package;

import flixel.FlxState;

class PlayState extends FlxState {
	override public function create() {
		var landscape = new Landscape();
		add(landscape);

		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
