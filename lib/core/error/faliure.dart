abstract class Faliure {
  final String message;
  Faliure(this.message);
}

class ServerFaliure extends Faliure {
  ServerFaliure(super.message);
}