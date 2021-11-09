syms x

T = input("Введи Т: ");
eps = input("Введи значение странной буквы: ");
disp("Я знаю что это кси не чеши мозга");

% первый пункт
a1 = T * T;
a2 = T * eps * 2;
a3 = 1;
K1 = 1;

w1 = tf([0, K1], [0.1, 1]);
w2 = tf([0, 1], [a1, a2, a3]);

w_raz = series(w1, w2);
w_zam = feedback(w1, w2);

display(w_raz);
display(w_zam);

disp("Конец первого пункта");
pause

ltiview('bode', w_raz, w_zam);
ltiview('nyquist', w_raz, w_zam);
ltiview('step', w_raz, w_zam);


disp("Нажми что-нибудь чтобы продолжить");
pause

%2 пункт

%поиск коефицента усиления для границы устойчивости
for K1 = 0:0.1:1000
    w1 = tf([0, K1], [0.1, 1]);
    w2 = tf([0, 1], [a1, a2, a3]);
    
    w_zam = feedback(w1, w2);

    r = pole(w_zam);
    X = real(r);

    if ((abs(X(1)) < 0.01) || (abs(X(2)) < 0.01) || (abs(X(3)) < 0.01))
        koef_border = K1;
        break
    end
end

disp("Значение коэффициента усиления, при котором система будет находиться" + ...
    " на границе устойчивости ");
disp(koef_border);

disp("Графики для различных коефициентов усиления и фиксированом кси")
disp("Кси = ");
disp(eps);

for K1 = [1, koef_border, koef_border * 2]
    w1 = tf([0, K1], [0.1, 1]);
    w2 = tf([0, 1], [a1, a2, a3]);

    w_zam = feedback(w1, w2);
    ltiview('bode', w_raz, w_zam);
    ltiview('nyquist', w_raz, w_zam);
    ltiview('step', w_raz, w_zam);
    disp("При коэффициента усиления ");
    disp(K1);

    %display(allmargin(w_zam));
    disp("Нажми что-нибудь чтобы продолжить");
    pause
end

a1 = T * T;
a2 = T * eps * 2;
a3 = 1;
K1 = 1;

disp("Клнец 3 пункта");
disp("Нажми что-нибудь чтобы продолжить");

%3 пункт
disp("Графики при различном кси и зафиксированном коеф усиления");
disp("Коеф усиления = ");
disp(K1);
for eps_move = [0.01, 0.5, 0.95]
    a1 = T * T;
    a2 = T * eps_move * 2;
    a3 = 1;
    w1 = tf([0, K1], [0.1, 1]);
    w2 = tf([0, 1], [a1, a2, a3]);
    disp("При кси равном ");
    disp(eps_move);


    w_raz = series(w1, w2);
    w_zam = feedback(w1, w2);

    %display(w_raz);
    %display(w_zam);
    
    ltiview('bode', w_raz, w_zam);
    ltiview('nyquist', w_raz, w_zam);
    ltiview('step', w_raz, w_zam);
    %ltiview('pzmap', w_raz, w_zam);
    disp("Нажми что-нибудь чтобы продолжить");
    pause;
end

disp("Клнец 3 пункта");
disp("Нажми что-нибудь чтобы продолжить");
pause

%4 пункт


disp("Значение коэффициента усиления, при котором система будет находиться" + ...
    " на границе устойчивости ");
disp(koef_border);

%поиск максимального запаса по амплитуде и фазе
GainMargins_dB = -1;
Phase = 0;
for K1 = 0.1:1:koef_border
    for eps_move = 0.01:0.01:0.99
        a2 = T * eps_move * 2;
        w1 = tf([0, K1], [0.1, 1]);
        w2 = tf([0, K1], [a1, a2, a3]);
        
        w_raz = series(w1, w2);
    
        %disp("При коэффициента усиления ");
        %disp(K1);
    
        m = allmargin(w_raz);
    
        if mag2db(m.GainMargin) + m.PhaseMargin > GainMargins_dB + Phase
            Phase = m.PhaseMargin;
            GainMargins_dB = mag2db(m.GainMargin);
            Kmax = K1;
            epsMax = eps_move;
        end
    end
end

a2 = T * epsMax * 2;
w1 = tf([0, Kmax], [0.1, 1]);
w2 = tf([0, Kmax], [a1, a2, a3]);
        
w_raz = series(w1, w2);

disp("Запас по амплитуде максимальный при коеф усиления ");
disp(Kmax);
disp("и кси ");
disp(epsMax);

m = allmargin(w_raz);
disp("Запас по амплитуде ");
disp(mag2db(m.GainMargin));
disp("Запас по фазе ");
disp(m.PhaseMargin);

ltiview('bode', w_raz);

a1 = T * T;
a2 = T * eps * 2;
a3 = 1;

%замкнутой
disp("Корни характеристического уравнения для системы на границе устойчивости");
w1 = tf([0, koef_border], [0.1, 1]);
w2 = tf([0, 1], [a1, a2, a3]);
w_zam_solove = feedback(w1, w2);
display(pole(w_zam_solove));

%замкнутой
disp("Корни характеристического уравнения для УСТОЙЧИВОЙ")
w1 = tf([0, 1], [0.1, 1]);
w2 = tf([0, 1], [a1, a2, a3]);
w_zam_solove = feedback(w1, w2);
display(pole(w_zam_solove));

%замкнутой
disp("Корни характеристического уравнения для НЕУСТОЙЧИВОЙ")
w1 = tf([0, koef_border * 2], [0.1, 1]);
w2 = tf([0, 1], [a1, a2, a3]);
w_zam_solove = feedback(w1, w2);
display(pole(w_zam_solove));

%разомкнутой
disp("Корни характеристического уравнения для системы с максимальным запасом устойчивости");
display(pole(w_raz));

disp("Всё");
