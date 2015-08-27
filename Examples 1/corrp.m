function [z] = corrp(x,y)

%Saco la longitud de ambos archivos de entrada
m=length(x);
n=length(y);

%Agrega ceros a las funciones para poder realizar la 
%correlacion
x=[x,zeros(1,n)];
y=[y,zeros(1,m)];

%Recorre el el arreglo para por cada punto hacer una
%correlacion
for i=1:n+m-1
    z(i)=0;
    %Formula de la correlacion
    for j=1:m
        if(j-i+1>0)
            z(i)=z(i)+x(j)*y(j-i+1);
        end
    end
end