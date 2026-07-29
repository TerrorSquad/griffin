import sys
import json

def main():
    data = json.load(sys.stdin)

    tool_name = data.get("tool_name", "")
    tool_input = data.get("tool_input", {})

    if tool_name == "Task":
        description = tool_input.get("description", "").lower()
        prompt = tool_input.get("prompt", "").lower()

        if "explore" in description or "explore" in prompt:
            print("Blocked: Explore subagent is not permitted.")
            sys.exit(2)

if __name__ == "__main__":
    main()