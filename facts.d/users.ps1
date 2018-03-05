$Computername = $env:COMPUTERNAME
$adsi = [ADSI]"WinNT://$Computername"
$paths = $adsi.Children  | where {$_.SchemaClassName  -eq 'user'} | select Path
$users=@()
$paths | ForEach-Object { 
    $myarray = $_.Path.split('/')
    $users += $myarray[-1]     
}
foreach ($user in $users) {
    write-host ("winuser_{0}_is_present=true" -f $user)
}
