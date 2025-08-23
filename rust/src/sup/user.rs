use crate::sup::*;
use chrono::Utc;
use mongodb::{Client, Collection, bson::{doc, to_bson}};
impl User {
    pub fn new(
        user_id: String,
        username: String,
        profile_picture: String,
        bio: String,
        about: String,
    ) -> User {
        User {
            user_id: user_id,
            username: username,
            profile_picture: profile_picture,
            posts: Vec::<Post>::new(),
            score: 0.0,
            bio: bio,
            about: about,
            private_profile_enabled: false,
            user_created: Utc::now(),
        }
    }
    pub async fn add_post(&self, collection: &Collection<User>, post: Post) -> mongodb::error::Result<()> {
        let post_bson = to_bson(&post)?;
        collection.update_one(doc! {"user_id": &self.user_id}, doc!{"$push": {"posts": post_bson}},).await?;
        Ok(())
    }
    
}
