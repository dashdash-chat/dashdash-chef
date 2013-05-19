$ORIGIN dashdashinc.com.
@ 3600 IN A 184.72.244.2
@ 3600 IN MX 10 aspmx.l.google.com
@ 3600 IN MX 20 alt1.aspmx.l.google.com
@ 3600 IN MX 20 alt2.aspmx.l.google.com
@ 3600 IN MX 30 aspmx2.googlemail.com
@ 3600 IN MX 30 aspmx3.googlemail.com
@ 172800 IN NS ns-72.awsdns-09.com.
@ 172800 IN NS ns-1506.awsdns-60.org.
@ 172800 IN NS ns-828.awsdns-39.net.
@ 172800 IN NS ns-1737.awsdns-25.co.uk.
@ 900 IN SOA ns-72.awsdns-09.com. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400
@ 3600 IN TXT "google-site-verification=xSIzo39gyVe2fbXd6Jr_-h50Y8zZNJYmMA2xjYBOIno"
@ 3600 IN TXT "v=spf1 include:_spf.google.com ~all"
mail 3600 IN CNAME ghs.googlehosted.com
www 3600 IN CNAME dashdashinc.com
