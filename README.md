# C Kafka Telemetry Producer

A native **C event producer built with librdkafka** for publishing versioned industrial telemetry to Apache Kafka.

![Architecture](https://raw.githubusercontent.com/oleglihvoinen/oleglihvoinen.github.io/main/assets/architecture/c-kafka-telemetry-producer.png)

## Summary

The producer models an edge or factory-side integration pattern where machine telemetry must be published efficiently into a streaming platform. Machine ID is used as the Kafka message key to provide deterministic partitioning and preserve per-machine event ordering within a partition.

## Architecture

Industrial process / edge host → C + librdkafka producer → `machine.telemetry.v1` → consumer group → validation/enrichment → Snowflake / lakehouse / monitoring.

## Engineering design

- native librdkafka producer API
- keyed event publishing and explicit topic versioning
- JSON Schema contract for telemetry payloads
- delivery callback for acknowledgement visibility
- explicit producer flush before shutdown
- broker and topic configuration through environment variables
- clean separation between producer code and event contract
- Ubuntu CI compilation with `librdkafka-dev`

## Event contract

The schema defines event version, machine identity, timestamp, temperature, RPM and operating status. Keeping the contract versioned independently from producer code supports controlled schema evolution and downstream compatibility.

## Build

```bash
sudo apt-get install librdkafka-dev
make
export KAFKA_BOOTSTRAP_SERVERS=localhost:9092
./telemetry-producer M-001 72.4 1480
```

## Operational hardening

For enterprise deployment, the producer can be extended with SASL/TLS, idempotent producer settings, retries, batching, Schema Registry, Avro/Protobuf serialization, producer metrics, dead-letter handling and broker-backed integration tests.

**Technologies:** C · Linux · librdkafka · Apache Kafka · JSON Schema · event streaming · GCC · GitHub Actions
