% §±§â§Ñ§Ü§ä§Ú§é§Ö§ã§Ü§Ñ§ñ §â§Ñ§Ò§à§ä§Ñ 3, §£§Ñ§â§Ú§Ñ§ß§ä 5 (§ä§Ñ§Ò§Ý§Ú§è§Ñ 3.11)
clear; clc;

filename = 'PR3_v5_results.txt';
fid = -1;

try
    fid = fopen(filename, 'w');
    if fid == -1
        error('Cannot open file');
    endif
catch
    fid = -1;
end_try_catch

file_success = (fid != -1);

% §¶§å§ß§Ü§è§Ú§ñ §Õ§Ý§ñ §à§Õ§ß§à§Ó§â§Ö§Þ§Ö§ß§ß§à§Ô§à §Ó§í§Ó§à§Õ§Ñ §Ó §Ü§à§ß§ã§à§Ý§î §Ú §æ§Ñ§Û§Ý
function print_both(fid, file_success, varargin)
    fprintf(varargin{:});
    if file_success
        fprintf(fid, varargin{:});
    endif
endfunction

% §ª§ã§ç§à§Õ§ß§í§Ö §Õ§Ñ§ß§ß§í§Ö (§ä§Ñ§Ò§Ý§Ú§è§Ñ 3.11)
V = [20 26 15;
     27 24 10;
     15 28 11;
     9 30 23];

print_both(fid, file_success, '§£§Ñ§â§Ú§Ñ§ß§ä 5 (§ä§Ñ§Ò§Ý§Ú§è§Ñ 3.11)\n');

print_both(fid, file_success, '§ª§ã§ç§à§Õ§ß§Ñ§ñ §Þ§Ñ§ä§â§Ú§è§Ñ §á§à§ä§Ö§â§î:\n');
print_both(fid, file_success, '     s1   s2   s3\n');
for i = 1:size(V, 1)
    print_both(fid, file_success, 'R%d  ', i);
    for j = 1:size(V, 2)
        print_both(fid, file_success, '%4d', V(i, j));
    end
    print_both(fid, file_success, '\n');
end
print_both(fid, file_success, '\n');

% 1. §¬§â§Ú§ä§Ö§â§Ú§Û §­§Ñ§á§Ý§Ñ§ã§Ñ
n = size(V, 2);
Laplace = sum(V, 2) / n;

print_both(fid, file_success, '1. §¬§â§Ú§ä§Ö§â§Ú§Û §­§Ñ§á§Ý§Ñ§ã§Ñ\n');
print_both(fid, file_success, '§°§Ø§Ú§Õ§Ñ§Ö§Þ§í§Ö §á§à§ä§Ö§â§Ú:\n');
for i = 1:size(Laplace, 1)
    print_both(fid, file_success, 'R%d: %.3f\n', i, Laplace(i));
end
[minLaplace, idxLaplace] = min(Laplace);
print_both(fid, file_success, '\n§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§à§Ö §â§Ö§ê§Ö§ß§Ú§Ö: R%d (%.3f)\n\n', idxLaplace, minLaplace);

% 2. §®§Ú§ß§Ú§Þ§Ñ§Ü§ã§ß§í§Û §Ü§â§Ú§ä§Ö§â§Ú§Û (§£§Ñ§Ý§î§Õ§Ñ)
maxV = max(V, [], 2);

print_both(fid, file_success, '2. §®§Ú§ß§Ú§Þ§Ñ§Ü§ã§ß§í§Û §Ü§â§Ú§ä§Ö§â§Ú§Û (§£§Ñ§Ý§î§Õ§Ñ)\n');
print_both(fid, file_success, '§®§Ñ§Ü§ã§Ú§Þ§Ñ§Ý§î§ß§í§Ö §á§à§ä§Ö§â§Ú §á§à §Ü§Ñ§Ø§Õ§à§Û §ã§ä§â§Ñ§ä§Ö§Ô§Ú§Ú:\n');
for i = 1:size(maxV, 1)
    print_both(fid, file_success, 'R%d: %d\n', i, maxV(i));
