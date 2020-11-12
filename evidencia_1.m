for i = 20:280
    for n = 140:280
        for m = 50:200
            for j = 50:200
                quit=0;
                x1 = 10;
                x2 = i;
                x3 = n;
                x4 = 280;

                y1 = 170;
                y2 = m;
                y3 = j;
                y4 = 120;

                %Matriz principal
                A = [(x1^3),(x1^2),(x1),1; (x2^3),(x2^2),(x2),1; (x3^3),(x3^2),(x3),1; (x4^3),(x4^2),(x4),1;];

                %Vector Y
                Y = [y1; y2; y3; y4];

                %matriz de soluciones
                Z = [];

                Z = inv(A) * Y;



                funcion = @(X)(Z(1)*X.^3)+(Z(2)*X.^2) + (Z(3)*X)+(Z(4));
                funcion_2=@(X) (3*Z(1)*X.^2)+(2*Z(2)*X) + (Z(3));
                funcion_3=@(X) ((6*Z(1)*X)+(2*Z(2)));
                funcion_4=@(X) sqrt((1+(((3*Z(1)*X.^2)+(2*Z(2)*X) + (Z(3))).^2)));
                longitud=integral(funcion_4,x1,x4);
                %longitud=400;
                if(longitud<500 && longitud>300)
                    xmax= %Calcular min
                    xmin= %calcular max
                    radio=((1+((funcion_2(xmax))^2))^(3/2))/(funcion_3(xmax));
                    radio_2=((1+(funcion_2(xmin)^2))^(3/2))/(funcion_3(xmin));
                    if radio < 50 && radio_2 <50 && radio > 0 && radio_2 > 0
                       disp(longitud)
                       disp(radio)
                       disp(radio_2)
                       disp(Z)
                       quit=1;
                        break;
                    end
                end
            end
            if quit == 1
                break;
            end
        end
        if quit == 1
           break;
        end
    end
    if quit == 1
       break;
   end
end 