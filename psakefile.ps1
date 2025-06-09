Task default -depends Reset, Optimize

Task Reset {
  Remove-Item -Path .\_site -Recurse -ErrorAction SilentlyContinue
  New-Item -Path .\_site -ItemType Directory
  Copy-Item -Destination .\_site -Path "index.html"
  Copy-Item -Destination .\_site -Path "hosted.html"
  Copy-Item -Destination .\_site -Path "web.config"
  Copy-Item -Destination .\_site -Path "downloading"
  Copy-Item -Destination .\_site -Path "upload"
  Copy-Item -Destination .\_site -Path .\assets -Recurse
}

Task Optimize {
  @(
    ".\_site\hosted.html",
    ".\_site\index.html"
  ) | ForEach-Object { Optimize-HTML -File $_ -OutputFile $_ }
  @(
    ".\_site\assets\css\app.css",
    ".\_site\assets\css\darkmode.css"
  ) | ForEach-Object { Optimize-CSS -File $_ -OutputFile $_ }
  @(
    ".\_site\assets\js\app-2.5.4.js",
    ".\_site\assets\js\app-2.5.4.min.js",
    ".\_site\assets\js\darkmode.js"
  ) | ForEach-Object { Optimize-JavaScript -File $_ -OutputFile $_ }
}