end
[minMax, idxMinMax] = min(maxV);
print_both(fid, file_success, '\n§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§à§Ö §â§Ö§ê§Ö§ß§Ú§Ö: R%d (%d)\n\n', idxMinMax, minMax);

% 3. §¬§â§Ú§ä§Ö§â§Ú§Û §³§ï§Ó§Ú§Õ§Ø§Ñ
minCol = min(V, [], 1);

print_both(fid, file_success, '3. §¬§â§Ú§ä§Ö§â§Ú§Û §³§ï§Ó§Ú§Õ§Ø§Ñ\n');
print_both(fid, file_success, '§®§Ú§ß§Ú§Þ§Ñ§Ý§î§ß§í§Ö §Ù§ß§Ñ§é§Ö§ß§Ú§ñ §á§à §ã§ä§à§Ý§Ò§è§Ñ§Þ:\n');
print_both(fid, file_success, 's1: %d, s2: %d, s3: %d\n\n', minCol(1), minCol(2), minCol(3));

% §®§Ñ§ä§â§Ú§è§Ñ §â§Ú§ã§Ü§à§Ó
R = zeros(size(V));
for i = 1:size(V, 1)
    for j = 1:size(V, 2)
        R(i, j) = V(i, j) - minCol(j);
    end
end

print_both(fid, file_success, '§®§Ñ§ä§â§Ú§è§Ñ §â§Ú§ã§Ü§à§Ó:\n');
print_both(fid, file_success, '     s1   s2   s3\n');
for i = 1:size(R, 1)
    print_both(fid, file_success, 'R%d  ', i);
    for j = 1:size(R, 2)
        print_both(fid, file_success, '%4d', R(i, j));
    end
    print_both(fid, file_success, '\n');
end

maxRisk = max(R, [], 2);
print_both(fid, file_success, '\n§®§Ñ§Ü§ã§Ú§Þ§Ñ§Ý§î§ß§í§Ö §â§Ú§ã§Ü§Ú §á§à §Ü§Ñ§Ø§Õ§à§Û §ã§ä§â§Ñ§ä§Ö§Ô§Ú§Ú:\n');
for i = 1:size(maxRisk, 1)
    print_both(fid, file_success, 'R%d: %d\n', i, maxRisk(i));
end
[minRisk, idxRisk] = min(maxRisk);
print_both(fid, file_success, '\n§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§à§Ö §â§Ö§ê§Ö§ß§Ú§Ö: R%d (%d)\n\n', idxRisk, minRisk);

% 4. §¬§â§Ú§ä§Ö§â§Ú§Û §¤§å§â§Ó§Ú§è§Ñ
alpha = 0.5;
minV = min(V, [], 2);
maxVmat = max(V, [], 2);
Hurwitz = alpha * minV + (1 - alpha) * maxVmat;

print_both(fid, file_success, '4. §¬§â§Ú§ä§Ö§â§Ú§Û §¤§å§â§Ó§Ú§è§Ñ\n');
print_both(fid, file_success, '§¬§à§ï§æ§æ§Ú§è§Ú§Ö§ß§ä §à§á§ä§Ú§Þ§Ú§Ù§Þ§Ñ alpha = 0.5\n');
print_both(fid, file_success, '§©§ß§Ñ§é§Ö§ß§Ú§ñ §Ü§â§Ú§ä§Ö§â§Ú§ñ:\n');
for i = 1:size(Hurwitz, 1)
    print_both(fid, file_success, 'R%d: %.1f = 0.5*%d + 0.5*%d\n', i, Hurwitz(i), minV(i), maxVmat(i));
end
[minHurwitz, idxHurwitz] = min(Hurwitz);
print_both(fid, file_success, '\n§°§á§ä§Ú§Þ§Ñ§Ý§î§ß§à§Ö §â§Ö§ê§Ö§ß§Ú§Ö: R%d (%.1f)\n\n', idxHurwitz, minHurwitz);

