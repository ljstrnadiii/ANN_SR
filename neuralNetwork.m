% let attributes be a nxp matrix, classification be nxc

function m = neuralNetwork(attributes,classification)

% learning rate for gradient descent
n = 2.6; 
numEpochs=800;

% dim of attributes and classification
p = length(attributes(1,:));
c = length(classification(1,:));
n = length(attributes(:,1));

% array of node count for each unit. 
numNodes = [p, 4, c];

% prealllcate memory for cell for each weight matrix
%   and also each value after activation 'z'
w = cell(length(numNodes)-1,1);
z = cell(length(numNodes)-1,1);
delta = cell(length(numNodes)-1,1);

% initialize weight matrices in a cell. one weight matrix/layer
for i = 1:length(numNodes)-1
    w{i}=rand(numNodes(i+1),numNodes(i)); 
end

% Train and find Error on dataset, plot error over t
t=0;
figure; hold on;


while t < numEpochs
    
    t = t + 1;
    
    % Go through all examples
    for i = 1:n
        % grab data
        x = attributes(i,:)';
        c = classification(i,:)';
        
        % feed-forward through network
        z{1} = actFun(w{1}*x);
        for j = 2:length(z)
            z{j} = actFun(w{j}*z{j-1});
        end
        
        % Calculate delta errors: use backward recursion: "back-prop"
        delta{length(delta)} = dactFun(z{length(z)}).*(c-z{length(z)});
        for k = length(delta)-1:-1:1
            delta{k}=dactFun(z{k}).*(w{k+1}.'*delta{k+1});
        end

        % Impliment gradient Descent
        for l = length(w):-1:2
            w{l}=w{l} + n.*delta{l}*(z{l-1}.');
        end
        w{1} = w{1} + n.*delta{1}*(x.');
        
    end
    
    RMS = 0;
    
    % Calculate RMS 
    for i = 1:n
        x = attributes(i,:).';
        c = classification(i,:).';
        %RMS = RMS + norm(c-model(x,w),2);
        %RMS = RMS + norm(c-actFun(w{3}*actFun(w{2}*actFun(w{1}*x))),2);
        RMS = RMS + norm(c-actFun(w{2}*actFun(w{1}*x)),2);
    end
    
    y=RMS/n;
    plot(t,y^2,'*');
end


        