classdef Hedge
    
    properties
        eta
        T
        numActions
        action
        weights
        algoPayoff
        minPayoff
        regret
    end
    
    methods
        function obj = Hedge(eta, T, numActions)
            obj.eta = eta;
            obj.T = T;
            obj.numActions = numActions;
            obj.weights = ones(obj.numActions,1);
            obj.regret = 0;
        end
        
        function obj = updateWeights(obj, lossVector)
            for i = 1:length(obj.weights)
                obj.weights(i) = obj.weights(i) * exp(-obj.eta * lossVector(i));
            end
        end
            
        function obj = nextAction(obj)
            totalWeight = sum(obj.weights);
            cumWeights = zeros(obj.numActions,1);
            
            cumWeights(1) = obj.weights(1)/totalWeight;            
            for i = 2:length(obj.weights)
                cumWeights(i) = cumWeights(i-1) + obj.weights(i)/totalWeight;%cumulation on probabilities
            end
            obj.action = 1+sum(cumWeights<rand); %find(any(cumWeights<=rand));
        end
            
        function obj = computeRegret(obj, lossVector)
            obj.algoPayoff = (lossVector*obj.weights)/sum(obj.weights);
            obj.minPayoff = min(lossVector);
            obj.regret = obj.regret + (obj.algoPayoff - obj.minPayoff);%Computes and updates the regret
        end
    end
    
end

