package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	static inline var SEGMENTS_TOTAL:Int = 9;
	static var SEGMENTS_TURRET = [1, 5, 9];
	static var SEGMENTS_CITY = [2, 3, 4, 6, 7, 8];

	var basicLandscape:Landscape;
	var buildingsGroup = new FlxTypedGroup<Building>();
	var turretsGroup = new FlxTypedGroup<Turret>();

	override public function create() {
		setupBasicLandscape();
		setupBasicBuildings();

		super.create();
	}

	override public function update(elapsed:Float) {
		if (FlxG.mouse.justPressed) {
			fireClosestAvailableTurret();
		}

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
			turretsGroup.add(basicTurret);
		}
		add(buildingsGroup);
	}

	function fireClosestAvailableTurret() {
		var cursorPosition = FlxG.mouse.getScreenPosition();
		var closest:Turret = null;
		var shortestDistance:Float = FlxMath.MAX_VALUE_FLOAT;
		var turretPosition:FlxPoint;
		var turretDistance:Float = 0;

		for (i in turretsGroup) {
			turretPosition = i.getPosition();
			turretDistance = turretPosition.dist(cursorPosition);
			if ((turretDistance < shortestDistance) && i.alive) {
				shortestDistance = turretDistance;
				closest = i;
			}
		}

		// Insert firing logic here!
	}

	function placeBuilding(building:Building, segment:Int) {
		var segmentMidpoint = (segment - .5) * (FlxG.width / SEGMENTS_TOTAL);

		building.x = segmentMidpoint - (building.width / 2);
		building.y = basicLandscape.y - building.height;
	}
}
