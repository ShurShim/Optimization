clear all; clc;

A = [0 5 7 11 13 15 19 29;
     5 0 4 6 8 10 13 24;
     7 4 0 9 12 13 12 27;
     11 6 9 0 5 7 10 21;
     13 8 12 5 0 13 15 26;
     15 10 13 7 13 0 3 14;
     19 13 12 10 15 3 0 15;
     29 24 27 21 26 14 15 0];

P = [110; 100; 100; 80; 120; 140; 80; 70];

fprintf('§®§Ñ§ä§â§Ú§è§Ñ §Ü§â§Ñ§ä§é§Ñ§Û§ê§Ú§ç §â§Ñ§ã§ã§ä§à§ñ§ß§Ú§Û (A):\n');
disp(A);

fprintf('§ª§ã§ç§à§Õ§ß§í§Ö §Õ§Ñ§ß§ß§í§Ö:\n');
fprintf('§¬§à§Ý§Ú§é§Ö§ã§ä§Ó§à §Ó§Ö§â§ê§Ú§ß: %d\n', length(P));
fprintf('§£§Ö§ã§Ñ §Ó§Ö§â§ê§Ú§ß (P):\n');
disp(P');

max_dist = max(A, [], 2);
[opt_radio_val, opt_radio] = min(max_dist);

fprintf('\n§©§¡§¥§¡§¹§¡ 1: §µ§©§¦§­ §²§¡§¥§ª§°§¥§°§³§´§µ§±§¡ (§è§Ö§ß§ä§â §Ô§â§Ñ§æ§Ñ)\n');
fprintf('§®§Ñ§Ü§ã§Ú§Þ§Ñ§Ý§î§ß§í§Ö §â§Ñ§ã§ã§ä§à§ñ§ß§Ú§ñ §à§ä §Ü§Ñ§Ø§Õ§à§Û §Ó§Ö§â§ê§Ú§ß§í:\n');
for i = 1:length(max_dist)
    fprintf('  §£§Ö§â§ê§Ú§ß§Ñ %d: %d\n', i, max_dist(i));
end
fprintf('§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§Ñ§ñ §Ó§Ö§â§ê§Ú§ß§Ñ: %d\n', opt_radio);
fprintf('§®§Ú§ß§Ú§Þ§Ñ§Ý§î§ß§à§Ö §Þ§Ñ§Ü§ã§Ú§Þ§Ñ§Ý§î§ß§à§Ö §â§Ñ§ã§ã§ä§à§ñ§ß§Ú§Ö: %d §Ü§Þ\n', opt_radio_val);

weighted_sum = A * P;
[opt_wired_val, opt_wired] = min(weighted_sum);

fprintf('\n§©§¡§¥§¡§¹§¡ 2: §µ§©§¦§­ §±§²§°§£§°§¥§¯§°§¤§° §¥§°§³§´§µ§±§¡ (§Þ§Ö§Õ§Ú§Ñ§ß§Ñ §Ô§â§Ñ§æ§Ñ)\n');
fprintf('§£§Ù§Ó§Ö§ê§Ö§ß§ß§í§Ö §ã§å§Þ§Þ§í §â§Ñ§ã§ã§ä§à§ñ§ß§Ú§Û §à§ä §Ü§Ñ§Ø§Õ§à§Û §Ó§Ö§â§ê§Ú§ß§í:\n');
for i = 1:length(weighted_sum)
    fprintf('  §£§Ö§â§ê§Ú§ß§Ñ %d: %.0f\n', i, weighted_sum(i));
end
fprintf('§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§Ñ§ñ §Ó§Ö§â§ê§Ú§ß§Ñ: %d\n', opt_wired);
fprintf('§®§Ú§ß§Ú§Þ§Ñ§Ý§î§ß§Ñ§ñ §Ó§Ù§Ó§Ö§ê§Ö§ß§ß§Ñ§ñ §ã§å§Þ§Þ§Ñ: %.0f\n', opt_wired_val);

% §£§í§Ó§à§Õ
fprintf('\n§£§½§£§°§¥\n');
fprintf('1. §µ§Ù§Ö§Ý §â§Ñ§Õ§Ú§à§Õ§à§ã§ä§å§á§Ñ §â§Ö§Ü§à§Þ§Ö§ß§Õ§å§Ö§ä§ã§ñ §â§Ñ§Ù§Þ§Ö§ã§ä§Ú§ä§î §Ó §Ó§Ö§â§ê§Ú§ß§Ö %d.\n', opt_radio);
fprintf('2. §µ§Ù§Ö§Ý §á§â§à§Ó§à§Õ§ß§à§Ô§à §Õ§à§ã§ä§å§á§Ñ §â§Ö§Ü§à§Þ§Ö§ß§Õ§å§Ö§ä§ã§ñ §â§Ñ§Ù§Þ§Ö§ã§ä§Ú§ä§î §Ó §Ó§Ö§â§ê§Ú§ß§Ö %d.\n', opt_wired);
