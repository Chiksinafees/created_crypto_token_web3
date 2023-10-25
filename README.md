# Check your Balance

1. First find principal id , use

```
dfx identity get-principal
```

2. save it somewhere

eg. my id : xevzc-zvwds-xausy-2z2hh-4fftx-ckm32-pjxvj-bkoqf-57xg5-nl6jb-lae

3. Format and store it in a command line variable:

   ```
    OWNER_PUBLIC_KEY="principal \"$( \dfx identity get-principal )\""

   ```

4. Check that step 3 worked by printing it out: it format exactly the method we required

```
echo $OWNER_PUBLIC_KEY
```

eg. formatted id : principal "xevzc-zvwds-xausy-2z2hh-4fftx-ckm32-pjxvj-bkoqf-57xg5-nl6jb-lae"

5. To check the owner's balance

make sure your canister name should match where u made balanceOf function eg: mine is "token_backend" use:

```
dfx canister call token_backend balanceOf "( $OWNER_PUBLIC_KEY )"
```

# Charge the Canister

1. Check canister ID:

```
dfx canister id token
```

2. Save canister ID into a command line variable:

```
CANISTER_PUBLIC_KEY="principal \"$( \dfx canister id token )\""
```

3. Check canister ID has been successfully saved:

```
echo $CANISTER_PUBLIC_KEY
```

4. Transfer half a billion tokens to the canister Principal ID:

```
dfx canister call token_backend transfer "($CANISTER_PUBLIC_KEY, 500_000_000)"
```

# Deploy the Project to the Live IC Network

1. Create and deploy canisters:

```
dfx deploy --network ic
```

2. Check the live canister ID:

```
dfx canister --network ic id token
```

3. Save the live canister ID to a command line variable:

```
LIVE_CANISTER_KEY="principal \"$( \dfx canister --network ic id token )\""
```

4. Check that it worked:

```
echo $LIVE_CANISTER_KEY
```

5. Transfer some tokens to the live canister:

```
dfx canister --network ic call token_backend transfer "($LIVE_CANISTER_KEY, 50_000_000)"
```

6. Get live canister front-end id:

cross-check assets location as motoko is regularly updating

```
dfx canister --network ic id token_assets
```

7. Copy the id from step 6 and add .raw.ic0.app to the end to form a URL.

   e.g. zdv65-7qaaa-aaaai-qibdq-cai.raw.ic0.app
