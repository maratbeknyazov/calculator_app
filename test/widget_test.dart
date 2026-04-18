// Импортируем «инструменты» для рисования интерфейса (кнопки, тексты)
import 'package:flutter/material.dart';
// Импортируем «инструменты» для самих тестов (проверки, нажатия)
import 'package:flutter_test/flutter_test.dart';

// Подключаем твое приложение. Название 'calculator_app' должно совпадать с именем твоего проекта.
import 'package:calculator_app/main.dart';

void main() {
  // Это начало нашего теста. 
  // 'Counter increments smoke test' — это просто название проверки, чтобы ты понял, что упало, если будет ошибка.
  // WidgetTester tester — это наш «виртуальный палец», который будет тыкать в экран.
  testWidgets('Тест счетчика: проверяем, что цифра меняется при нажатии', (WidgetTester tester) async {
    
    // 1. Команда: «Запусти приложение в памяти компьютера».
    // tester.pumpWidget — это как нажать на иконку приложения на телефоне.
    await tester.pumpWidget(const MyApp());

    // 2. Проверяем, что в самом начале на экране есть текст '0'.
    // expect — это команда «я ожидаю, что...»
    // find.text('0') — ищем глазами текст «0»
    // findsOneWidget — подтверждаем, что нашли ровно одну такую штуку.
    expect(find.text('0'), findsOneWidget);
    
    // И сразу проверяем, что текста '1' пока НЕТ (это логично, мы еще ничего не нажимали).
    expect(find.text('1'), findsNothing);

    // 3. Находим кнопку с иконкой «плюс» (Icons.add) и имитируем нажатие пальцем.
    // await tester.tap — «нажми-ка сюда».
    await tester.tap(find.byIcon(Icons.add));

    // 4. ОЧЕНЬ ВАЖНО: После нажатия приложению нужно время, чтобы перерисовать экран.
    // tester.pump() — это команда «подожди долю секунды, пока анимация закончится и цифра обновится».
    await tester.pump();

    // 5. Финальная проверка:
    // Теперь текста '0' на экране быть не должно (findsNothing).
    expect(find.text('0'), findsNothing);
    // А вот текст '1' должен появиться (findsOneWidget).
    expect(find.text('1'), findsOneWidget);
  });
}