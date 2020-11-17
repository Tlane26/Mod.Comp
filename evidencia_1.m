clc
clearvars

contador=0;
contador2=0;
contador3=0;
for i = 86:120
    for n = 220:240
        for m = 170:0.5:190
            for j = 60:0.5:120
                contador=contador + 1;
                disp(contador)
                quit=0;
                x1 = 10;
                x2 =i;
                x3 = n;
                x4 = 280;

                y1 = 170;
                y2 = m;
                y3 = j;
                y4 = 120;

                %Matriz principal
                A = [(x1^3),(x1^2),(x1),1; (x2^3),(x2^2),(x2),1; (x3^3),(x3^2),(x3),1; (x4^3),(x4^2),(x4),1];

                %Vector Y
                Y = [y1; y2; y3; y4];

                %matriz de soluciones

                Z = inv(A) * Y;


                if (Z(1)~=0)
                    funcion = @(X)(Z(1)*X.^3)+(Z(2)*X.^2) + (Z(3)*X)+(Z(4));
                    funcion_2=@(X) (3*Z(1)*X.^2)+(2*Z(2)*X) + (Z(3));
                    funcion_3=@(X) ((6*Z(1)*X)+(2*Z(2)));
                    funcion_4=@(X) sqrt((1+((funcion_2(X)).^2)));
                    longitud=integral(funcion_4,x1,x4);
                    %longitud=400;
                    if(longitud<500 && longitud>300)
                        cont=1;
                        index=1;
                        X=[x1:x4];
                        Y=[];
                        for k=x1:x4
                            Y(cont)=funcion(k);
                            dy = funcion_2(k);
                            if dy==0
                                xmin=k;
                            end
                            cont=cont+1;
                        end
                        contador2=contador2+1;
                        try
                            radio=((1+(funcion_2(xmin)^2))^(3/2))/(funcion_3(xmin));
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
        if quit == 1
           break;
        end
    end
    if quit == 1
       break;
   end
end

disp(contador2)
disp(contador)
