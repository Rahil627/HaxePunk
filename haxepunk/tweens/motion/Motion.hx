package haxepunk.tweens.motion;

import haxepunk.Tween;
import haxepunk.utils.Ease.EaseFunction;

/**
 * Base class for motion Tweens.
 */
class Motion extends Tween
{
	/**
	 * Current x position of the Tween.
	 */
	public var x:Float;

	/**
	 * Current y position of the Tween.
	 */
	public var y:Float;

	/**
	 * Constructor.
	 * @param	duration	Duration of the Tween.
	 * @param	complete	Optional completion callback.
	 * @param	type		Tween type.
	 * @param	ease		Optional easer function.
	 */
	public function new(duration:Float, ?type:TweenType, ?ease:EaseFunction)
	{
		x = y = 0;
		super(duration, type, ease);
	}
}
