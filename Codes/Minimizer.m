function oA=Minimizer(oA,temp,r)
    xMin=min([temp(:,1);temp(:,4)])-2.5*r;
    xMax=max([temp(:,1);temp(:,4)])+2.5*r;

    yMin=min([temp(:,2);temp(:,5)])-2.5*r;
    yMax=max([temp(:,2);temp(:,5)])+2.5*r;

    zMin=min([temp(:,3);temp(:,6)])-2.5*r;
    zMax=max([temp(:,3);temp(:,6)])+2.5*r;

    oA(any(oA(:,1)<xMin,2),:)=[];
    oA(any(oA(:,1)>xMax,2),:)=[];

    oA(any(oA(:,2)<yMin,2),:)=[];
    oA(any(oA(:,2)>yMax,2),:)=[];

    oA(any(oA(:,3)<zMin,2),:)=[];
    oA(any(oA(:,3)>zMax,2),:)=[];
end