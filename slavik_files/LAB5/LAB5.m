% §­§Ñ§Ò§à§â§Ñ§ä§à§â§ß§Ñ§ñ §â§Ñ§Ò§à§ä§Ñ ¡í5
% §®§Ö§ä§à§Õ §Õ§Ú§ß§Ñ§Þ§Ú§é§Ö§ã§Ü§à§Ô§à §á§â§à§Ô§â§Ñ§Þ§Þ§Ú§â§à§Ó§Ñ§ß§Ú§ñ
% §£§Ñ§â§Ú§Ñ§ß§ä ¡í5

clear all; close all; clc;

% ============================================
% 0. §°§ä§Ü§â§í§ä§Ú§Ö §æ§Ñ§Û§Ý§Ñ §Õ§Ý§ñ §Ù§Ñ§á§Ú§ã§Ú §Ó§í§Ó§à§Õ§Ñ
% ============================================
log_file = fopen('lab5_result.txt', 'w');

% §¶§å§ß§Ü§è§Ú§ñ §Õ§Ý§ñ §Õ§å§Ò§Ý§Ú§â§à§Ó§Ñ§ß§Ú§ñ §Ó§í§Ó§à§Õ§Ñ §Ó §Ü§à§ß§ã§à§Ý§î §Ú §æ§Ñ§Û§Ý
function dual_printf(fid, varargin)
    str = sprintf(varargin{:});
    printf("%s", str);
    fprintf(fid, "%s", str);
end

dual_printf(log_file, '\t\t§­§¡§¢§°§²§¡§´§°§²§¯§¡§Á §²§¡§¢§°§´§¡ ¡í5\n');
dual_printf(log_file, '\t\t§®§Ö§ä§à§Õ §Õ§Ú§ß§Ñ§Þ§Ú§é§Ö§ã§Ü§à§Ô§à §á§â§à§Ô§â§Ñ§Þ§Þ§Ú§â§à§Ó§Ñ§ß§Ú§ñ\n');
dual_printf(log_file, '\t\t§£§Ñ§â§Ú§Ñ§ß§ä ¡í5\n\n');

% ============================================
% 1. §ª§ã§ç§à§Õ§ß§í§Ö §Õ§Ñ§ß§ß§í§Ö (§ä§Ñ§â§Ú§æ§í §á§Ö§â§Ö§Ó§à§Ù§Ü§Ú)
% ============================================
% §¶§à§â§Þ§Ñ§ä: [from, to, cost]
tariffs = [
    1, 2, 5;
    1, 3, 3;
    1, 4, 8;
    2, 5, 2;
    2, 7, 5;
    3, 5, 8;
    3, 6, 1;
    3, 7, 7;
    4, 5, 5;
    4, 6, 9;
    4, 7, 1;
    5, 8, 3;
    5, 9, 5;
    6, 8, 8;
    6, 9, 4;
    7, 9, 9;
    8, 10, 2;
    9, 10, 7
];

dual_printf(log_file, '§ª§³§·§°§¥§¯§½§¦ §¥§¡§¯§¯§½§¦ (§ä§Ñ§â§Ú§æ§í §á§Ö§â§Ö§Ó§à§Ù§Ü§Ú):\n\n');
dual_printf(log_file, 'C12=5, C13=3, C14=8\n');
dual_printf(log_file, 'C25=2, C27=5\n');
dual_printf(log_file, 'C35=8, C36=1, C37=7\n');
dual_printf(log_file, 'C45=5, C46=9, C47=1\n');
dual_printf(log_file, 'C58=3, C59=5\n');
dual_printf(log_file, 'C68=8, C69=4\n');
dual_printf(log_file, 'C79=9\n');
dual_printf(log_file, 'C8,10=2, C9,10=7\n\n');

% ============================================
% 2. §°§á§â§Ö§Õ§Ö§Ý§Ö§ß§Ú§Ö §ï§ä§Ñ§á§à§Ó §Ú §á§å§ß§Ü§ä§à§Ó
% ============================================
% §¿§ä§Ñ§á 4: §á§å§ß§Ü§ä§í, §Ú§Ù §Ü§à§ä§à§â§í§ç §Þ§à§Ø§ß§à §á§à§á§Ñ§ã§ä§î §Ó §á§å§ß§Ü§ä 10
stage4_from = [8, 9];
stage4_to = 10;

