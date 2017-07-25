#!/bin/bash

  function readQuote {
    random=$(gshuf -i 1-99 -n 1)
    jq -r --arg random $random '.[$random|tonumber] | .quote, .author' ~/.quotes
  }


  if ! test "`find ~/.quotes -mmin +60`" && [ -s ~/.quotes ]; then
      echo "reading old quotes"
      readQuote
  else
      rm -f ~/.quotes
      echo "getting new quotes"
      curl -X GET --header 'Accept: application/json' 'https://talaikis.com/api/quotes/' 2>/dev/null >> ~/.quotes
      readQuote
  fi
