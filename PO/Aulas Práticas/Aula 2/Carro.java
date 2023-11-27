public class Carro {
	private String	_marca;
	private int		_km;
	private int		_vCurrent;
	private int		_vMax;
	private Pneu[]	_pneus;
	private boolean _isLocked;

	public Carro(String marca, int vMax, Pneu p1, Pneu p2, Pneu p3, Pneu p4) {
		_marca = marca;
		_vMax = vMax;
		_km = 0;
		_isLocked = false;
		_pneus = new Pneu[4];
		_pneus[0] = p1;
		_pneus[1] = p2;
		_pneus[2] = p3;
		_pneus[3] = p4;
	}

	public String getMarca() {
		return _marca;
	}

	public int getKm() {
		return _km;
	}

	public int getVCurrent() {
		return _vCurrent;
	}

	public int getVMax() {
		return _vMax;
	}

	public boolean isAnyFlat() {
		for (int i = 0; i < _pneus.length; i++) {
			if (_pneus[i].isFlat()) {
				return true;
			}
		}
		return false;
	}

	public boolean isLocked() {
		return _isLocked;
	}
}
