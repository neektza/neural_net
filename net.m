%% Treniranje mreže - sva slova - histogrami + zoning

brojSlova = 26;

list=dir('slova');

A = [];
C = [];

for i = 3 : (2 + 8 * brojSlova)
   %ucitaj sliku
   img = imread(strcat('slova/', list(i).name));    
   %centriraj sliku
   img = center(img);
   %smanji na 10x10
   img = imresize(img, [20, 20]);
   %kreiraj histograme
   [x, y] = hists(img);
   %zoning
   zone = zoning(img);
   
   %ulazna matrica za treniranje - histogrami + zoning = 24 ulaza
   ulaz = [x y']; % dodaj histograme
   ulaz = [ulaz  zone(1,1) zone(1,2) zone(2,1) zone(2,2)]; % dodaj zoning
   A = [A ulaz'];
   
   %izlazi - binarni vektori 1 do 26 [0 0 0 0 0]-[1 1 0 0 1]
   intSlovo = (ceil((i-2) / 8)) - 1;
   %flipud - metoda samo okrece vektor naopako
   %de2bi - metoda pretvara integer u binarni vektor 
   C = [C flipud(de2bi(intSlovo, 5)')];

end

ul_dim = [0 10;  0 10; 0 10; 0 10; 0 10; 
          0 10;  0 10; 0 10; 0 10; 0 10;
          0 10;  0 10; 0 10; 0 10; 0 10; 
          0 10;  0 10; 0 10; 0 10; 0 10;
          0 10;  0 10; 0 10; 0 10; 0 10; 
          0 10;  0 10; 0 10; 0 10; 0 10;
          0 10;  0 10; 0 10; 0 10; 0 10; 
          0 10;  0 10; 0 10; 0 10; 0 10;
          0 100; 0 100; 0 100; 0 100];
      
izl_dim = [0 1; 0 1; 0 1; 0 1; 0 1];

net = newff( ul_dim , izl_dim, [40, 20],{'tansig','tansig'} ,'traingd');

net.trainParam.show = 50;
net.trainParam.lr = 0.2;
net.trainParam.epochs = 15000;
net.trainParam.goal = 0;

net = init(net);
[net,tr,Y,E] = train(net, A, C);

%% Simuliranje - sva slova  
img = imread(strcat('slova/', 'A1.bmp')); 
img = center(img);
img = imresize(img, [16, 16]);

[x, y] = hists(img);
zone = zoning(img);

ulaz = [x y'];
ulaz = [ulaz  zone(1,1) zone(1,2) zone(2,1) zone(2,2)];

binSlovo = sim(net, ulaz');
binSlovo = (binSlovo > 0.5);
binSlovo'

if(binSlovo ==         [0 0 0 0 0]') disp('A');
    elseif(binSlovo == [0 0 0 0 1]') disp('B');
    elseif(binSlovo == [0 0 0 1 0]') disp('C');
    elseif(binSlovo == [0 0 0 1 1]') disp('D');
    elseif(binSlovo == [0 0 1 0 0]') disp('E');
    elseif(binSlovo == [0 0 1 0 1]') disp('F');
    elseif(binSlovo == [0 0 1 1 0]') disp('G');
    elseif(binSlovo == [0 0 1 1 1]') disp('H');
%----------------------------------------------   
    elseif(binSlovo == [0 1 0 0 0]') disp('I');
    elseif(binSlovo == [0 1 0 0 1]') disp('J');
    elseif(binSlovo == [0 1 0 1 0]') disp('K');
    elseif(binSlovo == [0 1 0 1 1]') disp('L');
    elseif(binSlovo == [0 1 1 0 0]') disp('M');
    elseif(binSlovo == [0 1 1 0 1]') disp('N');
    elseif(binSlovo == [0 1 1 1 0]') disp('O');
    elseif(binSlovo == [0 1 1 1 1]') disp('P');
%----------------------------------------------
    elseif(binSlovo == [1 0 0 0 0]') disp('Q');
    elseif(binSlovo == [1 0 0 0 1]') disp('R');
    elseif(binSlovo == [1 0 0 1 0]') disp('S');
    elseif(binSlovo == [1 0 0 1 1]') disp('T');
    elseif(binSlovo == [1 0 1 0 0]') disp('U');
    elseif(binSlovo == [1 0 1 0 1]') disp('V');
    elseif(binSlovo == [1 0 1 1 0]') disp('W');
    elseif(binSlovo == [1 0 1 1 1]') disp('X');
%----------------------------------------------
    elseif(binSlovo == [1 1 0 0 0]') disp('Y');
    elseif(binSlovo == [1 1 0 0 1]') disp('Z');    
end

%% Prebroji tocno klasificirane uzorke iz skupa za ucenje
brojSlova = 26;
brojUzoraka = 26 * 8;
tocnoKlas = 0;
stringNetocnoKlasSlova = [];
klasificiranaKao = [];

list = dir('slova');
%lis2t = dir('slova/test');

for i = 3 : (2 + 8 * brojSlova)
   %ucitaj sliku
   imeSlike = list(i).name;
   img = imread(strcat('slova/', imeSlike));    
   %centriraj sliku
   img = center(img);
   %smanji na 10x10
   img = imresize(img, [20, 20]);
   %kreiraj histograme
   [x, y] = hists(img);
   %zoning
   zone = zoning(img);
   
   %ulazna matrica za treniranje - histogrami + zoning = 24 ulaza
   ulaz = [x y']; % dodaj histograme
   ulaz = [ulaz  zone(1,1) zone(1,2) zone(2,1) zone(2,2)]; % dodaj zoning
   
binSlovo = sim(net, ulaz');
binSlovo = (binSlovo > 0.5);

if(binSlovo ==         [0 0 0 0 0]') str = 'A';
    elseif(binSlovo == [0 0 0 0 1]') str = 'B';
    elseif(binSlovo == [0 0 0 1 0]') str = 'C';
    elseif(binSlovo == [0 0 0 1 1]') str = 'D';
    elseif(binSlovo == [0 0 1 0 0]') str = 'E';
    elseif(binSlovo == [0 0 1 0 1]') str = 'F';
    elseif(binSlovo == [0 0 1 1 0]') str = 'G';
    elseif(binSlovo == [0 0 1 1 1]') str = 'H';
%----------------------------------------------   
    elseif(binSlovo == [0 1 0 0 0]') str = 'I';
    elseif(binSlovo == [0 1 0 0 1]') str = 'J';
    elseif(binSlovo == [0 1 0 1 0]') str = 'K';
    elseif(binSlovo == [0 1 0 1 1]') str = 'L';
    elseif(binSlovo == [0 1 1 0 0]') str = 'M';
    elseif(binSlovo == [0 1 1 0 1]') str = 'N';
    elseif(binSlovo == [0 1 1 1 0]') str = 'O';
    elseif(binSlovo == [0 1 1 1 1]') str = 'P';
%----------------------------------------------
    elseif(binSlovo == [1 0 0 0 0]') str = 'Q';
    elseif(binSlovo == [1 0 0 0 1]') str = 'R';
    elseif(binSlovo == [1 0 0 1 0]') str = 'S';
    elseif(binSlovo == [1 0 0 1 1]') str = 'T';
    elseif(binSlovo == [1 0 1 0 0]') str = 'U';
    elseif(binSlovo == [1 0 1 0 1]') str = 'V';
    elseif(binSlovo == [1 0 1 1 0]') str = 'W';
    elseif(binSlovo == [1 0 1 1 1]') str = 'X';
%----------------------------------------------
    elseif(binSlovo == [1 1 0 0 0]') str = 'Y';
    elseif(binSlovo == [1 1 0 0 1]') str = 'Z';    
end   
   
if(imeSlike(1) == str)
   tocnoKlas = tocnoKlas + 1;
else stringNetocnoKlasSlova = [stringNetocnoKlasSlova imeSlike(1)];
     klasificiranaKao = [klasificiranaKao str];
end
end

fprintf('Broj toèno klasificiranih: %i\n', tocnoKlas);
fprintf('Postotak tocno klasificiranih: %f posto\n', tocnoKlas/brojUzoraka*100);
fprintf('Problematicna slova: %s\n', stringNetocnoKlasSlova);
fprintf('Klasificirana kao  : %s\n', klasificiranaKao);


