for cluster in {west,east}; do
  docker-compose exec "${cluster}_a" \
    couchbase-cli node-init \
    -c localhost  \
    --username couchbase \
    --password couchbase \
    --node-init-hostname a.${cluster}.local

  docker-compose exec "${cluster}_b" \
    couchbase-cli node-init \
    -c localhost  \
    --username couchbase \
    --password couchbase \
    --node-init-hostname b.${cluster}.local

  docker-compose exec "${cluster}_a" \
    couchbase-cli cluster-init  \
    -c localhost  \
    --cluster-username couchbase  \
    --cluster-password couchbase  \
    --services data \
    --cluster-ramsize 1024

  docker-compose exec "${cluster}_a" \
    couchbase-cli server-add \
    -c localhost \
    --username couchbase \
    --password couchbase \
    --server-add http://b.${cluster}.local:8091 \
    --server-add-username couchbase \
    --server-add-password couchbase \
    --services data

  docker-compose exec "${cluster}_a" \
    couchbase-cli bucket-create \
    -c localhost:8091 \
    --username couchbase \
    --password couchbase \
    --bucket xdcr_proxy \
    --bucket-type couchbase \
    --bucket-ramsize 1000

  docker-compose exec "${cluster}_a" \
    couchbase-cli rebalance \
    -c localhost:8091 \
    --username couchbase \
    --password couchbase
done
