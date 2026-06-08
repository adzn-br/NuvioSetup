# Fixed output folder
$output = "C:\Users\addis\OneDrive\Desktop\Stremio format\NuvioCollectionImages\collection imgs\png\logosoutput"
mkdir $output -Force

# Ask for resize height
$resize = Read-Host "Enter logo height in pixels (e.g. 450)"

# Ask for image paths
$paths = Read-Host "Paste full image paths separated by commas"

# Convert input into array
$files = $paths -split "," | ForEach-Object { $_.Trim('"').Trim() }

foreach ($file in $files) {

    if (Test-Path $file) {

        $name = Split-Path $file -Leaf
        $outputPath = Join-Path $output $name

        magick $file `
            -resize "x$resize" `
            -background black `
            -gravity center `
            -extent 1920x1080 `
            $outputPath

        Write-Host "Processed: $name"
    }
    else {
        Write-Host "File not found: $file"
    }
}