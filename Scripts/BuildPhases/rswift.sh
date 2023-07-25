#!/bin/bash

# M1 Macの場合はHomebrewのパスを追加する
if [ $(uname -m) = "arm64" ]; then
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH+:$PATH}";
fi

if mint list | grep -q 'R.swift'; then
  mint run R.swift rswift generate "$SRCROOT/CharacterAlarm/Generated/R.generated.swift"
else
  echo "error: R.swift not installed; run 'mint bootstrap' to install"
  return -1
fi
