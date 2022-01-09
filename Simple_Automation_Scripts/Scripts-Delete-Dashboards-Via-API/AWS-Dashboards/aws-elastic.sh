while read -r fn; do
aws cloudwatch delete-dashboards --dashboard-names $fn
echo
done < evt-elastic-dashboard-names

