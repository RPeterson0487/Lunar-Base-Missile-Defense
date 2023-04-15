package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState {
	static inline var SEGMENTS_TOTAL:Int = 9;
	static var SEGMENTS_TURRET = [1, 5, 9];
	static var SEGMENTS_CITY = [2, 3, 4, 6, 7, 8];

	var basicLandscape:Landscape;
	var buildingsGroup:FlxTypedGroup<Building> = new FlxTypedGroup<Building>();

	override public function create() {
		setupBasicLandscape();
		setupBasicBuildings();

		super.create();
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}

	function setupBasicLandscape() {
		basicLandscape = new Landscape();
		add(basicLandscape);
	}

	function setupBasicBuildings() {
		for (segment in SEGMENTS_CITY) {
			var basicCity = new City();
			placeBuilding(basicCity, segment);
			buildingsGroup.add(basicCity);
		}

		for (segment in SEGMENTS_TURRET) {
			var basicTurret = new Turret();
			placeBuilding(basicTurret, segment);
			buildingsGroup.add(basicTurret);
		}
		add(buildingsGroup);
	}

	function placeBuilding(building:Building, segment:Int) {
		var segmentMidpoint = (segment - .5) * (FlxG.width / SEGMENTS_TOTAL);

		building.x = segmentMidpoint - (building.width / 2);
		building.y = basicLandscape.y - building.height;
	}
}
