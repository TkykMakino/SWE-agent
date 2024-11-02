_print() {
    local total_lines=$(awk 'END {print NR}' $CURRENT_FILE)
    echo "[File: $(realpath $CURRENT_FILE) ($total_lines lines total)]"
    lines_above=$(jq -n "$CURRENT_LINE - $WINDOW/2" | jq '[0, .] | max | floor')
    lines_below=$(jq -n "$total_lines - $CURRENT_LINE - $WINDOW/2" | jq '[0, .] | max | round')
    if [ $lines_above -gt 0 ]; then
        echo "($lines_above more lines above)"
    fi
    cat $CURRENT_FILE | grep -n $ | head -n $(jq -n "[$CURRENT_LINE + $WINDOW/2, $WINDOW/2] | max | floor") | tail -n $(jq -n "$WINDOW")
    if [ $lines_below -gt 0 ]; then
        echo "($lines_below more lines below)"
    fi
}

_constrain_line() {
    if [ -z "$CURRENT_FILE" ]
    then
        echo "No file open. Use the open command first."
        return
    fi
    local max_line=$(awk 'END {print NR}' $CURRENT_FILE)
    local half_window=$(jq -n "$WINDOW/2" | jq 'floor')
    export CURRENT_LINE=$(jq -n "[$CURRENT_LINE, $max_line - $half_window] | min")
    export CURRENT_LINE=$(jq -n "[$CURRENT_LINE, $half_window] | max")
}

# @yaml
# signature: plan
# docstring: create a plan to solve the issue. Always use this command when planning
plan() {
    echo "Okay. Now, please follow these tips for planning."
    echo "Important Tips:"
    echo "1. Before you begin to solve the issue, make a rough plan to SUBMIT the patch. Decide first what the overall steps will be to resolve the issue, and then follow that plan to execute the commands and resolve the issue. This plan should encompass the entire flow of issue resolution."
    
#    echo "2. Always start by trying to replicate the bug that the issues discusses.
#     If the issue includes code for reproducing the bug, we recommend that you re-implement that in your environment, and run it to make sure you can reproduce the bug.
#     Then start trying to fix it.
#     When you think you've fixed the bug, re-run the bug reproduction script to make sure that the bug has indeed been fixed.
#
#     If the bug reproduction script does not print anything when it successfully runs, we recommend adding a print("Script completed successfully, no errors.") command at the end of the file,
#     so that you can be sure that the script indeed ran fine all the way through."
#    echo "2. Always start by searching for code related to the bug being discussed in the issue.
#     Once you have determined that you have gathered enough information, make edits to resolve the issue.
#    
#     When you feel that the edits to resolve the issue are complete, submit the edits as a patch.
#     During this time, you *MUST NOT* attempt to reproduce the issue or test. It is difficult to do so. It is forbidden to include in the plan any steps that involve creating or running tests."
    echo "Be sure to start by searching for code related to the issue.
     When you feel you have gathered enough information, move on to reproducing the bug discussed in the issue.
     If the issue contains code to reproduce the bug, we recommend that you reimplement it in your environment, run it, and verify that you can reproduce the bug. If it was not included, use the information you have researched to reproduce the issue.
     Then start trying to fix it.
     When you think you've fixed the bug, re-run the bug reproduction script to make sure that the bug has indeed been fixed.

     If the bug reproduction script does not print anything when it successfully runs, we recommend adding a print("Script completed successfully, no errors.") command at the end of the file,
     so that you can be sure that the script indeed ran fine all the way through."  
    echo "3. Please classify each step into one of the following genres: “REPRODUCE”, “SEARCH”, “EDIT” or “TEST” and list it after the step name in the format **STEP NAME [STEP GENRE]**."
#    echo "3. Please classify each step into one of the following genres: “SEARCH”, “EDIT” or “SUBMIT” and list it after the step name in the format **STEP NAME [STEP GENRE]**."

    echo "4. In solving the issue according to this plan, please be sure to include the name of the step and the step genre at that point in the following format before of all DISCUSSION. However, the step name and step genre in this response should be **Create Plan [PLAN]**." 
    echo "**STEP NAME [STEP GENRE]**"
    echo "DISCUSSION"
    echo "    "
#    echo "5. As you execute this plan, be sure to select the “report” command as the action at the end of each step. This will allow you to proceed to the next step."
#    echo "6. If you want to go back one step, select the “back” command as the action instead of the “report” command at the end of the step. However, the number of times the “back” command can be used is limited."
    echo "   "
    echo "After you have finished describing your plan according to these tips, select the appropriate command as the action to start first step and begin proceeding with your plan from step 1."

    return
}

# @yaml
# signature: report
# docstring: Summarize the operations performed so far and prepare a report. Perform this operation whenever you progress through the plan's steps
report() {
    echo "Summarize the previous operations and their results, then proceed to the next step."
    echo "STEP NAME and STEP GENRE should be those of the next step."
    echo "The DISSCUSSION should include a sentence summarizing the operations that have been performed and their results before describing the next operation to be performed."

    return
}

