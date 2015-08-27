%   Crea el eco de una señal en formato .wav, si no se especifica
%   otro factor de retraso o amplicacion se usara por defecto 0,1s de retraso
%   y 0,2 como fator de aplificacion.
%   Params:
%           -file -> Nombre del archivo de entrada 
%           -s -> Retraso en segundos 
%           -k -> factor de amplificacion para la segunda señal

function [y] = kernel(file,s,k)

% Cargamos los valores por defecto de los argumentos
switch nargin
    case 1
        s = 0.1;
        k = 0.2;
    case 2
        k = 0.2;
end

%Cargo el archivo en memoria
[x,fs] = wavread(file);

%Saco la longitud del archivo
m = length(x);

%Creo un vector lleno de ceros
d = zeros(1,m);
%En la primera posicion pongo el delta de la señal normal
d(1) = 1;
%Creo la senal del eco 
d2 = zeros(1,m);
%Debido a que quiero un desplazamiento de 0,1s multiplico
%la frecuencia de muestreo de la señal por el valor a desplazar
index = fs*s;
d2(index) = 1;
%Creo el kernel del eco
h = d+d2.*k;

%Convoluciono la señal de entrada con la respuesta impulso
y=conv(x,h);

%Escucho la señal obtenida
soundsc(y,fs)
