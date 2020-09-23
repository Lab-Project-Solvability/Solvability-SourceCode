# The following code implements a Feedforward Neural Network (FNN) that uses Regressive Backpropagation to train
# The code is adapted from code written by Jason Brownlee on November 7, 2016 in Code Algorithms From Scratch
# and can be found at https://machinelearningmastery.com/implement-backpropagation-algorithm-scratch-python/
#

from math import exp
from random import seed
from random import random
from csv import reader

# Load the csv file
def loadCsv(filename):
	
	# dataset = pd.read_csv(filename)
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

# Convert strings to int
def strToInt(dataset, column):
	class_values = [row[column] for row in dataset]
	unique = set(class_values)
	lookup = dict()
	for i, value in enumerate(unique):
		lookup[value] = i
	for row in dataset:
		row[column] = lookup[row[column]]
	return lookup	

# Initialize a network
def initializeNetwork(numInputs, numHiddenLayers, numHiddenNodes, numOutputs):
	network = []
	hiddenLayer = []
	k = 0

	# Make a hidden layer numHidden times. Make a weight numInputs + 1 times
	while k < numHiddenLayers:
		hiddenLayer.append([{'weights':[random() for i in range(numInputs + 1)]} for i in range(numHiddenNodes)]) 	
		network.append(hiddenLayer[k])
		k += 1

   # Make weights  numHidden + 1 times for the output layers
	output_layer = [{'weights':[random() for i in range(numHiddenNodes + 1)]} for i in range(numOutputs)]
	network.append(output_layer)
	return network
 
# Calculate neuron activation for an input
def activate(weights, inputs):
    # Bias
	activation = weights[-1]
	# Add weight * weight to bias to get the activation of the node
	for i in range(len(weights)-1):
		activation += weights[i] * inputs[i]
	return activation
 
# Transfer neuron activation - Sigmoid Activation Function
def transfer(activation):
	return 1.0 / (1.0 + exp(-activation))
 
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
 
# Calculate the derivative of an neuron output
def transferDerivative(output):
	return output * (1.0 - output)
 
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
				errors.append(expected - neuron['output']) #expected[j]
		for j in range(len(layer)):
			neuron = layer[j]
			neuron['delta'] = errors[j] * transferDerivative(neuron['output'])
 
# Update network weights with error
def updateWeights(network, row, learningRate):
	for i in range(len(network)):
		inputs = row #row[:-1]
		if i != 0:
			inputs = [neuron['output'] for neuron in network[i - 1]]
		for neuron in network[i]:
			for j in range(len(inputs)):
				neuron['weights'][j] += learningRate * neuron['delta'] * inputs[j]
			neuron['weights'][-1] += learningRate * neuron['delta']
 
# WHY ARE WE CONVERTING TO INT BEFORE WE MULTIPLY
# Train a network for a fixed number of epochs
def trainNetwork(network, data, learningRate, numEpoch): #def trainNetwork(network, data, learningRate, numEpoch, numOutputs):
	for epoch in range(numEpoch):
		sumError = 0
		for row in data:
			# outputs from the NN
			outputs = forwardPropagate(network, row[1:4])
			outputs = outputs[0]
			
			# target volume
			expected = row[4] 
			
			#[0 for i in range(numOutputs)]
			# print('Row[-1]', row[-1])
			#expected[row[-1]] = 1
			sumError += pow((expected-outputs),2) #(expected-outputs)**2 #sum((expected - outputs)**2)
			backwardPropagateError(network, expected)
			updateWeights(network, row[1:4], learningRate)
		sumError = sumError/len(data)
		print('>epoch=%d, lrate=%.3f, error=%.3f' % (epoch, learningRate, sumError))
 
# Test training backprop algorithm
seed(1)
filename = 'immanentTrainingData.csv'
dataset = loadCsv(filename)

# Convert the data in columns 2 - 5 to a float
for x in range(1,5):
	strToFloat(dataset, x)

#strToInt(dataset, len(dataset[0])-1)

# Specify the NN architecture and other variables for NN training
numInputs = 3
numOutputs = 1
numHiddenLayers = 2
numNodesPerHiddenLayer = 4
learningRate = 0.5
numEpochs = 10

network = initializeNetwork(numInputs, numHiddenLayers, numNodesPerHiddenLayer, numOutputs)
print(network)
trainNetwork(network, dataset, learningRate, numEpochs) #trainNetwork(network, dataset, learningRate, numEpochs, numOutputs)
# for layer in network:
# 	print(layer)
