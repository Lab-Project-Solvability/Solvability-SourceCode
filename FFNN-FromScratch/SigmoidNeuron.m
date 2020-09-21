classdef SigmoidNeuron
    
    properties
       b = 0;
    end
    
    methods
        function obj = SigmoidNeuron()
        end 
        
        function activation_fun = activate (weights, inputs)
            activation_fun = 0;
            for i = 1:len(weights)
                activation_fun =  activation + weights[i]*inputs[i];
            end
          
        end
        
        function transfer_val = transfer(activate)
             transfer_val = 1.0/(1.0 + exp(-1*activate));
        end
        
        function input_to = foward_propagate(G, row)
             input_to = row;
             
        end
        
    end 
    
end
