%Intialize network
%3 input neurons, 2 hidden layers (with 4 neurons each), one output neuron.
 G = digraph;

function createNodes
  
   
   % Add 12 nodes inside the graph.
   
   for i = 1:12
       obj = SigmoidNeuron();
       
       G = addnode(G, obj);
       
   end 
  G.Nodes.Name = {'x_1' 'x_2' 'x_3' 'h1' 'h_2' 'h_3' 'h_4' 'h_5' 'h_6' 'h_7' 'h_8' 'o_1'}'; 

end 


function createEdges_1
        G = addedge(G, {'x_1'}, {'h_1' 'h_2' 'h_3' 'h4'}, [1 1 1 1]);
        G = addedge(G, {'x_2'}, {'h_1' 'h_2' 'h_3' 'h4'}, [1 1 1 1]);
        G = addedge(G, {'x_3'}, {'h_1' 'h_2' 'h_3' 'h4'}, [1 1 1 1]);   
end

function createEdges_2
       G = addedge(G, {'h_1'}, {'h_5' 'h_6' 'h_7' 'h8'}, [1 1 1 1]);
       G = addedge(G, {'h_2'}, {'h_5' 'h_6' 'h_7' 'h8'}, [1 1 1 1]);
       G = addedge(G, {'h_3'}, {'h_5' 'h_6' 'h_7' 'h8'}, [1 1 1 1]);
       G = addedge(G, {'h_4'}, {'h_5' 'h_6' 'h_7' 'h8'}, [1 1 1 1]);

end


function createEdges_3 
     G = addedge(G, {'h_5'}, {'o_1'});
     G = addedge(G, {'h_6'}, {'o_1'});
     G = addedge(G, {'h_7'}, {'o_1'});
     G = addedge(G, {'h_8'}, {'o_1'});
end

function createNetwork
   createNodes();
   createEdges_1();
   createEdges_2();
   createEdges_3();
end

