# Token Design

CHFC (CHFC) is a digital stablecoin that is pegged to the Swiss franc and run on Algorand

CHFC Coin should be managed by a consortium of swiss banks

This consortium claims that each CHFC is backed by Swiss francs held in reserve
The tokenization of the Swiss franc happens in a three-step process:

* A user commit to convert a part or its whole account balance held in Swiss franc. 
* The bank issuer uses a create the equivalent amount of CHFC Coin. 
* The newly minted CHF Coins are sent to the user and the substituted Swiss franc are held in a reserve. 
* The redemption of CHF Coins for Swiss franc follows the process listed above but in reverse.

# Regulation framework implemented

## Minter manager (Swiss National Bank)
SNB Swiss national bank is the sole owner of Swiss franc. 
* SNB has the possibility to Onboard Swiss bank so each Swiss bank can mint new tokens
* SNB has the possibility to define the allowance of each Swiss bank (how much token each bank can mint which is equal to the amount of Swiss franc this bank hold in reserve)
SNB is having an algorand account that can managed minter

## Minter (commercial banks)
Julius Bär, UBS, Credit Suisse are "minters" - create and destroy CHF Coin

Each minter has a mintingAllowance, which SNB configures. 
The mintingAllowance is how many tokens that minter may issue, and as a minter issues tokens,
its mintingAllowance declines. SNB will periodically reset the mintingAllowance as long as 
a minter maintains adequate reserves for the tokens it has issued. 
The mintingAllowance is to limit the damage if any particular minter is compromised.

### Minter have the possibility to freeze an account
We use the “freeze” address is the account responsible for freezing the distribution of the token, so that no one can access it.

### Minter have the possibility to 

# Implementing negative interest rate
Negative interest rates are a form of monetary policy that sees interest rates fall below 0%. 
Central banks and regulators use this unusual policy tool when there are strong signs of deflation.

We model the negative interest rate of -0.75% by leveraging the clawback algorand functionnality 

the asset/token from another account. 






* Creator: SNB account adress
* AssetName: CHF stable coin
* UnitName: CHFC
* Total: 1000 000 or any number close to the real number of swiss franc in circulation
* Decimals: 2  – this parameter determines the number of digits to be used after the decimal point.
* DefaultFrozen (required) – true to freeze holdings for this asset by default.
* URL: https://www.snb.ch/CHFC
* MetaDataHash (optional) – while this parameter is optional for ASAs in general, it is recommended for tokenized assets.
* This field is an up to 32-byte hash of some metadata that is relevant to your tokenized asset and/or asset holders.
* Note that this field can only be specified upon creation.
* For instance, you can use MetaDataHash to represent the hash of some certificate that stipulates 
* the digitized asset is the representation of a certain real-world asset.

Manager Address = SNB minter manager account. It is the only one that can authorize transactions to modify or destroy an asset.
Reserve Address = SNB minter manager non-minted assets can reside in an account holding the reserve address instead of the default creator account.
Freeze Address = the freeze account can freeze or unfreeze the asset holdings for a given account. If an account is frozen, it cannot send or receive the asset. This option can be used to investigate criminal activity, for example.
Clawback Address – the clawback account is able to transfer assets from and to any asset holder. This option can be used to revoke assets from an account that breaches certain contractual obligations.