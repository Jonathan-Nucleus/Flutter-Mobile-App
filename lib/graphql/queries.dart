final String fetchUser = """
query {
  fetchUser {
    _id
    introduction
    profilePhoto
    usernameId
    password
    phoneNumber
    myProducts{
      _id
      user {
        _id
        profilePhoto
        usernameId
      }
      images
      description
      price
      brand
      category
      style
      condition
      size
      soldOut
    }
    myCart{
      _id
      user {
        _id
        profilePhoto
        usernameId
      }
      images
      description
      price
      brand
      category
      style
      condition
      size
      soldOut
    }
    followers{
      _id
      profilePhoto
      usernameId
    }
    following{
      _id
      profilePhoto
      usernameId
    }
    notifications{
      _id
      message
    }
    notification
    directMessage
    marketing
  }
}
""";

final String getSoldProducts = """
query {
  getSoldProducts
}
""";

final String getRooms = """
query {
getRooms {
    _id
    other_user {
      usernameId
    }
    last_message {
      text
      createdAt
    }
    number_of_unread_messages
  }
}

""";

final String getRoom = """
query (\$_id: ID) {
  getRoom(_id: \$_id){
    user{
      _id
      usernameId
    }
    other_user{
      _id
      usernameId
    }
    messages {
      text
      createdAt
      sender{
        usernameId
      }
      receiver{
        usernameId
      }
    }
    number_of_unread_messages
  }
}
""";

final String getProduct = """
query (\$_id: ID) {
  getProduct(_id: \$_id){
    
    _id
    usernameId
    images
    description
    price
    brand
    category
    style
    condition
    size
  }
}
""";

final String getRecommendedProducts = """
query {
  getRecommendedProducts {
    _id
    images
    price
    user {
      profilePhoto
    }
  }
}
""";

final String fetchPopularUsers = """
query {
  fetchPopularUsers {
    _id
    profilePhoto
    usernameId
  }
}
""";

final String getPopularCategories = """
query {
  getPopularCategories {
    _id
    name
    image
    productsCount
  }
}
""";

final String getAllProducts = """
query {
  getAllProducts {
    _id
    images
    user {
      _id
      usernameId
      profilePhoto
    }
  }
}
""";

final String getMostRecentFollowing = """
query {
  getMostRecentFollowing {
    _id
    usernameId
    profilePhoto
  }
}
""";

final String getFeedProducts = """
query {
  getFeedProducts {
    _id
    images
    description
    user {
      _id
      usernameId
      profilePhoto
    }
    }
}
""";

final String getProductById = """
query (\$_id: ID) {
  getProductById(_id: \$_id){
    _id
    user {
      _id
      profilePhoto
      usernameId
    }
    images
    description
    price
    brand
    category
    style
    condition
    size
    soldOut
  }
}""";

final String fetchUserById = """
query (\$_id: ID) {
    fetchUserById (_id: \$_id){
    _id
    usernameId
    profilePhoto
    introduction
    myProducts {
      _id
      images
      description
      price
      brand
      category
      style
      condition
      size
      soldOut
    }
    followers {
      _id
    }
    following {
      _id
    }
  }
}""";

final String getCategories = """
query {
  getCategories {
    _id
    name
    image
    sub_categories {
      _id
      name
      image
    }
    }
  }
""";

final String getCategoryById = """
query (\$_id: ID) {
    getCategoryById(_id: \$_id){
    _id
    name
    image
    products {
      _id
      images
    }
  }
}
""";

final String searchProducts = """
query (\$searchText: String) {
    searchProducts(searchText: \$searchText){
    _id
    images
    brand
    price
    category
  }
}
""";
