function Gamealgorithm(nact, nrounds)
   
    eta = sqrt(8 * log(nact)/nrounds);
    myHedgealgorithm = Hedgealgorithm(nact, nrounds, eta);
    M = randi(nact,nact);
    
    playerchoice = [];
    aichoice = [];
    regrets = [];
    iterations = [];
    lossvctarray = [];
    
    for i = 1:nrounds
        player = randi(nact);
        lossvct = M(player,:);
        myHedgealgorithm = myHedgealgorithm.updatewts(lossvct);
        myHedgealgorithm = myHedgealgorithm.nxtact();
        ai = myHedgealgorithm.act;
        myHedgealgorithm = myHedgealgorithm.compregret(lossvct);
        regret = myHedgealgorithm.regret;
        iterations = [iterations; i];
        playerchoice = [playerchoice;  player];
        aichoice = [aichoice; ai];
        regrets = [regrets; regret];
        lossvctarray = [lossvctarray; lossvct];
    end
    
    netregret = max(regrets);
    output = table (iterations, playerchoice, aichoice, regrets);
    disp(output);
    disp('The last(20th) regret is '); disp(netregret);
    
end