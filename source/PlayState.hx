package;

import flixel.FlxState;

class PlayState extends FlxState {
	var basicLandscape:Landscape;

	override public function create() {
		setupBasicLandscape();
		setupBasicCities();

		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	function setupBasicLandscape() {
		basicLandscape = new Landscape();
		add(basicLandscape);
	}

	function setupBasicCities() {
		var basicCity = new City();
		basicCity.x = (basicLandscape.width / 2);
		basicCity.y = basicLandscape.y - basicCity.height;
		// add(basicCity);
	}
}
