function [w1,w2,w3] = neuralNet1(Attributes, Classifications)

n = .2;
nbrOfNodes1 = 15;
nbrOfNodes2 = 3;
nbrOfEpochs = 2500;

% Initialize matrices with random weights 0-1
W1 = rand(nbrOfNodes1, length(Attributes(1,:)));
W2 = rand(nbrOfNodes2,nbrOfNodes1);
W3 = rand(length(Classifications(1,:)),nbrOfNodes2);

m = 0; figure; hold on; e = size(Attributes);

while m < nbrOfEpochs

    % Increment loop counter
    m = m + 1;

    % Iterate through all examples
    for i=1:e(1)
        % Input data from current example set
        I = Attributes(i,:).';
        D = Classifications(i,:).';
       
        % Propagate the signals through network
        H1 = f(W1*I);
        H2 = f(W2*H1);
        O = f(W3*H2);

        % Output layer error
        delta_i = O.*(1-O).*(D-O);

        % Calculate error for each node in layer_(n-1)
        delta_j = H2.*(1-H2).*(W3.'*delta_i);
        delta_k = H1.*(1-H1).*(W2.'*delta_j);

        % Adjust weights in matrices sequentially
        W3 = W3 + n.*delta_i*(H2.');
        W2 = W2 + n.*delta_j*(H1.');
        W1 = W1 + n.*delta_k*(I.');
    end

    RMS_Err = 0;
    % Calculate RMS error
    for i=1:e(1)
        D = Classifications(i,:).';
        I = Attributes(i,:).';
        RMS_Err = RMS_Err + norm(D-f(W3*f(W2*f(W1*I))),2);
        
    end
    y = RMS_Err/e(1);
    plot(m,y,'*');
  
    w1=W1;
    w2=W2;
    w3=W3;
end


function x = f(x)
x = 1./(1+exp(-x));