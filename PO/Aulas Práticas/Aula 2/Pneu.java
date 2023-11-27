public class Pneu {
	// Fields
	private float _currentPressure;
	private float _recommendedPressure;
	private boolean _isFlat;
	private boolean _islow;

	// Constructors
	public Pneu(float recommendedPressure, float currentPressure) {
		_recommendedPressure = recommendedPressure;
		_currentPressure = currentPressure;
		_isFlat = false;
		_islow = false;
	}

	// Methods
	// Getters
	public float getRecommendedPressure() {
		return _recommendedPressure;
	}

	public float getCurrentPressure() {
		return _currentPressure;
	}

	public boolean isFlat() {
		return _isFlat;
	}

	public boolean isLow() {
		return _islow;
	}

	// Setters
	public void setCurrentPressure(float currentPressure) {
		if (!_isFlat) {
			this._currentPressure = currentPressure;
			if (_currentPressure > 1.5 * _recommendedPressure) {
				_isFlat = true;
			}
			if (_currentPressure < 0.8 * _recommendedPressure) {
				_islow = true;
			}
		}
	}

}

