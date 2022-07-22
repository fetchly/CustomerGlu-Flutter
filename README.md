# **Instructions**


# Starting

**1.** Download the repository and start it by running the command `flutter run` in your terminal.

**2.** Make sure to change this value `android:value="YOUR_WRITE_KEY"` in your `AndroidManifest.xml`. You will need to contact the CostumerGlu team to receive the credentials.

# Registering / Logging in

**3.** For registering a User you can click on the Register User button. You can check at this page for the [Register User Payload](https://docs.customerglu.com/integration-doc#register-a-device). The Register function is also used for updating user attributes.

**4.** Clear Data will let you clear the cached data.

# Wallet & Campaigns

**5.** Clicking on Open Wallet will redirect you to a new view, the Wallet Page, where user will be able to see all challanges and rewards.

**6.** By clicking on Load campaign by id, will be opening one of the campaigns generated in your dashboard. The id will be automatically generated once you create the Campaign. The id is passed by on this function `CustomergluPlugin.loadCampaignById("CAMPAIGN_ID/TAG",autoclosewebview: true);`
