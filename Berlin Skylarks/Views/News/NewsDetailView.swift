//
//  NewsDetailView.swift
//  Berlin Skylarks
//
//  Created by David Battefeld on 25.12.20.
//

import SwiftUI

let DetailViewPadding: CGFloat = 25
let SmallPaddingCategoryAuthor: CGFloat = 10

struct NewsDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: NewsItemSpacing) {
                Text("Team 1 beendet Saison mit Sweep")
                    .font(.title)
                    .padding(DetailViewPadding)
                    .lineLimit(nil)
                   
                HStack { //category bar
                   Text("Spielbericht, Verbandsliga, Baseball")
                    .font(.title3)
                    .frame(alignment: .topLeading)
                    .padding(NewsItemPadding)
                }
                .background(ItemBackgroundColor)
                .cornerRadius(NewsItemCornerRadius)

                Text("David Battefeld")
                    .font(.subheadline)
                    .padding(.vertical, SmallPaddingCategoryAuthor)
                Text("Im direkten Rückspiel gegen die Dresden Dukes nach der Auswärtsfahrt der Vorwoche ließen die Skylarks rein gar nichts anbrennen. In zwei sehr einseitigen Spielen gewann man in beiden Fällen klar und vorzeitig durch Mercy Rule und ließ den Gästen keine Chance.")
                    .blur(radius: 1.0)
                Group {
                    Text("Tabelle")
                        .font(.title2)
                    Text("Zum ersten Spiel muss man nicht viel schreiben - es geriet in kürzester Zeit zur Julius-Mannel-Show, und zwar auf beiden Seiten des Balles. Der Skylarks-Veteran, zuletzt in puncto Frequenz der Pitching-Einsätze hinter Max Leidinger zurückgefallen, schaffte es, seine dominante Form aus 2018 zu channeln und eine absolute Galavorstellung abzuliefern. Gegen den tödlichen Mix aus Fastball in der 80mph-Reichweite und Curveball gelang den Dresdnern richtig lange gar nichts - und zwar derart, dass zunächst 11 Strikeouts in Folge auf dem Scoresheet standen. Das ganze nahm derart absurde Formen an, dass im 3. Inning die gesamte Defensive bei einem Foul Ball zusammenzuckte - so wenig war man bisher am Spielgeschehen beteiligt worden. Offensiv lief es wie schon auswärts weiter wie am Schnürchen - man punktete viel und früh. Auch hier konnte sich Julius hervortun - sein Homerun im 1. Inning, im Grunde bereits die Entscheidung, war von Länge und Schlagkraft definitiv kein Halvorsen-Park-Special. Auch alle anderen Hitter von 1-9 im Lineup wirkten frisch und wach, sodass niemand hervorstach, aber alle mindestens einen Hit und Punkt erreichen konnten. \n\n Zur Ironie des Tages gehörte es dann natürlich auch, dass Julius sein Perfect Game dann im 4. und letzten Inning mit einem sinkenden Line Drive in die Opposite Gap wieder verlor - natürlich mit 2 Aus. Dem schnellen Sieg nach nur einer knappen Stunde aufgrund der 15-Punkte-Führung tat dies natürlich keinen Abbruch.")
                    Image("Rondell")
                }
                Group {
                    Text("Tabelle")
                    Text("Das zweite Spiel entwickelte sich in die exakt gleiche Richtung, wenn auch mit anderen Vorzeichen. Nachdem die Tabellenführung nun auch rechnerisch gesichert war, boten die Captains Francesco und Phil ein Lineup auf, das so in dieser Saison noch nie auf dem Platz gestanden hatte - unter anderem kamen Henri Granowski auf First Base und Fritz Leidinger im RF zu ihren Saisondebüts auf diesen Positionen. Auf dem Mound stand der wohl größtmögliche Gegensatz zu Julius Mannel in Finesse Pitcher Ryan Jones - was aber trotz gänzlich anderer Herangehensweise ähnlich gut funktionierte. Im ersten Inning konnte eine Rally der Gäste schnell wieder gestoppt werden, als ein Single und ein Error nicht in Punkte umgemünzt werden konnten, da der Läufer auf Third nach einem Rundown mit dem eher unüblichen 6-2-7 Play ausgemacht wurde. Ebenfalls wieder initiiert durch einen Fehler der Defensive kamen die Dresdner im 2. Inning zu ihrem einzigen wirklichen Offensivausbruch: eine kurze Phase der Ungenauigkeit des Pitchers mit einigen Walks und HBPs ausnutzend kamen die Gäste durch gut getimte Hits zu 3 Punkten - zu dem Zeitpunkt fast Gleichstand. \n\n Da sich allerdings der Trend fortsetzte, dass das Dresdner Pitching der Offensive der Gastgeber keinen Einhalt bieten konnte und kein Heim-Inning unter 4 Punkten beendet wurde, war dann dennoch sehr schnell nach dem 4. Inning erneut Schluss. Es liegt nahe, an dieser Stelle wieder einmal Max Leidinger zu erwähnen, der zwei Homeruns vorweisen konnte und damit allein 6 der Skylarks-Punkte zu verantworten hatte, stattdessen möchte ich aber an dieser Stelle einem anderen Spieler Tribut zollen, für den es leider das letzte Spiel im Skylarks-Dress gewesen ist: Joe Kaskie erreichte ebenfalls 2 von 3 am Schlag und wird im kommenden Jahr wieder den lokalen Baseball in Florida unsicher machen. So long - our doors will always be open for you!")
                    Text("Fazit und Ausblick")
                        .font(.title2)
                    Text("Damit ist die Saison für Team 1 beendet - und zwar die erfolgreichste seit Jahren. Schaffte man es in den Jahren davor eher mit Mühe und Not, den zweiten Tabellenplatz gegen starke Sluggers und Flamingos zu halten, gelang es diese Saison wieder, befreit aufzuspielen und von Anfang bis Ende diszipliniert unser Programm abzuspulen, was verdient mit dem ersten Tabellenplatz belohnt wurde. Unter normalen Umständen hieße das, dass für uns demnächst die Best-of-5-Serie um den Titel des Berliner Baseballmeisters beginnen würde - im zweiten Corona-Jahr mit verkürzter Saison sind allerdings weiterhin alle Meisterschaften des BSVBB ausgesetzt, sodass wir uns 'nur' mit einer sehr guten regulären Saison schmücken können - wenn auch mit reduzierter Aussagekraft, schließlich haben nicht einmal alle Teams gleich viele Spiele absolviert und durch den Rückzug der Magdeburg Poor Pigs fiel sogar ein kompletter Kontrahent ganz aus der Liga heraus. \n\n Wir bedanken uns an dieser Stelle bei allen Helfer:innen, die zum erfolgreichen Abschluss der Saison beigetragen haben, bei allen Zuschauer:innen, die uns bei unseren Spielen begleitet haben, Andi und Sven vom Catering-Team, die das leibliche Wohl unserer Spieler:innen und Gäste stets im Blick hatten, und allen, die ich vergessen habe. Wir drücken ganz fest die Daumen, dass wir nächstes Jahr wieder eine ganz normale Saison spielen können und freuen uns bereits wieder auf eure Unterstützung. Gebt gut Acht im Winter, bleibt gesund (und lasst euch impfen) - wir sehen uns ganz bald!")
                }
            } .padding(DetailViewPadding)
        }
        .navigationBarTitle("Article", displayMode: .inline)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailView()
    }
}
