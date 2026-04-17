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
    print(f"\n{'=' * 80}")
    print(f" ШАГ {step_number}: {description}")
    print("=" * 80)


def main():
    print("ПРАКТИЧЕСКАЯ РАБОТА №2")
    print("Нахождение базиса и приведение задачи к базисным переменным")
    print("Вариант №15")

    # ========== 1. Исходные данные (вариант 15) ==========
    print_step(1, "Исходные данные задачи (вариант №15)")

    c = np.array([21, 15, 3, 13, 15, 21, 29])  # целевая функция
    print(
        f"\nЦелевая функция: max({c[0]}x₁ + {c[1]}x₂ + {c[2]}x₃ + {c[3]}x₄ + {c[4]}x₅ + {c[5]}x₆ + {c[6]}x₇)"
    )

    # Матрица коэффициентов ограничений (5×7)
    A_orig = np.array(
        [
            [7, 26, 17, 17, 25, 7, 3],
            [-10, 28, 12, 4, -7, -6, 24],
            [20, -6, 18, 4, 24, -5, 29],
            [3, 11, 3, 29, -3, 26, -3],
            [8, 1, 12, 23, 19, 8, 13],
        ],
        dtype=float,
    )

    b = np.array([106, 52, 79, 62, 89], dtype=float)

    print("\nСистема ограничений:")
    print("1) 7x₁ + 26x₂ + 17x₃ + 17x₄ + 25x₅ + 7x₆ + 3x₇ = 106")
    print("2) -10x₁ + 28x₂ + 12x₃ + 4x₄ - 7x₅ - 6x₆ + 24x₇ = 52")
    print("3) 20x₁ - 6x₂ + 18x₃ + 4x₄ + 24x₅ - 5x₆ + 29x₇ ≥ 79")
    print("4) 3x₁ + 11x₂ + 3x₃ + 29x₄ - 3x₅ + 26x₆ - 3x₇ ≥ 62")
    print("5) 8x₁ + x₂ + 12x₃ + 23x₄ + 19x₅ + 8x₆ + 13x₇ ≤ 89")
    print("x₁ … x₇ ≥ 0")

    # ========== 2. Матрица A (исходная) ==========
    print_step(2, "Матрица ограничений А (исходная)")
    print_matrix_with_labels(A_orig, "A", "x", "Матрица коэффициентов A (5×7)")

    # ========== 3. Вектор B ==========
    print_step(3, "Вектор-столбец B")
    print("\nB =")
    print(b.reshape(-1, 1))

    # ========== 4. Приведение к уравнениям ==========
    print_step(4, "Приведение ограничений к уравнениям (ввод x8, x9, x10)")
    print("\nВводим дополнительные переменные:")
    print("  - для 3-го неравенства (≥) вычитаем x8")
    print("  - для 4-го неравенства (≥) вычитаем x9")
    print("  - для 5-го неравенства (≤) прибавляем x10")

    # Расширенная матрица A (5×10): x1..x7, x8, x9, x10
    A_ext = np.zeros((5, 10))
    A_ext[:, :7] = A_orig
    A_ext[2, 7] = -1  # x8
    A_ext[3, 8] = -1  # x9
    A_ext[4, 9] = 1  # x10

    print("\nСистема после ввода доп. переменных (без преобразования):")
    eqs = [
        "7x₁ + 26x₂ + 17x₃ + 17x₄ + 25x₅ + 7x₆ + 3x₇ = 106",
        "-10x₁ + 28x₂ + 12x₃ + 4x₄ - 7x₅ - 6x₆ + 24x₇ = 52",
        "20x₁ - 6x₂ + 18x₃ + 4x₄ + 24x₅ - 5x₆ + 29x₇ - x₈ = 79",
        "3x₁ + 11x₂ + 3x₃ + 29x₄ - 3x₅ + 26x₆ - 3x₇ - x₉ = 62",
        "8x₁ + x₂ + 12x₃ + 23x₄ + 19x₅ + 8x₆ + 13x₇ + x₁₀ = 89",
    ]
    for i, eq in enumerate(eqs, 1):
        print(f"{i}) {eq}")

    # ========== Преобразование строк 3 и 4 (умножение на -1) ==========
    print(
        "\nДля удобства выбора базиса умножим строки 3 и 4 на -1 (чтобы коэффициенты при x8 и x9 стали +1)."
    )
    A_ext[2, :] = -A_ext[2, :]
    A_ext[3, :] = -A_ext[3, :]
    b_new = b.copy()
    b_new[2] = -b_new[2]
    b_new[3] = -b_new[3]

    print("\nПреобразованная система (строки 3' и 4'):")
    eqs2 = [
        "7x₁ + 26x₂ + 17x₃ + 17x₄ + 25x₅ + 7x₆ + 3x₇ = 106",
        "-10x₁ + 28x₂ + 12x₃ + 4x₄ - 7x₅ - 6x₆ + 24x₇ = 52",
        "-20x₁ + 6x₂ - 18x₃ - 4x₄ - 24x₅ + 5x₆ - 29x₇ + x₈ = -79",
        "-3x₁ - 11x₂ - 3x₃ - 29x₄ + 3x₅ - 26x₆ + 3x₇ + x₉ = -62",
        "8x₁ + x₂ + 12x₃ + 23x₄ + 19x₅ + 8x₆ + 13x₇ + x₁₀ = 89",
    ]
    for i, eq in enumerate(eqs2, 1):
        print(f"{i}) {eq}")

    # ========== 5. Новая матрица A и вектор B ==========
    print_step(5, "Новая матрица A (расширенная, преобразованная) и вектор B")
    print("\nМатрица A' (5×10):")
    print_matrix_with_labels(A_ext, "A'", "x", "Преобразованная матрица")
    print("\nВектор B':")
    print(b_new.reshape(-1, 1))

    # ========== 6. Ранг и базисные переменные ==========
    print_step(6, "Ранг матрицы и количество базисных переменных")
    rank = np.linalg.matrix_rank(A_ext)
    print(f"Ранг матрицы A' : rank = {rank}")
    print(f"Количество уравнений m = 5")
    print(f"Количество переменных n = 10")
    print(f"rank = m = 5 → система совместна, rank < n → система неопределена")
    print(f"Число базисных переменных = m = 5")
    print(f"Число свободных переменных = n - m = 5")

    # ========== 7. Выбор базиса ==========
    print_step(7, "Выбор базисных переменных")
    # Выбираем базис: x8, x9, x10, x1, x2 (столбцы 8,9,10,1,2) в терминах 1-индексации
    # в Python индексы с 0: столбцы 7,8,9,0,1
    basis_idx = [7, 8, 9, 0, 1]  # индексы в A_ext
    free_idx = [i for i in range(10) if i not in basis_idx]  # остальные: 2,3,4,5,6

    print("\nБазисные переменные: x8, x9, x10, x1, x2")
    print("Свободные переменные: x3, x4, x5, x6, x7")

    D = A_ext[:, basis_idx]
    S = A_ext[:, free_idx]

    print("\nМатрица D (коэффициенты при базисных переменных):")
    print_matrix_with_labels(D, "D", "basis", "Матрица D (5×5)")
    print("\nМатрица S (коэффициенты при свободных переменных):")
    print_matrix_with_labels(S, "S", "free", "Матрица S (5×5)")

    # Проверка невырожденности D
    det_D = np.linalg.det(D)
    print(f"\nОпределитель D: det(D) = {det_D:.6f}")
    if abs(det_D) < 1e-10:
        print("ОШИБКА: D вырождена! Выберите другой базис.")
        return
    else:
        print("det(D) ≠ 0 → D невырождена, можно найти обратную.")

    # ========== 8. Обратная матрица D⁻¹ ==========
    print_step(8, "Нахождение обратной матрицы D⁻¹")
    D_inv = np.linalg.inv(D)
    print("\nD⁻¹:")
    print_matrix_with_labels(D_inv, "D_inv", "col", "Обратная матрица")

    # ========== 9. Вычисление β ==========
    print_step(9, "Вычисление коэффициентов β = D⁻¹ · B'")
    beta = D_inv @ b_new
    print("\nβ = D⁻¹ · B' =")
    for i, idx in enumerate(basis_idx):
        print(f"  β_{i + 1} (для x{idx + 1}) = {beta[i]:.6f}")

    # ========== 10. Вычисление α = D⁻¹·S ==========
    print_step(10, "Вычисление матрицы α = D⁻¹ · S")
    alpha = D_inv @ S
    print("\nα = D⁻¹ · S (5×5):")
    print_matrix_with_labels(alpha, "alpha", "free", "Матрица α")
    print("\nКоэффициенты αᵢⱼ (строка i — базовая переменная, столбец j — свободная):")
    for i, b_idx in enumerate(basis_idx):
        row = []
        for j, f_idx in enumerate(free_idx):
            row.append(f"α_{i + 1},{f_idx + 1} = {alpha[i, j]:.6f}")
        print("  " + ", ".join(row))

    # ========== 11. Система в базисных переменных ==========
    print_step(11, "Запись системы в базисных переменных")
    print("\nСистема X_basis = β - α · X_free, где X_free = [x3, x4, x5, x6, x7]")
    print("В развёрнутом виде:")
    for i, b_idx in enumerate(basis_idx):
        line = f"x{b_idx + 1} = {beta[i]:.6f}"
        for j, f_idx in enumerate(free_idx):
            coef = alpha[i, j]
            if abs(coef) > 1e-10:
                line += f" - ({coef:.6f}·x{f_idx + 1})"
        print(line)

    # ========== 12. Матричная форма ==========
    print_step(12, "Матричная форма Â·X = β")
    A_hat = np.hstack((np.eye(5), alpha))
    print("\nÂ = [E | α] (5×10):")
    print_matrix_with_labels(A_hat, "A_hat", "x", "Матрица Â")
    print(f"\nβ = {beta.reshape(-1, 1)}")

    # ========== 13. Базисное решение ==========
    print_step(13, "Базисное решение (свободные переменные = 0)")
    x_basis = beta.copy()
    x_free = np.zeros(5)
    X_full = np.zeros(10)
    for i, idx in enumerate(basis_idx):
        X_full[idx] = x_basis[i]
    # свободные и так нули
    print("\nБазисные переменные:")
    for i, idx in enumerate(basis_idx):
        print(f"x{idx + 1} = {x_basis[i]:.6f}")
    print("\nСвободные переменные равны 0.")
    print("\nПолное базисное решение X = (x1 ... x10):")
    for i, val in enumerate(X_full, 1):
        print(f"x{i} = {val:.6f}")

    # ========== 14. Проверка подстановкой ==========
    print_step(14, "Проверка решения подстановкой в исходные уравнения")
    print("\nПроверка для преобразованной системы A'·X = B':")
    residual = A_ext @ X_full - b_new
    for i in range(5):
        print(f"Уравнение {i + 1}: невязка = {residual[i]:.2e} (должна быть ~0)")

    # ========== 15. Анализ допустимости ==========
    print_step(15, "Анализ допустимости базисного решения")
    if np.all(beta >= -1e-10):
        print("\nВсе β_i ≥ 0 → базисное решение является ДОПУСТИМЫМ опорным планом.")
        if np.all(beta > 1e-10):
            print("Опорный план невырожденный (все β_i > 0).")
        else:
            zero_idx = [i + 1 for i, val in enumerate(beta) if abs(val) < 1e-10]
            print(f"Опорный план вырожденный (нулевые компоненты: x{zero_idx}).")
    else:
        print("\nБазисное решение НЕДОПУСТИМО, так как следующие β_i отрицательны:")
        for i, idx in enumerate(basis_idx):
            if beta[i] < -1e-10:
                print(f"  x{idx + 1} = {beta[i]:.6f}")
        print("Необходимо сменить базис или применить двухфазный метод.")

    # ========== Доп. вывод значения целевой функции ==========
    print("\nЗначение целевой функции на опорном плане (свободные = 0):")
    # Учитываем только x1..x7 (остальные в целевую не входят)
    W = np.dot(c, X_full[:7])
    print(
        f"W = {c[0]}·x1 + {c[1]}·x2 + {c[2]}·x3 + {c[3]}·x4 + {c[4]}·x5 + {c[5]}·x6 + {c[6]}·x7 = {W:.6f}"
    )


if __name__ == "__main__":
    main()
