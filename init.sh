docker-compose exec node_a couchbase-cli cluster-init  -c localhost  --cluster-username couchbase  --cluster-password couchbase  --services data  --cluster-ramsize 1024
docker-compose exec node_b couchbase-cli cluster-init  -c localhost  --cluster-username couchbase  --cluster-password couchbase  --services data  --cluster-ramsize 1024

docker-compose exec node_a couchbase-cli bucket-create -c localhost:8091 --username couchbase --password couchbase --bucket xdcr_proxy --bucket-type couchbase --bucket-ramsize 1000
docker-compose exec node_b couchbase-cli bucket-create -c localhost:8091 --username couchbase --password couchbase --bucket xdcr_proxy --bucket-type couchbase --bucket-ramsize 1000
