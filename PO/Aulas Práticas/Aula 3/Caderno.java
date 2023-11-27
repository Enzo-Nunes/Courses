public class Caderno {
	private	int _linhas;
	private int _linhasEscritas;

	public Caderno(int linhas) {
		_linhas = linhas;
		_linhasEscritas = 0;
	}

	public boolean isFull() {
		return _linhas == _linhasEscritas;
	}

	public int getLinhas() {
		return _linhasEscritas;
	}

	public boolean escrever(String escrita) {
		if (!isFull()) {
			if (escrita.length() > 0) {
				_linhasEscritas++;
				return true;
			}
		}
		return false;
	}
}