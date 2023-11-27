// import java.util.*;

// public class DrawAreaGreaterCoords extends Command<Editor> {
// 	public DrawAreaGreaterCoords(Editor receiver) {
// 		super("Desenha formas com Area superior ao prod das coords", receiver);
// 	}

// 	protected void execute() {
// 		ArrayList<Form> forms = _receiver.getForms();
// 		ArrayList<Form> formsOrdered = new ArrayList<Form>();

// 		for(Form f: forms) {
// 			if (f.computeArea() > f.getOrigin().getX() * f.getOrigin().getY()) {
// 				formsOrdered.add(f);
// 			}
// 		}

// 		Collections.sort(formsOrdered, new OrderByArea());

// 		for (Form f: formsOrdered) {
// 			_display.addNewLine(f.draw());
// 		}
		
// 		_display.display();
// 	}
// }

// class OrderByArea implements Comparator<Form> {
// 	public int compare(Form f1, Form f2) {
// 		return f1.computeArea() - f2.computeArea();
// 	}
// }
