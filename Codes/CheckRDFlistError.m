%Tab 5, check RDF
function [FlagRDFlist,MessageRDFList]=CheckRDFlistError(app)

FlagRDFlist=false;
MessageRDFList=[];

RDFlist=str2num(char(app.T5EFT10.Value));

if isempty(RDFlist) && ~isempty(app.T5EFT10.Value)
    MessageRDFList={'The "skeleton ID" box is not in the correct format.';
        'The skeleton ID values must be separated by ",".';
        'Please compare what you wrote in the box with the provided example to find out the problem.'};
    FlagRDFlist=true;
    return
elseif isempty(RDFlist)
    MessageRDFList='Please fill the "skeleton ID" box and the click on the "Plot" button.';
    FlagRDFlist=true;
    return
elseif size(unique(RDFlist),2)<size(RDFlist,2)
    MessageRDFList={'The skeleton ID values must be unique.';'Please check the Skeleton ID box and box and the click on the "Plot" button.'};
    FlagRDFlist=true;
    return
end

SIZE=size(app.Skeleton,1);
for j=1:size(RDFlist,2)
    if ~(floor(RDFlist(1,j))==RDFlist(1,j))
        MessageRDFList={['"' num2str(RDFlist(1,j)) '" is not an acceptable skeleton ID value.'];'Skeleton ID values must be integer.';...
            'Please check the Skeleton ID box and box and the click on the "Plot" button.'};
        FlagRDFlist=true;
        return
    elseif RDFlist(1,j)<1 || RDFlist(1,j)>SIZE
        MessageRDFList={['"' num2str(RDFlist(1,j)) '" is not an acceptable skeleton ID value.'];['Skeleton ID value must be an integer smaller than ' num2str(SIZE+1) '.'];...
            'Please check the Skeleton ID box and box and the click on the "Plot" button.'};
        FlagRDFlist=true;
        return
    end
end

end
