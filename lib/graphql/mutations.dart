final String removeNotification = """
mutation removeNoti(\$_id: ID) {
  removeNoti(_id: \$_id)
}
""";

final String editProfile = """
mutation updateUser(\$usernameId: String, \$introduction: String) {
  updateUser(usernameId: \$usernameId, introduction: \$introduction){
    usernameId
    introduction
  }
}
""";

final String loginUser = """
mutation loginUser(\$usernameId: String, \$password: String) {
  loginUser(usernameId: \$usernameId, password: \$password){
    accessToken
  }
}
""";

final String getPhoneAuthCode = """
mutation getPhoneAuthCode(\$name: String!, \$phoneNumber: String!, \$countryCode: String!) {
  getPhoneAuthCode(name: \$name, phoneNumber: \$phoneNumber, countryCode: \$countryCode)
}
""";

final String confirmPhoneAuthCode = """
mutation confirmPhoneAuthCode(\$phoneNumber: String!, \$code: String!, \$countryCode: String!) {
  confirmPhoneAuthCode(phoneNumber: \$phoneNumber, code: \$code, countryCode: \$countryCode){
    accessToken
  }
}
""";
final String confirmEditedPhoneAuthCode = """
mutation confirmEditedPhoneAuthCode(\$phoneNumber: String!, \$code: String!, \$countryCode: String!) {
  confirmEditedPhoneAuthCode(phoneNumber: \$phoneNumber, code: \$code, countryCode: \$countryCode)
}
""";

final String updatePassword = """
mutation updatePassword(\$newPass: String) {
  updatePassword(newPass: \$newPass)
}
""";

final String updateNoti = """
mutation updateNotification(\$pushNoti: Boolean, \$directMessage: Boolean, \$marketing: Boolean) {
  updateNotification(pushNoti: \$pushNoti, directMessage: \$directMessage, marketing: \$marketing)
}
""";

final String registerUser = """
mutation registerUser(\$usernameId: String, \$password: String) {
  registerUser(usernameId: \$usernameId, password: \$password)
}
""";

final String updateUserPhoto = """
mutation updateUserPhoto(\$profilePhoto: Upload) {
  updateUserPhoto(profilePhoto: \$profilePhoto){
    filename
    mimetype
    encoding
    uri
  }
}
""";

final String createRoom = """
mutation createRoom(\$otherUserId: ID) {
  createRoom(otherUserId: \$otherUserId){
    _id
    user{
      usernameId
    }
    other_user{
      usernameId
    }
    messages{
      text
    }
    number_of_unread_messages
    createdAt
  }
}
""";

final String sendMessage = """
mutation sendMessage(\$receiverId: ID, \$text: String) {
  sendMessage(receiverId: \$receiverId, text: \$text){
    _id
    text,
    receiver{
      usernameId
    }
    sender{
      usernameId
    }
    createdAt
  }
}
""";

final String createProduct = """
mutation createProduct(
\$user: ID,
\$images: [Upload],
\$price: Int,
\$brand: String,
\$category: String,
\$condition: String,
\$size: String,
\$style: String,
\$description: String,
\$soldOut: Boolean) {
createProduct(
user: \$user,
images: \$images,
price: \$price,
brand: \$brand,
category: \$category,
condition: \$condition,
size: \$size,
style: \$style,
description: \$description,
soldOut: \$soldOut)  
}
""";

final String follow = """
mutation follow(\$_id: ID) {
  follow(_id: \$_id)
}
""";

final String unfollow = """
mutation unfollow(\$_id: ID) {
  unfollow(_id: \$_id)
}
""";

final String addProduct = """
mutation addProduct(\$_id: ID) {
  addProduct(_id: \$_id)
}
""";

final String removeProduct = """
mutation removeProduct(\$_id: ID) {
  removeProduct(_id: \$_id)
}
""";

final String deleteProduct = """
mutation deleteProduct(\$_id: ID) {
  deleteProduct(_id: \$_id)
}
""";

final String updateSoldProduct = """
mutation updateSoldProduct(\$_id: ID, \$soldOut: Boolean) {
  updateSoldProduct(_id: \$_id, soldOut: \$soldOut)
}
""";

final String updateProduct = """
mutation updateProduct(
\$_id: ID,
\$newImages: [Upload],
\$removedImagesIndexes: [Int],
\$price: Int,
\$brand: String,
\$category: String,
\$condition: String,
\$size: String,
\$style: String,
\$description: String
) {
updateProduct(
_id: \$_id,
newImages: \$newImages,
removedImagesIndexes: \$removedImagesIndexes,
price: \$price,
brand: \$brand,
category: \$category,
condition: \$condition,
size: \$size,
style: \$style,
description: \$description)  
}
""";
