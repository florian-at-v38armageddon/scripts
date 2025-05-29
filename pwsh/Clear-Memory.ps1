<#
    .SYNOPSIS
    Clears the memory cache of the current script.

    .DESCRIPTION
    This script allows you to clear the memory cache of the running PowerShell script.
    It calls the Garbage Collector to free up memory.

    .EXAMPLE
    .\Clear-Memory.ps1

    .NOTES
    This is a simple script to help manage memory usage in PowerShell scripts.
    This has more utility if you include this code to a much larger script.
    E.G: A script that use Windows Forms on PowerShell.
#>

$memoryObject = [System.GC]::Collect()
$usedMemoryBefore = "{0:N2}" -f ($memoryObject / 1MB)
Write-Host "Used Memory Before cleaning: $usedMemoryBefore MB"

[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

$memoryObject = [System.GC]::GetTotalMemory($false)
$usedMemoryAfter = "{0:N2}" -f ($memoryObject / 1MB)
Write-Host "Mémoire utilisée après la libération : $usedMemoryAfter MB"
