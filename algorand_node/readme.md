# Algorand node installation

# Useful commands
```
sudo systemctl start algorand
sudo systemctl stop algorand
goal node status -d /var/lib/algorand_testnet
```
SSH access and installation
```
ssh -i "~/.ssh/ee-default-keypair.pem" ubuntu@ec2-54-93-225-56.eu-central-1.compute.amazonaws.com
```

getting token https://bank.testnet.algorand.network

## getting Algorand API token

To connect from SDK or REST we need to know the network address and authorization token. This are stored in:
```
cat $ALGORAND_DATA/algod.net
cat $ALGORAND_DATA/algod.token
```

## AWS credentials
```
Event: Swiss Blockchain Hackathon 2021
Team Name: CM2P
Event ID: 4952f1ff0ce149e4a9db892487c52914

Team ID: 1bbc6b7402bd4af0b00adbce6e7ad489
```
Remember to only use "eu-central-1" as your region, unless otherwise directed by the event operator.

logging link: see CM2P-keepass.kdbx file in google drive

## Setting up Algorand

Participation nodes are running the Algorand consensus protocol, and communicate with each other through relay nodes. Authorized by the user’s participation key, these nodes propose and vote on blocks on behalf of the user’s stake within the consensus algorithm. A single participation node may represent multiple users, provided the appropriate participation keys are installed in it. Anyone can run a participation node, and everyone is encouraged to do so. Participation nodes ensure the security of the Algorand blockchain: As long as enough of them run the consensus protocol honestly, the blockchain is guaranteed to never fork, even if all the relay nodes are compromised.

### Node size recommended
* 4-8GB RAM
* 100GB SSD
* 10Mbit broadband

we will use a t2.large: 2vcpu, 8GB ram, 500GB disk

-> our instance https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#Instances:search=i-07f6e27e0231f4271

ee-default-keypair.pem see CM2P-keepass.kdbx file in google drive

### Installation
```
sudo apt-get update
sudo apt-get install -y gnupg2 curl software-properties-common
curl -O https://releases.algorand.com/key.pub
sudo apt-key add key.pub
sudo add-apt-repository "deb [arch=amd64] https://releases.algorand.com/deb/ stable main"
sudo apt-get update

# To get both algorand and the devtools:
sudo apt-get install -y algorand-devtools

# Or, to only install algorand:
sudo apt-get install -y algorand

# dont start it yet

```
switch to testnet with
```
ALGORAND_DATA=/var/lib/algorand_testnet
sudo mkdir -p ${ALGORAND_DATA}
sudo cp -p /var/lib/algorand/genesis/testnet/genesis.json ${ALGORAND_DATA}/genesis.json
sudo cp -p /var/lib/algorand/system.json ${ALGORAND_DATA}/system.json
sudo chown -R algorand ${ALGORAND_DATA}
```

# Links
* AWS console https://eu-central-1.console.aws.amazon.com/ec2/v2/home?region=eu-central-1#InstanceDetails:instanceId=i-07f6e27e0231f4271
* https://developer.algorand.org/docs/run-a-node/setup/install/
* https://developer.algorand.org/docs/run-a-node/operations/switch_networks/

# Ideas
https://about.algodex.com/


