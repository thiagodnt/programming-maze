//Cria caminho (startX, startY) -> (endX, endY)

var startRoomX=argument0;
var startRoomY=argument1;
var endRoomX=argument2;
var endRoomY=argument3;

//Converte var em grid
startX=startRoomX div oAStar.blockSize;
startY=startRoomY div oAStar.blockSize;
endX=endRoomX div oAStar.blockSize;
endY=endRoomY div oAStar.blockSize;

//Estruturas de dados
G=ds_map_create();
H=ds_map_create();
F=ds_priority_create();
P=ds_map_create();
C=ds_list_create();

//Inicializa mapa (G)
ds_map_add(G,getKey(startX,startY),0);

//Algoritmo A*
searching=true;
found=false;
curX=startX;
curY=startY;

while(searching){
    processCurrentNode();
}

var path=-1;
if(found){
    path=path_add();
    var curNode=getKey(endX,endY);
    while(curNode!=getKey(startX,startY)){
        path_add_point(path,getKeyX(curNode)*oAStar.blockSize,
            getKeyY(curNode)*oAStar.blockSize,100);
        curNode=ds_map_find_value(P,curNode);
    }
    path_add_point(path,startX*oAStar.blockSize,startY*oAStar.blockSize,100);
    path_reverse(path);
    path_set_closed(path,false);
}

//Destrói estruturas de dados
ds_map_destroy(G);
ds_map_destroy(H);
ds_priority_destroy(F);
ds_map_destroy(P);
ds_list_destroy(C);

//Retorna o resultado encontrado
return path;
