%% leemos la imagen 

RGB = imread('1.bmp');

gray = rgb2gray(RGB);

imshow(gray)

% Elemetos estructurales necesarios para hacer operaciones morfologicas

se1 = strel('square',11); 
se2 = strel('line',11,45);
se3 = strel('disk',15);% <-------
se4 = strel('ball',15,5);

%Operaciones morfologicas

J1 = imdilate(gray,se1); % Dilatacion
J2 = imerode(gray,se2); % Erosión
J3 = imopen(gray,se3);  % Apertura % <-------
J4 = imclose(gray,se4); % Cierre

figure,
subplot(2,2,1), imshow(J1), title ( 'Dilatacion')
subplot(2,2,2), imshow(J2), title ( 'Erosion')
subplot(2,2,3), imshow(J3), title ( 'Apertura')
subplot(2,2,4), imshow(J4), title ( 'Cierre')

% Binarizar una imagen
 
BW = im2bw(J3,0.26 );
%BW = BW == 0; % Invertimos los colores 
%BW = imfill(BW,'holes'); % Rellenamos agujeros

figure, imshow(BW)


%% Identificamos los objetos en la imagen 

gray_label = bwlabel(BW);
imshow(label2rgb(gray_label));
propiedades = regionprops(gray_label); 

%% Identificar los objetos encontrados 

for k =1 : length(propiedades) 
    caja = propiedades(k).BoundingBox;
    rectangle('Position', [caja(1),caja(2),caja(3),caja(4)],...
    'EdgeColor','r','LineWidth',3)
end
%% Enumerar los objetos

L = bwlabel (BW);       % Etiquieta regiones (componentes conectados) 
numele = max(max(L));   % Nos da el número de objetos 
disp('Numero de componentes: '), disp(numele) 


%% Recortamos los objetos de interés 

prop = regionprops(L,'all');

r = prop(4).BoundingBox;
m = imcrop(RGB,r);
figure;imshow(m);

r2 = prop(3).BoundingBox;
m2 = imcrop(RGB,r2);
figure;imshow(m2);







