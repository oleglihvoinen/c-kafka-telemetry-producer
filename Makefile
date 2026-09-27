CC ?= gcc
CFLAGS ?= -O2 -Wall -Wextra -Wpedantic
LDLIBS ?= -lrdkafka
TARGET=telemetry-producer
all: $(TARGET)
$(TARGET): src/main.c
	$(CC) $(CFLAGS) -o $@ $< $(LDLIBS)
clean:
	rm -f $(TARGET)
.PHONY: all clean
