<# 
	.SYNOPSIS
	This script create a backup of a Minecraft world (overworld) using tar with zstd compression.

	.DESCRIPTION 
	Create a backup of a Minecraft world (overworld) using tar with zstd compression.
	Saves the backup in a specified directory with a timestamp in the filename.
	Keep the backups for a specified number of days and delete it after that (default is 7 days).
	
	.EXAMPLE
	./Backup-MinecraftWorld.ps1
	
	.NOTES
	This script is optimized for use on a Linux server with PowerShell and tar installed.
	You must modify the variables at the beginning of the script to match your server's configuration.	
#>

$mcDir = "/path/to/srv/mc"
$backupDir = "/path/to/destination/folder"
$worldName = "world"
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$archiveName = "world-$timestamp.tar.zst"
$retentionDays = 7 # Edit the day as you wish

# Pre-checks
if (-not (Get-Command tar -ErrorAction SilentlyContinue)) {
	Write-Error "The 'tar' command is not available. Please install it to use this script."
	exit 1
}
if (-not (Test-Path $backupDir)) {
	New-Item -ItemType Directory -Path $backupDir | Out-Null
}

$tarCmd = "tar --zstd -cf `"$backupDir/$archiveName`" -C `"$mcDir`" $worldName" 
Invoke-Expression $tarCmd

Write-Output "The Minecraft world has been saved to the following path: $backupDir/$archiveName"

# Cleaning backups that are older than 7 days
Get-ChildItem "$backupDir/world-*.tar.zst" | Where-Object { 
	$_.LastWriteTime -lt (Get-Date).AddDays(-$retentionDays)
} | Remove-Item -Force