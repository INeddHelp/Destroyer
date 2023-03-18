$sourceFilePath = "words_alpha.txt"
$destinationFilePath = "$([Environment]::GetFolderPath('Desktop'))\words_alpha.txt"

Copy-Item -Path $sourceFilePath -Destination $destinationFilePath
