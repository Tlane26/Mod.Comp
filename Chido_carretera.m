close all 
clc

x1 = 10;  % coordenada x1 ya dada 
x4 = 280; % coordenada x4 ya dada
y1 = 170; % coordenada y1 ya dada
y4 = 120; % coordenada y4 ya dada

%Se secciona la grafica y solo se seleccionan laz zonas donde es mas
%posible que las coordenadas correctas se encuentren para de esta forma
%optimizar el codigo.
incx = (x4-x1)/3;  
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

%se forma la funcion con los coeficientes que se generan en la iteracion d
%los ciclos for rpncipales y se revisan que se cumplan las condiciones que
%establece el reto.
        if (Z(1)~=0 )
            funcion = @(X)(Z(1)*X.^3)+(Z(2)*X.^2) + (Z(3)*X)+(Z(4)); %funcion principal
            funcion_2=@(X) (3*Z(1)*X.^2)+(2*Z(2)*X) + (Z(3)); %funcion derivada para calculo del radio de curva
            funcion_3=@(X) ((6*Z(1)*X)+(2*Z(2))); %segunda derivada para calculo del radio de curva
            funcion_4=@(X) sqrt((1+((funcion_2(X)).^2))); %funcion de longitud de curvatura
            longitud=integral(funcion_4,x1,x4); %se calcula la longitud
            %se corrobora si se cumplen las condiciones de longitud de arco
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
                radio=((1+(funcion_2(xmax)^2))^(3/2))/(funcion_3(xmax));
                
                %se comprueba si el radio de curvatura cumple con las
                %dimensiones establecidas
                if radio < 50 && radio>-50
                    PC1y = funcion(xmax)-abs(radio); 
                    PC2y = funcion(xmin)+abs(radio);
                    centerc1 = [xmax PC1y];
                    centerc2 = [xmin PC2y];
                    
                    disp(longitud)
                    disp(radio)
                    disp(Z)
                    quit=1;
                    figure('Name','Armando')
                    hold on
                    
                    %se grafican los circulos en los puntos criticos
                    viscircles(centerc1, abs(radio),'color','r','LineStyle','--');
                    viscircles(centerc2, abs(radio),'color','r','LineStyle','--');
                    axis([7 282 50 250])
                    plot(X,Y)
                    hold off
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

for i = 1:1:incx
    
    x2 = xmin - i;
    x3 = xmax - i;
    radio=((1+(funcion_2(x2)^2))^(3/2))/(funcion_3(x2));
    radio1=((1+(funcion_2(x3)^2))^(3/2))/(funcion_3(x3));
    
    if radio < 50 && radio > -50
        hold on
        y = @(X) funcion_2(x2) * (X-x2) + funcion(x2);
        
        fplot(y,[x2 x2+50])
        hold off
    end
       
    if radio1 < 50 && radio1 > -50
        
        hold on
        y1 = @(X) funcion_2(x3) * (X-x3) + funcion(x3);
        
        fplot(y1,[x3 x3+50])
        hold off
    end

end
figure('Name','Carretera')
hold on
plot(X,Y,'color','k','LineWidth',20)
plot(X,Y,'color','y','LineStyle','--','LineWidth',4)
hold off
