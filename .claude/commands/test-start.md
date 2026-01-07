---
description: Start Python HTTP test server on port 8000
allowed-tools: Bash(./.test/start-server.sh:*), Read
---

Start the Python HTTP test server for local development and testing.

This command:
- Starts a Python HTTP server on port 8000
- Validates that no server is already running
- Maintains a PID file in `.test/server.pid`
- Logs all output to `.test/server.log`
- Runs in background (doesn't hijack terminal)

**URL:** http://localhost:8000

**Log file:** `.test/server.log`

To stop the server, use `/test-stop`
