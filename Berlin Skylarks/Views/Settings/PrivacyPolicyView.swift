//
//  PrivacyPolicyView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 28.04.22.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            Text("""
                 **Data protection statement according to § 13 TMG**.

                 This statement is intended to inform visitors about the policies regarding the collection, use and disclosure of personal information.

                 If you choose to use the app, you consent to the collection and use of information in accordance with this policy. The information I collect will be used to provide and improve the service. I will only use or share your information as described in this Privacy Policy.

                 The app "Berlin Skylarks" was developed by David Battefeld as a free and open source app without intention of making any profit. It is an app for providing game data and other information for the Berlin baseball club "Skylarks". The Skylarks are a legally non-independent department within the Turngemeinde in Berlin 1848 e.V..

                 The club itself does not act as publisher or operator of this app, operator in the sense of these rules is solely:

                 David Battefeld
                 Leibnizstrasse 40
                 10629 Berlin
                 app@tib-baseball.de
                 (hereinafter "operator")

                 **1. What data is collected?**

                 The app does not collect any personal data. There is no possibility to enter or store names, mail addresses, phone numbers, IP addresses or similar data. Such data is also not read from device memory, otherwise collected or linked.

                 There is also no app tracking of any kind. The app does not collect usage statistics.

                 **2. Data Sharing with Third Parties**.

                 Since no personal data is collected, it cannot be shared with third parties.

                 **3. Log data/crash reports**.

                 When using the App, data and information may be collected on your device in the event of an error in the App, which is referred to as log data. This log data may include information such as the device name, the version of the operating system, the configuration of the App when you use my Service, the time and date of your use of the Service, and other statistics. All of this data is generally completely anonymous and cannot be traced to individual devices or users.

                 **4. Calendar Access**.

                 The App may in certain cases request access to calendars stored on the User's device. These calendars are used only for the purpose of transferring the games displayed in the App to the requested calendar. Such transfer is always made at the explicit request of the user and never in the background. No further access, readout, processing or modification of calendar data takes place.

                 **5. Use of external data**

                 The app uses the interface of the German Baseball and Softball Association (DBV) for the display of data, which is described at https://bsm.baseball-softball.de/api_docs. The app provider assumes no responsibility for the accuracy, completeness or timeliness of the displayed data obtained through this interface.

                 **6. Links to other sites**

                 The App may contain links to other websites. When you click on a third party link, you will be redirected to that site. Note that these external sites are not operated by the operator of this app. The latter therefore strongly recommends that you read the privacy policies of these websites. The Operator has no control over, and assumes no responsibility for, the content, privacy policies, or practices of any third party web sites or services.

                 **7. Deletion of all data**.

                 Deletion of the App will completely erase all data stored on the User's device. There is no way to recover it, as it will not be stored in any other location at any time.
                 Any permission to use the user's calendar as explained in §4 must be granted again after reinstalling the app.

                 **8. Changes to this privacy policy**.

                 The operator may update our privacy policy from time to time. We therefore recommend that you regularly check this page for changes. The Operator will notify you of any changes by posting the new Privacy Policy on this page.
                 
                 This privacy policy is valid as of 11/5/2022.
                 """)
#if !os(watchOS)
            .textSelection(.enabled)
#endif
            .padding()
        }
        .navigationTitle("Privacy Policy")
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
