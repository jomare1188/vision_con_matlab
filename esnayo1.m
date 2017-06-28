%% inicio
clc
clear all                  
close all

%% cargar imagen y grises
%I= rgb2gray(imread('Salmonella.JPG'));                           % relleno agujeros
I= imresize(imread('E. Coli.JPG'),0.40); 
I2 = im2bw(imcomplement(I),0.60);        % importante medir la sensibilidad de ese 0.6
rango = [15 25];
rango2 = [30 80];
%% ciruclos interiores
figure 
subplot (1,3,1)
imshow(I)
[centers,radii] = imfindcircles(I,rango);

% para identificar los circulos me baso en la posicion , creo una columna
% adicional en la matriz , se llama clase , a cada circulo le corresponde
% una clase que depende de las coordenadas del centro , entonces los
% circulos con el mismo centro tendran la misma clase

matrix1=[centers radii];
clase1=median(matrix1(:,1:2),2);
matrix1=[matrix1 clase1];
%% identificacion circulos interiores
 matrix1_sorted=sortrows(matrix1,4);
viscircles(matrix1_sorted(1,1:2), matrix1_sorted(1,3),'EdgeColor','c');
viscircles(matrix1_sorted(2,1:2), matrix1_sorted(2,3),'EdgeColor','b');
viscircles(matrix1_sorted(3,1:2), matrix1_sorted(3,3),'EdgeColor','y');
viscircles(matrix1_sorted(4,1:2), matrix1_sorted(4,3),'EdgeColor','g');

%% circulos exteriores
subplot (1,3,2)
imshow(I2)
[centers2,radii2] = imfindcircles(I2,rango2,'ObjectPolarity','bright','Sensitivity',0.9);
matrix2=[centers2 radii2];
clase2=median(matrix2(:,1:2),2);
matrix2=[matrix2 clase2];



%% identificacion circulos exteriores
matrix2_sorted=sortrows(matrix2,4);
viscircles(matrix2_sorted(1,1:2), matrix2_sorted(1,3),'EdgeColor','c');
viscircles(matrix2_sorted(2,1:2), matrix2_sorted(2,3),'EdgeColor','b');
viscircles(matrix2_sorted(3,1:2), matrix2_sorted(3,3),'EdgeColor','y');
viscircles(matrix2_sorted(4,1:2), matrix2_sorted(4,3),'EdgeColor','g');

%% grafica 3 
subplot(1,3,3)
imshow(I)

viscircles(matrix2_sorted(1,1:2), matrix2_sorted(1,3),'EdgeColor','c');
viscircles(matrix2_sorted(2,1:2), matrix2_sorted(2,3),'EdgeColor','b');
viscircles(matrix2_sorted(3,1:2), matrix2_sorted(3,3),'EdgeColor','y');
viscircles(matrix2_sorted(4,1:2), matrix2_sorted(4,3),'EdgeColor','g');

viscircles(matrix1_sorted(1,1:2), matrix1_sorted(1,3),'EdgeColor','c');
viscircles(matrix1_sorted(2,1:2), matrix1_sorted(2,3),'EdgeColor','b');
viscircles(matrix1_sorted(3,1:2), matrix1_sorted(3,3),'EdgeColor','y');
viscircles(matrix1_sorted(4,1:2), matrix1_sorted(4,3),'EdgeColor','g');

%% c�lculo de areas 
areas1=pi().*matrix1(:,3).^2;
areas2=pi().*matrix2(:,3).^2;
Ahalos=areas2-areas1;
Ahalos_relativa=(Ahalos./Ahalos(3))



colores={'cyan';'azul'; 'amarillo'; 'verde'}
Ahalos_relativa_et={Ahalos_relativa; colores};
% points=detectSURFFeatures(I);
% imshow(I); hold on;
% plot(points.selectStrongest(50));