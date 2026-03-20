% Лабораторная работа. Вариант 15
clc;
close all;
clear all;
Aish=[3 4 3 8 9;5 2 1 4 3;4 9 4 6 7;3 4 11 5 4;8 9 8 7 1];
Bish=[61;43;79;87;58];
disp('Вариант 15');
n=15;
disp('Исходные данные варианта'); disp(n);
A=Aish + (2*n-1)
B=Bish + (9*n-4)
% Векторные и матричные вычисления
disp('Транспонированные матрицы A и В');
Bt=B'
At=A'
disp('Обратная матрица A с проверкой');
Aobr=inv(A)
provA=A*Aobr
disp('Проверка матрицы A на ортогональность');
Eort=At-Aobr
disp('Матрица нормированных коэфф. СНорм=(Bt)');
C=(Bt-min(Bt))/(max(Bt)-min(Bt))
disp('Результат умнож. матриц Fcb=С*B');
Fcb=C*B
disp('Результат умнож. матриц Fbc=B*C');
Fbc=B*C
disp('Определитель матрицы Fbc');
OFbc=det(Fbc)
disp('Определитель матрицы A');
OA=det(A)
disp('Главные миноры A:');
for k=1:5
fprintf('Минор элемента %d%d\n', k, k);
minor = det(A([1:k-1, k+1:5], [1:k-1,k+1:5]));
disp(minor);
end
disp('Решаем СЛАУ Ax=B методом Гаусса');
AGs=rref([A B])
r=size(AGs)
disp('Вектор значений переменных [X] СЛАУ Ax=B');
XGs=AGs(:,r(2))
disp('Проверяем решение СЛАУ Ax-B=0');
EpsGs=A*XGs-B
disp('Решаем СЛАУ Ax=B методом обратной матрицы');
Xom=inv(A)*B
disp('Проверяем решение СЛАУ Ax-B=0');
Epsom=A*Xom-B


