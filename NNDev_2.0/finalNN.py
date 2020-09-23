# The following code is adapted from code written by Samay Shamdasani on Aug 7, 2017 and is available 
# at: https://dev.to/shamdasani/build-a-flexible-neural-network-with-backpropagation-in-python


from csv import reader
import numpy as np

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

class Neural_Network(object):
  def __init__(self):
    #default parameters
    self.inputSize = 3
    self.outputSize = 1
    self.hiddenSize = 2
    self.hiddenNodes = 4
    
    #weights
    #rows x columns
    self.W1 = np.random.randn(self.inputSize, self.hiddenNodes) # (3x4) weight matrix from input to hidden layer
    self.W2 = np.random.randn(self.hiddenNodes, self.hiddenNodes) # (4x4) weight matric from hidden to hidden
    self.W3 = np.random.randn(self.hiddenNodes, self.outputSize) # (4x1) weight matrix from hidden to output layer

  def forward(self, x):
    #forward propagation through our network
    self.z1 = np.dot(x, self.W1) # dot product of x (input) and first set of 3x4 weights
    self.z2 = self.sigmoid(self.z1) # activation function
    self.z3 = np.dot(self.z2, self.W2) # dot product of hidden layer (z2) and second set of 4x4 weights
    self.z4 = self.sigmoid(self.z3) # activation function
    self.z5 = np.dot(self.z4, self.W3) # dot product of hidden layer (z4) and second set of 4x1 weights
    o = self.sigmoid(self.z5) # final activation function which results in the output
    return o 

  def sigmoid(self, s):
    # activation function 
    return 1/(1+np.exp(-s))

  def sigmoidPrime(self, s):
    #derivative of sigmoid
    return s * (1 - s)

  def backward(self, x, y, o):
        # backward propgate through the network
    self.o_error = y - o # error in output
    self.o_delta = self.o_error*self.sigmoidPrime(o) # applying derivative of sigmoid to error

    self.z4_error = self.o_delta.dot(self.W3.T) # z4 error: how much our hidden layer weights contributed to output error
    self.z4_delta = self.z4_error*self.sigmoidPrime(self.z4) # applying derivative of sigmoid to z4 error

    self.z2_error = self.z4_delta.dot(self.W2.T) # z2 error: how much our hidden layer weights contributed to output error
    self.z2_delta = self.z2_error*self.sigmoidPrime(self.z2) # applying derivative of sigmoid to z2 error

    self.W1 += x.T.dot(self.z2_delta) # adjusting first set (input --> hidden) weights
    self.W2 += self.z2.T.dot(self.z4_delta) # adjusting second set (hidden --> hidden) weights
    self.W3 += self.z4.T.dot(self.o_delta) # adjusting second set (hidden --> output) weights
    
  def train (self, x, y):
    o = self.forward(x)
    self.backward(x, y, o)

  def setParam(self, numInputs, numOutputs, numHiddenLayer, numHiddenNodes):
    self.inputSize = numInputs
    self.outputSize = numOutputs
    self.hiddenSize = numHiddenLayer
    self.hiddenNodes = numHiddenNodes

# Data

# Read in and modify the data
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

# Access the input and target volume columns
inputs = []
targetVolumes = []
for row in dataset:
    inputs.append(row[1:4])
    targetVolumes.append(row[4])

# Transform the dataset
# Convert data to numpy arrays
# 2000 x 3
inputs = np.array(inputs, dtype=float )
# 2000 x 1
targetVolumes  = np.array(targetVolumes, dtype=float)

# Transpose the data for the class functions
# Make inputs 3 x 2000
x = inputs
# Make output 2000 x 1
y = targetVolumes.reshape(-1,1)

# scale units
x = x/10000 #np.amax(x, axis=0) # maximum of x array
y = y/10000 #np.amax(y, axis=0) # maximum of y array

NN = Neural_Network()

# Set values for NN training and architecture
numEpochs = 500
numIn = 3
numOut = 1
numHiddenLayers = 2
numHiddenNodes = 4

NN.setParam(numIn,numOut,numHiddenLayers,numHiddenNodes)
for i in range(numEpochs): # trains the NN numEpoch times
    print ('Input:', x) 
    print ('Actual Output:', y)
    print ('Predicted Output:', NN.forward(x)) 
    print('Loss:', np.mean(np.square(y - NN.forward(x)))) 
    print('Epoch:', i)
    NN.train(x, y)
