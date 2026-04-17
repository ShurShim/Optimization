% Практическая работа 3, Вариант 15
% Матрица потерь (расходов)
V = [7, 4, 9, 8, 3;
     8, 6, 9, 5, 1;
     9, 3, 8, 6, 2;
    11, 5, 13,11,6];

fprintf('Матрица потерь V:\n');
disp(V);

% --- 1. Критерий Лапласа ---
% Предполагаем равные вероятности состояний природы
meanV = mean(V, 2);               % среднее по строкам
[minLaplace, optLaplace] = min(meanV);
fprintf('\n=== Критерий Лапласа ===\n');
fprintf('Средние потери по вариантам:\n');
disp(meanV');
fprintf('Оптимальная стратегия: R%d (средние потери = %.4f)\n', optLaplace, minLaplace);

% --- 2. Минимаксный критерий (Вальда) ---
maxV = max(V, [], 2);             % максимум в каждой строке
[minWald, optWald] = min(maxV);
% Возможны несколько оптимальных стратегий
optWaldAll = find(maxV == minWald);
fprintf('\n=== Критерий Вальда (минимакс) ===\n');
fprintf('Максимальные потери по вариантам:\n');
disp(maxV');
if length(optWaldAll) == 1
    fprintf('Оптимальная стратегия: R%d (гарантированные потери = %.4f)\n', optWald, minWald);
else
    fprintf('Оптимальные стратегии: ');
    fprintf('R%d ', optWaldAll);
    fprintf('(гарантированные потери = %.4f)\n', minWald);
end

% --- 3. Критерий Сэвиджа (матрица рисков) ---
minCol = min(V, [], 1);           % минимум по столбцам
R = V - minCol;                   % матрица рисков
fprintf('\n=== Критерий Сэвиджа ===\n');
fprintf('Матрица рисков:\n');
disp(R);
maxR = max(R, [], 2);             % максимальный риск по строкам
[minSavage, optSavage] = min(maxR);
optSavageAll = find(maxR == minSavage);
fprintf('Максимальный риск по вариантам:\n');
disp(maxR');
if length(optSavageAll) == 1
    fprintf('Оптимальная стратегия: R%d (максимальный риск = %.4f)\n', optSavage, minSavage);
else
    fprintf('Оптимальные стратегии: ');
    fprintf('R%d ', optSavageAll);
    fprintf('(максимальный риск = %.4f)\n', minSavage);
end

% --- 4. Критерий Гурвица ---
alpha = 0.5;                      % коэффициент оптимизма (можно изменить)
minRow = min(V, [], 2);
maxRow = max(V, [], 2);
H = alpha * minRow + (1 - alpha) * maxRow;
[minHurwicz, optHurwicz] = min(H);
optHurwiczAll = find(H == minHurwicz);
fprintf('\n=== Критерий Гурвица (alpha = %.2f) ===\n', alpha);
fprintf('Значения Гурвица для вариантов:\n');
disp(H');
if length(optHurwiczAll) == 1
    fprintf('Оптимальная стратегия: R%d (значение = %.4f)\n', optHurwicz, minHurwicz);
else
    fprintf('Оптимальные стратегии: ');
    fprintf('R%d ', optHurwiczAll);
    fprintf('(значение = %.4f)\n', minHurwicz);
end
