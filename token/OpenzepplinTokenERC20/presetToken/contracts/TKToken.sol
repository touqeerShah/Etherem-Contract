// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "../ERC20/presets/ERC20PresetMinterPauser.sol";
contract TKToken  is ERC20PresetMinterPauser{
  constructor()ERC20PresetMinterPauser("TK Token","TK"){
    
  }
}