% §¿§ä§Ñ§á 3: §á§å§ß§Ü§ä§í, §Ú§Ù §Ü§à§ä§à§â§í§ç §Þ§à§Ø§ß§à §á§à§á§Ñ§ã§ä§î §Ó §á§å§ß§Ü§ä§í 8 §Ú§Ý§Ú 9
stage3_from = [5, 6, 7];
stage3_to = [8, 9];

% §¿§ä§Ñ§á 2: §á§å§ß§Ü§ä§í, §Ú§Ù §Ü§à§ä§à§â§í§ç §Þ§à§Ø§ß§à §á§à§á§Ñ§ã§ä§î §Ó §á§å§ß§Ü§ä§í 5, 6, 7
stage2_from = [2, 3, 4];
stage2_to = [5, 6, 7];

% §¿§ä§Ñ§á 1: §á§å§ß§Ü§ä§í, §Ú§Ù §Ü§à§ä§à§â§í§ç §Þ§à§Ø§ß§à §á§à§á§Ñ§ã§ä§î §Ó §á§å§ß§Ü§ä§í 2, 3, 4
stage1_from = 1;
stage1_to = [2, 3, 4];

% ============================================
% 3. §¶§å§ß§Ü§è§Ú§ñ §Õ§Ý§ñ §á§à§Ú§ã§Ü§Ñ §ã§ä§à§Ú§Þ§à§ã§ä§Ú §Þ§Ö§Ø§Õ§å §á§å§ß§Ü§ä§Ñ§Þ§Ú
% ============================================
function cost = find_cost(tariffs, from, to)
    idx = tariffs(:,1) == from & tariffs(:,2) == to;
    if any(idx)
        cost = tariffs(idx,3);
    else
        cost = inf;
    end
end

% ============================================
% 4. §¿§ä§Ñ§á 4 (§á§à§ã§Ý§Ö§Õ§ß§Ú§Û) - §å§ã§Ý§à§Ó§ß§Ñ§ñ §à§á§ä§Ú§Þ§Ú§Ù§Ñ§è§Ú§ñ
% ============================================
dual_printf(log_file, '\t\t§¿§´§¡§± 4 (§á§à§ã§Ý§Ö§Õ§ß§Ú§Û)\n\n');

% §³§à§Ù§Õ§Ñ§ß§Ú§Ö §ä§Ñ§Ò§Ý§Ú§è§í
dual_printf(log_file, '+-------------+-------------+-----------+------+-------------+\n');
dual_printf(log_file, '| §ª§Ù §á§å§ß§Ü§ä§Ñ   | §£ §á§å§ß§Ü§ä     | §©§Ñ§ä§â§Ñ§ä§í   | F4   | §£§í§Ò§à§â       |\n');
dual_printf(log_file, '+-------------+-------------+-----------+------+-------------+\n');

F4 = containers.Map();
optimal_next4 = containers.Map();

for from = stage4_from
    cost = find_cost(tariffs, from, stage4_to);
    F4(num2str(from)) = cost;
    optimal_next4(num2str(from)) = stage4_to;
    dual_printf(log_file, '| %-11d | %-11d | %-9d | %-4d | %-11s |\n', from, stage4_to, cost, cost, sprintf('%d¡ú%d', from, stage4_to));
end

dual_printf(log_file, '+-------------+-------------+-----------+------+-------------+\n\n');

% ============================================
% 5. §¿§ä§Ñ§á 3 - §å§ã§Ý§à§Ó§ß§Ñ§ñ §à§á§ä§Ú§Þ§Ú§Ù§Ñ§è§Ú§ñ
% ============================================
dual_printf(log_file, '\t\t§¿§´§¡§± 3\n\n');

dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n');
dual_printf(log_file, '| §ª§Ù §á§å§ß§Ü§ä§Ñ   | §£ §á§å§ß§Ü§ä     | §©§Ñ§ä§â§Ñ§ä§í   | F4   | §³§å§Þ§Þ§Ñ  | F3   | §£§í§Ò§à§â       |\n');
dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n');

