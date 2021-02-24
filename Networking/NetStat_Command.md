### [Home](../Home.md) | [Networking Home](../Networking/Networking.md)

# Networking Notes

### NetStat
Netstat command can be run on a server / client to see a list of connections.

### Example 1
The following codeblock can be used to count the **total** number of TCP connections on port 8080 as well as a count of TCP connections on port 8080 which have a status of **"Established"**

    netstat -np tcp | find "8081" /c && netstat -np tcp | find "8081" | find "ESTABLISHED" /c

### Example 2
The following code block will list all TCP connections on port 1433

    netstat -np tcp | find "1433"