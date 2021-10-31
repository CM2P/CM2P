# CM2P Team submission

## Inspiration
Currently, there is no Swiss bank coin in place where investors can participate in even though the Swiss banking sector is known for its reliability and longevity. Trust in the Swiss financial system can only be shown by engaging with bank products or accounts. However, investors are interested in a decentral solution. This allows them a broader risk diversification as well as participating in a complete industry.

We created a proof of concept of a new stable coin that could be issued by Julius Bär Bank against deposits. This coin has a negative interest rate which transfers the coin money to the Swiss national bank.

## Try it!
IOS app https://appdistribution.firebase.dev/i/d59a7895bdb6e0d6

## What it does
We created

* a CHF-S a stable coin pegged to swiss francs on Algorand
* We publish real time data concerning CHF-S using Streamr, public link at https://streamr.network/streams/0x4ab637f2880fb13fd5d6817eb4ee6981e2002d40%2Fchfs-swiss-stable-coin (main ethereum account with 0 ETH so not persisted)

## How we built it
We use used Flutter-Flow and Google Flutter for our mobile app, all written in Dart, using Algorand Dart SDK

### The negative interest rate 
The calculation was done using Dart and Algorand explorer, it is supposed to run in backend server and move 0.75% CHF-S per year our of all CHF-S token holder.

### The real time Streamr 
use Algorand Explorer and Streamr Javascript SDK

We host an Algorand testnet node on AWS EC2 Virutal machine

## Challenges we ran into
One nasty bug in an unofficial Algorand SDK make us sweat :-) we learned that it is not ideal to use not supported SDK ;-)

## Accomplishments that we're proud of
We went from zero friday 20:00 to a lot of deliverables that make sense and we are proud of our work

## What we learned
Algorand blockchain, Streamr and some part of Casperlabs SDK

## What's next for SwiFi
Convince Julius Bär partner to move from a PoC to a prototype using Algorand.

Built With
* algorand
* dart
* flutter
* github
* javascript
* node.js
* streamr
# Try it out
* https://streamr.network/streams/0x4ab637f2880fb13fd5d6817eb4ee6981e2002d40%2Fchfs-swiss-stable-coin
* https://appdistribution.firebase.dev/i/d59a7895bdb6e0d6
* https://github.com/CM2P/CM2P/blob/main/SwiFi-Screens.pdf
