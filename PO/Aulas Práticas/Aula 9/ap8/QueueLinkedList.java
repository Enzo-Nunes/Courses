package ap8;

import java.util.LinkedList;
import java.util.Iterator;

public class QueueLinkedList implements Queue {
	private LinkedList<Object> _queue = new LinkedList<>();

	public void enqueue(Object obj) {
		_queue.add(obj);
	}

	public Object dequeue() throws EmptyQueueException {
		if (_queue.isEmpty())
			throw new EmptyQueueException();

		return _queue.removeFirst();
	}

	public int size() {
		return _queue.size();
	}

	public int countEqual(Object obj) {
		int count = 0;
		Iterator<Object> iter = _queue.iterator();

		while (iter.hasNext()) {
			if (iter.next().equals(obj))
				count++;
		}

		return count;
	}

}
