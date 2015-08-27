function [m,f]=DFT(x)

    lenX = length(x);
    m = zeros(1,lenX/2+1);
    f = zeros(1,lenX/2+1);
    
    for k = 1:lenX/2+1

        cosx = generarFuncionCoseno(lenX,k);
        senx = generarFuncionSeno(lenX,k);

        Re = sum(x.*cosx);
        Im = sum(x.*senx);

        m(k) = sqrt(Re^2 + Im^2);
        f(k) = atan(Im/Re);
        
    end
end