# Capital Gain Taxes
## Sumary
- [About the project](#about-the-project)
- [Setup](#setup)
- [Running](#running)
- [Exemples](#examples)
- [Architecture and decisions](#architecture-and-decisions)

## About the project
This project is the suggested exercise for Nubank's hiring process.

The goal is to calculate how much tax should be paid based on the profit or losses of stock  market investment.

There are several rules to decide if the operation should be taxed or not. Those rules are:
- No tax should be paid if the operation is a purchase.
- No tax should be paid if the stocks were sold with no profit (The price of each unit is equal or less than the weighted average price of purchase)
- No tax should be paid if the operation generates no profit after deducting losses.
- No tax should be paid if the total amount of the operation falls below $20,000.00

Also, there are some rules to the overall transactions process:
- To determine the profit or loss you should use the weighted-average price of purchases as a base when selling.
- If a sell operation result in loss, the loss should be deducted from future profit.
- The tax is 20% of the profits.
- There will never be an operation selling more stocks that were bought.

The input expected is a JSON with an array of hashs with the following pattern
e.g.
```json
[
  {
    "operation":"buy",
    "unit-cost":10,
    "quantity":10000
  },
  {
    "operation":"sell",
    "unit-cost":20,
    "quantity":5000
  }
]
```
And the output is a JSON with the same size containing the tax to pay in each operation.
e.g.
```json
[
  {
    "tax":0
  },
  {
    "tax":10000
  }
]
```

## Setup
There are two ways to setup this project in order to run:
I recommend using docker.
### Docker
If you want to have the commodity of running with docker, all you need to do is run inside the project folder.
```
docker build -t capital-gain-taxes .
```
### Native setup
To run natively in your terminal, you need to install ruby version 2.6.4 or higher.
Since this is something very documented already, I'm leaving a link with the tutorial on how to: [https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/)

Once you have ruby installed in your terminal, you may enter the project folder and run the following commands:
```
bundle install
gem build capital-gain-taxes.gemspec && gem install ./capital-gain-taxes-0.0.1.gem
```

And then you're good to go.
## Running

### Native run
If you have the gem installed in your terminal, all you have to do is run the following command
```bash
capital_gain_taxes '[{"operation":"buy", "unit-cost":10, "quantity": 10000}, {"operation":"sell",
"unit-cost":20, "quantity": 5000}]'
```

### Docker
If you are running on docker, you have two options:
Run directly from  you terminal
```bash
docker run -it capital-gain-taxes capital_gain_taxes '[{"operation":"buy", "unit-cost":10, "quantity": 10000}, {"operation":"sell",
"unit-cost":20, "quantity": 5000}]'
```
Or to connect to the image iteractive terminal and run from there
```bash
docker run -it capital-gain-taxes bash
> capital_gain_taxes '[{"operation":"buy", "unit-cost":10, "quantity": 10000}, {"operation":"sell",
```

**IMPORTANT**: Note that in all exemples the input json is passed as a String inside `'' ` in order to parse correctly the json.


## Exemples
For the sake of faciliting the use and test, I'm leaving here some exemples given with the exercise.

#### Case 1
Input:
```
'[{"operation": "buy", "unit-cost": 10, "quantity": 100}, {"operation": "sell", "unit-cost": 15, "quantity": 50}, {"operation": "sell", "unit-cost": 15, "quantity": 50}]'
```
Output:
```
["tax": 0}, "tax": 0}, "tax": 0}]
```

#### Case 2
Input:
```
'[{"operation": "buy", "unit-cost": 10, "quantity": 10000}, {"operation": "sell", "unit-cost": 20, "quantity": 5000}, {"operation": "sell", "unit-cost": 5, "quantity": 5000}]'
```

Output:
```
["tax": 0}, "tax": 10000.0}, "tax": 0}]
```

#### Case 3
Input:
```
'[{"operation": "buy", "unit-cost": 10, "quantity": 10000}, {"operation": "sell", "unit-cost": 5, "quantity": 5000}, {"operation": "sell", "unit-cost": 20, "quantity": 5000}]'
```

Output:
```
["tax": 0}, "tax": 0}, "tax": 5000.0}]

```
#### Case 4
Input:
```
'[{"operation": "buy", "unit-cost": 10, "quantity": 10000}, {"operation": "buy", "unit-cost": 25, "quantity": 5000}, {"operation": "sell", "unit-cost": 15, "quantity": 10000}]'
```

Output:
```
["tax": 0}, "tax": 0}, "tax": 0}]
```
#### Case 5
Input:
```
'[{"operation": "buy", "unit-cost": 10, "quantity": 10000}, {"operation": "buy", "unit-cost": 25, "quantity": 5000}, {"operation": "sell", "unit-cost": 15, "quantity": 10000}, {"operation": "sell", "unit-cost": 25, "quantity": 5000}]'
```

Output:
```
["tax": 0}, "tax": 0}, "tax": 0}, "tax": 10000.0}]
```
#### Case 6
Input:
```
'[{"operation": "buy", "unit-cost": 10, "quantity": 10000}, {"operation": "sell", "unit-cost": 2, "quantity": 5000}, {"operation": "sell", "unit-cost": 20, "quantity": 2000}, {"operation": "sell", "unit-cost": 20, "quantity": 2000}, {"operation": "sell", "unit-cost": 25, "quantity": 1000}]'
```

Output:
```
["tax": 0}, "tax": 0}, "tax": 0}, "tax": 0}, "tax": 3000.0}]
```


#### Case Bonus
Input:
```
```

Output:
```
```


## Archtecture and decisions


















