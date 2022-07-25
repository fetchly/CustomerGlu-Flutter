# **Instructions**


# Starting

**1.** Download the repository and start it by running the command `flutter run` in your terminal.

**2.** Make sure to change this value `android:value="YOUR_WRITE_KEY"` in your `AndroidManifest.xml`. You will need to contact the CostumerGlu team to receive the credentials.

# Registering / Logging in

**3.** For registering a User you can click on the Register User button. You can check at this page for the [Register User Payload](https://docs.customerglu.com/integration-doc#register-a-device). The Register function is also used for updating user attributes. You will pass the user object on this function `bool is_registered = await CustomergluPlugin.registerDevice(userData,loadCampaigns: true)`, you can check more about the `userData` object in the [Documentation](https://docs.customerglu.com/sdk/flutter#register-user-mandatory)

![](https://cdn.discordapp.com/attachments/991788426078732398/1000815771166965791/Peek_24-07-2022_14-20.gif)

**4.** Clear Data will let you clear the cached data.

![](https://cdn.discordapp.com/attachments/991788426078732398/1000815771569635408/Peek_24-07-2022_14-21.gif)

# Wallet & Campaigns

**5.** Clicking on Open Wallet will redirect you to a new view, the Wallet Page, where user will be able to see all challanges and rewards.

![](https://cdn.discordapp.com/attachments/991788426078732398/1000815771871613018/Peek_24-07-2022_14-22.gif)

**6.** By clicking on Load campaign by id, will be opening one of the campaigns generated in your dashboard. The id will be automatically generated once you create the Campaign. The id is passed by on this function `CustomergluPlugin.loadCampaignById("CAMPAIGN_ID/TAG",autoclosewebview: true);`

![](https://cdn.discordapp.com/attachments/991788426078732398/1000815772496576552/Peek_24-07-2022_14-23.gif)

You can check more about the documentation by clicking [here](https://docs.customerglu.com/sdk/flutter)
