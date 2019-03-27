{ exec, ... }: {
  hello = exec ["echo" "\"hello\""];
  pass = secretName: exec [ ./pass.sh secretName ];
}

