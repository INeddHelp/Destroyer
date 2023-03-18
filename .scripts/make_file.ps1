$sourceFilePath = "words_alpha.txt"
$destinationFilePath = "$([Environment]::GetFolderPath('Desktop'))\file.txt"

Copy-Item -Path $sourceFilePath -Destination $destinationFilePath
