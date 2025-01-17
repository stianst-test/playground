<html>

<head>
<style>
    body {
        font-family: Sans;
    }

    table, th, td {
        border: 1px solid #bbb;
        border-collapse: collapse;
    }

    th, td {
        padding: 8px 15px;
        font-size: 14px;
    }

    tr:nth-child(even) {
        background-color: #f3f3f3;
    }
</style>
</head>

<body>

<table>
<tr>
    <th>Name</th>
    <th>Value</th>
</tr>

<tr>
    <td>Request</td>
    <td><span id="requestUrl"></span></td>
</tr>
<tr>
    <td>Frontend</td>
    <td>${frontendUrl} [<span id="frontendStatus"></span>]</td>
<tr>
    <td>Backend</td>
    <td>${backendUrl} [<span id="backendStatus"></span>]</td>
</tr>
<tr>
    <td>Admin</td>
    <td>${adminUrl} [<span id="adminStatus"></span>]</td>
</tr>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>


<tr>
    <td>Server mode</td>
    <td>${serverMode}</td>
</tr>
<tr>
    <td>Realm</td>
    <td>${realm}</td>
</tr>
<#if realmUrl??>
<tr>
    <td>Realm URL</td>
    <td>${realmUrl}</td>
</tr>
</#if>

<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
</tr>

<#list config as key, value>
<tr>
    <td>${key}</td>
    <td>${value}</td>
</tr>
</#list>

<#if proxyHeaders?has_content>
    <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr>

    <#list proxyHeaders as key, value>
    <tr>
        <td>${key}</td>
        <td>${value}</td>
    </tr>
    </#list>
</#if>

<script>
    function testUrl(url, responseId) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState == 4) {
            clearTimeout(timeout);
            if (xhr.status == 200) {
                document.getElementById(responseId).textContent='OK';
            } else {
                document.getElementById(responseId).textContent='FAILED';
            }
        }
    }
    var timeout = setTimeout(function() {
      xhr.abort();
      document.getElementById(responseId).textContent='TIMEOUT';
    }, 5000);
        xhr.open('GET', url, true);
        xhr.send();
    }

    document.getElementById("requestUrl").textContent=document.location.href

    testUrl('${frontendTestUrl}', 'frontendStatus');
    testUrl('${backendTestUrl}', 'backendStatus');
    testUrl('${adminTestUrl}', 'adminStatus');
</script>
</body>
</html>