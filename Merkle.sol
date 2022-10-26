// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

/*    
       h1234
       /  \
     h12   h34
     /\    /\
    h1 h2 h3 h4

index=1
pathElement=[h1, h34]

index%2==1 => left + hash(index)
index%2==0 => hash(index) + right
*/
contract MerkleProof {
    function verify (bytes32[] memory proof, bytes32 root, bytes32 leaf, uint index) public pure returns (bool) {
        bytes32 hash = leaf;

        for (uint i=0; i<proof.length; i++) {
            if (index%2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proof[i]));
            } else {
                hash = keccak256(abi.encodePacked(proof[i], hash));
            }

            index = index / 2;
        }
        return hash == root;
    }
}