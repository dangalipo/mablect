# Mable Code Test

## Problem statement
The problem statement can be found [here](docs/mable_be_code_test.pdf)

## Assumptions
- Transfer amount will be always positive
- All account in the transfers csv document will be in the accounts csv
- If either the above occur or a transaction would leave an account in negative the sytem should immediately exit alerting the user to the error
- The result of running the service should be output as a csv in the same format as the accounts csv

## Requirements
- Ruby 3.2.2

## Setup 

Run the following commands

`bundle`

## Running the System
You can run the system with the sample files using the following command:

`ruby lib/transaction_processor_runner.rb examples/mable_acc_balance.csv examples/mable_trans.csv` 
