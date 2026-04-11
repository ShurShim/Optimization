% §­§Ñ§Ò§à§â§Ñ§ä§à§â§ß§Ñ§ñ §â§Ñ§Ò§à§ä§Ñ 4
% §£§Ñ§â§Ú§Ñ§ß§ä 5 (§ã§Ö§ä§Ö§Ó§à§Û §Ô§â§Ñ§æ§Ú§Ü §ã §â§Ñ§Ò§à§ä§Ñ§Þ§Ú §Ú §Õ§Ý§Ú§ä§Ö§Ý§î§ß§à§ã§ä§ñ§Þ§Ú)
% §²§Ñ§ã§é§Ö§ä §á§Ñ§â§Ñ§Þ§Ö§ä§â§à§Ó §ã§Ö§ä§Ö§Ó§à§Ô§à §Ô§â§Ñ§æ§Ú§Ü§Ñ

clc;
clear all;
close all;

% §°§á§Ú§ã§Ñ§ß§Ú§Ö §ã§Ö§ä§Ö§Ó§à§Û §Þ§à§Õ§Ö§Ý§Ú §Õ§Ý§ñ §Ó§Ñ§â§Ú§Ñ§ß§ä§Ñ 5
% §¶§à§â§Þ§Ñ§ä: [§ß§Ñ§é§Ñ§Ý§à_§ã§à§Ò§í§ä§Ú§ñ, §Ü§à§ß§Ö§è_§ã§à§Ò§í§ä§Ú§ñ, §Õ§Ý§Ú§ä§Ö§Ý§î§ß§à§ã§ä§î]
edges = [
    1, 2, 8
    1, 3, 5
    1, 5, 7
    1, 6, 9
    2, 4, 4
    2, 5, 7
    3, 6, 0   % §æ§Ú§Ü§ä§Ú§Ó§ß§Ñ§ñ §â§Ñ§Ò§à§ä§Ñ
    3, 8, 9
    4, 5, 0   % §æ§Ú§Ü§ä§Ú§Ó§ß§Ñ§ñ §â§Ñ§Ò§à§ä§Ñ
    4, 7, 7
    5, 6, 4
    5, 7, 8
    5, 9, 5
    6, 8, 5
    6, 9, 3
    7, 9, 8
    8, 9, 4
];

% §¯§Ñ§ç§à§Õ§Ú§Þ §Ü§à§Ý§Ú§é§Ö§ã§ä§Ó§à §ã§à§Ò§í§ä§Ú§Û (§Ó§Ö§â§ê§Ú§ß)
events = unique([edges(:,1); edges(:,2)]);
N = max(events);

% §³§á§Ú§ã§à§Ü §ã§Þ§Ö§Ø§ß§à§ã§ä§Ú §Õ§Ý§ñ §á§â§ñ§Þ§à§Ô§à §Ú §à§Ò§â§Ñ§ä§ß§à§Ô§à §á§â§à§ç§à§Õ§Ñ
succ = cell(N, 1);   % §ã§Ý§Ö§Õ§å§ð§ë§Ú§Ö §ã§à§Ò§í§ä§Ú§ñ
pred = cell(N, 1);   % §á§â§Ö§Õ§í§Õ§å§ë§Ú§Ö §ã§à§Ò§í§ä§Ú§ñ

for i = 1:size(edges,1)
    u = edges(i,1);
    v = edges(i,2);
    d = edges(i,3);
    succ{u} = [succ{u}, v];
    pred{v} = [pred{v}, u];
end

% 1. §²§Ñ§ß§ß§Ú§Ö §ã§â§à§Ü§Ú t_p
tp = zeros(1, N);
for i = 1:N
    if isempty(pred{i})
        tp(i) = 0;
    else
        max_val = -inf;
        for j = 1:length(pred{i})
            prev = pred{i}(j);
            % §ß§Ñ§ç§à§Õ§Ú§Þ §Õ§Ý§Ú§ä§Ö§Ý§î§ß§à§ã§ä§î §â§Ñ§Ò§à§ä§í prev -> i
            idx = find(edges(:,1) == prev & edges(:,2) == i);
            if ~isempty(idx)
                d_prev = edges(idx,3);
                candidate = tp(prev) + d_prev;
                if candidate > max_val
                    max_val = candidate;
                end
            end
        end
        tp(i) = max_val;
    end
end

