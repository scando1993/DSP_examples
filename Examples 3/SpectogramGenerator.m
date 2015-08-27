function matrizEspectral = generadorSpectograma(filename,resolucionF)
%   matrizEspectral = generadorSpectograma(filename,resolucionF)
%   Esta funcion genera un espectograma y un diagrama en el tiempo de una
%   grabacion de audio. Adicionalmente retorna el espectograma en una
%   matriz.
%
%   filename: nombre o camino de un archivo de audio .wav (ejemplo
%   'c:\Users\grabacion.wav')
%   resolucionF: resolucion en frecuencia, es decir el tamano de la DFT en muestras (ejemplo: 256)
%   matrizEspectral: Una matriz que contiene el espectro de la senal. La
%   dimesi?n de la matrix debe de ser resolucionF x #de FFT, es decir las
%   columnas representan el tiempo y las filas la frecuencia.
%   Created by: Kevin Cando Garces on 30-06-2015.

%   Uso:
%     Si se ponen argumentos la funcion retorna una matriz conteniendo los datos, sino puede ser 
%     empleado sin necesidad de ser igualado a algun valor, asi mismo si se tiene 2 canales muestra 
%     un espectograma por cada canal
%     
    [data,fs] = wavread(filename);
    nsize = size(data);
    lendata = length(data);
    t = (0:lendata-1)*1/fs;
    if nsize(2) > 1
        if nargout > 0
            chanel1 = spectrogram(data(:,1),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            chanel2 = spectrogram(data(:,2),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            matrizEspectral = [chanel1 chanel2];
            figure('units','normalized','outerposition',[0 0 1 1]);
            title('Analisis Espectral');
            subplot(2,2,1);
            spectrogram(data(:,1),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            title('Analisis Espectral del canal 1');
            xlabel('Tiempo (s)');
            ylabel('Frecuencia (Hz)');
            subplot(2,2,3);
            plot(t,data(:,1));
            title('Analisis en el tiempo para el canal 1');
            axis off;
            subplot(2,2,2);
            spectrogram(data(:,2),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            title('Analisis Espectral del canal 2');
            xlabel('Tiempo (s)');
            ylabel('Frecuencia (Hz)');
            subplot(2,2,4);
            plot(t,data(:,2));
            title('Analisis en el tiempo para el canal 2');
            axis off;
        else
            figure('units','normalized','outerposition',[0 0 1 1]);
            title('Analisis Espectral');
            subplot(2,2,1);
            spectrogram(data(:,1),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            title('Analisis Espectral del canal 1');
            xlabel('Tiempo (s)');
            ylabel('Frecuencia (Hz)');
            subplot(2,2,3);
            plot(t,data(:,1));
            title('Analisis en el tiempo para el canal 1');
            axis off;
            subplot(2,2,2);
            spectrogram(data(:,2),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            title('Analisis Espectral del canal 2');
            xlabel('Tiempo (s)');
            ylabel('Frecuencia (Hz)');
            subplot(2,2,4);
            plot(t,data(:,2));
            title('Analisis en el tiempo para el canal 2');
            axis off;
        end
    else
        if nargout > 0
            matrizEspectral = spectrogram(data(:,1),hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
        else
            figure('units','normalized','outerposition',[0 0 1 1]);
            title('Analisis Espectral');
            subplot(2,1,1);
            spectrogram(data,hamming(resolucionF),resolucionF-10,resolucionF,fs,'yaxis');
            xlabel('Tiempo (s)');
            ylabel('Frecuencia (Hz)');
            subplot(2,1,2);
            plot(t,data);
            axis off;
        end
    end
end