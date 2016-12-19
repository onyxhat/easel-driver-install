$ErrorActionPreference = 'Stop'; # stop on all errors

###Functions
function Parse-ChocoParams() {
    $match_pattern = "(?<key>(\w+))\s*=\s*(?<value>([`"'])?([\w- _\\:\.]+)([`"'])?)"

    if ($packageParameters -match $match_pattern) {
        $results = $packageParameters | Select-String $match_pattern -AllMatches
        $results.matches | % {
            Set-Variable -Name $_.Groups['key'].Value.Trim() -Value $_.Groups['value'].Value.Trim() -Scope Global
        }
    }
}

###Preflight
$packageName  = 'easel.drvier' # arbitrary name for the package, used in messages
$toolsDir     = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url          = 'http://s3.amazonaws.com/easel-prod/paperclip/sender_version_windows_installers/23/original/EaselDriver-0.3.2.zip?1478118532' # download url, HTTPS preferred
$checkSum     = 'f978a72afab10ac1d347fc00648b4a70'
$checkSumType = 'MD5'

###Install
Install-ChocolateyZipPackage -PackageName "easel.driver" -Url $url -UnzipLocation $toolsDir -Checksum $checkSum -ChecksumType $checkSumType
