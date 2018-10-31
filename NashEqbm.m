function NashEqbm(numActions, numRounds)
        
        eta = sqrt(8 * log(numActions)/numRounds);
        myHedge1 = Hedge(eta, numRounds, numActions);
        myHedge2 = Hedge(eta, numRounds, numActions);        

        M = [];
    
        myId = [1 4 3 5 2 6 4];
        
        for i = 1:numActions*numActions
            if mod(i,length(myId)) ~= 0
                M = [M myId(mod(i,length(myId)))];
            else 
                M = [M myId(length(myId))];
            end
        end
        
        M = (reshape(M,numActions,numActions))';
        M2 = -M;
    
        payoff1_ = [];
        payoff2_ = [];
        player1Choice = randi(numActions);   
        player2Choice = randi(numActions);

        for i = 1:numRounds
            lossVector1 = M(player1Choice,:);
            myHedge1 = myHedge1.updateWeights(lossVector1);
            myHedge1 = myHedge1.nextAction();
            myHedge1 = myHedge1.computeRegret(lossVector1);
            player1Choice = myHedge1.action;
            lossVector2 = M2(player2Choice,:);
            myHedge2 = myHedge2.updateWeights(lossVector2);
            myHedge2 = myHedge2.nextAction();
            myHedge2 = myHedge2.computeRegret(lossVector2);
            player2Choice = myHedge2.action;

            dist1 = myHedge1.weights/sum(myHedge1.weights)
            dist2 = myHedge2.weights/sum(myHedge2.weights)
    
            payoff1_ = [payoff1_ dist1];
            payoff2_ = [payoff2_ dist2];
        end
        
        expectedDist1 = mean(payoff1_, 2);
        expectedDist2 = mean(payoff2_, 2);
            
        expectedPayoff1 = expectedDist1' * M
        expectedPayoff2 = expectedDist2' * M2
end
