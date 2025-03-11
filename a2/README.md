# safedelete.sh - Simplified Trash Utility with Single-File Undo

## What it does

`safedelete.sh` provides a simplified method for "deleting" files by moving them to the `~/.trash` directory. The key feature of this version is a simplified `--undo` option that restores only the *most recently* deleted file.

## Why/When this command is useful

This script is ideal for users who want a quick way to protect themselves against accidental deletions and who primarily need to restore only the last file they deleted. If you often find yourself deleting a file and immediately realizing you need it back, this tool can be helpful.

## How to use this command

1.  **"Deleting" Files:**
    *   `./safedelete.sh <file1> <file2> ...`: Moves the specified files to the `~/.trash` directory.

2.  **Restoring the Most Recently Deleted File (Undo):**
    *   `./safedelete.sh --undo`: Restores the *most recently* deleted file from the `~/.trash` directory back to the current directory.  If the trash is empty, it will print "Trash is empty.".

    *IMPORTANT:* The `--undo` command only restores the *last* file deleted. If you delete multiple files, you need to run the command multiple times, each time restoring the most recent one.

## Examples

1.  **Moving `file1.txt` and `file2.txt` to the trash:**

    ```bash
    ./safedelete.sh file1.txt file2.txt
    ```

    Output:

    ```
    Moved 'file1.txt' to trash.
    Moved 'file2.txt' to trash.
    ```

2.  **Restoring the most recently deleted file (in this case, `file2.txt`):**

    ```bash
    ./safedelete.sh --undo
    ```

    Output:

    ```
    Restored 'file2.txt'.
    ```

3.  **Restoring the next most recently deleted file (in this case, `file1.txt`):**

    To restore the *other* file (file1.txt) you need to run the undo command again:

    ```bash
    ./safedelete.sh --undo
    ```

    Output:

    ```
    Restored 'file1.txt'.
    ```

