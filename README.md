# Fetch Take-Home iOS Project – Mariana Montoya

### Summary:

<p> My recipe app is a lightweight, image-forward experience designed for quick browsing and sharing. Users can refresh, search, and view detailed recipe cards with direct links to the original source. With a rustic design and minimal color palette, it’s built to feel intuitive and warm—ideal for home cooks who want inspiration at a glance. </p>

### Screenshots
<p align="center">
  <img src="https://github.com/marianamontoya/MontoyaFetch/raw/main/Demos/ContentViewDemo.png" width="300" alt="Content View" />
  <br />
</p>

<p align="center">
  <img src="https://github.com/marianamontoya/MontoyaFetch/raw/main/Demos/RecipeDemo.png" width="300" alt="Recipe Demo" />
  <br />
</p>

### Video Demo
[Watch on YouTube](https://youtube.com/shorts/VnsMEuZEcg4)


### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
<p> Given the project requirements, I identified efficient retrieval and handling of JSON data as the most critical component. I prioritized implementing this functionality in a clean, efficient manner to ensure the data loading process was reliable, fast, and thoroughly tested. I also paid attention to small optimizations that could maintain performance without overcomplicating the solution. After completing the project, I realized that unit testing is perhaps the most important focus, because without thorough testing, errors can go unnoticed and potentially cause the entire project to fail! </p>

<p> In terms of user experience, I placed a strong emphasis on visuals. I believe that when it comes to recipes, images play a crucial role. That’s why I prioritized making the images visible on the main list view. Additionally, I added a larger version of the image in the recipe detail view, along with an easy way to access the original source website. </p>

<p> For design, I aimed for a clean and rustic baking aesthetic. I chose the American Typewriter font to give it a warm, handcrafted feel, and used a minimal black-and-white color scheme to keep the focus on the recipes themselves. Overall, my goal was to create a smooth, functional experience that felt both practical and visually inviting. </p>
    
### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

### ~12 hours (about 2 hours/day)

- **Day 1:** Reviewed JSON handling; revisited old projects to refresh.
- **Day 2:** Parsed JSON successfully, started image caching research.
- **Day 3:** Implemented caching, updated image views and navigation.
- **Day 4:** Focused on visuals and started learning unit testing.
- **Day 5:** Dedicated to writing and refining unit tests, wrote README.
- **Day 6:** Final testing, polish, created app icon.

<h4> Day One </h4>
<p> Figuring out the JSON and getting it read into the app. Since I hadn’t worked with JSON in a while, I revisited past projects to refresh my understanding. It involved a lot of research, trial and error, I didn’t make major visual progress on the app that day, but I gained a stronger understanding of the project requirements and refreshed key concepts, which helped everything move faster later. </p>

<h4> Day Two </h4>
<p> This day went much better—I got the JSON working quickly! At first, I used URLSession, which seemed fine until I reread the instructions more carefully. So, I spent time learning how to create an image cache, since I hadn’t done it that way before.</p>

<h4> Day Three </h4>
<p> It took some time, but I finally got the caching working. Then I shifted focus to the visuals—loading images from the JSON, updating the scroll view, and setting up the navigation link.</p>

<h4> Day Four </h4>
<p> I continued refining the design and adding my personal touch. I saved testing for last since I hadn’t tried unit testing before. A friend lent me a book called "iOS Unit Testing by Example", so I spent time learning how to write and run tests, along with going through Apple’s documentation. </p>

<h4> Day Five </h4>
<p> This day was mostly dedicated to unit testing—and more unit testing. I took breaks to write the README and make sure the UI looked the way I wanted.</p>

<h4> Day Six </h4>
<p> On the final day, I wrapped up unit testing and made sure all tests ran smoothly and clearly. I also double-checked any last-minute details and created an app icon when I needed a break from testing. </p> 


<p><strong>Key lesson learned:</strong> Testing takes longer than you expect!</p>

<p>Overall, my workflow involved first understanding and parsing the JSON data, then figuring out how to efficiently load and cache images, followed by focusing on the user interface and navigation, and finally dedicating time to testing and refining the app. This step-by-step approach helped me gradually build the app while learning new concepts along the way.</p>

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
<p>I wanted to include the YouTube embedded player but was unable to do so. This was because, in order to embed videos with WebKit, you need the specific video ID. Since I only had the full YouTube URLs, it was difficult to extract the video ID and concatenate it into the embed link properly. Due to this technical limitation, embedding the player was not feasible within the project scope.</p>

<p> I made trade-offs when it came to unit testing. I would have liked to test my DiskImageCache struct as well, but given the time constraints, I felt I needed more time to understand it fully.</p>

<p>One decision I made was in the <code>DiskImageCache</code> struct, where I had to choose between using SHA256 and SHA1 for creating the hash. I chose SHA1 for its speed and smaller footprint, which I felt was sufficient given the app’s needs and lack of sensitive data. Since this app does not handle sensitive user information, I felt SHA1 was sufficient. However, if security became a concern, such as handling user data, I would switch back to SHA256 for stronger protection.</p>

<p>Additionally, I opted to use <code>.ephemeral</code> for the image loader session because it is more lightweight. Since the app loads a significant number of images, I felt this approach would be more efficient and better suited for the use case.</p>

### Weakest Part of the Project: What do you think is the weakest part of your project?
<p> I believe the weakest part of my project is the functionality. While the core features are in place, there’s definitely room to add more especially by including the actual recipe information within the app. Adding detailed recipe content would greatly improve the user experience and make the app more valuable. Expanding functionality like this could transform the app from a simple image viewer into a practical cooking assistant. This reflection gives me clear ideas for future improvements and priorities.
</p>

<p> Another weak area is the unit testing. This project introduced me to iOS unit testing. I was in learning mode—but it gave me a strong foundation to build on. There are plenty of areas I could test and learn more about, which is why I feel this is my weakest part. I am however, excited to continue building my unit testing skills by practicing more complex test cases and exploring best practices, so I can write more thorough and effective tests in future projects. </p>

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

  <p> In an ideal world, I would have loved to incorporate the full recipe instructions and ingredient lists into the app. I’m still exploring what that would involve, but I imagine it would make the app much more useful. I also want to include embedded YouTube videos to provide helpful cooking tutorials. These features would significantly enhance the user experience, but I faced time and technical constraints during this project.
  </p>
  
  <p> Overall, I really enjoyed this project and the opportunity to build something like this. It pushed me out of my comfort zone in some ways and really tested me. I’m grateful to get insight into how the interview process works for iOS development jobs, especially since I only started learning about iOS development six months ago. I know I took longer than the expected 4–5 hours, but I really enjoyed fixing, tweaking, and researching every little part. I also felt it was important to take full advantage of the roughly 1–2 weeks given to complete this. Thank you again for the opportunity to work on this challenge. It was both a learning experience and a creative outlet, and I’d be excited to contribute this kind of care and curiosity to Fetch’s work.
  
  </p>
