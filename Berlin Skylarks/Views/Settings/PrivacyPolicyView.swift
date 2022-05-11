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
            Text("WIP!")
            Text("""
                 **Datenschutzerklärung gemäß  § 13 TMG**

                 Diese Erklärung dient dazu, Besucher über die Richtlinien bezüglich der Sammlung, Verwendung und Weitergabe von personenbezogenen Daten zu informieren.

                 Wenn Sie sich für die Nutzung der App entscheiden, erklären Sie sich mit der Sammlung und Nutzung von Informationen im Sinne dieser Richtlinie einverstanden. Die von mir gesammelten Daten werden für die Bereitstellung und Verbesserung des Dienstes verwendet. Ich werde Ihre Daten nur wie in dieser Datenschutzrichtlinie beschrieben verwenden oder weitergeben.

                  Die App "Berlin Skylarks" wurde von David Battefeld als kostenlose und quelloffene App ohne jede Gewinnerzielungsabsicht entwickelt. Es handelt sich um eine App für die Bereitstellung der Spieldaten und weiterer Informationen des Berliner Baseballvereins "Skylarks". Die Skylarks sind eine rechtlich nicht selbstständige Abteilung innerhalb der Turngemeinde in Berlin 1848 e.V.

                 Der Verein selbst ist nicht als Herausgeber oder Betreiber dieser App tätig, Betreiber im Sinne dieser Ordnung ist allein:

                 David Battefeld
                 Leibnizstraße 40
                 10629 Berlin
                 app@tib-baseball.de
                 (nachfolgend "Betreiber")

                 **1. Welche Daten werden erfasst?**

                 Die App erfasst keinerlei personenbezogene Daten. Es gibt keine Möglichkeit, Namen, Mailadressen, Telefonnummern, IP-Adressen oder ähnliche Daten anzugeben oder zu speichern. Solche Daten werden auch nicht aus dem Geräte-Speicher ausgelesen, anderweitig erfasst oder verknüpft.

                 Es ist außerdem kein App-Tracking irgendeiner Art eingerichtet. Die App erfasst keine Nutzungsstatistiken.

                 **2. Datenweitergabe an Dritte**

                 Da keine personenbezogenen Daten erfasst werden, können diese auch nicht mit Dritten geteilt werden.

                 **3. Log-Daten/Absturzberichte**

                 Bei der Nutzung der App können im Falle eines Fehlers in der App Daten und Informationen auf Ihrem Gerät erheben werden, die als Protokolldaten bezeichnet werden. Diese Protokolldaten können Informationen wie den Gerätenamen, die Version des Betriebssystems, die Konfiguration der App bei der Nutzung meines Dienstes, die Uhrzeit und das Datum Ihrer Nutzung des Dienstes und andere Statistiken enthalten. Alle diese Daten sind grundsätzlich vollständig anonym und können nicht zu einzelnen Geräten oder Nutzern zurückgeführt werden.

                 **4. Zugriff auf Kalender**

                 Die App kann in bestimmten Fällen den Zugriff auf die auf dem Endgerät des Nutzers gespeicherten Kalender anfragen. Diese Kalender werden nur für den Zweck genutzt, die in der App angezeigten Spiele in den gewünschten Kalender zu übertragen. Eine solche Übertragung erfolgt grundsätzlich auf explizite Anforderung des Nutzers und niemals im Hintergrund. Ein weiterer Zugriff, Auslesen, Verarbeiten oder Veränderung von Kalenderdaten findet nicht statt.

                 **5. Verwendung externer Daten**

                 Die App verwendet für die Anzeige der Daten die Schnittstelle des Deutschen Baseball- und Softballverbandes (DBV), die unter https://bsm.baseball-softball.de/api_docs beschrieben ist. Der Anbieter der App übernimmt keine Verantwortung für die Richtigkeit, Vollständigkeit oder Aktualität der angezeigten Daten, die über diese Schnittstelle bezogen werden.

                 **6. Links zu anderen Seiten**

                 Die App kann Links zu anderen Websites enthalten. Wenn Sie auf einen Link eines Dritten klicken, werden Sie zu dieser Site weitergeleitet. Beachten Sie, dass diese externen Seiten nicht vom Betreiber dieser App betrieben werden. Dieser empfiehlt daher dringend, die Datenschutzrichtlinien dieser Websites zu lesen. Der Betreiber hat keine Kontrolle über und übernimmt keine Verantwortung für den Inhalt, die Datenschutzrichtlinien oder die Praktiken von Websites oder Diensten Dritter.

                 **7. Löschung aller Daten**

                 Eine Löschung der App wird alle auf dem Endgerät des Nutzers gespeicherten Daten vollständig löschen. Es gibt keine Möglichkeit, diese wiederherzustellen, da sie zu keinem Zeitpunkt an einem anderen Ort gespeichert werden.
                 Eine etwaige Erlaubnis zur Kalendernutzung im Sinne von Punkt 4 muss nach einer Neuinstallation der App neu erteilt werden.

                 **8. Änderungen dieser Datenschutzerklärung**

                 Der Betreiber kann unsere Datenschutzerklärung von Zeit zu Zeit aktualisieren. Wir empfehlen Ihnen daher, diese Seite regelmäßig auf Änderungen zu überprüfen. Der Betreiber wird Sie über alle Änderungen informieren, indem die neue Datenschutzerklärung auf dieser Seite veröffentlicht wird.

                 Diese Datenschutzerklärung ist gültig ab dem 11.5.2022.
                 """)
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
