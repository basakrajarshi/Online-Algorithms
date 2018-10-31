function Game(numActions, numRounds)
    eta = sqrt(8 * log(numActions)/numRounds);
    myHedge = Hedge(eta, numRounds, numActions);
    M = rand(numActions);
    
    M = [0.9 0.1; 0.4 0.01];
    %M = [0.9 0.1; 0.01 0.4];
    
    for i = 1:numRounds
        playerChoice = randi(numActions);
        lossVector = M(playerChoice,:);
        myHedge = myHedge.updateWeights(lossVector);
        myHedge = myHedge.nextAction();
        myHedge = myHedge.computeRegret(lossVector);
        myHedge.regret;
    end
end

