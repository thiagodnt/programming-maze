//Processamento A* sobre o nó atual

var debug=true;

//Adiciona à lista
ds_list_add(C,getKey(curX,curY));

//Analisa nó adjacente
var distFromStartToCurrent=ds_map_find_value(G,getKey(curX,curY));
for(var i=max(0,curX-1);i<=min(oAStar.fieldWidth-1,curX+1);i++){
    for(var j=max(0,curY-1);j<=min(oAStar.fieldHeight-1,curY+1);j++){
        if(i==curX && j==curY)
            continue;
        var closed=ds_list_find_index(C,getKey(i,j))!=-1;
        var diagonal=((i+j)%2 == (curX+curY)%2);    //deletar(?); não possui diagonais
        var canWalk=false;
        var distFromCurrentToIJ=0;
        if(diagonal){
            canWalk=oAStar.walkable[i,j] &&
                oAStar.walkable[curX,j] && 
                oAStar.walkable[i,curY];
            distFromCurrentToIJ=1.414;
        }else{
            canWalk=oAStar.walkable[i,j];
            distFromCurrentToIJ=1;
        }
        if(!closed && canWalk){
            var tempG=distFromStartToCurrent+distFromCurrentToIJ;
            var tempH=abs(i-endX)+abs(j-endY);//heurística/distância de Manhattan
            var tempF=tempG+tempH;
            var processed=ds_map_exists(G,getKey(i,j));
            
            if(processed){
                var lowerG=(ds_map_find_value(G,getKey(i,j))>tempG);
                if(lowerG){
                    ds_map_replace(G,getKey(i,j),tempG);
                    ds_map_replace(H,getKey(i,j),tempH);
                    ds_priority_change_priority(F,getKey(i,j),tempF);
                    ds_map_replace(P,getKey(i,j),getKey(curX,curY));
                }
            }else{
                ds_map_add(G,getKey(i,j),tempG);
                ds_map_add(H,getKey(i,j),tempH);
                ds_priority_add(F,getKey(i,j),tempF);
                ds_map_add(P,getKey(i,j),getKey(curX,curY));; 
            }
        }
    }
}
//Encontra melhor opção
var minF=-1;
var empty=ds_priority_empty(F);

if(!empty) {
    minF=ds_priority_delete_min(F);
}

if(minF==-1){
    searching=false;
    found=false;
}else{
    curX=getKeyX(minF);
    curY=getKeyY(minF);
}
//Checa se o destino foi encontrado
if(curX==endX && curY==endY){
    searching=false;
    found=true;
}
