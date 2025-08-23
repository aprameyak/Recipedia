use crate::sup::*;
use mongodb::{Collection, bson::doc};

#[flutter_rust_bridge::frb]
pub fn new_post(uid: String, recipe: String, cap: String, image: String) {
    // TODO: Implement post creation logic
}

#[flutter_rust_bridge::frb]
pub fn new_user(id: String, username: String, pic: String, bio: String, about: String) {
    let _user = User::new(id, username, pic, bio, about);
    // TODO: Implement user creation logic
}
