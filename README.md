# Multi-Layer Perceptron (MLP) with single neuron implementation

## Running instruction
I used modelsim free edition that can be downloaded [here](https://www.intel.com/content/www/us/en/software-kit/666221/intel-quartus-ii-web-edition-design-software-version-13-1-for-windows.html)

Simulation was conducted in ns.

## Simulation
### Simulation Setup
defined variables
- Number of Layer (M) is 3
- Number of Neuron each layer (N) is 3
- Fixed-point resolution 32 bit (12 integer part, 20 fractional part)
- Actication function is ReLu (will take only positive value, negative value will become 0)

#### Input data (X)
- X0 = 0.3
- X1 = 1.3
- X2 = 2.3

#### Weight data
Weight data is generated automatically for just simulate the calculation. W0 is used for weight bias, where the bias always 1. W1-Wn are used for weight input data.

##### Weight data for hidden layer
- W0_0 = 1
- W1_0 = 1.1
- W2_0 = 1.2
- W3_0 = 1.3
- W0_1 = 2
- W1_2 = 2.1
- W2_1 = 2.2
- W3_1 = 2.3
- W0_2 = 3
- W1_2 = 3.1
- W2_2 = 3.2
- W3_2 = 3.3

##### Weight data for output layer
- W0_0 = 11
- W1_0 = 11.1
- W2_0 = 11.2
- W3_0 = 11.3
- W0_1 = 12
- W1_2 = 12.1
- W2_1 = 12.2
- W3_1 = 12.3
- W0_2 = 13
- W1_2 = 13.1
- W2_2 = 13.2
- W3_2 = 13.3

### Simulation result

#### Output from Hidden layer
- H0 = 5.88
- H1 = 10.78
- H2 = 15.68

#### Output from Output layer
- O0 = 374.188
- O1 = 407.528
- O2 = 440.868

#### Simulation from modelsim waveform
![simulation_result](https://github.com/ihsanalhafiz/MLP_Single_Neuron/blob/main/Images/tb_mlp_single_simulation.png?raw=true)
 
 The simulation result is confirmed by manual calculation from excel file in directory above.
