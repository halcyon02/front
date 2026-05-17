abstract class ITtsService {
  Future<void> speak(String text);
  Future<void> stop();
  Future<void> setRate(double rate);
  Future<void> setVolume(double volume);
}