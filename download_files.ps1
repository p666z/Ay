# سكريبت تنزيل جميع ملفات موقع greet-site.vercel.app
$baseUrl = "https://greet-site.vercel.app"
$outputDir = "$env:USERPROFILE\Downloads\greet-site"

# إنشاء المجلدات المطلوبة
$directories = @(
    "$outputDir\_next\static\css",
    "$outputDir\_next\static\chunks\app\greet\[slug]",
    "$outputDir\_next\static\chunks",
    "$outputDir\images"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Force -Path $dir | Out-Null
}

# ملفات CSS
$cssFiles = @(
    "/_next/static/css/4c0f46ad46dde57f.css",
    "/_next/static/css/613d74a29e1e46e6.css"
)

# ملفات JavaScript
$jsFiles = @(
    "/_next/static/chunks/webpack-5e465cfae67d66e1.js",
    "/_next/static/chunks/fd9d1056-b11b2651f33aae7f.js",
    "/_next/static/chunks/117-a2b2b2949136a78e.js",
    "/_next/static/chunks/main-app-2dcde4753ea0d175.js",
    "/_next/static/chunks/972-8c0ee6fabcd1342f.js",
    "/_next/static/chunks/app/greet/%5Bslug%5D/not-found-c354e3425e938980.js",
    "/_next/static/chunks/560-4d6d529966a6c8f4.js",
    "/_next/static/chunks/app/error-7ee4e0fdfdbb33d3.js",
    "/_next/static/chunks/521-b53316ac963015d8.js",
    "/_next/static/chunks/107-6f992db5ae762ca8.js",
    "/_next/static/chunks/app/greet/%5Bslug%5D/page-155295b1dd761fc7.js",
    "/_next/static/chunks/polyfills-42372ed130431b0a.js"
)

Write-Host "بدء تنزيل الملفات..." -ForegroundColor Green

# تنزيل ملفات CSS
Write-Host "`nتنزيل ملفات CSS..." -ForegroundColor Cyan
foreach ($file in $cssFiles) {
    $url = $baseUrl + $file
    $outputPath = $outputDir + $file.Replace("/", "\")
    try {
        Invoke-WebRequest -Uri $url -OutFile $outputPath
        Write-Host "  تم تنزيل: $file" -ForegroundColor Green
    } catch {
        Write-Host "  فشل تنزيل: $file" -ForegroundColor Red
    }
}

# تنزيل ملفات JavaScript
Write-Host "`nتنزيل ملفات JavaScript..." -ForegroundColor Cyan
foreach ($file in $jsFiles) {
    $url = $baseUrl + $file
    # تحويل %5B و %5D إلى [ و ] للمسار
    $localPath = $file.Replace("%5B", "[").Replace("%5D", "]")
    $outputPath = $outputDir + $localPath.Replace("/", "\")
    try {
        Invoke-WebRequest -Uri $url -OutFile $outputPath
        Write-Host "  تم تنزيل: $file" -ForegroundColor Green
    } catch {
        Write-Host "  فشل تنزيل: $file" -ForegroundColor Red
    }
}

Write-Host "`nتم الانتهاء من تنزيل جميع الملفات!" -ForegroundColor Green
Write-Host "المجلد: $outputDir" -ForegroundColor Yellow
