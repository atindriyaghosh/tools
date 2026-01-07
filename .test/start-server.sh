#!/bin/bash

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
TEST_DIR="$(cd "$(dirname "$0")" && pwd)"
PID_FILE="$TEST_DIR/server.pid"
LOG_FILE="$TEST_DIR/server.log"
PORT=${1:-8000}
REPO_ROOT="$(cd "$TEST_DIR/.." && pwd)"

# Initialize log file
echo "========================================" >> "$LOG_FILE"
echo "Server start attempt at $(date)" >> "$LOG_FILE"
echo "========================================" >> "$LOG_FILE"

echo -e "${GREEN}🚀 Starting Python test server${NC}"
echo ""

# Check if PID file exists
if [ -f "$PID_FILE" ]; then
    EXISTING_PID=$(cat "$PID_FILE")

    # Check if the PID is valid (process exists)
    if kill -0 "$EXISTING_PID" 2>/dev/null; then
        # Process is still running
        echo -e "${RED}⚠️  WARNING: Server is already running${NC}"
        echo -e "${RED}   PID: $EXISTING_PID${NC}"
        echo -e "${RED}   Stop the server first using: /test-stop${NC}"
        echo -e "${RED}   Log file: $LOG_FILE${NC}"
        echo ""
        exit 1
    else
        # PID file is a remnant (process no longer exists)
        echo -e "${YELLOW}⚙️  Found stale PID file, cleaning up...${NC}"
        rm -f "$PID_FILE"
    fi
fi

# Change to repo root to serve files correctly
cd "$REPO_ROOT" || exit 1

# Start the server in the background, redirect output to log file
python3 -m http.server $PORT >> "$LOG_FILE" 2>&1 &
SERVER_PID=$!

# Give the server a moment to start
sleep 0.5

# Verify the server started successfully
if kill -0 "$SERVER_PID" 2>/dev/null; then
    # Write PID to file
    echo "$SERVER_PID" > "$PID_FILE"

    echo -e "${GREEN}✅ Server started successfully${NC}"
    echo -e "${GREEN}   PID: $SERVER_PID${NC}"
    echo -e "${GREEN}   Port: $PORT${NC}"
    echo -e "${GREEN}   URL: http://localhost:$PORT${NC}"
    echo -e "${GREEN}   Log file: $LOG_FILE${NC}"
    echo ""
    echo -e "${YELLOW}To stop the server, run: /test-stop${NC}"
    echo ""
    exit 0
else
    echo -e "${RED}❌ Failed to start server${NC}"
    echo -e "${RED}   Check log file: $LOG_FILE${NC}"
    echo ""
    exit 1
fi
