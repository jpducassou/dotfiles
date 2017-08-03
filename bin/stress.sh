#!/bin/bash

requests=10
concurrency=5
url="${1}"

for i in $(seq 1 ${concurrency}); do
	echo "thread ${i} ..."
	curl -s -w 'total: %{time_total}\n' "${url}?[1-${requests}]" -o /dev/null & pidlist="${pidlist} $!"
done

# Execute and wait
FAIL=0
for job in $pidlist; do
	echo $job
	wait $job || let "FAIL += 1"
done

# Verify if any failed
if [ "$FAIL" -eq 0 ]; then
	echo "SUCCESS!"
else
	echo "Failed Requests: ($FAIL)"
fi

