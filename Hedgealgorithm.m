classdef Hedgealgorithm
 
    properties
        nact
        tt
        eta
        act
        wts
        algpf
        minpf
        regret
    end
    
    methods
        
        function objec = Hedgealgorithm(nact, tt, eta)
            objec.eta = eta;
            objec.tt = tt;
            objec.nact = nact;
            objec.wts = ones(objec.nact,1);
            objec.regret = 0;
        end
       
        function objec = updatewts(objec, lossvct)
            for i = 1;length(objec.wts)
                objec.wts(i) = objec.wts(i) * exp(-objec.eta * lossvct(i));
            end
        end    
           
        function objec = nxtact(objec)
            totalwt = sum(objec.wts);
            collwt = zeros(objec.nact,1);
            collwt(1) = objec.wts(1)/totalwt; 
            
            for i = 2:length(objec.wts)
                collwt(i) = collwt(i - 1) + objec.wts(i)/totalwt;
            end
            
            objec.act = 1 + sum(collwt < rand);
        end
        
        function objec = compregret(objec, lossvct)
            objec.algpf = (lossvct * objec.wts)/sum(objec.wts);
            objec.minpf = min(lossvct);
            objec.regret = objec.regret + (objec.algpf - objec.minpf);
        end
    end
end        