% 2. §±§à§Ù§Õ§ß§Ú§Ö §ã§â§à§Ü§Ú t_n
tn = inf(1, N);
tn(N) = tp(N); % §Ù§Ñ§Ó§Ö§â§ê§Ñ§ð§ë§Ö§Ö §ã§à§Ò§í§ä§Ú§Ö

for i = N:-1:1
    if isempty(succ{i})
        tn(i) = tp(i);
    else
        min_val = inf;
        for j = 1:length(succ{i})
            next = succ{i}(j);
            idx = find(edges(:,1) == i & edges(:,2) == next);
            if ~isempty(idx)
                d_next = edges(idx,3);
                candidate = tn(next) - d_next;
                if candidate < min_val
                    min_val = candidate;
                end
            end
        end
        tn(i) = min_val;
    end
end

% 3. §²§Ö§Ù§Ö§â§Ó§í §Ó§â§Ö§Þ§Ö§ß§Ú R
R = tn - tp;

% 4. §¬§â§Ú§ä§Ú§é§Ö§ã§Ü§Ú§Û §á§å§ä§î (§ã§à§Ò§í§ä§Ú§ñ §ã R = 0)
critical_events = find(abs(R) < 1e-10); % §ã §å§é§Ö§ä§à§Þ §á§à§Ô§â§Ö§ê§ß§à§ã§ä§Ú
critical_path = [];
% §£§à§ã§ã§ä§Ñ§ß§à§Ó§Ú§Þ §á§å§ä§î §á§à §ã§à§Ò§í§ä§Ú§ñ§Þ
if ~isempty(critical_events)
    path = critical_events(1);
    current = path;
    while current ~= N
        found = false;
        for i = 1:length(succ{current})
            next = succ{current}(i);
            if abs(R(next)) < 1e-10
                % §á§â§à§Ó§Ö§â§ñ§Ö§Þ, §Ö§ã§ä§î §Ý§Ú §â§Ñ§Ò§à§ä§Ñ current->next
                idx = find(edges(:,1) == current & edges(:,2) == next);
                if ~isempty(idx)
                    path = [path, next];
                    current = next;
                    found = true;
                    break;
                end
            end
        end
        if ~found
            break;
        end
    end
    critical_path = path;
end

% 5. §£§í§Ó§à§Õ §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó
fprintf('========== §²§Ö§Ù§å§Ý§î§ä§Ñ§ä§í §â§Ñ§ã§é§Ö§ä§Ñ ==========\n');
fprintf('§³§à§Ò§í§ä§Ú§Ö | tp   | tn   | R\n');
fprintf('--------------------------------\n');
for i = 1:N
    fprintf('   %d     | %3d  | %3d  | %3d\n', i, tp(i), tn(i), R(i));
end
fprintf('\n§¥§Ý§Ú§ß§Ñ §Ü§â§Ú§ä§Ú§é§Ö§ã§Ü§à§Ô§à §á§å§ä§Ú: %d\n', tp(N));
fprintf('§¬§â§Ú§ä§Ú§é§Ö§ã§Ü§Ú§Û §á§å§ä§î (§ã§à§Ò§í§ä§Ú§ñ): ');
fprintf('%d ', critical_path);
fprintf('\n');

% §¯§Ñ§ç§à§Õ§Ú§Þ §Ü§â§Ú§ä§Ú§é§Ö§ã§Ü§Ú§Ö §â§Ñ§Ò§à§ä§í (§á§à§Ý§ß§í§Û §â§Ö§Ù§Ö§â§Ó = 0)
fprintf('\n§¬§â§Ú§ä§Ú§é§Ö§ã§Ü§Ú§Ö §â§Ñ§Ò§à§ä§í (§á§à§Ý§ß§í§Û §â§Ö§Ù§Ö§â§Ó = 0):\n');
for i = 1:size(edges,1)
    u = edges(i,1);
    v = edges(i,2);
    d = edges(i,3);
    % §±§à§Ý§ß§í§Û §â§Ö§Ù§Ö§â§Ó §Ó§â§Ö§Þ§Ö§ß§Ú §â§Ñ§Ò§à§ä§í
    R_full = tn(v) - tp(u) - d;
    if abs(R_full) < 1e-10 && d > 0 % §æ§Ú§Ü§ä§Ú§Ó§ß§í§Ö §â§Ñ§Ò§à§ä§í §ß§Ö §Ó§í§Ó§à§Õ§Ú§Þ
        fprintf('  %d -> %d (§Õ§Ý§Ú§ä. = %d)\n', u, v, d);
    end
end