# @yaml
# signature: open <path> [<line_number>]
# docstring: opens the file at the given path in the editor. If line_number is provided, the window will be move to include that line
# arguments:
#   path:
#     type: string
#     description: the path to the file to open
#     required: true
#   line_number:
#     type: integer
#     description: the line number to move the window to (if not provided, the window will start at the top of the file)
#     required: false
open() {
    if [ -z "$1" ]
    then
        echo "Usage: open <file>"
        return
    fi
    # Check if the second argument is provided
    if [ -n "$2" ]; then
        # Check if the provided argument is a valid number
        if ! [[ $2 =~ ^[0-9]+$ ]]; then
            echo "Usage: open <file> [<line_number>]"
            echo "Error: <line_number> must be a number"
            return  # Exit if the line number is not valid
        fi
        local max_line=$(awk 'END {print NR}' $1)
        if [ $2 -gt $max_line ]; then
            echo "Warning: <line_number> ($2) is greater than the number of lines in the file ($max_line)"
            echo "Warning: Setting <line_number> to $max_line"
            local line_number=$(jq -n "$max_line")  # Set line number to max if greater than max
        elif [ $2 -lt 1 ]; then
            echo "Warning: <line_number> ($2) is less than 1"
            echo "Warning: Setting <line_number> to 1"
            local line_number=$(jq -n "1")  # Set line number to 1 if less than 1
        else
            local OFFSET=$(jq -n "$WINDOW/6" | jq 'floor')
            local line_number=$(jq -n "[$2 + $WINDOW/2 - $OFFSET, 1] | max | floor")
        fi
    else
        local line_number=$(jq -n "$WINDOW/2")  # Set default line number if not provided
    fi

    if [ -f "$1" ]; then
        export CURRENT_FILE=$(realpath $1)
        export CURRENT_LINE=$line_number
        _constrain_line
        _print
    elif [ -d "$1" ]; then
        echo "Error: $1 is a directory. You can only open files. Use cd or ls to navigate directories."
    else
        echo "File $1 not found"
    fi
}

# @yaml
# signature: goto <line_number>
# docstring: moves the window to show <line_number>
# arguments:
#   line_number:
#     type: integer
#     description: the line number to move the window to
#     required: true
goto() {
    if [ $# -gt 1 ]; then
        echo "goto allows only one line number at a time."
        return
    fi
    if [ -z "$CURRENT_FILE" ]
    then
        echo "No file open. Use the open command first."
        return
    fi
    if [ -z "$1" ]
    then
        echo "Usage: goto <line>"
        return
    fi
    if ! [[ $1 =~ ^[0-9]+$ ]]
    then
        echo "Usage: goto <line>"
        echo "Error: <line> must be a number"
        return
    fi
    local max_line=$(awk 'END {print NR}' $CURRENT_FILE)
    if [ $1 -gt $max_line ]
    then
        echo "Error: <line> must be less than or equal to $max_line"
        return
    fi
    local OFFSET=$(jq -n "$WINDOW/6" | jq 'floor')
    export CURRENT_LINE=$(jq -n "[$1 + $WINDOW/2 - $OFFSET, 1] | max | floor")
    _constrain_line
    _print
}

_scroll_warning_message() {
    # Warn the agent if we scroll too many times
    # Message will be shown if scroll is called more than WARN_AFTER_SCROLLING_TIMES (default 3) times
    # Initialize variable if it's not set
    export SCROLL_COUNT=${SCROLL_COUNT:-0}
    # Reset if the last command wasn't about scrolling
    if [ "$LAST_ACTION" != "scroll_up" ] && [ "$LAST_ACTION" != "scroll_down" ]; then
        export SCROLL_COUNT=0
    fi
    # Increment because we're definitely scrolling now
    export SCROLL_COUNT=$((SCROLL_COUNT + 1))
    if [ $SCROLL_COUNT -ge ${WARN_AFTER_SCROLLING_TIMES:-3} ]; then
        echo ""
        echo "WARNING: Scrolling many times in a row is very inefficient."
        echo "If you know what you are looking for, use \`search_file <pattern>\` instead."
        echo ""
    fi
}

# @yaml
# signature: scroll_down
# docstring: moves the window down {WINDOW} lines
scroll_down() {
    if [ -z "$CURRENT_FILE" ]
    then
        echo "No file open. Use the open command first."
        return
    fi
    export CURRENT_LINE=$(jq -n "$CURRENT_LINE + $WINDOW - $OVERLAP")
    _constrain_line
    _print
    _scroll_warning_message
}

# @yaml
# signature: scroll_up
# docstring: moves the window down {WINDOW} lines
scroll_up() {
    if [ -z "$CURRENT_FILE" ]
    then
        echo "No file open. Use the open command first."
        return
    fi
    export CURRENT_LINE=$(jq -n "$CURRENT_LINE - $WINDOW + $OVERLAP")
    _constrain_line
    _print
    _scroll_warning_message
}

# @yaml
# signature: create <filename>
# docstring: creates and opens a new file with the given name
# arguments:
#   filename:
#     type: string
#     description: the name of the file to create
#     required: true
create() {
    if [ -z "$1" ]; then
        echo "Usage: create <filename>"
        return
    fi

    # Check if the file already exists
    if [ -e "$1" ]; then
        echo "Error: File '$1' already exists."
		open "$1"
        return
    fi

    # Create the file an empty new line
    printf "\n" > "$1"
    # Use the existing open command to open the created file
    open "$1"
}

# @yaml
# signature: submit
# docstring: submits your current code and terminates the session
submit() {
    cd $ROOT

    # Check if the patch file exists and is non-empty
    if [ -s "/root/test.patch" ]; then
        # Apply the patch in reverse
        git apply -R < "/root/test.patch"
    fi

    git add -A
    git diff --cached > model.patch
    echo "<<SUBMISSION||"
    cat model.patch
    echo "||SUBMISSION>>"
}