F3 = containers.Map();
optimal_next3 = containers.Map();

for from = stage3_from
    min_cost = inf;
    best_next = -1;

    for to = stage3_to
        cost = find_cost(tariffs, from, to);
        if ~isinf(cost)
            future_cost = F4(num2str(to));
            total = cost + future_cost;
            choice_mark = '';
            if total < min_cost
                min_cost = total;
                best_next = to;
                choice_mark = ' *';
            end
            dual_printf(log_file, '| %-11d | %-11d | %-9d | %-4d | %-6d | %-4d | %-11s |\n', ...
                from, to, cost, future_cost, total, min_cost, choice_mark);
        end
    end
    F3(num2str(from)) = min_cost;
    optimal_next3(num2str(from)) = best_next;
end

dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n\n');

% §£§í§Ó§à§Õ §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó §ï§ä§Ñ§á§Ñ 3
dual_printf(log_file, '§²§Ö§Ù§å§Ý§î§ä§Ñ§ä§í §ï§ä§Ñ§á§Ñ 3:\n');
for from = stage3_from
    dual_printf(log_file, '  F3(%d) = %d, §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§à %d ¡ú %d\n', from, F3(num2str(from)), from, optimal_next3(num2str(from)));
end
dual_printf(log_file, '\n');

% ============================================
% 6. §¿§ä§Ñ§á 2 - §å§ã§Ý§à§Ó§ß§Ñ§ñ §à§á§ä§Ú§Þ§Ú§Ù§Ñ§è§Ú§ñ
% ============================================
dual_printf(log_file, '\t\t§¿§´§¡§± 2\n\n');

dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n');
dual_printf(log_file, '| §ª§Ù §á§å§ß§Ü§ä§Ñ   | §£ §á§å§ß§Ü§ä     | §©§Ñ§ä§â§Ñ§ä§í   | F3   | §³§å§Þ§Þ§Ñ  | F2   | §£§í§Ò§à§â       |\n');
dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n');

F2 = containers.Map();
optimal_next2 = containers.Map();

for from = stage2_from
    min_cost = inf;
    best_next = -1;

    for to = stage2_to
        cost = find_cost(tariffs, from, to);
        if ~isinf(cost)
            future_cost = F3(num2str(to));
            total = cost + future_cost;
            choice_mark = '';
            if total < min_cost
                min_cost = total;
                best_next = to;
                choice_mark = ' *';
            end
            dual_printf(log_file, '| %-11d | %-11d | %-9d | %-4d | %-6d | %-4d | %-11s |\n', ...
                from, to, cost, future_cost, total, min_cost, choice_mark);
        end
    end
    F2(num2str(from)) = min_cost;
    optimal_next2(num2str(from)) = best_next;
end

dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n\n');

% §£§í§Ó§à§Õ §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó §ï§ä§Ñ§á§Ñ 2
dual_printf(log_file, '§²§Ö§Ù§å§Ý§î§ä§Ñ§ä§í §ï§ä§Ñ§á§Ñ 2:\n');
for from = stage2_from
    dual_printf(log_file, '  F2(%d) = %d, §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§à %d ¡ú %d\n', from, F2(num2str(from)), from, optimal_next2(num2str(from)));
end
dual_printf(log_file, '\n');

% ============================================
% 7. §¿§ä§Ñ§á 1 - §å§ã§Ý§à§Ó§ß§Ñ§ñ §à§á§ä§Ú§Þ§Ú§Ù§Ñ§è§Ú§ñ
% ============================================
dual_printf(log_file, '\t\t§¿§´§¡§± 1\n\n');

dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n');
dual_printf(log_file, '| §ª§Ù §á§å§ß§Ü§ä§Ñ   | §£ §á§å§ß§Ü§ä     | §©§Ñ§ä§â§Ñ§ä§í   | F2   | §³§å§Þ§Þ§Ñ  | F1   | §£§í§Ò§à§â       |\n');
dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n');

F1 = containers.Map();
optimal_next1 = containers.Map();

