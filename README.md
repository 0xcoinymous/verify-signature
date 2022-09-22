## **signature varification contract**

with this contract you can verify the signer of a signature using the signature and message <br />
also you can calculate the hash of a message and after that calculate the signature , using browser console and metamask by methods below . <br />
__________________________________________________________________________ <br />
**verify signer of a message using `verify()` :** <br />
    verify( signer,  message  , signature ) 

__________________________________________________________________________ <br />
**sign a message using `getMsgHash()` and metamask :**

1) deploy the contract and get the hash of your message with function below : <br />
```
getMsgHash(message)
```

open browser console and then :

2) assign MsgHash with the value of getMsgHash(message)  <br />
```
    MsgHash =  
```

3) enable metamask: <br />
```
    ethereum.enable()  
```

4) get connected account of your metamask :  <br />
```
ethereum.request({ method: 'eth_requestAccounts' }).then(function (accounts) {  
    CurrentAccount = accounts[0];  
    console.log('current account: ' + CurrentAccount); 
}); 
```

5) send a request to sign the message with metamask :  <br />
```
    ethereum.request({method : "personal_sign" , params : [CurrentAccount, MsgHash]})  
```

