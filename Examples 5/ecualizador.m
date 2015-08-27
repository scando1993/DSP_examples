%Filtro personalizado ecualizador 3 bandas
%Creo el filtro perosnalizado que modifica la magnitud
N=1025; %Longitud respuesta en frecuencia
M=512; %Logitud del kernel final

[sonido,fs]=wavread('music.wav');

%MAGNITUD
%incializar el filtro con los valores de magnitudes en 1 y los valores de fase en 0
mg_filter = ones(1,N);

%FASE
ph_filter = zeros(1,N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Convertir aquí mg_filter a la respuesta en frecuencia deseada

%TODO: crear aquí mg_filter

fc1 = 800/fs;
fc2 = 2500/fs;
fc3 = 8000/fs;
fc4 = 16000/fs;

x=(0:0.5/(N-1):0.5);

index1 = 1;
index2 = 1;
index3 = 1;
index4 = 1;

flag1 = 0;
flag2 = 0;
flag3 = 0;
flag4 = 0;

for i = 1:N
    if(x(i) >= fc1 && flag1 == 0)
        index1 = i;
        flag1 = 1;
    end
    if(x(i) >= fc2 && flag2 == 0)
        index2 = i;
        flag2 = 1;
    end
    if(x(i) >= fc3 && flag3 == 0)
        index3 = i;
        flag3 = 1;
    end
    if(x(i) >= fc4 && flag4 == 0)
        index4 = i;
        flag4 = 1;
    end
end

for i = index1:index2
    mg_filter(i) = 0.1;
end
for i = index3:index4
    mg_filter(i) = 0.5;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DIBUJO DE LA RESPUESTA EN FRECUENCIA DESEADA
figure;
subplot(2,2,2);
x=(0:0.5/(N-1):0.5);
plot(x,mg_filter);
axis([0 0.5 0 2.2]);
title('Respuesta en frecuencia deseada');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Obtener la repuesta impulso
%TIPS:
%- Convertir a rectagular usando la función pol2cart.
%- Usar la ifft para convertir a respuesta a impulso. Recuerde que la ifft
%usa numeros complejos (por ejemplo 3+5j) y la simetria en frecuencias
%negativas.

[rea,img] = pol2cart(ph_filter,mg_filter);

complex = rea+img*i;

% signal = ones(1,2*N);
% 
% for i = 1:N-1
%     signal(i) = complex(N-i+1);
%     signal(N+i-1) = complex(i);
% end

%DIBUJO DE LA RESPUESTA AL IMPULSO
subplot(2,2,1);

%incializar la respuesta a impulso con ceros
k = zeros(1,N);

%TODO: Obtener respuesta a impulso
k = ifft(complex,'symmetric');

plot(k);
axis([1 (N) 0 1]);
title('Repuesta al impulso original');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Obtener el kernel
%TIPS:
%- Recuerde que la respuesta a impulso esta centrada en cero, es necesario desplazarla a la mitad del kernel.
%- Recuerde enventanar con blackman el kernel.

%TODO: Obtener kernel a partir de respuesta impulso

%incializar la kernel con ceros
kernel = zeros(1,N);
Blackman = blackman(M);
Blackman = Blackman';

for i = 1:M/2+1
    kernel(M/2+i-1) = k(i);
    if(M/2 - i > 0)
        kernel(M/2-i) = k(i+1);
    end
end


kernel = kernel/sum(kernel);
for i = 1:M
    kernel(i) = kernel(i)*Blackman(i);
end

%DIBUJO
subplot(2,2,3);
plot(kernel);
axis([1 (N) 0 1]);
title('Kernel');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Obtener la respuesta en frecuencia del kernel

%TODO: Obtener respuesta en frecuencia del kernel a usar
%TODO: Agregar este gráfico al plot principal

Y = fft(kernel);

%DIBUJO
subplot(2,2,4);
amp_esp = abs(Y);
x=(0:0.5/(N-1):0.5);
plot(x,amp_esp); 
axis([0 0.5 0 2.2]);
title('Respuesta en frecuencia actual')

%PROBAMOS EL FILTRO
sonido_l=sonido(:,1)';

%CNVOLUCIONO CON EL KERNEL
sonido_out=conv(sonido_l,kernel);

%ESCUCHAMOS EL RESULTADO
%sound(sonido_l,fs);
soundsc(sonido_out,fs);