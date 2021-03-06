"Starting..."

# Get the object used to communicate with the server.
#ftp://postback.se/templogger.postback.se
$request = [System.Net.WebRequest]::Create("ftp://postback.se/")
$request.UsePassive = false
$request.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectoryDetails
# This example assumes the FTP site uses anonymous logon.
$request.Credentials = New-Object System.Net.NetworkCredential("templogger","logger")

$response = $request.GetResponse()
#FtpWebResponse response = (FtpWebResponse)request.GetResponse();
    
$responseStream = $response.GetResponseStream()
$reader = New-Object System.IO.StreamReader($responseStream)
"Output:"
$reader.ReadToEnd()
"End of output"

"Download Complete, status " + $response.StatusDescription

$reader.Close()
$response.Close()
