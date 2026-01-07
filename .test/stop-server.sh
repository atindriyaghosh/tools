#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PID_FILE="$(cd "$(dirname "$0")" && pwd)/server.pid"

echo -e "${YELLOW}🛑 Stopping Python test server${NC}"
echo ""

# Check if PID file exists
if [ ! -f "$PID_FILE" ]; then
    echo -e "${YELLOW}ℹ️  No server running (PID file not found)${NC}"
    echo ""
    exit 0
fi

# Read the PID from file
SERVER_PID=$(cat "$PID_FILE")

# Check if the PID is valid (process exists)
if ! kill -0 "$SERVER_PID" 2>/dev/null; then
    echo -e "${YELLOW}ℹ️  Server is not running (stale PID file found)${NC}"
    echo -e "${YELLOW}   Removing stale PID file...${NC}"
    rm -f "$PID_FILE"
    echo -e "${GREEN}✅ Cleanup complete${NC}"
    echo ""
    exit 0
fi

# Process is running, kill it
echo -e "${YELLOW}   Killing process $SERVER_PID...${NC}"
if kill "$SERVER_PID" 2>/dev/null; then
    # Give it a moment to shut down
    sleep 0.5

    # Verify it's actually dead
    if ! kill -0 "$SERVER_PID" 2>/dev/null; then
        # Remove the PID file
        rm -f "$PID_FILE"
        echo -e "${GREEN}✅ Server stopped successfully${NC}"
        echo ""
        exit 0
    else
        # Process didn't stop gracefully, force kill it
        echo -e "${YELLOW}   Process didn't stop, force killing...${NC}"
        kill -9 "$SERVER_PID" 2>/dev/null
        sleep 0.5

        # Remove the PID file
        rm -f "$PID_FILE"
        echo -e "${GREEN}✅ Server force stopped${NC}"
        echo ""
        exit 0
    fi
else
    echo -e "${RED}❌ Failed to stop server (PID: $SERVER_PID)${NC}"
    echo ""
    exit 1
fi
