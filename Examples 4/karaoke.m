%Leemos el archivo de audio
[audio,fs]=wavread('music.wav');

xizq = audio(:,1); % Se toma el canal izquierdo
xizq = xizq'; % se transpone para poder procesar

xder = audio(:,2); % Se toma el canal derecho
xder = xder'; % se transpone para poder procesar

%Parametros
%Numero de muestras del kernel
M = 1024;
%
%Frecuencias de corte
fc1 = 180/fs;
fc2 = 3400/fs;

%Creacion del kernel
%Tip1: usar función sinc(x) y blackman(x)
%Tip2: la función sinc debe de estar centrada en el kernel, usar un rango
%de -M/2 a M/2 para generar la función

Blackman = blackman(M);
Blackman = Blackman';

h1 = zeros(M);
for i = 1:M
    h1(i) = sinc(2*fc1*(i-(M/2)))*Blackman(i);
end

h1 = h1/sum(h1);

h2 = zeros(M);

for i = 1:M
    h2(i) = sinc(2*fc2*(i-(M/2)))*Blackman(i);
end

h2 = h2/sum(h2);
h2 = -1*h2;
h2(M/2) = h2(M/2)+1;

kernel = h1' + h2';

%Filtro la señal
y = conv(xizq,kernel); %Convoluciono el kernel con el canal izquierdo de la señal
z = conv(xder,kernel); %Convoluciono el kernel con el canal derecho de la señal
karaokeAudio = zeros(length(y),2); %Creo una matriz con la longitud de la convolucion 
karaokeAudio(:,1) = y; %Asigno el canal izquierdo
karaokeAudio(:,2) = z; %Asigno el canal derecho

%Escuchamos el original
%soundsc(xizq,fs);

%Escuchamos el filtrado
soundsc(karaokeAudio,fs);

%Muestro el grafico
NFFT = M;
Y = abs(fft(kernel,NFFT));
f = fs/2*linspace(0,1,NFFT/2+1);
figure;
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('Espectro de frecuencia del Kernel')
xlabel('Frecuencia (Hz)')
ylabel('|Y(f)|')


