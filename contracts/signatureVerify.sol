// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

contract sigVerify {

    function verify(address _signer, string memory _msg , bytes memory _sig) external pure returns(bool ){

        // first we should calculate the message hash :
        bytes32 msgHash = getMsgHash(_msg) ;

        // when we sign the message of-chain , the message that is signed isn't msgHash 
        // we should prefix the message by "\x19Ethereum Signed Message:\n<length of message>" and after hash the message
        bytes32 signedMsgHash = getSignedMsgHash(msgHash) ;

        return recover(signedMsgHash , _sig) == _signer ;
    }

    function getMsgHash(string memory _msg) public pure returns(bytes32 ){
        return keccak256(abi.encodePacked(_msg));
    }

    function getSignedMsgHash(bytes32 _msgHash) internal pure returns(bytes32 ){
        return keccak256(abi.encodePacked( "\x19Ethereum Signed Message:\n32" , _msgHash ));
    }

    function recover (bytes32 _signedMsgHash , bytes memory _sig ) internal pure returns(address ){

        // first we should split the signature into 3 parts :
        // r and s are cryptographic parameters used for digital signature 
        (bytes32 r , bytes32 s , uint8 v) = _split(_sig) ;

        // finaly function below returns the address of signer :
        return ecrecover(_signedMsgHash , v , r , s);

    }

    function _split(bytes memory _sig) internal pure returns(bytes32 r , bytes32 s , uint8 v){

        // _sig is a dynamic data because its length is variable and for dynamic data types the first 32 bytes stores
        // the length of data 
        // also the variable _sig isn't the actual signature , it is the pointer to where the signature is stored in memory 

        /*
        First 32 bytes stores the length of the signature

        add(sig, 32) = pointer of sig + 32
        effectively, skips first 32 bytes of signature

        mload(p) loads next 32 bytes starting at the memory address p into memory
        */

        require(_sig.length == 65 , "invalid signature ") ;
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0,mload(add(_sig, 96)))
        }
    }

    function testSigLength(bytes memory _sig) public pure returns(uint _length , bool isEqual){
        // first we get the length with assembly :
        assembly {
            _length := mload(_sig)
        }

        isEqual = (_sig.length == _length);
    }
}


