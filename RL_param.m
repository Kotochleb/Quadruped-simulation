useGPU = false;

%% Create the observation info
obsDim = 37;
observationInfo = rlNumericSpec([obsDim 1]);
observationInfo.Name = 'observations';

%% create the action info
actDim = 12;
actionInfo = rlNumericSpec([actDim 1],'LowerLimit',0,'UpperLimit', 2*pi);
actionInfo.Name = 'action';

%% Environment
mdl = 'quadruped';
load_system(mdl);
blk = [mdl,'/RL Agent'];
env = rlSimulinkEnv(mdl,blk,observationInfo,actionInfo);

%% CRITIC
% Create the critic network layers
criticLayerSizes = [256 256];
statePath = [
    imageInputLayer([obsDim 1 1],'Normalization','none','Name', 'observation')
    fullyConnectedLayer(criticLayerSizes(1), 'Name', 'CriticStateFC1', ... 
            'Weights',2/sqrt(obsDim)*(rand(criticLayerSizes(1),obsDim)-0.5), ...
            'Bias',2/sqrt(obsDim)*(rand(criticLayerSizes(1),1)-0.5))
    leakyReluLayer('Name','CriticStateLRelu1', 'Scale', 0.01)
    fullyConnectedLayer(criticLayerSizes(2), 'Name', 'CriticStateFC2', ...
            'Weights',2/sqrt(criticLayerSizes(1))*(rand(criticLayerSizes(2),criticLayerSizes(1))-0.5), ... 
            'Bias',2/sqrt(criticLayerSizes(1))*(rand(criticLayerSizes(2),1)-0.5))
    ];
actionPath = [
    imageInputLayer([actDim 1 1],'Normalization','none', 'Name', 'action')
    fullyConnectedLayer(criticLayerSizes(2), 'Name', 'CriticActionFC1', ...
            'Weights',2/sqrt(actDim)*(rand(criticLayerSizes(2),actDim)-0.5), ... 
            'Bias',2/sqrt(actDim)*(rand(criticLayerSizes(2),1)-0.5))
    ];
commonPath = [
    additionLayer(2,'Name','add')
    leakyReluLayer('Name','CriticCommonLRelu1', 'Scale', 0.01)
    fullyConnectedLayer(1, 'Name', 'CriticOutput',...
            'Weights',2*5e-3*(rand(1,criticLayerSizes(2))-0.5), ...
            'Bias',2*5e-3*(rand(1,1)-0.5))
    ];

% Connect the layer graph
criticNetwork = layerGraph(statePath);
criticNetwork = addLayers(criticNetwork, actionPath);
criticNetwork = addLayers(criticNetwork, commonPath);
criticNetwork = connectLayers(criticNetwork,'CriticStateFC2','add/in1');
criticNetwork = connectLayers(criticNetwork,'CriticActionFC1','add/in2');

% Create critic representation
criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3, ... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4);
if useGPU
   criticOptions.UseDevice = 'gpu'; 
end

critic = rlRepresentation(criticNetwork,criticOptions, ...
                          'Observation',{'observation'},env.getObservationInfo, ...
                          'Action',{'action'},env.getActionInfo);

%% ACTOR
% Create the actor network layers
actorLayerSizes = [256 256];
actorNetwork = [
    imageInputLayer([obsDim 1 1],'Normalization','none','Name','observation')
    fullyConnectedLayer(actorLayerSizes(1), 'Name', 'ActorFC1', ...
            'Weights',2/sqrt(obsDim)*(rand(actorLayerSizes(1),obsDim)-0.5), ... 
            'Bias',2/sqrt(obsDim)*(rand(actorLayerSizes(1),1)-0.5))
    leakyReluLayer('Name', 'ActorLRelu1')
    fullyConnectedLayer(actorLayerSizes(2), 'Name', 'ActorFC2', ... 
            'Weights',2/sqrt(actorLayerSizes(1))*(rand(actorLayerSizes(2),actorLayerSizes(1))-0.5), ... 
            'Bias',2/sqrt(actorLayerSizes(1))*(rand(actorLayerSizes(2),1)-0.5))
    leakyReluLayer('Name', 'ActorRelu2')
    fullyConnectedLayer(actDim, 'Name', 'ActorFC3', ... 
            'Weights',2*5e-3*(rand(actDim,actorLayerSizes(2))-0.5), ... 
            'Bias',2*5e-3*(rand(actDim,1)-0.5))                       
    tanhLayer('Name','ActorTanh1')
    scalingLayer('Name', 'ActorScaledActions', 'Scale', pi/2, 'Bias', 0)
    ];

% Create actor representation
actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-4, ...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5);
if useGPU
   actorOptions.UseDevice = 'gpu'; 
end
actor = rlRepresentation(actorNetwork,actorOptions, ... 
                         'Observation',{'observation'},env.getObservationInfo, ...
                         'Action',{'ActorScaledActions'},env.getActionInfo);
%% AGENT
agentObj = rlDDPGAgent(actor,critic,agentOptions);
%% TRAIN                    
trainingResults = train(agentObj,env,trainingOptions)
