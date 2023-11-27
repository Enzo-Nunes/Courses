package ap8;

public interface Queue {
  void enqueue(Object obj);

  Object dequeue() throws EmptyQueueException;

  int size();
}
