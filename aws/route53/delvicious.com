$ORIGIN delvicious.com.
@ 300 IN A 54.235.124.190
@ 172800 IN NS ns-259.awsdns-32.com.
@ 172800 IN NS ns-1768.awsdns-29.co.uk.
@ 172800 IN NS ns-1531.awsdns-63.org.
@ 172800 IN NS ns-608.awsdns-12.net.
@ 900 IN SOA ns-259.awsdns-32.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
_xmpp-client._tcp 18000 IN SRV 0 5 5222 delvicious.com.
_xmpp-server._tcp 18000 IN SRV 0 5 5269 delvicious.com.
conference 18000 IN A 54.235.124.190
