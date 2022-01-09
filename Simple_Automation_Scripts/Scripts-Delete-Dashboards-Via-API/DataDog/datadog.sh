while read -r fn; do

curl -X DELETE "https://api.datadoghq.com/api/v1/dashboard/$fn" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: {{API-KEY-HERE}}" \
-H "DD-APPLICATION-KEY: {{API-KEY-HERE}}"
echo
done < datadog-final.txt