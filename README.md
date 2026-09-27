# C Kafka Telemetry Producer

A native **C producer using librdkafka** that publishes versioned industrial telemetry events to Apache Kafka.

## Use case
An edge or factory-side process publishes machine telemetry such as temperature, RPM and operating status. The machine ID is used as the Kafka message key so events for one machine preserve partition ordering.

## Architecture
Industrial process / edge host → C + librdkafka producer → `machine.telemetry.v1` → consumer group → validation/enrichment → Snowflake / lakehouse / monitoring.

## Engineering points
- native librdkafka producer API
- keyed messages and topic versioning
- JSON Schema event contract
- delivery callback and explicit flush
- environment-based broker/topic configuration
- CI compilation on Ubuntu

## Build
```bash
sudo apt-get install librdkafka-dev
make
export KAFKA_BOOTSTRAP_SERVERS=localhost:9092
./telemetry-producer M-001 72.4 1480
```

## Production evolution
SASL/TLS, retries and idempotence, schema registry, Avro/Protobuf, producer metrics, batching, dead-letter handling and broker-backed integration tests.

**Technologies:** C · Linux · librdkafka · Apache Kafka · JSON Schema · event streaming · GCC · GitHub Actions
