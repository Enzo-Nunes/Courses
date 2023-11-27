public class Garrafa {
	private int _capacity;
	private int _current;
	private boolean _isOpen;

	public Garrafa(int capacity) {
		_capacity = capacity;
		_current = 0;
		_isOpen = false;
	}

	public int getCapacity() {
		return _capacity;
	}

	public int getCurrent() {
		return _current;
	}

	public boolean isOpen() {
		return _isOpen;
	}

	public void open() {
		_isOpen = true;
	}

	public void close() {
		_isOpen = false;
	}

	public void fill(int amount) {
		if (_isOpen) {
			_current += amount;
			if (_current > _capacity) {
				_current = _capacity;
			}
		}
	}
}
