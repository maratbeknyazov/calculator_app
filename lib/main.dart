// Подключаем «коробку с инструментами» Flutter для создания интерфейса (кнопки, цвета, шрифты)
import 'package:flutter/material.dart';

// Точка входа. С этой строчки компьютер начинает «читать» твое приложение.
// Он говорит: «Запусти-ка мне главное приложение под названием MyApp»
void main() => runApp(const MyApp());

// Это «каркас» нашего приложения. Оно статичное (Stateless), то есть само по себе не меняется.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp — это общая оболочка: здесь задаем название и общую тему (цвета)
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue), // Основной цвет будет синим
      home: const MyHomePage(title: 'Калькулятор'), // Говорим, что главная страница — это MyHomePage
    );
  }
}

// А вот это уже «живая» страница. StatefulWidget значит, что данные на ней будут меняться (цифры на экране)
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title; // Сюда прилетит заголовок "Калькулятор"

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Здесь живет вся «логика» и «мозги» нашего калькулятора
class _MyHomePageState extends State<MyHomePage> {
  // Переменные — это «коробочки», где мы храним данные
  String output = "0";    // То, что пользователь видит на экране прямо сейчас
  String _output = "0";   // Временное хранилище для текста
  double num1 = 0.0;      // Первое число, которое ввели
  double num2 = 0.0;      // Второе число
  String operand = "";    // Знак операции (+, -, *, /)

  // Функция-обработчик нажатий. Срабатывает каждый раз, когда тыкаем в кнопку.
  buttonPressed(String buttonText) {
    
    // Если нажали "C" — всё стираем и обнуляем
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } 
    // Если нажали знак (+, -, /, X)
    else if (buttonText == "+" || buttonText == "-" || buttonText == "/" || buttonText == "X") {
      num1 = double.parse(output); // Сохраняем первое число (переводим текст в число)
      operand = buttonText;        // Запоминаем, что мы хотим сделать (например, сложить)
      _output = "0";               // Готовимся вводить второе число
    } 
    // Если нажали точку
    else if (buttonText == ".") {
      if (_output.contains(".")) { // Если точка уже есть, вторую не ставим
        return;
      } else {
        _output = _output + buttonText;
      }
    } 
    // Если нажали "равно" — время считать!
    else if (buttonText == "=") {
      num2 = double.parse(output); // Сохраняем второе число

      if (operand == "+") _output = (num1 + num2).toString();
      if (operand == "-") _output = (num1 - num2).toString();
      if (operand == "X") _output = (num1 * num2).toString();
      if (operand == "/") _output = (num1 / num2).toString();

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } 
    // Если просто нажали цифру
    else {
      _output = _output + buttonText;
    }

    // ВАЖНО: Команда setState говорит приложению: «Эй, данные изменились, перерисуй экран!»
    setState(() {
      // Округляем до 2 знаков после запятой, чтобы не было длинных хвостов
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  // Маленький «завод» по производству кнопок. Чтобы не писать код каждой кнопки вручную.
  Widget buildButton(String buttonText) {
    return Expanded( // Кнопка растянется, чтобы занять свободное место
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(24.0)),
        onPressed: () => buttonPressed(buttonText), // При нажатии вызываем функцию выше
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // А здесь мы рисуем то, что видим глазами (интерфейс)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)), // Верхняя полоска с названием
      body: Column( // Все элементы идут один под другим (в колонку)
        children: <Widget>[
          // Верхняя часть: экран с цифрами
          Container(
            alignment: Alignment.centerRight, // Прижимаем цифры вправо
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          
          const Expanded(child: Divider()), // Линия-разделитель и пустое место

          // Нижняя часть: Сетка кнопок
          Column(
            children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("/")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("X")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("."), buildButton("0"), buildButton("00"), buildButton("+")]),
              Row(children: [buildButton("CLEAR"), buildButton("=")]),
            ],
          ),
        ],
      ),
    );
  }
}