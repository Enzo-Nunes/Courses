package ap8;

public class EmptyQueueException extends Exception {

  public EmptyQueueException() {
    super("Empty queue");
  }
}
