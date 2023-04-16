package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HUD extends FlxTypedGroup<FlxSprite> {
	static inline var HUD_COLOR = FlxColor.BLACK;
	static inline var HUD_SIDE_SPACING:Float = 100;

	var background:FlxSprite;
	var timeInformation:FlxText;
	var timeElapsed:Float = 0;
	var scoreInformation:FlxText;
	var scoreCount:Int = 0;

	public function new(hudHeight:Int) {
		super();

		setupBackground(hudHeight);
		setupTimer();
		setupScore();
	}

	function setupBackground(hudHeight:Int) {
		background = new FlxSprite(0, FlxG.height - hudHeight);
		background.makeGraphic(FlxG.width, hudHeight, HUD_COLOR);
		add(background);
	}

	override function update(elapsed:Float) {
		updateTimer(elapsed);

		super.update(elapsed);
	}

	function setupTimer() {
		timeInformation = new FlxText();
		timeInformation.text = "You've lasted " + Std.int(timeElapsed) + " seconds.";
		timeInformation.size = Std.int(background.height - 15);
		timeInformation.x = HUD_SIDE_SPACING;
		timeInformation.y = background.getGraphicMidpoint().y - (timeInformation.height / 2);

		add(timeInformation);
	}

	function setupScore() {
		scoreInformation = new FlxText();
		scoreInformation.text = "Missiles intercepted: " + scoreCount;
		scoreInformation.size = Std.int(background.height - 15);
		scoreInformation.x = FlxG.width - scoreInformation.width - HUD_SIDE_SPACING;
		scoreInformation.y = timeInformation.y;

		add(scoreInformation);
	}

	function updateTimer(elapsed:Float) {
		timeInformation.text = "You've lasted " + Std.int(timeElapsed += elapsed) + " seconds.";
	}

	public function updateScore() {
		scoreCount += 1;
		scoreInformation.text = "Missiles intercepted: " + scoreCount;
	}
}