% Запись результатов в файл
f_stud_N15 = fopen('Lab_Work_1_N15.txt', 'wt');
fprintf(f_stud_N15, "Исходные данные варианта \t%u\n\n", n);
fprintf(f_stud_N15, 'Матрица А \n');
dlmwrite(f_stud_N15, A, '\t'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Матрица B \n');
dlmwrite(f_stud_N15, B, '\t'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Транспонированная матрица A \n');
dlmwrite(f_stud_N15, At, '\t'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Транспонированная матрица B \n');
dlmwrite(f_stud_N15, Bt, '\t'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Обратная матрица A \n');
dlmwrite(f_stud_N15, Aobr, '\t', 'precision', '%3.5e'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Проверка обратной матрицы A \n');
dlmwrite(f_stud_N15, provA, '\t', 'precision', '%3.3e'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Проверка матрицы A на ортогональность =[0] \n');
dlmwrite(f_stud_N15, Eort, '\t\t', 'precision', '%3.3f'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Матрица нормированных коэфф. СНорм=( Bt) \n');
dlmwrite(f_stud_N15, C, '\t', 'precision', '%3.3g'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, "Результат умнож. матриц Fcb=С*B= \t%f\n\n", Fcb);
fprintf(f_stud_N15, "Результат умнож. матриц Fbc=B*C= \t\n\n");
dlmwrite(f_stud_N15, Fbc, '\t'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, "Определитель матрицы A= \t%f\n", OA);
fprintf(f_stud_N15, "Главные миноры A: \n");
for k=1:5
    fprintf(f_stud_N15, 'Минор %d порядка: %f\n', k, det(A(1:k,1:k)));
end
fprintf(f_stud_N15, '\nРешение СЛАУ Ax=B методом Гаусса: \n');
fprintf(f_stud_N15, 'Расширенная матрица после приведения к ступенчатому виду: \n');
dlmwrite(f_stud_N15, AGs, '\t', 'precision', '%3.3f'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Вектор значений переменных [X] СЛАУ Ax=B методом Гаусса: \n');
dlmwrite(f_stud_N15, XGs, '\t', 'precision', '%3.3f'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Проверка решения СЛАУ Ax-B=0 (метод Гаусса): \n');
dlmwrite(f_stud_N15, EpsGs, '\t', 'precision', '%3.3e'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Решение СЛАУ Ax=B методом обратной матрицы: \n');
dlmwrite(f_stud_N15, Xom, '\t', 'precision', '%3.3f'); fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, 'Проверка решения СЛАУ Ax-B=0 (метод обратной матрицы): \n');
dlmwrite(f_stud_N15, Epsom, '\t', 'precision', '%3.3e'); fprintf(f_stud_N15, '\n');

fclose(f_stud_N15);

% Построение графика
% Задаем область значений аргумента
AAx=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25];
% Вычисляем значение функции
muAAx=(AAx-1)./(AAx*(n+39)/(n+31));
AAx1=[0 0.99]; % Добавляем недостающее нач. знач. арг.
muAAx1=[0 0]; % Добавляем недостающее нач. знач. функ.
% рисуем и сохраняем в файл pdf
hf=figure();
hold on;
plot(AAx, muAAx, 'b', 'linewidth', 4, AAx1, muAAx1, 'b', 'linewidth', 4);
set(gcf, 'position', [100 100 600 300]); % Положение нижн. лев. угла и разм окна в пикселях
set(gca, 'fontname', 'Liberation Serif'); % Тип шрифта знач. графика
set(gca, 'fontsize', 20); % Размер шрифта знач. графика
set(gca, 'xtick', [0 5 10 15 20 25], 'xlim', [0 25], 'linewidth', 1.8); % позиции сетки на X
set(gca, 'ytick', [0 0.25 0.5 0.75 1], 'ylim', [0 1]); % позиции сетки на Y
% вкл. сетку и подписываем оси
grid on;
xlabel("AA", 'fontsize', 20);
ylabel("\mu(AA)", 'fontsize', 20);
% Записываем график в файл
print(hf, "Graf_LabRab_1.pdf", "-dpdf", "-S600,300"); % сохр. в PDF
print(hf, "fig_LabRab_1.jpg", "-djpg", "-S550,304"); % сохр. в jpg
waitforbuttonpress();

% Нахождение значения целевой функции графическим способом
k = round(((32 - n) / (41 - n)) * n)
w = round((n - k + 6) / (n + 1))
t = -4 * pi : 0.1 : 3 * pi;
V1 = k * cos(w * t) + (n / (n + 3)) * cos(3 * w * t);
V2 = k / 2 + w * t - 1;
% Построение F(t) = max(V1, V2)
F = max(V1, V2);
[F_max, idx] = max(F);
t_max = t(idx);
% Рисуем все графики
hf = figure();
hold on;
plot(t, V1, 'b', 'linewidth', 4); % V1 синим
plot(t, V2, 'g', 'linewidth', 4); % V2 зеленым
plot(t, F, 'r', 'linewidth', 3); % F(t) красным
plot(t_max, F_max, 'ro', 'markersize', 10, 'linewidth', 3); % точка максимума
% Настройки графика
set(gcf, 'position', [200 200 600 300]);
set(gca, 'fontname', 'Liberation Serif');
set(gca, 'fontsize', 18);
grid on;
xlabel("t", 'fontsize', 20);
ylabel("V(t)", 'fontsize', 20);
title(['Max F(t) = ', num2str(F_max), ' t = ', num2str(t_max)]);
% Сохранение
print(hf, "Resh_LabRab_1.pdf", "-dpdf", "-S600,300");
waitforbuttonpress();

% Дописываем в файл значения k и w
f_stud_N15 = fopen('Lab_Work_1_N15.txt', 'at');
fprintf(f_stud_N15, '\n');
fprintf(f_stud_N15, "k= \t%f\n\n", k);
fprintf(f_stud_N15, "w= \t%f\n\n", w);
fclose(f_stud_N15);
