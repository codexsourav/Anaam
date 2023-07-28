<p>Anaam Social Media App by Sourav is a cutting-edge platform developed using Flutter and Firebase. It offers users a seamless and intuitive social networking experience, allowing them to connect, share, and interact effortlessly. With a user-friendly interface, Anaam enables posting multimedia content, following friends, and discovering trending topics. Powered by Firebase, the app ensures real-time updates, secure authentication, and reliable cloud storage. </p>
<p><br></p>
<p><br></p>
<h3 style="text-align: center;"><strong>Login/Auth Pages:</strong><br></h3>
<p><br></p>
<p><strong><img src="https://firebasestorage.googleapis.com/v0/b/codexsourav-404.appspot.com/o/images%2Fd846d6e5-f866-447c-baca-81b7faea9ecf20230728_115930.jpg?alt=media&amp;token=2a0ac7fc-104b-4508-94b6-c066546741a6" alt="auth  pages" style="display: block; margin-left: auto; margin-right: auto;" width="300px"></strong></p>
<p><strong>1. **Sign Up:**</strong><br> When a new user opens the Anaam app for the first time, they are presented with a signup screen. The signup process typically involves the following steps:<br> - User enters their email address and creates a strong password.<br> - The app validates the email format and checks if the email is not already registered in the system.<br> - If the email is valid and unique, the user's credentials (email and password) are securely stored in Firebase Authentication.<br> - After successful signup, the user is redirected to their profile page or asked to complete their profile details.<br><br><strong>2. **Login:**</strong><br> Once a user has signed up and wants to log in to the app, they are taken to the login screen. The login process involves the following steps:<br> - User enters their registered email address and password.<br> - The app securely sends this information to Firebase Authentication for verification.<br> - Firebase compares the provided credentials with the stored ones and validates whether they match.<br> - If the login credentials are correct, the user is granted access to their account, and they are redirected to their home feed or personalized dashboard.<br><br><strong>3. **Forgot Password:**</strong><br> In case a user forgets their password and can't log in, the "Forgot Password" feature comes to the rescue. The steps are as follows:<br> - On the login screen, there is an option/link to "Forgot Password."<br> - When the user clicks on this option, they are taken to a password reset screen.<br> - Here, the user is prompted to enter their registered email address.<br> - After the user submits their email, Firebase sends a password reset email to that address.<br> - The email contains a password reset link with a unique token.<br> - Clicking on the link redirects the user to a secure page within the app, allowing them to set a new password.<br> - Once the new password is set and submitted, Firebase updates the user's password accordingly, and they can log in using the new credentials.</p>
<p><br></p>
<p><br></p>
<p style="text-align: center;"><strong style="font-size: 18px;">Post Feed/Add Post/Like Post Pages:</strong></p>
<p><br></p>
<p><br></p>
<p><img src="https://firebasestorage.googleapis.com/v0/b/codexsourav-404.appspot.com/o/images%2F795136bf-8180-4f2a-8e90-10ab45c6b2d720230728_120043.jpg?alt=media&amp;token=166a2c67-693a-435a-9bfc-7794df89b1c1" alt="home pages" style="display: block; margin-left: auto; margin-right: auto;" width="300px"></p>
<p><br></p>
<p><strong>1. **Post Feed:**</strong><br> The Post Feed is a central part of the Anaam app, where users can view and interact with posts from other users they follow. The Post Feed typically functions as follows:<br> - Upon logging in, users are directed to their personalized Post Feed, where they see a chronological list of posts from users they follow.<br> - Each post in the feed displays relevant information, such as the author's name, profile picture, timestamp, and the content of the post (text, image, video, etc.).<br> - Users can scroll through the feed to view older posts, and new posts automatically appear at the top of the feed as they are added by other users.<br> - The Post Feed fosters engagement and social interaction by allowing users to like and comment on posts directly from the feed.<br><strong><br>2. **Add Post:**</strong><br> The Add Post feature empowers users to create and share their own content with their followers. The process of adding a post typically involves the following steps:<br> - Users access the "Add Post" screen by clicking on a dedicated button, usually located in the app's navigation bar or menu.<br> - In the "Add Post" screen, users can compose their post by entering text, attaching images, videos, or any other multimedia content they want to share.<br> - After composing the post, users can choose to add relevant hashtags or tags to make their post more discoverable to others interested in similar topics.<br> - Once the user is satisfied with the content and details of the post, they can click the "Post" button to publish it on their profile and make it visible in their followers' Post Feeds.<br><strong><br>3. **Like:**</strong><br> The Like feature allows users to show appreciation and support for posts they find interesting or enjoyable. Here's how liking a post typically works:<br> - Within the Post Feed, each post is accompanied by a "Like" button (often represented by a heart icon).<br> - When a user comes across a post they want to like, they can tap the "Like" button associated with that specific post.<br> - The app then sends a request to the server, updating the post's like count and associating the user's account with the liked post.<br> - The heart icon may change color (e.g., from empty to filled) to indicate that the post has been liked successfully.<br> - Users can like as many posts as they want, and the like count of each post is visible to all users who can view the post.</p>
<p><br></p>
<p style="text-align: center;"><strong style="font-size: 18px;">Comments Page:</strong></p>
<p><br></p>
<p><br></p>
<p><img src="https://firebasestorage.googleapis.com/v0/b/codexsourav-404.appspot.com/o/images%2F69cc1117-bb7e-40c3-b2b5-8a734eed02be20230728_120306.jpg?alt=media&amp;token=bef4c2c0-a559-4062-964d-6d6cc1667cc9" alt="comment page" style="display: block; margin-left: auto; margin-right: auto;" width="300px"><br></p>
<p>- On the Comment Page of a post, users can leave their thoughts and opinions by typing their comment in a text input box.<br>- After composing their comment, users can click the "Post" button to submit it.<br>- Once posted, the comment becomes visible to all users who can access the Comment Page.<br>- Users can also like and reply to comments left by others, fostering interactions and discussions on the post.</p>
<p><br></p>
<p><strong style="font-size: 18px;"><br></strong></p>
<p style="text-align: center;"><strong style="font-size: 18px;">Follow/Unfollow System<br></strong></p>
<p><br></p>
<p><img src="https://firebasestorage.googleapis.com/v0/b/codexsourav-404.appspot.com/o/images%2Faa3e0295-3c88-43cf-a649-f7c4c39ed69f20230728_120401.jpg?alt=media&amp;token=b5cb2fa6-f462-4ff5-b6fe-18386cb7b1c4" alt="follow unfolllow" style="display: block; margin-left: auto; margin-right: auto;" width="300px"><br></p>
<p><br></p>
<p><strong>- **Follow:**</strong></p>
<p> When a user follows another user, they opt to receive updates and content from that user in their feed. By following someone, their posts and activities become visible in the follower's Post Feed, allowing them to stay up-to-date with the followed user's updates.<br><strong><br>- **Unfollow:**</strong></p>
<p> If a user no longer wishes to see content from someone they previously followed, they can choose to unfollow them. Unfollowing a user removes their posts and activities from the follower's Post Feed, providing a more personalized feed experience.</p>
<p><br></p>
<p><br></p>
<p style="text-align: center;"><strong style="font-size: 18px;">Chat </strong><strong>System With Notifications</strong><br></p>
<p><br></p>
<p><img src="https://firebasestorage.googleapis.com/v0/b/codexsourav-404.appspot.com/o/images%2F10dc8866-ce38-48f5-ac28-c0e76d22283920230728_120651.jpg?alt=media&amp;token=cf656f5b-825c-478e-b903-1fff79c49b66" alt="chat psages" style="display: block; margin-left: auto; margin-right: auto;" width="300px"></p>
<p><br></p>
<p><strong>1. **Chat System:**</strong><br> - The Chat System allows users to have real-time conversations with other users one-on-one or in groups.<br> - Users can access their chats through a dedicated "Messages" section or a chat icon in the app's interface.<br><strong><br>2. **Sending Messages:**</strong><br> - Users can select a recipient or a group of recipients from their contacts or followers to start a chat.<br> - They can type their message in a text input box and click the "Send" button to deliver the message.<br><br><strong>3. **Receiving Notifications:**</strong><br> - When a user receives a new message in a chat, the app sends a notification to their device.<br> - Notifications alert the user about the incoming message, even when the app is not actively open.<br><strong><br>4. **Chat Updates:**</strong><br> - The chat interface updates in real-time, showing new messages as they arrive.<br> - New messages typically appear at the bottom of the chat, and the chat window automatically scrolls to display them.</p>
<p><br></p>
<p><br></p>
<p><br></p>
<p style="text-align: center;"><a href="https://github.com/codexsourav/Anaam" class="buttonDownload" target="_blank">View Code<br></a></p>
<p style="text-align: center;"><br></p>
<p><br></p>
<p><br></p>
<p><strong>Technologies I Used:</strong></p>
<ul>
    <li style="margin-left: 20px;">Flutter</li>
    <li style="margin-left: 20px;">Firebase</li>
    <li style="margin-left: 40px;">Firebase Firestore</li>
    <li style="margin-left: 40px;">Firebase Storage</li>
    <li style="margin-left: 40px;">Firebase auth (email,password)</li>
    <li style="margin-left: 40px;">Firebase Push Notification</li>
</ul>
<p><br></p>
<p><br></p>
