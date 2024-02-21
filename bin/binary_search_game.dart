import 'dart:io';
import 'dart:math';

void main() {
  print("выберите режим игры: ");
  print("1. пользователь загадывает случайное число от 1 до 100, а компьютер должен отгадать.");
  print("2. компьютер загадывает случайное число от 1 до 100, а пользователь должен отгадать.");
  print("""3. соревновательная игра . Один раунд состоит из двух этапов: 
                1- Пользователь загадывает число, а компьютер угадывает. 
                2- Компьютер загадывает число, а пользователь отгадывает. """);

  String choice = stdin.readLineSync() ?? '';

  switch (choice) {
    case '1':
      computerGuesses();
      break;
    case '2':
      userGuesses();
      break;
    case '3':
      rankedGame();
      break;
    default:
      print("Ошибка введите 1, 2 или 3.");
  }
}

int computerGuesses() {
  print("Загадайте число от 1 до 100. ввелите greater, если число больше загаданного и less, если число меньше загаданного и yes, если компьютер угадал:");
  int low = 1;
  int high = 100;
  int guess;
  int steps = 0;

  do {
    guess = (low + high) ~/ 2;
    print("это $guess?");
    String answer = stdin.readLineSync() ?? '';
    steps++;

    if (answer.toLowerCase() == "greater") {
      low = guess + 1;
      // print(low);
      // print(high);
    } else if (answer.toLowerCase() == "less") {
      high = guess - 1;
      // print(low);
      // print(high);
    } else if (answer.toLowerCase() == "yes") {
      print("загаданное число это $guess");
      break;
    }
  } while (low <= high);

  print("компьютер отгадал за $steps шагов!");
  return steps;
}

int userGuesses() {
  int randomNumber = Random().nextInt(100) + 1;
  int guess;
  int steps = 0;

  do {
    print("Компьютер загадал случайное число от 1 до 100, введите ваше предположение:");
    guess = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    steps++;

    if (guess > randomNumber) {
      print("less");
    } else if (guess < randomNumber) {
      print("greater");
    }
  } while (guess != randomNumber);

  print("Поздравляем! Вы угадали за $steps шагов!");
  return steps;
}

void rankedGame() {
  print("Введите количество раундов от 1 до 10 :");
  int rounds = int.tryParse(stdin.readLineSync() ?? '') ?? 1;

  int computerWins = 0;
  int userWins = 0;

  for (int round = 1; round <= rounds; round++) {
    print("--------Round $round--------");

    int computerSteps = computerGuesses();
    int userSteps = userGuesses();

    if (computerSteps < userSteps) {
      print("Компьютер победил в этом раунде!");
      computerWins++;
    } else if (userSteps < computerSteps) {
      print("Вы выиграли этот раунд!");
      userWins++;
    } else {
      print("В этом раунде ничья!");
    }
  }

  print("---------Game Over---------");

  if (computerWins > userWins) {
    print("Компьютер выиграл $computerWins-$userWins");
  } else if (userWins > computerWins) {
    print("Вы выиграли $userWins-$computerWins");
  } else {
    print("Это ничья!");
  }
}

