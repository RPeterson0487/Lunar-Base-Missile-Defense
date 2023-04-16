package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;

class PlayState extends FlxState {
	static inline var SEGMENTS_TOTAL:Int = 9;
	static var SEGMENTS_TURRET = [1, 5, 9];
	static var SEGMENTS_CITY = [2, 3, 4, 6, 7, 8];
	static inline var TIMER_MAX:Float = 3;

	public var explosionGroup = new FlxTypedGroup<Explosion>();

	var basicLandscape:Landscape;
	var buildingsGroup = new FlxTypedGroup<Building>();
	var citiesGroup = new FlxTypedGroup<Building>();
	var turretsGroup = new FlxTypedGroup<Turret>();
	var enemyMissileGroup = new FlxTypedGroup<EnemyMissile>();
	var timerRemaining:Float = TIMER_MAX;
	var hud:HUD;
	var gameOver:Bool = false;

	override public function create() {
		super.create();

		FlxG.mouse.load(AssetPaths.crosshair__png__png, 1, -8, -8);

		setupBasicLandscape();
		setupBasicBuildings();
		add(enemyMissileGroup);
		add(explosionGroup);

		hud = new HUD(Std.int(basicLandscape.height / 2));
		add(hud);
	}

	override public function update(elapsed:Float) {
		if (FlxG.keys.justPressed.NINE) {
			endGame();
		}

		if (FlxG.mouse.justPressed && !gameOver) {
			fireClosestAvailableTurret();
		}

		if (FlxG.keys.justPressed.R) {
			FlxG.switchState(new PlayState());
		}

		timerRemaining -= elapsed;
		if (timerRemaining <= 0 && !gameOver) {
			fireEnemyMissiles();
			timerRemaining += TIMER_MAX;
		}

		FlxG.overlap(explosionGroup, enemyMissileGroup, collideEnemyMissileAndExplosion);
		FlxG.overlap(enemyMissileGroup, buildingsGroup, collideEnemyMissileAndBuilding);
		FlxG.overlap(enemyMissileGroup, basicLandscape, collideEnemyMissileAndLandscape);

		if (citiesGroup.countLiving() == 0) {
			endGame();
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
			citiesGroup.add(basicCity);
		}

		for (segment in SEGMENTS_TURRET) {
			var basicTurret = new Turret();
			placeBuilding(basicTurret, segment);
			buildingsGroup.add(basicTurret);
			turretsGroup.add(basicTurret);
		}
		add(buildingsGroup);
	}

	function placeBuilding(building:Building, segment:Int) {
		var segmentMidpoint = (segment - .5) * (FlxG.width / SEGMENTS_TOTAL);

		building.x = segmentMidpoint - (building.width / 2);
		building.y = basicLandscape.y - building.height;
	}

	function fireClosestAvailableTurret() {
		var cursorPosition = FlxG.mouse.getScreenPosition();
		var closest:Turret = null;
		var shortestDistance:Float = FlxMath.MAX_VALUE_FLOAT;
		var turretPosition:FlxPoint;
		var turretDistance:Float = 0;

		if (turretsGroup.countLiving() > 0) {
			for (i in turretsGroup) {
				turretPosition = i.getPosition();
				turretDistance = turretPosition.dist(cursorPosition);
				if ((turretDistance < shortestDistance) && i.alive) {
					shortestDistance = turretDistance;
					closest = i;
				}
			}

			closest.fireTurret((closest.x + (closest.width / 2)), closest.y, cursorPosition);
		}
	}

	function fireEnemyMissiles() {
		var numberOfMissiles = FlxG.random.int(1, 20);

		for (i in 1...numberOfMissiles) {
			var launchPosition = FlxG.random.float(0, FlxG.width);
			var target = buildingsGroup.members[FlxG.random.int(0, buildingsGroup.length - 1)];
			var incoming = new EnemyMissile(launchPosition, 0, target);
			enemyMissileGroup.add(incoming);
		}
	}

	function collideEnemyMissileAndExplosion(explosion:Explosion, enemyMissile:EnemyMissile) {
		if (explosion.scoreable) {
			enemyMissile.explode(true);
			hud.updateScore();
		}
		else {
			enemyMissile.explode();
		}
	}

	function collideEnemyMissileAndBuilding(enemyMissile:EnemyMissile, building:Building) {
		enemyMissile.explode();
		building.destroyBuilding();
	}

	function collideEnemyMissileAndLandscape(enemyMissile:EnemyMissile, landscape:Landscape) {
		enemyMissile.explode(25);
	}

	function endGame() {
		gameOver = true;
		hud.gameOver = true;
	}
}
