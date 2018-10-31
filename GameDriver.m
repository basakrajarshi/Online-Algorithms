function GameDriver(numActions, maxNumRounds)

%% NOTE: 
%%      1. This uses the Hedge class; Hedge.m file to be placed in the same 
%%          directory as this.
%%      2. Appropriate parts of the code to be commented / un-commented for 
%%          questions 1a and 1b.
    
    regrets_ =[];
    numRounds_ =[];
    %worstCaseRegretFactor = 0;
    %worstCaseNumRounds = 0;
    %worstCaseRegret = 0;
    %worstCaseM = [];
    %worstCaseLossVector = [];
    
    %for numRounds = 10:10:maxNumRounds 
        
        %% ps4 1a
%         numRounds = numRounds;
        
        eta = sqrt(8 * log(numActions)/numRounds);
        myHedge = Hedge(eta, numRounds, numActions);
        M = rand(numActions);       %M generated randomly
        
        %% ps4 1a
%         playerChoices = [];
%         aiChoices = [];
%         regrets = [];
%         iterations = [];
    
        lossVector_ = [];

        for i = 1:numRounds
            playerChoice = randi(numActions);   %simulating the choice of the human
            lossVector = M(playerChoice,:);
            myHedge = myHedge.updateWeights(lossVector);
            myHedge = myHedge.nextAction();
            aiChoice = myHedge.action;
            myHedge = myHedge.computeRegret(lossVector);
            regret = myHedge.regret;
            %% ps4 1a
%             iterations = [iterations; i];
%             playerChoices = [playerChoices;  playerChoice];
%             aiChoices = [aiChoices; aiChoice];
%             regrets = [regrets; regret];
            
            lossVector_ = [lossVector_; lossVector];
        end
                
        %% ps4 1b        
        regretFactor = regret/sqrt(numRounds);
        if (regretFactor > worstCaseRegretFactor)
            worstCaseRegretFactor = regretFactor;% Updating all the parameters for the worst case scenario
            worstCaseNumRounds = numRounds;
            worstCaseRegret = regret;
            worstCaseM = M;
            worstCaseLossVector = lossVector_;
        end
        
        %% ps4 q1a
%         output = table (iterations, playerChoices, aiChoices, regrets);
%         disp(output);
        
        %% ps4 q1b
        regrets_ = [regrets_, regret];
        numRounds_ = [numRounds_, numRounds];
    %end
    
    figure(1);
    hold on;
    plot(numRounds_, regrets_,'.');
    axis([0 maxNumRounds 0 sqrt(maxNumRounds)])

	%% ps4 1b
    disp('Worst Case Regret');
    disp('worstCaseNumRounds'); disp(worstCaseNumRounds);
    disp('worstCaseRegret'); disp(worstCaseRegret);
    disp('worstCaseM'); disp(worstCaseM);
    disp('worstCaseLossVector'); disp(worstCaseLossVector);
    
    i_ = [];
    bound1 = [];
    bound2 = [];
    
    for i=1:maxNumRounds
        i_ = [i_, i];
        bound1 = [bound1, sqrt(i)];
        bound2 = [bound2, sqrt((i/2)*log(numActions))];
    end
    
    plot(i_, bound1);
    plot(i_, bound2);
    legend('regret', '√(T)','√(T/2 * ln N)');
    xlabel('T');
    ylabel('Regret');
    hold off;
    
end
