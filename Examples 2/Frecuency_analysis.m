%   Prueba la funcion DFT la cual tiene que estar en el dir local para
%   que pueda funcionar.
%   Params:
%           -file -> Nombre del archivo de entrada, si es .txt carga el 
%                   achivo x1.txt si es cualquier otra cosa carga el
%                   archivo usando wavread
%           -N -> Punto de inicio para la seleccion del numero de muestras
%           -M -> Punto final para la seleccion del numero de muestras
%           -ch -> Selecciona el canal que se desee usar

function [y] = prueba(file,N,M,ch)
    k = strfind(file,'.txt');
    if  k ~= 0
        x = load(file);
        [m,f] = DFT(x);
        figure('Name','Diagrama en Magnitud','NumberTitle','off');
        stem(m);
        figure('Name','Diagrama en Fase','NumberTitle','off');
        stem(f);
    else
        [data,fs] = wavread(file);
        switch nargin
            case 1
                dataLeft = data(:,1);
                [m,f] = DFT(dataLeft);
                figure('Name','Diagrama en Magnitud del Canal_Izq','NumberTitle','off');
                stem(m);
                figure('Name','Diagrama en Fase del Canal_Izq','NumberTitle','off');
                stem(f);
                dataRight = data(:,2);
                [m,f] = DFT(dataRight);
                figure('Name','Diagrama en Magnitud del Canal_Der','NumberTitle','off');
                stem(m);
                figure('Name','Diagrama en Fase del Canal_Der','NumberTitle','off');
                stem(f);
            case 2
                dataLeft = data(N:length(data),1);
                [m,f] = DFT(dataLeft);
                figure('Name','Diagrama en Magnitud del Canal_Izq','NumberTitle','off');
                stem(m);
                figure('Name','Diagrama en Fase del Canal_Izq','NumberTitle','off');
                stem(f);
                dataRight = data(N:length(data),1);
                [m,f] = DFT(dataRight);
                figure('Name','Diagrama en Magnitud del Canal_Der','NumberTitle','off');
                stem(m);
                figure('Name','Diagrama en Fase del Canal_Der','NumberTitle','off');
                stem(f);
            case 3
                dataLeft = data(N:M,1);
                [m,f] = DFT(dataLeft);
                figure('Name','Diagrama en Magnitud del Canal_Izq','NumberTitle','off');
                stem(m);
                figure('Name','Diagrama en Fase del Canal_Izq','NumberTitle','off');
                stem(f);
                dataRight = data(N:M,1);
                [m,f] = DFT(dataRight);
                
                figure('Name','Diagrama en Magnitud del Canal_Der','NumberTitle','off');
                stem(m);
                figure('Name','Diagrama en Fase del Canal_Der','NumberTitle','off');
                stem(f);
            case 4  
                ham = hamming(M-N,'periodic');
                data =conv(data(:,ch),ham);
                datax = data(N:M,ch);
                [m,f] = DFT(datax');
                x1 = linspace(0,fs,length(m));
                figure('Name','Diagrama Espectral','NumberTitle','off');
                ax1 = subplot(2,1,1);
                plot(ax1,x1,m);
                title('Diagrama en Magnitud');
                xlabel('Frecuencia (Hz)');
                ylabel('Amplitud');
                x2 = linspace(0,4*pi,length(f));
                ax2 = subplot(2,1,2);
                plot(ax2,x2,f);
                title('Diagrama en Fase');
                xlabel('Numero de muestras');
                ylabel('Fase');
                
        end
    end
end