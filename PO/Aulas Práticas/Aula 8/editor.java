// public class editor {

// 	public int process(int a, int b) {
// 		return a + b;
// 	}

// 	public int[] arrayProcess(int[] a, int[] b) throws CannotProcessException, InvalidArgumentException {
// 		private int[] res;

// 		if (a.length != b.length || a == null || b == null) 
// 			throw new CannotProcessException();

// 		for (int i = 0; i < a.length; i++) {
// 			try {
// 				res[i] = process(a[i], b[i]);
// 			} catch (InvalidArgumentException) {
// 				res[i] = -1;
// 			}
// 		}
// 		return res;
// 	}
// }

// public class CannotProcessException extends Exception {
// 	public CannotProcessException() {
// 		super("Imcompatible array size or null pointer");
// 	}
// }