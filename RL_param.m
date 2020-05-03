useGPU = true;

%% Create the observation info
obsDim = 37;
observationInfo = rlNumericSpec([obsDim 1]);
observationInfo.Name = 'observations';

%% create the action info
actDim = 12;
%actDimFlat = 12;
actionInfo = rlNumericSpec([actDim 1], 'LowerLimit', -pi, 'UpperLimit', pi);
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
    %flattenLayer('Name', 'FlattenObservationWTF')
    fullyConnectedLayer(criticLayerSizes(1), 'Name', 'CriticStateFC1')
    leakyReluLayer('Name','CriticStateLRelu1', 'Scale', 0.01)
    fullyConnectedLayer(criticLayerSizes(2), 'Name', 'CriticStateFC2')
    ];
actionPath = [
    imageInputLayer([actDim 1 1],'Normalization','none', 'Name', 'action')
    %flattenLayer('Name', 'FlattenAction')
    fullyConnectedLayer(criticLayerSizes(2), 'Name', 'CriticActionFC1')
    ];
commonPath = [
    additionLayer(2,'Name','add')
    leakyReluLayer('Name','CriticCommonLRelu1', 'Scale', 0.01)
    fullyConnectedLayer(1, 'Name', 'CriticOutput')
    ];

% Connect the layer graph
criticNetwork = layerGraph(statePath);
criticNetwork = addLayers(criticNetwork, actionPath);
criticNetwork = addLayers(criticNetwork, commonPath);
criticNetwork = connectLayers(criticNetwork,'CriticStateFC2','add/in1');
criticNetwork = connectLayers(criticNetwork,'CriticActionFC1','add/in2');

%analyzeNetwork(criticNetwork)

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
<<<<<<< HEAD
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
=======
actorLayerSizes = [64 64];

hipNetwork = [
    fullyConnectedLayer(actorLayerSizes(1), 'Name', 'HipActorFC1')
    leakyReluLayer('Name', 'HipActorLRelu1')
    fullyConnectedLayer(actorLayerSizes(2), 'Name', 'HipActorFC2')
    leakyReluLayer('Name', 'HipActorLRelu2')
    fullyConnectedLayer(4, 'Name', 'HipActorFC3')                       
    tanhLayer('Name','HipActorTanh')
    scalingLayer('Name', 'HipActorRescaledActions', 'Scale', pi/4, 'Bias', 0)
];

legNetwork = [
    fullyConnectedLayer(actorLayerSizes(1), 'Name', 'LegActorFC1')
    leakyReluLayer('Name', 'LegActorLRelu1')
    fullyConnectedLayer(actorLayerSizes(2), 'Name', 'LegActorFC2')
    leakyReluLayer('Name', 'LegActorLRelu2')
    fullyConnectedLayer(4, 'Name', 'LegActorFC3')                       
    tanhLayer('Name','LegActorTanh')
    scalingLayer('Name', 'LegActorRescaledActions', 'Scale', pi/3, 'Bias', 0) % [-pi/3 pi/3]
];

kneeNetwork = [
    fullyConnectedLayer(actorLayerSizes(1), 'Name', 'KneeActorFC1')
    leakyReluLayer('Name', 'KneeActorLRelu1')
    fullyConnectedLayer(actorLayerSizes(2), 'Name', 'KneeActorFC2')
    leakyReluLayer('Name', 'KneeActorLRelu2')
    fullyConnectedLayer(4, 'Name', 'KneeActorFC3')                       
    tanhLayer('Name','KneeActorTanh')
    scalingLayer('Name', 'KneeActorRescaledActions', 'Scale', 3*pi/8, 'Bias', 3*pi/8) % [0 3pi/4]
];

obsInput = imageInputLayer([obsDim 1 1],'Normalization','none','Name','observation');
concat = concatenationLayer(3, 3, "Name", "Actions");

%stack layers

actorNetwork = layerGraph();
actorNetwork = addLayers(actorNetwork, obsInput);
actorNetwork = addLayers(actorNetwork, kneeNetwork);
actorNetwork = addLayers(actorNetwork, legNetwork);
actorNetwork = addLayers(actorNetwork, hipNetwork);
actorNetwork = addLayers(actorNetwork, concat);

%connect layers
actorNetwork = connectLayers(actorNetwork, "observation", "KneeActorFC1");
actorNetwork = connectLayers(actorNetwork, "observation", "LegActorFC1");
actorNetwork = connectLayers(actorNetwork, "observation", "HipActorFC1");
actorNetwork = connectLayers(actorNetwork, "KneeActorRescaledActions","Actions/in1");
actorNetwork = connectLayers(actorNetwork, "LegActorRescaledActions","Actions/in2");
actorNetwork = connectLayers(actorNetwork, "HipActorRescaledActions","Actions/in3");

%analyzeNetwork(actorNetwork)
%env.getActionInfo

% Create actor representation
actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-4, ...
                                       'GradientThreshold',pi,'L2RegularizationFactor',1e-5);
if useGPU
   actorOptions.UseDevice = 'gpu'; 
end
actor = rlRepresentation(actorNetwork,actorOptions, ... 
                         'Observation',{'observation'},env.getObservationInfo, ...
                         'Action',{'Actions'},env.getActionInfo);

%% AGENT
agentObj = rlDDPGAgent(actor,critic,agentOptions);
%% TRAIN                    
trainingResults = train(agentObj,env,trainingOptions)