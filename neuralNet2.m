function [w1, w2, w3, w4] = neuralNet2(Attributes, Classifications)

n = .3;
nbrOfNodes1 = 10;
nbrOfNodes2 = 20;
nbrOfNodes3 = 5;
nbrOfEpochs = 1500;

% Initialize matrices with random weights 0-1
W1 = rand(nbrOfNodes1, length(Attributes(1,:)));
W2 = rand(nbrOfNodes2,nbrOfNodes1);
W3 = rand(nbrOfNodes3,nbrOfNodes2);
W4 = rand(length(Classifications(1,:)),nbrOfNodes3);
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
        H3 = f(W3*H2);
        O = f(W4*H3);

        % Output layer error
        delta_i = O.*(1-O).*(D-O);

        % Calculate error for each node in layer_(n-1)
        delta_j = H3.*(1-H3).*(W4.'*delta_i);
        delta_k = H2.*(1-H2).*(W3.'*delta_j);
        delta_l = H1.*(1-H1).*(W2.'*delta_k);
        
        % Adjust weights in matrices sequentially
        W4 = W4 + n.*delta_i*(H3.');
        W3 = W3 + n.*delta_j*(H2.');
        W2 = W2 + n.*delta_k*(H1.');
        W1 = W1 + n.*delta_l*(I.');
    end

    RMS_Err = 0;
  
    % Calculate RMS error
    for i=1:e(1)
        D = Classifications(i,:).';
        I = Attributes(i,:).';
        RMS_Err = RMS_Err + norm(D-f(W4*f(W3*f(W2*f(W1*I)))),2);
        
    end
    
    y = RMS_Err/e(1);
    
    plot(m,y,'*');
    w1=W1;
    w2=W2;
    w3=W3;
    w4=W4;
    
end


function x = f(x)
x = 1./(1+exp(-x));