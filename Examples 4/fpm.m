function [y] = fpm(M)
    %Se carga la señal
    yn = load('yn.mat');
    %Se hace el subset a la estructura cargada por 
    %el metodo load
    yn = yn.yn(1,:);
    
    %Implementacion del filtro por convolucion
    %Creacion del kernel de M-muestras
    kernel = zeros(1,M);
    for i = 1:M
        kernel(i) = 1/M;
    end
    
    %Filtro por convolucion
    y = conv(yn,kernel);

    lenYn = length(yn); %Longitud de la señal original

    %Implementacion del filtro por recursion
    %Parametros para el filtro
    p = (M-1)/2;
    q = p+1;
    
    z = zeros(1,lenYn); %Señal despues del filtro

    %Se le agregan ceros a la señal para mantener 
    %dimensiones
    for i = 1:q+p
        yn(1,lenYn+i) = 0;
    end

    %Implementacion recursiva del filtro
    for i = 1:lenYn
        if i-q < 1
            if i-1 < 1
                z(i) = yn(i+p);
            else
                z(i) = z(i-1)+yn(i+p);
            end
        else
            z(i) = z(i-1)+yn(i+p)-yn(i-q);
        end

    end
    
    %Se divide el filtro para la magnitud del mismo
    z = z/M;
    
    %Grafico para ilustrar los dos metodos
    figure;
    title('Ejemplo del Filtro de promedio movil');
    subplot(3,1,1);
    plot(yn);
    axis([0 10000 -2 2]);
    title('Señal original');
    subplot(3,1,2);
    plot(y);
    title('Filtro promedio movil por convolucion');
    subplot(3,1,3);
    plot(z);
    title('Filtro de promedio movil por recursion');

end