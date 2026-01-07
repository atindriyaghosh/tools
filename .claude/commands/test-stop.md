---
description: Stop Python HTTP test server
allowed-tools: Bash(./.test/stop-server.sh:*), Read
---

Stop the running Python HTTP test server.

This command:
- Stops the Python HTTP server gracefully
- Falls back to force-kill if graceful stop fails
- Cleans up the PID file in `.test/server.pid`
- Handles edge cases (no server running, stale PID file)
- Shows output for immediate feedback

If the server is already stopped or was never started, this command exits cleanly without errors.

To start the server again, use `/test-start`