% §³§Ó§à§Õ§ß§Ñ§ñ §ä§Ñ§Ò§Ý§Ú§è§Ñ
print_both(fid, file_success, '5. §³§Ó§à§Õ§ß§Ñ§ñ §ä§Ñ§Ò§Ý§Ú§è§Ñ §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó\n');
print_both(fid, file_success, '§¬§â§Ú§ä§Ö§â§Ú§Û          §°§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§Û §á§â§à§Ö§Ü§ä\n');
print_both(fid, file_success, '§­§Ñ§á§Ý§Ñ§ã§Ñ           R%d\n', idxLaplace);
print_both(fid, file_success, '§£§Ñ§Ý§î§Õ§Ñ            R%d\n', idxMinMax);
print_both(fid, file_success, '§³§ï§Ó§Ú§Õ§Ø§Ñ           R%d\n', idxRisk);
print_both(fid, file_success, '§¤§å§â§Ó§Ú§è§Ñ           R%d\n', idxHurwitz);

% §¡§ß§Ñ§Ý§Ú§Ù §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó
print_both(fid, file_success, '6. §¡§ß§Ñ§Ý§Ú§Ù §â§Ö§Ù§å§Ý§î§ä§Ñ§ä§à§Ó\n');
print_both(fid, file_success, '§²§Ñ§Ù§ß§í§Ö §Ü§â§Ú§ä§Ö§â§Ú§Ú §Õ§Ñ§ð§ä §â§Ñ§Ù§ß§í§Ö §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§Ö §â§Ö§ê§Ö§ß§Ú§ñ:\n');
print_both(fid, file_success, '  - §­§Ñ§á§Ý§Ñ§ã§Ñ (§à§á§ä§Ú§Þ§Ú§ã§ä§Ú§é§ß§í§Û): R3\n');
print_both(fid, file_success, '  - §£§Ñ§Ý§î§Õ§Ñ (§Ü§à§ß§ã§Ö§â§Ó§Ñ§ä§Ú§Ó§ß§í§Û): R1\n');
print_both(fid, file_success, '  - §³§ï§Ó§Ú§Õ§Ø§Ñ (§Þ§Ú§ß§Ú§Þ§Ú§Ù§Ñ§è§Ú§ñ §â§Ú§ã§Ü§Ñ): R3\n');
print_both(fid, file_success, '  - §¤§å§â§Ó§Ú§è§Ñ (§ß§Ö§Û§ä§â§Ñ§Ý§î§ß§í§Û): R2\n');
print_both(fid, file_success, '\n§±§â§à§Ö§Ü§ä R3 §ñ§Ó§Ý§ñ§Ö§ä§ã§ñ §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§Þ §á§à §Õ§Ó§å§Þ §Ü§â§Ú§ä§Ö§â§Ú§ñ§Þ §Ú§Ù §é§Ö§ä§í§â§Ö§ç\n');
print_both(fid, file_success, '§±§â§à§Ö§Ü§ä R4 §ß§Ö §ñ§Ó§Ý§ñ§Ö§ä§ã§ñ §à§á§ä§Ú§Þ§Ñ§Ý§î§ß§í§Þ §ß§Ú §á§à §à§Õ§ß§à§Þ§å §Ü§â§Ú§ä§Ö§â§Ú§ð\n');
print_both(fid, file_success, '\n§²§¦§¬§°§®§¦§¯§¥§µ§¦§®§½§« §±§²§°§¦§¬§´: R3\n');


% §©§Ñ§Ü§â§í§ä§Ú§Ö §æ§Ñ§Û§Ý§Ñ
if file_success
    fclose(fid);
    fprintf('\n§²§Ö§Ù§å§Ý§î§ä§Ñ§ä§í §ã§à§ç§â§Ñ§ß§Ö§ß§í §Ó §æ§Ñ§Û§Ý: %s\n', filename);
endif
