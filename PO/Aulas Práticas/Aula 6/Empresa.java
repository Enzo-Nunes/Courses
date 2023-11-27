import java.util.*;

public class Empresa {
	private ArrayList<Funcionário> _funcionários;

	public Empresa() {
		_funcionários = new ArrayList<Funcionário>();
	}

	public boolean addFuncionário(Funcionário f ) {
		for(Funcionário f1 : _funcionários) {
			if (f1.equals(f)) {
				return false;
			}
		}
		_funcionários.add(f);
		return true;
	}

	public void printNomeSalário() {
		for(Funcionário f : _funcionários) {
			System.out.println(f.getID() + " " + f.getSalário());
		}
	}

	public ArrayList<Funcionário> getFuncionáriosSalárioAlto(int alto) {
		ArrayList<Funcionário> res = new ArrayList<Funcionário>();
		for (Funcionário f : _funcionários) {
			if (f.getSalário() > alto) {
				res.add(f);
			}
		}
		return res;
	}

	public void removeFuncionárioComInicial(String inicial) {
		Iterator<Funcionário> iter = _funcionários.iterator();
		while (iter.hasNext()) {
			Funcionário f = iter.next();
			if (f.getID().startsWith(inicial)) {
				iter.remove();
			}
		}
	}
}