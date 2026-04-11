import numpy as np
import pandas as pd
from scipy import linalg


def print_matrix_with_labels(A, rows_label="A", cols_prefix="x", title="Матрица"):
    """Красивый вывод матрицы с индексами"""
    print(f"\n{title}:")
    df = pd.DataFrame(A)
    print(df.to_string(index=False, header=False))
    return df


def print_step(step_number, description):
    """Вывод номера шага с описанием"""
    print(f"\n{'=' * 80}")
    print(f" ШАГ {step_number}: {description}")
    print('=' * 80)


def main():
    print("ПРАКТИЧЕСКАЯ РАБОТА №2")
    print("Нахождение базиса и приведение задачи к базисным переменным")
    print("Вариант №20")

    # ШАГ 1: Исходные данные
    print_step(1, "Исходные данные задачи (вариант №20)")

    # Коэффициенты целевой функции
    c = np.array([23, 25, 19, 24, 25, 15, 12])
    print(f"\nЦелевая функция: max({c[0]}x₁ + {c[1]}x₂ + {c[2]}x₃ + {c[3]}x₄ + {c[4]}x₅ + {c[5]}x₆ + {c[6]}x₇)")

    # Матрица коэффициентов ограничений (левая часть)
    A = np.array([
        [9, -2, -8, 21, -9, 25, 20],
        [30, 17, 3, 18, 8, 29, -9],
        [13, 30, 1, -4, 2, -6, 16],
        [12, -1, -4, -4, -5, 5, 11],
        [-5, 30, 9, -5, 16, 13, -8]
    ], dtype=float)

    # Вектор правых частей
    b = np.array([62, 101, 43, 7, 56], dtype=float)

    print("\nСистема ограничений:")
    print("1) 9x₁ - 2x₂ - 8x₃ + 21x₄ - 9x₅ + 25x₆ + 20x₇ = 62")
    print("2) 30x₁ + 17x₂ + 3x₃ + 18x₄ + 8x₅ + 29x₆ - 9x₇ = 101")
    print("3) 13x₁ + 30x₂ + x₃ - 4x₄ + 2x₅ - 6x₆ + 16x₇ ≥ 43")
    print("4) 12x₁ - x₂ - 4x₃ - 4x₄ - 5x₅ + 5x₆ + 11x₇ ≥ 7")
    print("5) -5x₁ + 30x₂ + 9x₃ - 5x₄ + 16x₅ + 13x₆ - 8x₇ ≤ 56")

    # ШАГ 2: Матрица ограничений А
    print_step(2, "Матрица ограничений А")
    print_matrix_with_labels(A, "A", "x", "Матрица коэффициентов A (5×7)")

    # ШАГ 3: Вектор-столбец В
    print_step(3, "Вектор-столбец В (правые части)")
    print("\nВектор B:")
    print(b.reshape(-1, 1))

    # ШАГ 4: Приведение ограничений к уравнениям
    print_step(4, "Приведение системы ограничений к уравнениям")
    print("\nВводим дополнительные переменные:")
    print("x₈ для 3-го неравенства (≥ 43) → вычитаем x₈")
    print("x₉ для 4-го неравенства (≥ 7) → вычитаем x₉")
    print("x₁₀ для 5-го неравенства (≤ 56) → прибавляем x₁₀")

    # Расширенная матрица с дополнительными переменными
    A_extended = np.zeros((5, 10))
    A_extended[:, :7] = A
    # Добавляем коэффициенты для дополнительных переменных
    A_extended[2, 7] = -1  # x₈ для 3-го уравнения
    A_extended[3, 8] = -1  # x₉ для 4-го уравнения
    A_extended[4, 9] = 1  # x₁₀ для 5-го уравнения

    print("\nНовая система уравнений:")
    equations = [
        "9x₁ - 2x₂ - 8x₃ + 21x₄ - 9x₅ + 25x₆ + 20x₇ = 62",
        "30x₁ + 17x₂ + 3x₃ + 18x₄ + 8x₅ + 29x₆ - 9x₇ = 101",
        "13x₁ + 30x₂ + x₃ - 4x₄ + 2x₅ - 6x₆ + 16x₇ - x₈ = 43",
        "12x₁ - x₂ - 4x₃ - 4x₄ - 5x₅ + 5x₆ + 11x₇ - x₉ = 7",
        "-5x₁ + 30x₂ + 9x₃ - 5x₄ + 16x₅ + 13x₆ - 8x₇ + x₁₀ = 56"
    ]
    for i, eq in enumerate(equations, 1):
        print(f"{i}) {eq}")

    print("\nУсловия неотрицательности:")
    print("x₁, x₂, x₃, x₄, x₅, x₆, x₇, x₈, x₉, x₁₀ ≥ 0")

    # Новая матрица А и вектор В
    print_step(5, "Новая матрица А (расширенная) и вектор-столбец В")
    print("\nНовая матрица А (5×10):")
    print_matrix_with_labels(A_extended, "A_new", "x", "Матрица коэффициентов A_extended")
    print("\nВектор B остался без изменений:")
    print(b.reshape(-1, 1))

    # ШАГ 6: Определение ранга базисных переменных m
    print_step(6, "Определение ранга матрицы и базисных переменных")

    rank_A = np.linalg.matrix_rank(A_extended)
    print(f"\nРанг матрицы A_extended: rank = {rank_A}")
    print(f"Количество уравнений: m = 5")
    print(f"Количество переменных: n = 10")
    print(f"rank = 5 = m, следовательно система совместна")
    print(f"rank = 5 < 10 = n, следовательно система неопределенная")
    print(f"Количество базисных переменных: m = 5")
    print(f"Количество свободных переменных: n - m = 5")

    # ШАГ 7: Выбор базисных переменных
    print_step(7, "Выбор базисных переменных")
    print("\nВ качестве базисных переменных выбираем x₁, x₂, x₃, x₄, x₅")
    print("Соответственно свободные переменные: x₆, x₇, x₈, x₉, x₁₀")

    # Формируем матрицы D (базисные) и S (свободные)
    # Индексы базисных переменных (0-4)
    basis_indices = [0, 1, 2, 3, 4]
    free_indices = [5, 6, 7, 8, 9]

    D = A_extended[:, basis_indices]  # первые 5 столбцов
    S = A_extended[:, free_indices]  # остальные 5 столбцов

    print("\nМатрица D (коэффициенты при базисных переменных x₁-x₅):")
    print_matrix_with_labels(D, "D", "x_basis", "Матрица D (5×5)")

    print("\nМатрица S (коэффициенты при свободных переменных x₆-x₁₀):")
    print_matrix_with_labels(S, "S", "x_free", "Матрица S (5×5)")

    # Проверяем, что D невырождена
    det_D = np.linalg.det(D)
    print(f"\nОпределитель матрицы D: det(D) = {det_D:.6f}")
    if abs(det_D) > 1e-10:
        print("det(D) ≠ 0 → матрица D невырождена, можно найти обратную")
    else:
        print("ОШИБКА: Матрица D вырождена!")
        return

    # ШАГ 8: Нахождение обратной матрицы D⁻¹
    print_step(8, "Нахождение обратной матрицы D⁻¹")

    D_inv = np.linalg.inv(D)
    print("\nОбратная матрица D⁻¹:")
    print_matrix_with_labels(D_inv, "D_inv", "row", "Обратная матрица D⁻¹")

    # ШАГ 9: Вычисление коэффициентов β
    print_step(9, "Вычисление коэффициентов β (базисное решение)")

    beta = np.dot(D_inv, b)
    print("\nβ = D⁻¹ × B:")
    print(f"β = D⁻¹ × B = \n{beta.reshape(-1, 1)}")

    print("\nКомпоненты вектора β:")
    for i in range(len(beta)):
        print(f"β_{i + 1} = {beta[i]:.6f}")

    # Проверка допустимости базисного решения
    print("\nПроверка допустимости базисного решения:")
    print(f"Все β_i ≥ 0? {'Да' if np.all(beta >= -1e-10) else 'Нет'}")
    if np.all(beta >= -1e-10):
        print("→ Решение допустимое (опорный план)")
    else:
        print("→ Решение недопустимое (отрицательные компоненты)")
        # Проверим, есть ли строго отрицательные
        negative_beta = [i for i, val in enumerate(beta) if val < -1e-10]
        if negative_beta:
            print(f"Отрицательные компоненты: β_{[i + 1 for i in negative_beta]}")

    # ШАГ 10: Вычисление коэффициентов αij
    print_step(10, "Вычисление коэффициентов αij (матрица α = D⁻¹ × S)")

    alpha = np.dot(D_inv, S)
    print("\nα = D⁻¹ × S:")
    print_matrix_with_labels(alpha, "alpha", "basis", "Матрица α (5×5)")

    print("\nКоэффициенты αij (элементы матрицы):")
    for i in range(5):
        for j in range(5):
            print(f"α_{i + 1},{free_indices[j] + 1} = {alpha[i, j]:.6f}")

    # ШАГ 11: Запись системы в базисных переменных
    print_step(11, "Запись системы уравнений в базисных переменных")

    print("\nСистема X = β - α × X_free (где X_free = [x₆, x₇, x₈, x₉, x₁₀]):")
    for i in range(5):
        terms = []
        for j in range(5):
            if abs(alpha[i, j]) > 1e-10:  # пропускаем нулевые коэффициенты
                sign = "-" if alpha[i, j] > 0 else "+"  # в формуле стоит минус α × x
                coef = abs(alpha[i, j])
                var_idx = free_indices[j] + 1
                if sign == "-":
                    terms.append(f"- {coef:.4f}·x{var_idx}")
                else:
                    terms.append(f"+ {coef:.4f}·x{var_idx}")

        if terms:
            # Убираем первый знак, если он плюс
            if terms[0].startswith("+"):
                terms[0] = terms[0][2:]  # убираем "+ "
            expr = " ".join(terms)
        else:
            expr = "0"

        print(f"x{i + 1} = {beta[i]:.4f} {expr}")

    print("\nВ развернутом виде:")
    for i in range(5):
        line = f"x{i + 1} = {beta[i]:.4f}"
        for j in range(5):
            if abs(alpha[i, j]) > 1e-10:
                line += f" - ({alpha[i, j]:.4f}·x{free_indices[j] + 1})"
        print(line)

    # ШАГ 12: Запись в матричной форме
    print_step(12, "Запись системы в матричной форме")

    print("\nСистема в матричной форме Â × X = β, где:")
    print("Â = [E | α]")

    # Строим матрицу Â
    A_hat = np.zeros((5, 10))
    A_hat[:, :5] = np.eye(5)
    A_hat[:, 5:] = alpha

    print("\nМатрица Â (5×10):")
    print_matrix_with_labels(A_hat, "A_hat", "x", "Матрица Â")

    print(f"\nВектор β:\n{beta.reshape(-1, 1)}")

    # ШАГ 13: Базисное решение
    print_step(13, "Базисное решение")

    print("\nБазисное решение получаем, приравнивая свободные переменные к нулю:")
    print("x₆ = 0, x₇ = 0, x₈ = 0, x₉ = 0, x₁₀ = 0")

    x_basis = beta.copy()
    x_free = np.zeros(5)

    print("\nТогда базисные переменные равны β:")
    for i in range(5):
        print(f"x{i + 1} = {x_basis[i]:.6f}")

    print("\nПолное базисное решение X = (x₁, x₂, x₃, x₄, x₅, x₆, x₇, x₈, x₉, x₁₀):")
    X_full = np.zeros(10)
    X_full[:5] = x_basis
    X_full[5:] = x_free
    for i, val in enumerate(X_full, 1):
        print(f"x{i} = {val:.6f}")

    # ШАГ 14: Проверка решения
    print_step(14, "Проверка решения подстановкой в исходные уравнения")

    print("\nПроверка для исходных уравнений с дополнительными переменными:")
    # Первое уравнение (равенство)
    left1 = np.dot(A_extended[0, :], X_full)
    print(f"Ур.1: 9·x₁ - 2·x₂ - 8·x₃ + 21·x₄ - 9·x₅ + 25·x₆ + 20·x₇ = {left1:.6f} ≈ {b[0]}? {abs(left1 - b[0]) < 1e-6}")

    # Второе уравнение (равенство)
    left2 = np.dot(A_extended[1, :], X_full)
    print(
        f"Ур.2: 30·x₁ + 17·x₂ + 3·x₃ + 18·x₄ + 8·x₅ + 29·x₆ - 9·x₇ = {left2:.6f} ≈ {b[1]}? {abs(left2 - b[1]) < 1e-6}")

    # Третье уравнение (было ≥, теперь с -x₈)
    left3 = np.dot(A_extended[2, :], X_full)
    print(
        f"Ур.3: 13·x₁ + 30·x₂ + x₃ - 4·x₄ + 2·x₅ - 6·x₆ + 16·x₇ - x₈ = {left3:.6f} ≈ {b[2]}? {abs(left3 - b[2]) < 1e-6}")

    # Четвертое уравнение (было ≥, теперь с -x₉)
    left4 = np.dot(A_extended[3, :], X_full)
    print(
        f"Ур.4: 12·x₁ - x₂ - 4·x₃ - 4·x₄ - 5·x₅ + 5·x₆ + 11·x₇ - x₉ = {left4:.6f} ≈ {b[3]}? {abs(left4 - b[3]) < 1e-6}")

    # Пятое уравнение (было ≤, теперь с +x₁₀)
    left5 = np.dot(A_extended[4, :], X_full)
    print(
        f"Ур.5: -5·x₁ + 30·x₂ + 9·x₃ - 5·x₄ + 16·x₅ + 13·x₆ - 8·x₇ + x₁₀ = {left5:.6f} ≈ {b[4]}? {abs(left5 - b[4]) < 1e-6}")

    # ШАГ 15: Анализ решения и выводы
    print_step(15, "Анализ решения и выводы")

    print("\n1. Система ограничений была преобразована к каноническому виду")
    print("   путем введения дополнительных переменных x₈, x₉, x₁₀.")
    print("\n2. Ранг матрицы системы равен 5, что меньше числа переменных (10),")
    print("   следовательно система имеет бесконечное множество решений.")
    print("\n3. В качестве базисных выбраны переменные x₁, x₂, x₃, x₄, x₅.")
    print("\n4. Получено базисное решение:")
    for i, val in enumerate(X_full, 1):
        if i <= 5:
            status = "базисная"
        else:
            status = "свободная"
        print(f"   x{i} = {val:.6f} ({status})")

    print(f"\n5. Решение {'является' if np.all(x_basis >= -1e-10) else 'НЕ является'} допустимым опорным планом")
    if np.all(x_basis >= -1e-10):
        print("   (все базисные переменные неотрицательны)")
    else:
        print("   (присутствуют отрицательные базисные переменные)")

    if np.all(x_basis > 1e-10):
        print("6. Опорный план является НЕвырожденным (все β_i > 0)")
    elif np.any(np.abs(x_basis) < 1e-10) and np.all(x_basis >= -1e-10):
        zero_indices = [i + 1 for i, val in enumerate(x_basis) if abs(val) < 1e-10]
        print(f"6. Опорный план является вырожденным (нулевые компоненты: x_{zero_indices})")

    print("\n7. Значение целевой функции на опорном плане:")
    # Вычисляем значение целевой функции для базисного решения (свободные = 0)
    f_value = np.dot(c[:5], x_basis)  # только первые 5 компонент, т.к. свободные = 0
    print(f"   W = 23·x₁ + 25·x₂ + 19·x₃ + 24·x₄ + 25·x₅ + 15·x₆ + 12·x₇ = {f_value:.6f}")
    print(f"   (при x₆ = x₇ = 0)")


if __name__ == "__main__":
    main()