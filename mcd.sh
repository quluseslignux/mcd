:"
mcd
A Bash function to create and change into directories at the same time.
Copyright (C) 2025  QUL

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

You can reach me at quluseslignux@proton.me
"

mcd() {
    if [ "$1" == "--help" ]; then
        echo "Usage: mcd [-s] <directory>"
        echo ""
        echo "A simple Bash function to create and change to a directory."
        echo ""
        echo "Options:"
        echo "  -s        Silent mode. No output will be shown."
        echo "  --help    Display this help message."
        return 0
    fi

    # Check if no arguments are passed
    if [ -z "$1" ]; then
        echo "Usage: mcd [-s] <directory>"
        return 1
    fi

    # Parse arguments
    SILENT=false
    if [ "$1" == "-s" ]; then
        SILENT=true
        shift  # Remove the -s flag from the arguments
    fi

    DIR="$1"

    # Check and create directory
    if [ -d "$DIR" ]; then
        $SILENT || echo "Directory exists. Changing to '$DIR'."
    else
        $SILENT || echo "Directory does not exist. Creating and changing to '$DIR'."
        mkdir -p "$DIR" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo "mcd: Cannot create directory '$DIR': Permission denied" >&2
            return 1
        fi
    fi

    # Change to the directory
    cd "$DIR" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "mcd: Cannot change to directory '$DIR': Permission denied" >&2
        return 1
    fi
}
