B = input("Введи B ");
T1 = input("Введи Т1 ");
T2 = input("Введи Т2 ");
K = input("Введи K ");

Num_out(K, T1, T2, B);

display(tf(K, [T1 * T2, T1 + T2, 1]));

disp("Пункт 5");
K1 = input("Введи K1 ");
Num_out(K1, T1, T2, B);
display(tf(K1, [T1 * T2, T1 + T2, 1]));

K2 = input("Введи K2 ");
Num_out(K2, T1, T2, B);
display(tf(K2, [T1 * T2, T1 + T2, 1]));

K3 = input("Введи K3 ");
Num_out(K3, T1, T2, B);
display(tf(K3, [T1 * T2, T1 + T2, 1]));


inp = input("Какой T больше? T1 - y / T2 - n ", 's');
    if (ischar(inp) && lower(inp) == 'y')
        disp("Введи три новых значения T1 ");
        T_change = input("T1 ");
        Num_out(K, T_change, T2, B);
        display(tf(K, [T_change * T2, T_change + T2, 1]));
        T_change = input("T1 ");
        Num_out(K, T_change, T2, B);
        display(tf(K, [T_change * T2, T_change + T2, 1]));
        T_change = input("T1 ");
        Num_out(K, T_change, T2, B);
        display(tf(K, [T_change * T2, T_change + T2, 1]));
    else
        disp("Введи три новых значения T2 ");
        T_change = input("T2 ");
        Num_out(K, T1, T_change, B);
        display(tf(K, [T1 * T_change, T1 + T_change, 1]));
        T_change = input("T2 ");
        Num_out(K, T1, T_change, B);
        display(tf(K, [T1 * T_change, T1 + T_change, 1]));
        T_change = input("T2 ");
        Num_out(K, T1, T_change, B);
        display(tf(K, [T1 * T_change, T1 + T_change, 1]));
    end

function Num_out(K, T1, T2, B)
    A = 4 * K * B * T1 * T2 / (pi * (T1 + T2));
    omeg = sqrt(1 / (T1 * T2));
    disp("A = ");
    disp(A);
    disp("omeg = ");
    disp(omeg);
end
