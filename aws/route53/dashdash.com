$ORIGIN dashdash.com.
@ 300 IN A 184.72.244.2
@ 3600 IN MX 10 ASPMX.L.GOOGLE.COM.
@ 3600 IN MX 20 ALT1.ASPMX.L.GOOGLE.COM.
@ 3600 IN MX 20 ALT2.ASPMX.L.GOOGLE.COM.
@ 3600 IN MX 30 ASPMX2.GOOGLEMAIL.COM.
@ 3600 IN MX 30 ASPMX3.GOOGLEMAIL.COM.
@ 172800 IN NS ns-1860.awsdns-40.co.uk.
@ 172800 IN NS ns-1493.awsdns-58.org.
@ 172800 IN NS ns-64.awsdns-08.com.
@ 172800 IN NS ns-645.awsdns-16.net.
@ 900 IN SOA ns-1860.awsdns-40.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
@ 3600 IN TXT "google-site-verification=wf29PjGZp7Exin3ppCTolMg_2Rc6rn7vcdNARysAzYw"
_xmpp-client._tcp 300 IN SRV 0 5 5222 xmpp.dashdash.com
_xmppconnect 300 IN TXT "_xmpp-client-xbosh=https://xmpp.dashdash.com:5281/http-bind/"
blog 3600 IN CNAME domains.tumblr.com
leaves 300 IN A 54.235.240.250
www 300 IN CNAME dashdash.com
xmpp 300 IN A 107.21.218.247
