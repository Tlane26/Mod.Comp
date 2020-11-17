close all
clc
hold on

x1 = 10;
x4 = 280;
y1 = 170;
y4 = 120;
incx = (x4-x1)/3;
incy = (y4-y1)/2;
for i = 1:1:incx
    for j = 1:1:x4-incx
        quit=0;
        x2 = x1+i;
        x3 = x4-i;
        y2 = y1+j;
        y3 = y4-j;


        %Matriz principal
        A = [(x1^3),(x1^2),(x1),1; (x2^3),(x2^2),(x2),1; (x3^3),(x3^2),(x3),1; (x4^3),(x4^2),(x4),1];

        %Vector Y
        Y = [y1; y2; y3; y4];

        %matriz de soluciones

        Z = inv(A) * Y;


        if (Z(1)~=0 )
            funcion = @(X)(Z(1)*X.^3)+(Z(2)*X.^2) + (Z(3)*X)+(Z(4));
            funcion_2=@(X) (3*Z(1)*X.^2)+(2*Z(2)*X) + (Z(3));
            funcion_3=@(X) ((6*Z(1)*X)+(2*Z(2)));
            funcion_4=@(X) sqrt((1+((funcion_2(X)).^2)));
            longitud=integral(funcion_4,x1,x4);
            if(longitud<500 && longitud>300)
                cont=1;
                X=[x1:x4];
                Y=[];
                xmax = (-Z(2)-sqrt(Z(2)^2-3*Z(1)*Z(3)))/(3*Z(1));
                xmin = (-Z(2)+sqrt(Z(2)^2-3*Z(1)*Z(3)))/(3*Z(1));
                for k=x1:x4
                    Y(cont)=funcion(k);
                    cont=cont+1;
                end

                try
                    radio=((1+(funcion_2(xmax)^2))^(3/2))/(funcion_3(xmax));
                catch
                    radio=51;
                end
                if radio < 50 && radio>-50
                    disp(longitud)
                    disp(radio)
                    disp(Z)
                    quit=1;
                    plot(X,Y)
                    disp(X)
                    disp(Y)
                   break;
                end
            end
        end
    end
    if quit == 1
        break;
    end
end

