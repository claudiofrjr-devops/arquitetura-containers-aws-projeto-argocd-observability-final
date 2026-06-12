k run bastionpod --rm -i --tty --iamge debian -n default -- bash

apos instalar o curl

loki.linuxtips-observability.local

curl -v -H "Content-Type: application/json" -XPOST -s "http://loki.linuxtips-observability.local/loki/api/v1/push" --data-raw '{"streams": [{ "stream": { "foo": "bar" }, "values": [ [ "1745450629000000000", "LINUXTIPS VAI" ] ] }]}'