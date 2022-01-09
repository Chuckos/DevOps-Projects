while read -r fn; do
aws cloudwatch delete-dashboards --dashboard-names $fn
echo
done < prod-us-east-dashboard-names-final

