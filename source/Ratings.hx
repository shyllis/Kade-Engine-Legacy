import flixel.FlxG;

class Ratings {
	public static function GenerateLetterRank(accuracy:Float) {
		var ranking:String = "N/A";
		if (FlxG.save.data.botplay)
			ranking = "BotPlay";

		if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0)
			ranking = "(MFC)";
		else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1)
			ranking = "(GFC)";
		else if (PlayState.misses == 0)
			ranking = "(FC)";
		else if (PlayState.misses < 10)
			ranking = "(SDCB)";
		else
			ranking = "(Clear)";

		var wifeConditions:Array<Bool> = [
			accuracy >= 99.9935, accuracy >= 99.980, accuracy >= 99.970, accuracy >= 99.955, accuracy >= 99.90, accuracy >= 99.80, accuracy >= 99.70,
			accuracy >= 99, accuracy >= 96.50, accuracy >= 93, accuracy >= 90, accuracy >= 85, accuracy >= 80, accuracy >= 70, accuracy >= 60, accuracy < 60
		];

		for (i in 0...wifeConditions.length) {
			var b = wifeConditions[i];
			if (b) {
				switch (i) {
					case 0:
						ranking += " AAAAA";
					case 1:
						ranking += " AAAA:";
					case 2:
						ranking += " AAAA.";
					case 3:
						ranking += " AAAA";
					case 4:
						ranking += " AAA:";
					case 5:
						ranking += " AAA.";
					case 6:
						ranking += " AAA";
					case 7:
						ranking += " AA:";
					case 8:
						ranking += " AA.";
					case 9:
						ranking += " AA";
					case 10:
						ranking += " A:";
					case 11:
						ranking += " A.";
					case 12:
						ranking += " A";
					case 13:
						ranking += " B";
					case 14:
						ranking += " C";
					case 15:
						ranking += " D";
				}
				break;
			}
		}

		if (accuracy == 0)
			ranking = "N/A";
		else if (FlxG.save.data.botplay)
			ranking = "BotPlay";

		return ranking;
	}

	public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String {
		var customTimeScale = Conductor.timeScale;

		if (customSafeZone != null)
			customTimeScale = customSafeZone / 166;

		if (FlxG.save.data.botplay)
			return "good";

		if (noteDiff > 166 * customTimeScale)
			return "miss";
		if (noteDiff > 135 * customTimeScale)
			return "shit";
		else if (noteDiff > 90 * customTimeScale)
			return "bad";
		else if (noteDiff > 45 * customTimeScale)
			return "good";
		else if (noteDiff < -45 * customTimeScale)
			return "good";
		else if (noteDiff < -90 * customTimeScale)
			return "bad";
		else if (noteDiff < -135 * customTimeScale)
			return "shit";
		else if (noteDiff < -166 * customTimeScale)
			return "miss";
		return "sick";
	}

	public static function CalculateRanking(score:Int, scoreDef:Int, accuracy:Float):String {
		return (!FlxG.save.data.botplay ? "Score:"
			+ (Conductor.safeFrames != 10 ? score + " (" + scoreDef + ")" : "" + score)
			+ " | Misses:"
			+ PlayState.misses
			+ " | Accuracy:"
			+ (FlxG.save.data.botplay ? "N/A" : HelperFunctions.truncateFloat(accuracy, 2) + " %")
			+ " | "
			+ GenerateLetterRank(accuracy) : "");
	}
}
