function dict=get_huffcodes(symbols,prob)
    sym_hold=symbols;
    temp=[prob symbols];
    temp=flipud(sortrows(temp));
    symbols=temp(:,2);
    prob=temp(:,1);
    N=size(prob,1);

    
    MAX_LEN=64;
    up=0;
    down=1;
    codes=zeros(N,MAX_LEN)-1;
    S=N;
    sym_track=zeros(N,N)-1;
    sym_track(:,1)=symbols;
    while S>1  
        
        %get lowest two probabilties, sum and remove from list
        low=prob(S);
        high=prob(S-1);
        prob=prob(1:S-2);
        new=low+high;

        %gets cooresponding lowest symbols and delete, concatenate lowest
        %as one node now
        low_sym=sym_track(S,(sym_track(S,:)>-1));
        high_sym=sym_track(S-1,(sym_track(S-1,:)>-1));
        sym_track=sym_track(1:S-2,:);
        new_sym=[low_sym high_sym];
        new_sym=[new_sym zeros(1,N-size(new_sym,2))-1];
        
        for j=1:size(low_sym,2)    
            for i=1:MAX_LEN
                if codes(low_sym(j)+1,i)==-1
                    codes(low_sym(j)+1,i)=down;
                    break;
                end
            end
        end
        for j=1:size(high_sym,2)
            for i=1:MAX_LEN
                if codes(high_sym(j)+1,i)==-1
                    codes(high_sym(j)+1,i)=up;
                    break;
                end
            end
        end

        %find index for new nodes and place into correct spot based on
        %probabilty order
        ind=find(prob<new,1);%if doesn't exist?
        if isempty(ind)
            prob=[prob; new];
            sym_track=[sym_track; new_sym];
        elseif ind==1
            prob=[new; prob];
            sym_track=[new_sym; sym_track];
        else
            ind=ind(1);
            prob=[prob(1:ind-1); new; prob(ind:end)];
            sym_track=[sym_track(1:ind-1,:); new_sym; sym_track(ind:end,:)];
        end
        S=S-1;
    end
    
    lens=zeros(N,1);
    for i=1:size(codes,1)
        temp=find(codes(i,:)<0,1);
        if ~isempty(temp)
            lens(i)=temp(1)-1;
        end
        c=codes(i,1:lens(i));
        c=fliplr(c);
        codes(i,1:lens(i))=c;
    end
    dict=[sym_hold lens codes];
end