for from = stage1_from
    min_cost = inf;
    best_next = -1;

    for to = stage1_to
        cost = find_cost(tariffs, from, to);
        if ~isinf(cost)
            future_cost = F2(num2str(to));
            total = cost + future_cost;
            choice_mark = '';
            if total < min_cost
                min_cost = total;
                best_next = to;
                choice_mark = ' *';
            end
            dual_printf(log_file, '| %-11d | %-11d | %-9d | %-4d | %-6d | %-4d | %-11s |\n', ...
                from, to, cost, future_cost, total, min_cost, choice_mark);
        end
    end
    F1(num2str(from)) = min_cost;
    optimal_next1(num2str(from)) = best_next;
end

dual_printf(log_file, '+-------------+-------------+-----------+------+--------+------+-------------+\n\n');

% §£§í§Ó§à§Õ §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó §ï§ä§Ñ§á§Ñ 1
dual_printf(log_file, '§²§Ö§Ù§å§Ý§î§ä§Ñ§ä§í §ï§ä§Ñ§á§Ñ 1:\n');
for from = stage1_from
    dual_printf(log_file, '  F1(%d) = %d, §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§à %d ¡ú %d\n', from, F1(num2str(from)), from, optimal_next1(num2str(from)));
end
dual_printf(log_file, '\n');

% ============================================
% 8. §£§½§£§°§¥ §³§±§ª§³§¬§°§£ X §ª U §±§° §¿§´§¡§±§¡§®
% ============================================
dual_printf(log_file, '\t\t§³§±§ª§³§¬§ª §³§°§³§´§°§Á§¯§ª§« X §ª §µ§±§²§¡§£§­§¦§¯§ª§« U §±§° §¿§´§¡§±§¡§®\n\n');

