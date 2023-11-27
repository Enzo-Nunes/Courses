public class Funcionário {
	private final String _id;
	private int _salário;

	public Funcionário(String id, int salário) {
		_id = id;
		_salário = salário;
	}

	public String getID() {
		return _id;
	}

	public int getSalário() {
		return _salário;
	}

	public boolean equals(Funcionário f) {
		return _id.equals(f.getID());
	}
}