start-process ${env:ProgramFiles}'\oracle\virtualbox\vboxheadless' '-s Debian' -WindowStyle Hidden
start-sleep -s 9
start-process ${env:ProgramFiles}'\PuTTY\putty.exe' '-load "Debian Virtualbox Serial"' -verb runAs
