# 1.创建根证书
# rootCA.key是根证书的私钥，rootCA.crt是自签名的根证书，有效期设为10年
openssl genpkey -algorithm RSA -out rootCA.key
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.crt -subj "/CN=testkuas.kylincloud.org"

# 2.创建中间证书
# intermediate.key是中间证书的私钥，intermediate.csr是证书签名请求，intermediate.crt是签署后的中间证书
openssl genpkey -algorithm RSA -out intermediate.key
openssl req -new -key intermediate.key -out intermediate.csr -subj "/CN=testkuas.kylincloud.org"
# 使用根证书签署中间证书
openssl x509 -req -in intermediate.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out intermediate.crt -days 3650 -sha256

# 3.创建服务器证书
# server.key是服务器的私钥，server.csr是服务器证书的签名请求，server.crt是最终的服务器证书，有效期设为一年
openssl genpkey -algorithm RSA -out server.key
openssl req -new -key server.key -out server.csr -subj "/CN=testkuas.kylincloud.org"
# 使用中间证书签署服务器证书
openssl x509 -req -in server.csr -CA intermediate.crt -CAkey intermediate.key -CAcreateserial -out server.crt -days 365 -sha256


cat rootCA.crt intermediate.crt server.crt > fullchain.crt