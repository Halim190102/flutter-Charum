String kelipatan3(int angka, bool option) {
  String angkaString = angka.toString();
  String hasil = '';
  int counter = 0;

  for (int i = angkaString.length - 1; i >= 0; i--) {
    hasil = angkaString[i] + hasil;
    counter++;
    if (counter == 3 && i != 0) {
      hasil = '.$hasil';
      counter = 0;
    }
  }
  if (option) {
    if (angka <= 1) {
      hasil += ' thread';
    } else {
      hasil += ' threads';
    }
    return hasil;
  } else {
    return hasil;
  }
}

int time = 750;
int refreshTime = 2;
