# Echo a random filename from all the files and directories in the current directory
Get-ChildItem -name | Select-Object -index $(Random $((Get-ChildItem).Count))