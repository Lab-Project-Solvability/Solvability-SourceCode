from csv import reader
from random import seed
from random import random
from math import exp

# Read in the dataset
def loadCsv(filename):
    dataset = list()
    with open(filename, 'r') as file:
        csvReader = reader(file, delimiter=';')
        for row in csvReader:
            if not row:
                continue
            dataset.append(row)
    return dataset

# Convert strings to float
def strToFloat(dataset, column):
    for row in dataset:
        row[column] = float(row[column].strip())    

# Initialise the network
def initializeNetwork(numInputs, numHiddenLayers, numHiddenNodes, numOutputs):
    network = list()
    hiddenLayers = list()
    k = 0
    while k < numHiddenLayers:
        hiddenLayers.append([{'weights':[random() for i in range(numInputs + 1)]} for i in range(numHiddenNodes)]) 
        network.append(hiddenLayers[k])
        k += 1

    outputLayer = [{'weights':[random() for i in range(numHiddenNodes + 1)]} for i in range(numOutputs)]
    network.append(outputLayer)
    return network

# Calculate neuron activation for an input
def activate(weights, inputs):
    activation = weights[-1]
    for i in range(len(weights)-1):
        activation += weights[i] * inputs[i]
    return activation
 
# Transfer neuron activation via sigmoid activation function
def transfer(activation):
    return 1.0 / (1.0 + exp(-activation))
    
# Calculate the derivative of an neuron output
def transferDerivative(output):
    return output * (1.0 - output)

# Update network weights with error
def updateWeights(network, row, l_rate):
    for i in range(len(network)):
        inputs = row
        if i != 0:
            inputs = [neuron['output'] for neuron in network[i - 1]]
        for neuron in network[i]:
            for j in range(len(inputs)):
                neuron['weights'][j] += l_rate * neuron['delta'] * inputs[j]
            neuron['weights'][-1] += l_rate * neuron['delta']

# Backpropagate error and store in neurons
def backwardPropagateError(network, expected):
    for i in reversed(range(len(network))):
        layer = network[i]
        errors = list()
        if i != len(network)-1:
            for j in range(len(layer)):
                error = 0.0
                for neuron in network[i + 1]:
                    error += (neuron['weights'][j] * neuron['delta'])
                errors.append(error)
        else:
            for j in range(len(layer)):
                neuron = layer[j]
                errors.append(expected - neuron['output'])
        for j in range(len(layer)):
            neuron = layer[j]
            # Gradient Descent
            neuron['delta'] = errors[j] * transferDerivative(neuron['output'])

# Forward propagate input to a network output
def forwardPropagate(network, row):
    inputs = row
    for layer in network:
        new_inputs = []
        for neuron in layer:
            activation = activate(neuron['weights'], inputs)
            neuron['output'] = transfer(activation)
            new_inputs.append(neuron['output'])
        inputs = new_inputs
    return inputs

# Train a network for a fixed number of epochs
def trainNetwork(network, data, l_rate, n_epoch, n_outputs):
    for epoch in range(n_epoch):
        sum_error = 0
        for row in data:
            input = row[1:4]
            outputs = forwardPropagate(network, input)
            outputs = outputs[0]
            expected = row[4]
            sum_error += (expected - outputs)**2
            backwardPropagateError(network, expected)
            updateWeights(network, input, l_rate)
        # Get the mean squared error
        sum_error = sum_error/len(data)
        print('>epoch=%d, lrate=%.3f, error=%.3f' % (epoch, l_rate, sum_error))

# Access the dataset
filename = 'immanentTrainingData.csv'
dataset = loadCsv(filename)

# Convert columns with numbers from string to float
# Columns 2, 3, 4 and 5 have numbers. 
# Columns 2, 3 and 4 is the lenght, width and height of the object
# Column 5 contains the target volume
# Note that Python is 0-indexed
for x in range(1,5):
    strToFloat(dataset, x)

# NN development

# State architectural requirements
numInputs = 3
numOutputs = 1
numHiddenLayers = 2
numHiddenNodesPerLayer = 4
learnRate = 0.2
numEpochs = 500

# Intialise the NN
seed(1)
network = initializeNetwork(numInputs, numHiddenLayers, numHiddenNodesPerLayer, numOutputs)
# Train the NN
trainNetwork(network, dataset, learnRate,numEpochs, numOutputs)
# Print the NN
for layer in network:
    print(layer)