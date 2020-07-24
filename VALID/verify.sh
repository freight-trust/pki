# SHA256SUMS FILE
curl -L --progress-bar ${DOWNLOAD}_${VERSION}_SHA256SUMS?direct -o tmp/<DOWNLOAD>${VERSION}_SHA256SUMS
 
# SHA256SUMS SIGNATURES FILE
curl -L --progress-bar https://dl.bintray.com/${ORG}/${DOWNLOAD}/_${VERSION}_SHA256SUMS.sig?direct -o tmp/${DOWNLOAD}_${VERSION}_SHA256SUMS.sig
 
#  BINARY
curl -L --progress-bar https://dl.bintray.com/${ORG}/${DOWNLOAD}/${VERSION}_linux_amd64.zip -o tmp/${DOWNLOAD}_${VERSION}_linux_amd64.zip
 
# PUBLIC KEY
 
gpg --import $org.gpg
gpg --verify tmp/${DOWNLOAD}_${VERSION}_SHA256SUMS.sig tmp/${DOWNLOAD}_${VERSION}_SHA256SUMS
 
SHA256_FROM_FILE=`grep ${DOWNLOAD}_${VERSION}_linux_amd64.zip tmp/${DOWNLOAD}_${VERSION}_SHA256SUMS | cut -d" " -f 1`
SHA256_FROM_OPENSSL=`openssl dgst -sha256 tmp/${DOWNLOAD}_${VERSION}_linux_amd64.zip | cut -d" " -f 2`
 
echo "SHA256_FROM_FILE = $SHA256_FROM_FILE"
echo "SHA256_FROM_OPENSSL = $SHA256_FROM_OPENSSL"
 
if [ "$SHA256_FROM_FILE" = "$SHA256_FROM_OPENSSL" ]
    then echo "SHA256 HASH MATCHES. PROCEED!"
else echo "SHA256 HASH DOES NOT MATCH. DO NOT CONTINUE!"
fi

