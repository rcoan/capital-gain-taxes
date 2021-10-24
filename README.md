# Capital Gain Taxes
## Sumary
- [About the project](#about-the-project)
- [Setup](#setup)
- [Running](#running)
- [Exemples](#examples)
- [Architecture and decisions](#architecture-and-decisions)

## About the project
This project is the suggested exercise for Nubank's hiring process.

The goal is to calculate how much tax should be paid based on the profit or losses of the stock market investment.

There are several rules to decide if the operation should be taxed or not. Those rules are:
- No tax should be paid if the operation is a purchase.
- No tax should be paid if the stocks were sold with no profit (The price of each unit is equal to or less than the weighted average price of purchase)
- No tax should be paid if the operation generates no profit after deducting losses.
- No tax should be paid if the total amount of the operation falls below $20,000.00

Also, there are some rules to the overall transactions process:
- To determine the profit or loss you should use the weighted-average price of purchases as a base when selling.
- If a sell operation results in loss, the loss should be deducted from future profit.
- The tax is 20% of the profits.
- There will never be an operation selling more stocks that were bought.

The input expected is a JSON with an array of hashes with the following pattern
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
There are two ways to setup this project to run:
Note: If you have no familiarity of ruby, I recommend using docker.
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
capital_gain_taxes '[{"operation":"buy", "unit-cost":10, "quantity": 10000}, {"operation":"sell",
```

**IMPORTANT**: Note that in all examples the input json is passed as a String inside `'' ` to parse correctly the json.


## Examples
For the sake of facilitating the use and test, I'm leaving here some examples given with the exercise.

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


#### Case Bonus 1
Input:
```
'[ { "operation": "buy", "unit-cost": 100, "quantity": 1000 }, { "operation": "sell", "unit-cost": 80, "quantity": 250 }, { "operation": "sell", "unit-cost": 130, "quantity": 184 } ]'
```

Output:
```
[
  { "tax": 0 }, # No tax for buy
  { "tax": 0 }, # No tax for operation had loss
  { "tax": 104.0 } # Tax the total profi for 520 since it had profit, and previous losses should not affect the operation total
]
```

#### Case Bonus 2
Input:
```
'[ { "operation": "buy", "unit-cost": 50, "quantity": 1000 }, { "operation": "sell", "unit-cost": 55, "quantity": 300 }, { "operation": "sell", "unit-cost": 57, "quantity": 400 }, { "operation": "buy", "unit-cost": 30, "quantity": 2000 }, { "operation": "buy", "unit-cost": 27, "quantity": 1000 }, { "operation": "sell", "unit-cost": 50, "quantity": 3000 } ]'
```

Output:
```
[
  { "tax": 0 }, # No tax for buy
  { "tax": 0 }, # No tax for operation below 20k
  { "tax": 560.0 }, # Tax for the 2_800 profit
  { "tax": 0 }, # No tax for buy
  { "tax": 0 }, # No tax for buy
  { "tax": 11_454.545454545456 } # Tax the 57_272 profit
]
```


## Architecture and decisions
About the code decisions I made and why the patterns I've chosen
### Interactors
I use this pattern for some time now, since I read Clean Architecture (Uncle Bob),
it's similar to the structure of a Service object, but its purpose is a bit different:
It is used to contain a use case and orchestrate its flow, worrying as little as possible about how
to implement business rules and focus on what to do and in what order, letting the Service objects worry about **how**.

This project may be little, with only one use case, but the use of the interactor helps to separate responsibility and domains.
### Service objects
Just like the Interactors pattern, the Service Object has been one of my favorite patterns on my toolbox.

The objective is to create a class with single responsibility that screams its reason to exist, it also should be stateless.
Since the Service Object have online one public method, the method **call**, it's focused on how to do one thing,
and do it very well, receiving as much as possible as params.

Very often one service object uses others, from the "same level" or below, and acts a bit like an orchestrator and may be similar to the Interactor.
The difference is the semantics of each. In these cases, the service object should be a "How to" to be used in multiple interactors or service objects,
but the interactor represents a single-use case.
### Presenters
The purpose of using a presenter in this project is to remove from the interactor the "logic" of how to format
the response for the user. This helps to make the code cleaner and separate the responsibility,
since any change on how to show the info should not impact the use case or anything else.
### Models
In this case, I chose to have an entity to represent the context of multiple operations and their evolution through time.
The app could be done without it, but the representation of this context may fall into a confusing hash or array that has little meaning
and difficult understanding of the purpose of each part of the code.

### Validations
In order to validate the input operations I've decided to create methods within the models containing the validation rules.
I've opted to not implement independent validators since the rules were few and not much complex. But if they increase, probably would be the way to go.

All validations were made with emphasis to avoid possible errors caused by unprocessable data.
- The fields `unit-cost`, `quantity` and `operation` must be present.
- Unit-cost must not be negative.
- Quantity must not be negative.
- The operation must only be `buy` or `sell`

### Why a ruby and why a gem
I've been coding in Ruby for some years now, so it is the Lang I'm most familiar with, from there
was easy to make a gem since would be a nice-to-use solution for the command line as requested.
There were many gems I could have used, but I decided to go PORO (plain old ruby objects) since
everything I needed already exited in ruby core and there was no need to recreate the wheel.

There are, however, some things I gave up and tried to recreate from not using Elixir, which is a
functional Lang that I've some familiarity with but decided to go with the safer solution. Things like
pattern matching and head | tail functionality.
