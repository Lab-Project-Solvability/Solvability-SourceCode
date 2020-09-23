# https://towardsdatascience.com/lets-code-a-neural-network-in-plain-numpy-ae7e74410795

import numpy as np
import pandas as pd
from csv import reader

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


nn_architecture = [
    {"input_dim": 3, "output_dim": 4, "activation": "sigmoid"},
    {"input_dim": 4, "output_dim": 4, "activation": "sigmoid"},
    {"input_dim": 4, "output_dim": 1, "activation": "sigmoid"}]


def init_layers(nn_architecture, seed=36):  # 36 is the number of weights.
    np.random.seed(seed)
    number_of_layers = len(nn_architecture)
    params_values = {}

    for idx, layer in enumerate(nn_architecture):
        layer_idx = idx + 1
        layer_input_size = layer["input_dim"]
        layer_output_size = layer["output_dim"]
        params_values['W' + str(layer_idx)] = np.random.randn(
            layer_output_size, layer_input_size) * 0.1
        params_values['b' + str(layer_idx)] = np.random.randn(
            layer_output_size, 1) * 0.1      
    return params_values


def sigmoid(Z):
    return 1/(1+np.exp(-Z))


def sigmoid_backward(dA, Z):
    sig = sigmoid(Z)
    return dA * sig * (1 - sig)


def single_layer_forward_propagation(A_prev, W_curr, b_curr, activation="relu"):
    Z_curr = np.dot(W_curr, A_prev) + b_curr
    
    if activation == "relu":
        activation_func = relu
    elif activation == "sigmoid":
        activation_func = sigmoid
    else:
        raise Exception('Non-supported activation function')
        
    return activation_func(Z_curr), Z_curr


def full_forward_propagation(X, params_values, nn_architecture):
    memory = {}
    A_curr = X
    
    for idx, layer in enumerate(nn_architecture):
        layer_idx = idx + 1
        A_prev = A_curr
        
        activ_function_curr = layer["activation"]
        W_curr = params_values["W" + str(layer_idx)]
        b_curr = params_values["b" + str(layer_idx)]
        A_curr, Z_curr = single_layer_forward_propagation(A_prev, W_curr, b_curr, activ_function_curr)
        
        memory["A" + str(idx)] = A_prev
        memory["Z" + str(layer_idx)] = Z_curr
       
    return A_curr, memory


def get_cost_value(Y_hat, Y):
    m = Y_hat.shape[1]
    cost = -1 / m * (np.dot(Y, np.log(Y_hat).T) + np.dot(1 - Y, np.log(1 - Y_hat).T))
    return np.squeeze(cost)


def get_accuracy_value(Y_hat, Y):
    Y_hat_ = convert_prob_into_class(Y_hat)
    return (Y_hat_ == Y).all(axis=0).mean()


def single_layer_backward_propagation(dA_curr, W_curr, b_curr, Z_curr, A_prev, activation="relu"):
    m = A_prev.shape[1]
    
    if activation == "relu":
        backward_activation_func = relu_backward
    elif activation == "sigmoid":
        backward_activation_func = sigmoid_backward
    else:
        raise Exception('Non-supported activation function')
    
    dZ_curr = backward_activation_func(dA_curr, Z_curr)
    dW_curr = np.dot(dZ_curr, A_prev.T) / m
    db_curr = np.sum(dZ_curr, axis=1, keepdims=True) / m
    dA_prev = np.dot(W_curr.T, dZ_curr)

    return dA_prev, dW_curr, db_curr


def full_backward_propagation(Y_hat, Y, memory, params_values, nn_architecture):
    grads_values = {}
    m = Y.shape[1]
    Y = Y.reshape(Y_hat.shape)
   
    dA_prev = - (np.divide(Y, Y_hat) - np.divide(1 - Y, 1 - Y_hat));
    
    for layer_idx_prev, layer in reversed(list(enumerate(nn_architecture))):
        layer_idx_curr = layer_idx_prev + 1
        activ_function_curr = layer["activation"]
        
        dA_curr = dA_prev
        
        A_prev = memory["A" + str(layer_idx_prev)]
        Z_curr = memory["Z" + str(layer_idx_curr)]
        W_curr = params_values["W" + str(layer_idx_curr)]
        b_curr = params_values["b" + str(layer_idx_curr)]
        
        dA_prev, dW_curr, db_curr = single_layer_backward_propagation(
            dA_curr, W_curr, b_curr, Z_curr, A_prev, activ_function_curr)
        
        grads_values["dW" + str(layer_idx_curr)] = dW_curr
        grads_values["db" + str(layer_idx_curr)] = db_curr
    
    return grads_values


def update(params_values, grads_values, nn_architecture, learning_rate):
    for layer_idx, layer in enumerate(nn_architecture):
        params_values["W" + str(layer_idx)] -= learning_rate * grads_values["dW" + str(layer_idx)]        
        params_values["b" + str(layer_idx)] -= learning_rate * grads_values["db" + str(layer_idx)]

    return params_values


def train(X, Y, nn_architecture, epochs, learning_rate):
    params_values = init_layers(nn_architecture, 2)
    cost_history = []
    accuracy_history = []
    
    for i in range(epochs):
        Y_hat, cashe = full_forward_propagation(X, params_values, nn_architecture)
        cost = get_cost_value(Y_hat, Y)
        cost_history.append(cost)
        accuracy = get_accuracy_value(Y_hat, Y)
        accuracy_history.append(accuracy)
        
        grads_values = full_backward_propagation(Y_hat, Y, cashe, params_values, nn_architecture)
        params_values = update(params_values, grads_values, nn_architecture, learning_rate)
        
    return params_values, cost_history, accuracy_history

# Reading in data
filename = 'immanentTrainingData.csv'
dataset = loadCsv(filename)

data_frame = pd.read_csv(filename, sep =';')

# Convert columns with numbers from string to float
# Columns 2, 3, 4 and 5 have numbers. 
# Columns 2, 3 and 4 is the lenght, width and height of the object
# Column 5 contains the target volume
# Note that Python is 0-indexed
for x in range(1,5):
    strToFloat(dataset, x)

inputs = []
output = []
for row in dataset:
    inputs.append(row[1:4])
    output.append(row[4])

# Convert data to numpy arrays
inputs = np.array(inputs)
output  = np.array(output)

# # Reshape the data for the class functions
inputs = inputs.T
# output = output.reshape(1,-1)

#print(inputs.shape)
#print(output.shape)

column_input_1 = data_frame.iloc[:,1]
column_input_2 = data_frame.iloc[:,2]
column_input_3 = data_frame.iloc[:,3]
column_output = data_frame.iloc[:, 4]

input_data_frame = pd.DataFrame([column_input_1,column_input_2,column_input_3]).T

arr_input_1 = column_input_1.to_numpy()
arr_input_2 = column_input_2.to_numpy()
arr_input_3 = column_input_3.to_numpy()
arr_output = column_output.to_numpy()

input_array = [arr_input_1, arr_input_2, arr_input_3]


print(arr_output)

#argument_1, argument_2, argument_3 = train(input,output,nn_architecture,1000,0.5000)
 
# print(argument_1)
# print(argument_2)
# print(argument_3)
