# Syval Take-Home Project: Social Media Post Feature
### by George Garcia

## Overview
This take home project is a social media feature for Syval that aims to enhance financial wellness and emotional awareness for Gen Z users. Built using SwiftUI and Swift

## My design decisions

### 1. Emotional Context for Financial Transactions
The core concept behind Syval is connecting emotions to financial decisions. This current implementation achieves this with some features:

1. Feeling Selection : Users can attach emotions to their financial posts using emoji reactions (Happy 😊, Neutral 😐, Sad 😞)

2. Hashtag Categories : Posts are categorized with emotionally relevant hashtags (#flex, #reflect, #reward, #uncertain, #necessary, #supportive) that help users contextualize their spending

3. Visual Differentiation : Each hashtag category has a distinct color that provides immediate visual feedback on the emotional context of a transaction

### 2. Social Support
The social aspects of the app are designed to create a supportive community around financial decisions:

1. Tagging Friends: Users can tag up to 5 friends in their financial posts

2. Interaction Mechanisms: Standard social media interactions (likes, comments) encourage engagement and support

3. Shared Financial Experiences: The feed design emphasizes shared experiences around spending and saving

### 3. Personal Goals Feature
Financial goals are deeply integrated into the posting experience:

1. Goal Selection: Users can attach transactions to specific financial goals within a post

2. Progress Visualization: Each post shows how a transaction impacts progress toward a selected goal

3. Visual Progress Indicators: Progress bars provide immediate feedback on goal advancement

### 4. User Interface Design
The UI is designed with Gen Z preferences in mind. I think the vibrant color scheme would be strategic since it uses the color to highlight emotional states and actions

## Technical Implementation
### Architecture
This project follows the MVVM (Model-View-ViewModel) architecture pattern where:

1. Models: Simple data structures (Post, Goal, Friend, etc.) that represent the core entities
2. ViewModels: Manage business logic and state (CreatePostViewModel, HomeViewModel)
3. Views: SwiftUI components that render the UI based on view model state

### SwiftUI View Components and Mock Data
1. CreatePostView: A screen for creating financial posts with emotional context
2. PostView: Represents a Post item in the list of posts. This displays all associated metadata and interactions
3. MockDataService: This is where we provide sample data for demonstration purposes

## Trade-offs
### 1. Simplicity vs. Feature Richness
I was more focused on the core features that demonstrate the concept clearly. Although the tradeoff would be some advanced features like post editing, filtering, or media integration, I just decided to prioritize the core concept of emotional financial sharing over feature completeness

### 2. Mock Data vs. Real Backend
Used mock data services to simulate backend functionality, however, there is no real persistence or network operations in the current implementation. In the end, it allows focus on frontend experience while demonstrating data flow patterns

### 3. Guided Experience vs. User Freedom
I was thinking of choosing a guided post creation flow with required field. I suppose the trade off would be less flexibility for users who might want to post with minimal information. I think the reason for me ti implement this is to ensure post contain sufficient context for meaningful social and emotional insights

## Potential Ideas for Future Enhancements
### 1. Expanded Social Features
I had an idea where there can be financial challenges for saving or mindful spending. I thought of adding these features to encourage users to take control of their finances and make positive changes

### 2. Gamification Elements
Maybe like a reward system for positive financial behaviors and emotional awareness. Perhaps badges on a user's profile to show their progression

### 3. Enhanced Goal 
I think it would be interesting if we had users share their goals with their friends to encourage them to make positive financial decisions. Show some milestones and rewards for achieving them

## Areas for Improvement (if i had more time)
### 1. User Experience
I wanted to add an onboarding flow for the app to help users understand the features and how to use it.
There are also users who would have disabilities so adding accessibility features like VoiceOver could be a nice to have. Lastly, I would improve the UI for better user experience

### 2. Technical Architecture
First, I would implement a more robust state management solution for complex interactions and data handling. 

Second, I would also include testing coverage like unit and UI tests. 

Finally, I would consider more modularization in the codebase. Meaning breaking down large views into more reusable components. Depending the size of the project, I would probably use the Atomic Design approach

### 3. Data Handling
The current implementation lacks the capability to persist data and to create posts while being offline, so adding data persistence and offline capabilities would be a priority.

I would also implement a more robust validation for user inputs and then perhaps add some privacy controls to control who can see posts. 

## Conclusion
This was a fun project to work on!

This implementation demonstrates how a social media feature can enhance financial wellness for Gen Z users by connecting emotions to spending and integrating goal tracking. The design prioritizes emotional awareness and social connection while maintaining a focus on financial growth.