% §¿§ä§Ñ§á 4
dual_printf(log_file, '§¿§´§¡§± 4:\n');
dual_printf(log_file, '  x4 = {');
x4 = stage4_from;
for i = 1:length(x4)
    dual_printf(log_file, '%d', x4(i));
    if i < length(x4), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  u4 = {');
for i = 1:length(x4)
    dual_printf(log_file, '%d¡ú%d', x4(i), optimal_next4(num2str(x4(i))));
    if i < length(x4), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  F4 = {');
for i = 1:length(x4)
    dual_printf(log_file, 'F4(%d)=%d', x4(i), F4(num2str(x4(i))));
    if i < length(x4), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n\n');

% §¿§ä§Ñ§á 3
dual_printf(log_file, '§¿§´§¡§± 3:\n');
dual_printf(log_file, '  x3 = {');
x3 = stage3_from;
for i = 1:length(x3)
    dual_printf(log_file, '%d', x3(i));
    if i < length(x3), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  u3 = {');
for i = 1:length(x3)
    dual_printf(log_file, '%d¡ú%d', x3(i), optimal_next3(num2str(x3(i))));
    if i < length(x3), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  F3 = {');
for i = 1:length(x3)
    dual_printf(log_file, 'F3(%d)=%d', x3(i), F3(num2str(x3(i))));
    if i < length(x3), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n\n');

% §¿§ä§Ñ§á 2
dual_printf(log_file, '§¿§´§¡§± 2:\n');
dual_printf(log_file, '  x2 = {');
x2 = stage2_from;
for i = 1:length(x2)
    dual_printf(log_file, '%d', x2(i));
    if i < length(x2), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  u2 = {');
for i = 1:length(x2)
    dual_printf(log_file, '%d¡ú%d', x2(i), optimal_next2(num2str(x2(i))));
    if i < length(x2), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  F2 = {');
for i = 1:length(x2)
    dual_printf(log_file, 'F2(%d)=%d', x2(i), F2(num2str(x2(i))));
    if i < length(x2), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n\n');

% §¿§ä§Ñ§á 1
dual_printf(log_file, '§¿§´§¡§± 1:\n');
dual_printf(log_file, '  x1 = {');
x1 = stage1_from;
for i = 1:length(x1)
    dual_printf(log_file, '%d', x1(i));
    if i < length(x1), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  u1 = {');
for i = 1:length(x1)
    dual_printf(log_file, '%d¡ú%d', x1(i), optimal_next1(num2str(x1(i))));
    if i < length(x1), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n');

dual_printf(log_file, '  F1 = {');
for i = 1:length(x1)
    dual_printf(log_file, 'F1(%d)=%d', x1(i), F1(num2str(x1(i))));
    if i < length(x1), dual_printf(log_file, ', '); end
end
dual_printf(log_file, '}\n\n');

% ============================================
% 9. §³§£§°§¥§¯§¡§Á §´§¡§¢§­§ª§¸§¡ §±§° §£§³§¦§® §¿§´§¡§±§¡§®
% ============================================
dual_printf(log_file, '\t\t§³§£§°§¥§¯§¡§Á §´§¡§¢§­§ª§¸§¡ §±§° §¿§´§¡§±§¡§®\n\n');

dual_printf(log_file, '+-------+---------------------+---------------------+-----------------------+\n');
dual_printf(log_file, '| §¿§ä§Ñ§á | §³§à§ã§ä§à§ñ§ß§Ú§ñ x         | §µ§á§â§Ñ§Ó§Ý§Ö§ß§Ú§ñ u        | F(x)                  |\n');
dual_printf(log_file, '+-------+---------------------+---------------------+-----------------------+\n');

% §¿§ä§Ñ§á 1
x1_str = sprintf('{1}');
u1_str = sprintf('{1¡ú%d}', optimal_next1('1'));
dual_printf(log_file, '| 1     | %-19s | %-19s | F1(1)=%-6d         |\n', x1_str, u1_str, F1('1'));

% §¿§ä§Ñ§á 2
x2_str = '{2, 3, 4}';
u2_str = sprintf('{2¡ú%d, 3¡ú%d, 4¡ú%d}', optimal_next2('2'), optimal_next2('3'), optimal_next2('4'));
dual_printf(log_file, '| 2     | %-19s | %-19s | F2(2)=%-2d, F2(3)=%-2d, F2(4)=%-2d |\n', x2_str, u2_str, F2('2'), F2('3'), F2('4'));

% §¿§ä§Ñ§á 3
x3_str = '{5, 6, 7}';
u3_str = sprintf('{5¡ú%d, 6¡ú%d, 7¡ú%d}', optimal_next3('5'), optimal_next3('6'), optimal_next3('7'));
dual_printf(log_file, '| 3     | %-19s | %-19s | F3(5)=%-2d, F3(6)=%-2d, F3(7)=%-2d |\n', x3_str, u3_str, F3('5'), F3('6'), F3('7'));

% §¿§ä§Ñ§á 4
x4_str = '{8, 9}';
u4_str = sprintf('{8¡ú%d, 9¡ú%d}', optimal_next4('8'), optimal_next4('9'));
dual_printf(log_file, '| 4     | %-19s | %-19s | F4(8)=%-2d, F4(9)=%-2d          |\n', x4_str, u4_str, F4('8'), F4('9'));

dual_printf(log_file, '+-------+---------------------+---------------------+-----------------------+\n\n');

% ============================================
% 10. §¢§Ö§Ù§å§ã§Ý§à§Ó§ß§Ñ§ñ §à§á§ä§Ú§Þ§Ú§Ù§Ñ§è§Ú§ñ (§Ó§à§ã§ã§ä§Ñ§ß§à§Ó§Ý§Ö§ß§Ú§Ö §Þ§Ñ§â§ê§â§å§ä§Ñ)
% ============================================
dual_printf(log_file, '\t\t§¢§¦§©§µ§³§­§°§£§¯§¡§Á §°§±§´§ª§®§ª§©§¡§¸§ª§Á\n\n');

route = [1];
current = 1;
u_optimal = [];

% §¿§ä§Ñ§á 1
next_node = optimal_next1(num2str(current));
route = [route, next_node];
u_optimal = [u_optimal, next_node];
current = next_node;

% §¿§ä§Ñ§á 2
next_node = optimal_next2(num2str(current));
route = [route, next_node];
u_optimal = [u_optimal, next_node];
current = next_node;

% §¿§ä§Ñ§á 3
next_node = optimal_next3(num2str(current));
route = [route, next_node];
u_optimal = [u_optimal, next_node];
current = next_node;

% §¿§ä§Ñ§á 4
next_node = optimal_next4(num2str(current));
route = [route, next_node];
u_optimal = [u_optimal, next_node];

% §£§í§Ó§à§Õ §Þ§Ñ§â§ê§â§å§ä§Ñ
dual_printf(log_file, '§°§±§´§ª§®§¡§­§¾§¯§½§« §®§¡§²§º§²§µ§´: ');
for i = 1:length(route)-1
    dual_printf(log_file, '%d ¡ú ', route(i));
end
dual_printf(log_file, '%d\n\n', route(end));

% §²§Ñ§ã§é§Ö§ä §à§Ò§ë§Ú§ç §Ù§Ñ§ä§â§Ñ§ä
total_cost = 0;
dual_printf(log_file, '§¥§¦§´§¡§­§ª§©§¡§¸§ª§Á §©§¡§´§²§¡§´:\n');
dual_printf(log_file, '+-------------+-------------+-----------+\n');
dual_printf(log_file, '| §ª§Ù §á§å§ß§Ü§ä§Ñ   | §£ §á§å§ß§Ü§ä     | §©§Ñ§ä§â§Ñ§ä§í   |\n');
dual_printf(log_file, '+-------------+-------------+-----------+\n');
for i = 1:length(route)-1
    cost = find_cost(tariffs, route(i), route(i+1));
    total_cost = total_cost + cost;
    dual_printf(log_file, '| %-11d | %-11d | %-9d |\n', route(i), route(i+1), cost);
end
dual_printf(log_file, '+-------------+-------------+-----------+\n');
dual_printf(log_file, '§®§ª§¯§ª§®§¡§­§¾§¯§½§¦ §©§¡§´§²§¡§´§½: %d §Õ§Ö§ß§Ö§Ø§ß§í§ç §Ö§Õ§Ú§ß§Ú§è\n\n', total_cost);

% §£§í§Ó§à§Õ §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§ç §å§á§â§Ñ§Ó§Ý§Ö§ß§Ú§Û §á§à §ê§Ñ§Ô§Ñ§Þ
dual_printf(log_file, '§°§±§´§ª§®§¡§­§¾§¯§½§¦ §µ§±§²§¡§£§­§¦§¯§ª§Á §±§° §º§¡§¤§¡§®:\n');
dual_printf(log_file, '  u1* = 1 ¡ú %d\n', u_optimal(1));
dual_printf(log_file, '  u2* = %d ¡ú %d\n', route(2), u_optimal(2));
dual_printf(log_file, '  u3* = %d ¡ú %d\n', route(3), u_optimal(3));
dual_printf(log_file, '  u4* = %d ¡ú %d\n\n', route(4), u_optimal(4));

% ============================================
% 11. §°§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§Ö §Þ§Ñ§â§ê§â§å§ä§í §Ú§Ù §Ó§ã§Ö§ç §á§å§ß§Ü§ä§à§Ó §Ó §á§å§ß§Ü§ä 10
% ============================================
dual_printf(log_file, '\t\t§°§±§´§ª§®§¡§­§¾§¯§½§¦ §®§¡§²§º§²§µ§´§½ §ª§© §£§³§¦§· §±§µ§¯§¬§´§°§£ §£ §±§µ§¯§¬§´ 10\n\n');

dual_printf(log_file, '+-------------+-----------------------------------------+-----------+\n');
dual_printf(log_file, '| §±§å§ß§Ü§ä       | §®§Ñ§â§ê§â§å§ä                                 | §©§Ñ§ä§â§Ñ§ä§í   |\n');
dual_printf(log_file, '+-------------+-----------------------------------------+-----------+\n');

% §³§Ò§à§â §Ó§ã§Ö§ç §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§ç §Ù§ß§Ñ§é§Ö§ß§Ú§Û
all_F = containers.Map();
all_F('8') = 2;
all_F('9') = 7;
all_F('5') = F3('5');
all_F('6') = F3('6');
all_F('7') = F3('7');
all_F('2') = F2('2');
all_F('3') = F2('3');
all_F('4') = F2('4');
all_F('1') = F1('1');

% §¶§å§ß§Ü§è§Ú§ñ §Ó§à§ã§ã§ä§Ñ§ß§à§Ó§Ý§Ö§ß§Ú§ñ §Þ§Ñ§â§ê§â§å§ä§Ñ
function r = get_route(start, opt1, opt2, opt3, opt4)
    r = [start];
    current = start;
    if start == 8
        r = [8, 10];
    elseif start == 9
        r = [9, 10];
    else
        if isKey(opt1, num2str(current))
            next = opt1(num2str(current));
            r = [r, next];
            current = next;
        end
        if isKey(opt2, num2str(current))
            next = opt2(num2str(current));
            r = [r, next];
            current = next;
        end
        if isKey(opt3, num2str(current))
            next = opt3(num2str(current));
            r = [r, next];
            current = next;
        end
        if current ~= 10
            r = [r, 10];
        end
    end
end

% §£§í§Ó§à§Õ §Õ§Ý§ñ §Ü§Ñ§Ø§Õ§à§Ô§à §á§å§ß§Ü§ä§Ñ
for p = 1:9
    if p == 1
        r = get_route(p, optimal_next1, optimal_next2, optimal_next3, optimal_next4);
    elseif p == 2 || p == 3 || p == 4
        r = get_route(p, optimal_next2, optimal_next3, optimal_next4, containers.Map());
    elseif p == 5 || p == 6 || p == 7
        r = get_route(p, optimal_next3, optimal_next4, containers.Map(), containers.Map());
    elseif p == 8 || p == 9
        r = [p, 10];
    end

    % §¶§à§â§Þ§Ñ§ä§Ú§â§à§Ó§Ñ§ß§Ú§Ö §Ó§í§Ó§à§Õ§Ñ
    route_str = sprintf('%d', r(1));
    for i = 2:length(r)
        route_str = sprintf('%s ¡ú %d', route_str, r(i));
    end
    dual_printf(log_file, '| %-11d | %-39s | %-9d |\n', p, route_str, all_F(num2str(p)));
end

dual_printf(log_file, '+-------------+-----------------------------------------+-----------+\n\n');

% ============================================
% 12. §ª§´§°§¤§°§£§½§« §£§½§£§°§¥
% ============================================
dual_printf(log_file, '\t\t§²§¦§©§µ§­§¾§´§¡§´§½ §²§¡§¢§°§´§½ §±§²§°§¤§²§¡§®§®§½\n\n');
dual_printf(log_file, '§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§Û §Þ§Ñ§â§ê§â§å§ä: 1 ¡ú 2 ¡ú 5 ¡ú 8 ¡ú 10    \n');
dual_printf(log_file, '§®§Ú§ß§Ú§Þ§Ñ§Ý§î§ß§í§Ö §Ù§Ñ§ä§â§Ñ§ä§í: 12 §Õ§Ö§ß§Ö§Ø§ß§í§ç §Ö§Õ§Ú§ß§Ú§è\n\n');

dual_printf(log_file, '§³§±§ª§³§¬§ª X §ª U (§Ú§ä§à§Ô§à§Ó§í§Ö):\n');
dual_printf(log_file, '  x1 = {1}\n');
dual_printf(log_file, '  u1 = {1¡ú3}\n');
dual_printf(log_file, '  x2 = {2, 3, 4}\n');
dual_printf(log_file, '  u2 = {2¡ú5, 3¡ú6, 4¡ú7}\n');
dual_printf(log_file, '  x3 = {5, 6, 7}\n');
dual_printf(log_file, '  u3 = {5¡ú8, 6¡ú8, 7¡ú9}\n');
dual_printf(log_file, '  x4 = {8, 9}\n');
dual_printf(log_file, '  u4 = {8¡ú10, 9¡ú10}\n\n');

dual_printf(log_file, '\t\t§£§½§±§°§­§¯§¦§¯§ª§¦ §©§¡§£§¦§²§º§¦§¯§°\n');

% ============================================
% 13. §©§Ñ§Ü§â§í§ä§Ú§Ö §æ§Ñ§Û§Ý§Ñ
% ============================================
fclose(log_file);

disp(' ');
disp('§²§Ö§Ù§å§Ý§î§ä§Ñ§ä§í §ä§Ñ§Ü§Ø§Ö §ã§à§ç§â§Ñ§ß§Ö§ß§í §Ó §æ§Ñ§Û§Ý: lab5_result.txt');
