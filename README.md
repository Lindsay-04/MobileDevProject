# Project TechToTech Security Event App - Mobile development IOS

## Authors
Lindsay Rébeau, Baptiste Keunebroek, Mohammed Saber Bellaaziri

## Version 
1.0

## Build and Runtime Requirements

Xcode 6.0 or later (download it for free from the Mac App Store)
iOS 8.0 or later

## Description
As the iOS development team at TechToTech agency, we created a mobile application for our client's next event. The event is a 2-day security conference. During these 2 days, there will be several types of conferences and activities spread over several rooms. This application will make it easier for visitors to find their way around the event, with all schedules and information on their cell phone. 

## Launch the project 

### 1. Download or clone the project from GitHub

- Use the command `git clone` :  git clone https://github.com/username/project-name.git
- Download zip files 

### 2. Open Xcode

### 3. Open the project in Xcode and configure

- Select "Open another project..." from the welcome screen or from the "File" menu.
- Navigate to the cloned project directory and select the file with the extension ".xcodeproj" or ".xcworkspace".
- Choose the simulator or device on which you wish to run the application.

### 4. Configuration 
To create an API token on Airtable and add it in Xcode to access the data in your Airtable database, follow these steps:

### Step 1: Create an API token on Airtable

1. Log in to your Airtable account at [airtable.com](https://airtable.com).
2. Access the database you wish to use in your application.
3. Click on the name of your database to access the settings.
4. Select the "API" tab in the database parameters.
5. Under "API Access", click on the "Create Token" or "Generate API Key" button.
6. Copy the generated token. This token will be used to authenticate requests to your Airtable database.


### Step 2: Add the token to Xcode

Now that you have your API token, you can add it to your Xcode project for use in your network requests. Here's how to do it:

1. Open your Xcode project.
2. In the project browser, find or create the file where you want to store the API token. This is usually done in a configuration file or a constant file.
3. Create a constant or variable to store your API token. For example:

   ```swift
   let airtableAPIKey = "YOUR_API_ICI_TOKEN"
   ```

   Make sure you replace `"YOUR_API_ICI_JETON"` with the token you copied from Airtable.

4. Use this constant or variable in your code when making requests to the Airtable API. For example:

   ```swift
   let headers = ["Authorization": "Bearer\(airtableAPIKey)"]
   ```

   This line of code will be used to include the API token in the headers of your network requests to Airtable.



### Step 3: Use the token in your network requests

Now that you've added your API token to your Xcode project, you can use it to authenticate your network requests to Airtable. Be sure to include this token in the headers of your HTTP requests as described in the previous step.

By following these steps, you can create an API token on Airtable and add it to your Xcode project to securely access data in your Airtable database.
### 4. Run the project

- Press the play button to compile and run the project.
- See the results with the simulator or a real device with the application running.


