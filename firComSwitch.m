% Especificacoes
M = 80;
omega_c = 1000;
omega_s = 4000;
wc = omega_c * 2*pi / omega_s;
n = 1:M/2;

% Coeficientes do filtro ideal
h0 = 1 - (wc/pi);
haux = -sin(wc.*n)./(pi.*n);
h = [fliplr(haux) h0 haux];

% Escolha da janela pelo usuario
disp('Janelas disponiveis:');
disp('  1 - Retangular');
disp('  2 - Hamming');
disp('  3 - Blackman');
opcao = input('Escolha a janela (1, 2 ou 3): ');

switch opcao
    case 1
        w = ones(1, M+1);
        nome = 'Retangular';
    case 2
        w = hamming(M+1)';
        nome = 'Hamming';
    case 3
        w = blackman(M+1)';
        nome = 'Blackman';
    otherwise
        error('Opcao invalida. Escolha 1, 2 ou 3.');
end

% Aplica a janela
h = h .* w;

% Plot
[H, f] = freqz(h, 1, 2048, omega_s);
plot(f, 20*log10(abs(H)));
xlabel('Frequencia (rad/s)');
ylabel('Resposta de Modulo (dB)');
title(['Filtro Passa-Alta — Janela ' nome]);
ylim([-100 5]);
xline(omega_c, '--r', '\omega_c');
grid on;