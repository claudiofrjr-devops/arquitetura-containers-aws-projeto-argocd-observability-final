curl --location 'linuxtips-ingress-1884474170.us-east-2.elb.amazonaws.com/calculator' \
--header 'Content-Type: application/json' \
--header 'Host: health.allcloudi.shop' \
--data-raw '{ "age": 43, "weight": 80, "height": 1.73, "gender": "M", "activity_intensity": "medium_active" }' -iv

while true; do ; curl --location 'linuxtips-ingress-1884474170.us-east-2.elb.amazonaws.com/calculator' \
--header 'Content-Type: application/json' \
--header 'Host: health.allcloudi.shop' \
--data-raw '{ "age": 43, "weight": 80, "height": 1.73, "gender": "M", "activity_intensity": "moderately_active" }' -iv; echo; done