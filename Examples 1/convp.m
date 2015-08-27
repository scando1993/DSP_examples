function [y] = convp( x,h )

%Saco la longitud de ambos archivos de entrada
m=length(x);
n=length(h);

%Agrega ceros a las funciones para poder realizar la 
%convolucion
x=[x,zeros(1,n)];
h=[h,zeros(1,m)];

%Recorre el el arreglo para por cada punto hacer una
%convolucion
for i=1:n+m-1
    y(i)=0;
    %Formula de la convolucion
    for j=1:m
        if(i-j+1>0)
            y(i)=y(i)+x(j)*h(i-j+1);
        end
    end
end
