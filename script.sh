#!/bin/bash

isLoop=true
while $isLoop
do
  echo ""
  echo "--------------- / SELECT / ---------------"
  echo "Please select the function you need below:"
  echo "1. Generate a random mnemonic"
  echo "2. Get the xprv and xpub information from the mnemonic"
  echo "3. Get the address from xpub and hdpath"
  echo "4. Import blockchain wallet"
  echo "5. Exit"

  read choice

  if [ $choice -eq 1 ]; then
    echo "--------------- / RESULT / ---------------"
    echo ""
    node randomMnemonic.js
  elif [ $choice -eq 2 ]; then
    echo "Please enter your mnemonic:"
    read mnemonic
    echo "--------------- / RESULT / ---------------"
    echo ""
    node getKeyPairsByMnemonic.js ${mnemonic}
  elif [ $choice -eq 3 ]; then
    echo "Please enter your xpub:"
    read xpub
    echo "Please enter hdPath:"
    echo "(In Wallet service format hdPath is: \"m/0/0/1\", \"m/0/0/2\", \"m/0/1/1\")"
    read hdPath
    echo "--------------- / RESULT / ---------------"
    echo ""
    node getAddressByPath.js ${xpub} ${hdPath}
  elif [ $choice -eq 4 ]; then
    echo "Please enter the \"CONTAINER ID\" of p2pay_wallet_1:"
    read containerId
    echo "Please enter the \"service name\":"
    echo "(ex: BNB, BEP20, ETH, ERC20, MATIC, MATIC20, KLAY, KLAY20, BTC, TRX ...)"
    read service
    echo "Please enter your xpub:"
    read xpub
    echo "Please enter your xprv:"
    read xprv
    echo "--------------- / RESULT / ---------------"
    echo ""
    docker exec -ti ${containerId} curl --location \'http://localhost:3000/add_wallet\' --header \'Content-Type: application/json\' --data \'{\"service\":\"${service}\", \"xpub\":\"${xpub}\", \"hotWallet\":\"\", \"xpriv\":\"${xprv}\", \"coldWallet\":\"\", \"mnemonic\":\"\"}\'
  elif [ $choice -eq 5 ]; then
    isLoop=false
  else
    echo "Invalid selection, please try again!"
  fi
done