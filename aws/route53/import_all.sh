for ZONE in vine.im delvicious.com dashdash.com  dashdashinc.com dashdash.co dashdsah.com
do
    # cli53 create $ZONE  #NOTE comment this out if the Hosted Zones already exist in Route53, otherwise this will make duplicates
    cli53 import $ZONE -f $ZONE -r
    echo ''
done
