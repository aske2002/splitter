const vision = require("@google-cloud/vision")
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');

//Sæt en konstant med legitimationsoplysninger til google vision
const client = new vision.ImageAnnotatorClient({
  keyFilename: "key.json",
})

//Denne funktion/promise gør billedet klart til at blive scanent for linjer
//funktionen får hovedsageligt bileldet til at se godt ud
async function prepareImage(image64) {
  return new Promise(async(resolve, reject) => {
    //Lav billedet til en buffer så det kan sendes til google
    var image = Buffer.from(image64, "base64")
    //Sørg for at billedet er roteret korrekt, nogle telefoner har det med
    //at rotere billedet i metadata
    //funktionen toBuffer retunere en buffer med det roterede billede
    sharp(image).rotate().toBuffer(async function (err, outputBuffer, info) {
      //Fejlhåndtering
      if (err) {
        console.log(err)
        reject(err)
        return
      } else {
        //Lav et apirequest objekt som vi kan sende til google med billedets buffer
        var apiRequest = {
          image: {
            content: outputBuffer
          }
        };
        //Scan billedet for tekst med Googles AI
        var [result] = await client.textDetection(apiRequest);
        var detections = result.textAnnotations
        //Retuner fejl hvis ingen tekst
        if(detections.length < 1) {
          return reject("No text found")
        }
        //Fjerne det første element fra vores array med tekstobjekter
        detections.shift()
        //Få højden og bredden af billedet
        var width = info.height
        var height = info.height
        //I de næste par linjer finder vi den gennemsnitige x værdi og
        //hældning af teksten i forhold til billedet
        var average = 0;
        var averagex = 0
        for (var i = 0; i < detections.length; i++) {
          var vertices = detections[i].boundingPoly.vertices
          average += ((height-vertices[1].y) - (height-vertices[0].y))/(vertices[1].x - vertices[0].x)
          averagex += vertices[1].x - vertices[0].x
        }
        var haelning = average/detections.length
        averagex = averagex/detections.length
        //Udregn den gennemsnitige hældning af teskten i grader
        //ved hjælp af trigonometri
        var rotation;
        if (averagex < 0 && haelning < 0) {
         rotation = 180-Math.abs((Math.atan(haelning)*(180/Math.PI)))
       } else if (averagex < 0 && haelning > 0) {
         rotation = 180+Math.abs((Math.atan(haelning)*(180/Math.PI)))
       } else if (averagex > 0 && haelning < 0) {
         rotation = -(Math.abs((Math.atan(haelning)*(180/Math.PI))))
       } else if (averagex > 0 && haelning > 0) {
         rotation = Math.abs((Math.atan(haelning)*(180/Math.PI)))
       }
       //Roter billeddet med dette antal grader, og sæt baggrunden til hvis
       //vi retunere igen en buffer med det roterede billede
        sharp(outputBuffer).rotate(rotation, {background: "#FFFFFF"}).toBuffer(async function (err, outputBuffer, info) {
          //Fejlhåndtering
          if (err) {
            return reject(err)
          } else {
            //Lav en ny api request objekt
            apiRequest = {
              image: {
                content: outputBuffer
              }
            };
            //Send en request til Google Vision og scan billedet for tekst ingen
            //da vi skal have opdateret positionen af teksten
            //fordi billedet er blevet roteret
            var [result] = await client.textDetection(apiRequest);
            var vertices = result.textAnnotations[0].boundingPoly.vertices
            //Find bredden af teksten
            var width = Math.abs(vertices[0].x-vertices[1].x)
            //Find højden af teksten
            var height = Math.abs(vertices[1].y-vertices[2].y)
            //Crop billedet så kun teksten bliver inkluderet, billedet er nu færdigbehandlet
            sharp(outputBuffer).extract({ left: vertices[0].x, top: vertices[0].y, width: width, height: height }).toBuffer(async function (err, outputBuffer, info) {
              //Fejlhåndtering
              if (err) {
                return reject(err)
              } else {
                //Retuner det behandlede billede
                return resolve(outputBuffer)
              }
            })
          }
        })
      }
    });
  })
}

//Denne funktion samler alle tekstobjekterne
//til et array af arrays med linjer i
async function getLines(buffer) {
  return new Promise(async(resolve, reject) => {
    try {
        var apiRequest = {
          image: {
            content: buffer
          }
        };
        //Scan billedet for tekst ved hjælp af Google Vision
        var [result] = await client.textDetection(apiRequest);
        var detections = result.textAnnotations;
        //Fjern det første objekt fra vores array fordi
        //det er irrelevant
        detections.shift()
        for (var i = 0; i < detections.length; i++) {
          detections[i].id = i+1;
        }
        //Få data omkring bileldet, højde, bredde eks.
        image.metadata().then(function(metadata) {
          var width = metadata.height
          var height = metadata.height
          //Deklarer et array kaldet lines som kommer til at
          //indeholde alle arrays (linjer) med tekstobjekter
          var lines = [];
          //Loop igennem alle linjer og find hældning, centrum, og en a og b værdi
          //for en lineær funktion
          for (var i = 0; i < detections.length; i++) {
            var polygon = detections[i].boundingPoly.vertices
            //Sæt en variabel kalde middlepint til midten af ordet
            //hvis vi ikke tager højde for hældningen af ordet
            var middlepoint = [polygon[0].x + (polygon[1].x - polygon[0].x)/2, polygon[0].y + (polygon[1].y - polygon[0].y)/2]
            //Find hældningen af ordet
            var haelning = ((height-polygon[1].y) - (height-polygon[0].y))/(polygon[1].x - polygon[0].x)
            detections[i].haelning = haelning
            //Find forskellen mellem højeste og laveste punkt på ordet
            var ydiff = polygon[2].y-polygon[1].y
            //Find forskellen mellem punktet til venstre og højre på ordet
            var xdiff = polygon[1].x-polygon[2].x
            //phytagoras til at finde c værdien i en ret trekant
            //i forhold til ordets hældning
            var clength = Math.sqrt( Math.pow(Math.abs(ydiff), 2) + Math.pow(Math.abs(xdiff), 2))
            //find a og b værdi for funktionen
            //der står vinkelret på funktion som går gennem ordet
            var avaerdi = -1/haelning
            var bvaerdi = (height-middlepoint[1])-avaerdi*middlepoint[0]
            var funktionb;
            //Hvis ordets hældning er 0 behøves der ikke trigonometri til at udregne
            //ordets centrum
            if (haelning == 0) {
              //Sæt ordets center
              detections[i].center = {x: middlepoint[0], y: height-middlepoint[1]+Math.abs(0.5*ydiff)}
              //Find b værdien så det passer med at funktionen med haelning går gennem centrum
              funktionb = (height-(middlepoint[1]+Math.abs(0.5*ydiff)))-haelning*middlepoint[0]
            } else {
              //Disse to if statements skælner mellem om ordet hælder nedad eller opad
              if (avaerdi < 0) {
                //Hvis ordet hælder nedad, regner vi center ud således
                //Her finder vi x og y værdien for ordets centrum
                var vinkel = Math.atan(Math.abs(avaerdi)/1)
                var offset = Math.cos(vinkel)*(clength*0.5)
                var nyx = middlepoint[0]+offset
                var nyy = height-(avaerdi*nyx+bvaerdi)
                funktionb = (height-nyy)-haelning*nyx
                //Indsæt center i ordets objekt
                detections[i].center = {x: nyx, y: height-nyy}
              } else {
                //Hvis ordet hælder opad, regner vi center ud således
                var vinkel = Math.atan(Math.abs(avaerdi)/1)
                var offset = Math.cos(vinkel)*(clength*0.5)
                var nyx = middlepoint[0]-offset
                var nyy = height-(avaerdi*nyx+bvaerdi)
                funktionb = (height-nyy)-haelning*nyx
                //Indsæt center i ordets objekt
                detections[i].center = {x: nyx, y: height-nyy}
              }
            }
            //Vi sætter desuden ordets b værdi til den vi har udregnet
            detections[i].funktionb = funktionb
          }
          //Nu skal vi dele ordene op i linjer
          //Imens længden af vores array med ord er større end nul køres dette loop
          while(detections.length > 0) {
            //Vi undersøger hvilke andre ord som ligger på linje med detections[0]
            var haelning = detections[0].haelning
            var funktionb = detections[0].funktionb
            //Matches kommer til at indeholde ord på samme linje
            //med det ord vi checker for
            var matches = []
            //Vi looper igennem alle ord
            for (var d = 0; d < detections.length; d++) {
              //For hvert ord, sætter vi detection til detections[i].boundingPoly.vertices
              //dvs at detection bliver et array med 4 punkter, som beskriver
              //hjørnerne af ordet
              var detection = detections[d].boundingPoly.vertices
              //Vi looper nu gennem alle punkterne i ordet
              for (var s = 0; s < detection.length; s++) {
                //Vi sætter endpoint til det punkt vi er ved (s)
                //plus en, punkterne er i rækkefølge så de går med uret
                var endpoint = s+1
                if (s == 3) {
                  endpoint = 0;
                }
                //Vi finder hældninge mellem de to punkter, s og endpoint
                var sa = ((height-detection[endpoint].y) - (height-detection[s].y))/(detection[endpoint].x - detection[s].x)
                //Vi finder den tilsvarende b værdi
                var sb = (height-detection[s].y)-sa*detection[s].x
                //Hvis hældningen af ordets detections[0] er den samme som hældningen imellem de
                //to punkter for dette ord, betyder det at de to linjer aldrig kommer til at skære
                //hinanden, derfor sprinegr vi videre
                if (haelning == sa) {
                  continue;
                }
                //Vi skal finde ud af om og hvor funktionen for detections[0] skærer
                //linjen mellem de to punkter for dette pågældene ord
                var xcut;
                var ycut
                //Hvis hældningen mellem de to punkter er lodret
                if (sa == Infinity || sa == -Infinity) {
                  //Her skærer de to funktioner hinanden på y aksen
                  ycut = haelning*detection[endpoint].x+funktionb
                  //De to funktioner skærer selvfølgelig hinanden
                  //der ved x værdien for funktionen mellem de to punkter
                  //fordi hældningen er lodret
                  xcut = detection[endpoint].x
                } else {
                  //Hvis funktionen mellem de to punkter ikke er lodret
                  //regner vi ud ved hvilken x værdi de to funktioner skærer hinanden
                  xcut = (funktionb-sb)/(sa-haelning)
                  //ud fra dette kan vi også nemt finde punktet på y aksen hvor de skærer hinanden
                  ycut = haelning*xcut+funktionb
                }
                //Vi finder det højeste punkt på y aksen af de to punkter s og endpoint
                var highy = Math.max(height-detection[s].y, height-detection[endpoint].y)
                //Laveste punkt
                var lowy = Math.min(height-detection[s].y, height-detection[endpoint].y)
                //Højeste punkt på x-aksen
                var highx = Math.max(detection[s].x, detection[endpoint].x)
                //laveste punkt
                var lowx = Math.min(detection[s].x, detection[endpoint].x)
                //Hvis skæringspunktet ikke ligger mellem den højeste og Laveste
                //værdi på y-aksen, betyder det at de to ord ikke ligger på linje med hinanden
                if (ycut < lowy || ycut > highy) {
                  continue
                }
                //Det samme gælder for x-aksen
                if (xcut < lowx || xcut > highx) {
                  continue
                }
                //Hvis vi når her til betyder det at de
                //to ord ligger på linje med hinanden
                matches.push(detections[d])
                //Vi breaker og går videre til næste ord
                break
              }
            }
            //Når vi har loopet igennem alle ordet
            //Og checket om ordet detections[0] ligger
            //på linje med dem kigger vi om der er nogle Matches
            //Hvis der ikke er betyder det at detections[0]
            //ligger alene på linjen og vi pusher det til vores matches array
            if (matches.length == 0) {
              matches.push(detections[0])
            }
            //Disse loops fjerner alle ord fra vores detections
            //array som er blevet lagt ind i matches
            for (var i = 0; i < matches.length; i++) {
              for (var d = 0; d < detections.length; d++) {
                if (matches[i].id == detections[d].id) {
                  detections.splice(d, 1)
                }
              }
            }
            //Nu ligger vi vores matches array ind i vores lines, vores
            //matches array repræsentere da en linje
            lines.push(matches)
          }
          //Alle linjer er fundet, nu sortere vi ordene
          //så de placeringsmæssigt ligger fra venstre til højre
          for (var i = 0; i < lines.length; i++) {
            lines[i].sort((a, b) => (a.boundingPoly.vertices[0].x > b.boundingPoly.vertices[0].x) ? 1 : -1)
          }
          //Nu kan vi retunere alle linjerne
          resolve(lines)
        })
    //Fejlhåndtering hvis der sker en fejl i denne process
    } catch (error) {
        return reject(error)
    }
  })
}

//Denne funktion tager et array af linjer, og finder produkterne
function parseList(lines) {
  return new Promise((resolve, reject) => {
    //Vi deklarere nogle variabler Her
    //firstPrice repræsentere det index af lines, hvor den første pris optræder
    //total repræsentere det index af lines hvor totalsummen af kvitteringen optræder
    //det er måden hvorved vi ved at listen af produkter slutetr
    var firstPrice = -1
    var total = -1
    //Dette objekt kommer til at indholde alle produkterne
    //calcPrice er totalprisen som algoritmen regner sig frem til ud fra alle produkter
    //recPrice er totalprisen som står på kvitteringen
    //hvis de ikke matcher må der være sket en fejl.
    var parsed = {products: [], length: 0, calcPrice: 0, recPrice: null}
    //Loop igennem alle ord i alle linjer, og check om de matcher et beløb
    //Et beløb kan f.eks. være (1,32 eller -3,75)
    for (var i = 0; i < lines.length; i++) {
      for (var k = 0; k < lines[i].length; k++) {
        //En regex til at check pris, tillad minus foran
        var regex = /^-?((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})-{0,1}$/i;
        if (regex.test(lines[i][k].description)) {
          //Hvis dette ord matcher sætter vi linjen ordet optræder i til at
          //være firstPrice
          firstPrice = i;
        }
      }
      if (firstPrice != -1) {
        break
      }
    }
    //Hvis der ikke er nogen firstPrice er der nok
    //ikke nogle vare på kvitteringen så vi retunere en fejl
    if (firstPrice == -1) {
      return reject("Cannot find any products")
    }
    //Vi finder på samme måde totalprisen
    //ved at kigge efter ord der matcher
    //sum|total|i alt|at betale
    for (var i = firstPrice; i < lines.length; i++) {
      var fullline = ""
      var regex = /^ *(sum|total|i alt|at betale) */i;
      for (var k = 0; k < lines[i].length; k++) {
        fullline += lines[i][k].description + " "
      }
      if (regex.test(fullline)) {
        total = i;
      }
      if (total != -1) {
        break
      }
    }
    //Hvis der ikke er nogen total mængde
    //er der nok også noget galt med kvitteringen
    //så vi retunere en fejl
    if (total == -1) {
      return reject("No total amount")
    }
    //vi putter x-positionen for alle ord der indeholder en
    //pris mellem firstPrice og total ind i et array af x værdier
    var pricePos = []
    for (var i = firstPrice; i < total; i++) {
      for (var k = 0; k < lines[i].length; k++) {
        var regex = /^-?((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})-{0,1}$/i;
        if (regex.test(lines[i][k].description)) {
          var vertices = lines[i][k].boundingPoly.vertices
          pricePos.push(Math.max(vertices[0].x, vertices[1].x))
        }
      }
    }
    //Vi opretter et array priceObj
    var priceObj = []
    //Vi finder den højeste x positions værdi af alle prise
    var maxX = pricePos.reduce(function(a, b) {
        return Math.max(a, b);
    });
    //Vi finder den mindste
    var minX = pricePos.reduce(function(a, b) {
        return Math.min(a, b);
    });
    //Dette for loop er lidt kompliceret, det som det egnetligt gør
    //er at dele prisernes x-position op i grupper
    //hvor positionen ikke må have en større afvigelse
    //end 5% af den samlede bredde mellem højeste og laveste x-position
    //for en pris position
    //Loop igennem alle værdier i pricePos
    for (var i = 0; i < pricePos.length; i++) {
      var matched = false;
      //Loop igennem alle værdier for priceObj
      for (var k = 0; k < priceObj.length; k++) {
        //Hvis pricePos(i) ikke har en større afvigelse end
        //5% for priceObj gruppen
        if ((Math.abs((priceObj[k].x-pricePos[i]))/(maxX)) < 0.05) {
          //Put x positionen ind i priceObj gruppen,
          priceObj[k].positions.push(pricePos[i])
          //Vi har fundet et match så den sætter vi til true
          matched = true
          break
        }
      }
      //Hvis der ikke er et match laver vi en ny gruppe i priceObj
      if (!matched) {
        priceObj.push({x: pricePos[i], positions: [pricePos[i]]})
      }
    }
    //Vi looper igennem alle objekter i priceObj og finder
    //gruppen som har den højeste x-værdi (mest til venstre)
    var highestarray = priceObj[0]
    for (var i = 0; i < priceObj.length; i++) {
      //hvis priceObj[i]'s x-værdi er højere end variablen
      //highestarray's x-værdi sætter vi highestarray tild enne
      if (priceObj[i].x > highestarray.x) {
        highestarray = priceObj[i]
      }
    }
    //Vi deklarere en ny variabel sum
    var sum = 0;
    //Vi looper igennem alle pris positioner i highestarray
    //og addere dem til summen
    for (var i = 0; i < highestarray.positions.length; i++) {
      sum += highestarray.positions[i]
    }
    //Vi dividere summen for at finde gennemsnitspositionen
    sum = sum/(highestarray.positions.length)
    /*
      Det vi egnetligt har fundet her er at vi har delt alle priserne op i grupper
      i forhold til deres position på x-aksen, hvorefter vi har taget gruppen
      med den højeste x-værdi (mest til højre), for så at finde gennemsnittet
      af alle x-værdier for positionerne der ligger i denne gruppe. Det gør jeg fordi at
      priserne altid står i højer side af en kvittering, så for at være sikre på at en
      pris faktisk er den endelige pris på et produkt, skal den både være et tal med
      to kommaer, samt være indenfor 5% af denne x-værdi.
    */
    //Vi sætter igen firstPrice til -1 igen
    firstPrice = -1;
    //Denne gang looper vi igennem
    //alle ord igen, og kigger både på om de er en
    //pris men også om de ligger det rigtige sted
    for (var i = 0; i < lines.length; i++) {
      for (var k = 0; k < lines[i].length; k++) {
        var regex = /^-?((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})-{0,1}$/i;
        if (regex.test(lines[i][k].description)) {
          var vertices = lines[i][k].boundingPoly.vertices
          if ((Math.abs((sum-vertices[1].x))/(maxX)) < 0.05) {
            firstPrice = i;
          }
        }
      }
      if (firstPrice != -1) {
        break
      }
    }
    //Hvis firstPrice er -1 er der sket en fejl
    if (firstPrice == -1) {
      return reject("No items found")
    }

    //Nu kommer vi til at skulle finde produkterne
    //Nextproduct er en variabel, som beskriver det forrige produkt.
    //Hvis det forrige produkt ikke havde nogen pris, betyder det at der
    //Står 2 x 5,00 f.eks. så vi vil gerne have navnet og mængden af
    //produktet med
    var nextProduct = {amount: 1, name: "", active: false}
    //Loop igennem alle linjer mellem første og sidste produkt
    for (var i = firstPrice; i < total; i++) {
      //Hold styr på om produktet er tilføjet til listen af produkter
      var productAdded = false;
      //Loop igennem alle ord i linjen
      for (var k = 0; k < lines[i].length; k++) {
        //Deklarer regex som skal bruges senere
        var regex = /^-?((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})-{0,1}$/i;
        var regex2 = /^-?((\d[\d\.\,]{0,5}\d)|\d)\ x\ ((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})/i;
        var regex3 = /\d{1,4} STK ?$/i;
        //Test om ordet er en pris, prisen er afgørende for
        //om algoritmen ved om der er tale for et produkt
        if (regex.test(lines[i][k].description)) {
          var vertices = lines[i][k].boundingPoly.vertices
          //Kig om prisen ligger det rigtige sted på x-aksen til at
          //være en pris
          if ((Math.abs((sum-vertices[1].x))/(maxX)) < 0.05) {
            //Nu ved vi at det er et produkt, så vi ændrer productAdded til true
            productAdded = true
            //Vi deklarer de variabler vi skal bruge
            var amount = 1;
            var rabat = 0;
            var productname = "";
            var fullproductname = "";
            //Vi trækker prisen ud af ordet som vi ved er en pris. Erstat komme med punktum
            var priceString = lines[i][k].description.replace(",", "").replace(".", "")
            var priceString = priceString.substring(0, priceString.length-2 )+"."+priceString.substring(priceString.length-2, priceString.length)
            //Vi parser vores tring til en float, så vi arbejder med et tal
            var price = parseFloat(lines[i][k].description.replace(",", "."))
            //Hvis prisen er negativ må det være rabat, det påvirker kun det forhenværende produkt
            if (price < 0 || /^-?((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})-$/i.test(lines[i][k].description)) {
              //Vi trækker rabatten fra det forrige produkt som vi har tilføjet
              parsed.products[parsed.products.length-1].price += -Math.abs(price/parseFloat(parsed.products[parsed.products.length-1].amount))
              //Vi angiver på det forrige produkt at der er rabat
              parsed.products[parsed.products.length-1].rabat = Math.abs(price)
            } else {
              //Hvis den første karakter er et tal må det beskriver mængden af produktet
              if (/^-?\d+$/.test(lines[i][0].description) && lines[i].length > 2) {
                //Mængden er det første tale
                amount = parseInt(lines[i][0].description)
                //Vi looper igennem alle ord på linjen mellem det første tal
                //Og prisen og tilføjer disse strings til navnet så vi får det fulde
                //navn på produktet
                for (var m = 1; m < k; m++) {
                  productname += lines[i][m].description + " "
                }
                for (var m = 0; m < k; m++) {
                  fullproductname += lines[i][m].description + " "
                }
              } else {
                //Hvis det første ord ikke er et tal, er alle ord indtil
                //prisen en del af produktprisen
                for (var m = 0; m < k; m++) {
                  productname += lines[i][m].description + " "
                  fullproductname = productname;
                }
              }
              for (var t = 0; t < lines[i].length; t++) {
                //Hvis starten af navnet på produktet er af formen 2 x 5,00 f.eks.
                //betyder det at dette beskriver mængden af produktet
                if (regex2.test(fullproductname)) {
                    //Vi splitter da navnet af produktet ved x og tager alt før dette
                    var amountAlt = fullproductname.split(new RegExp("x", 'i'))[0];
                    //Hvis dette er et tal
                    if (parseFloat(amountAlt)) {
                      //Sætter vi mængden af produktet til at være det
                      amount = parseFloat(amountAlt)
                      //Og navnet af produktet på da være navnet
                      //på det forhenværende produkt som ikke blev tilføjet
                      productname = nextProduct.name
                    }
                //Ellers hvis produktetnavnet starter med a eller a med en accent
                //ved vi også at det forhenværende produkt ikke blev tilføjet
                //fordi der ikke var nogen pris, og vi derfor skal bruge mængded
                //og navnet fra nextProduct
                } else if (nextProduct.active && (/^(\a|\à|\á|\â|\â|\ä|\å|\ã|\Ã)*$/i.test(lines[i][t].description.trim()))) {
                    amount = nextProduct.amount
                    productname = nextProduct.name
                }
              }
              //Nulstil nextProduct
              nextProduct = {amount: 1, name: "", active: false}
              //Indsæt produktet i vores liste af produkter
              parsed.products.push({product: productname, amount: amount, price: (price/amount), rabat: rabat, name: (productname == "") ? false : true})
            }
          }
        }
      }
      //Hvis produktet ikke er blevet tilføjet
      if (!productAdded) {
        //Nulstil nextProduct
        nextProduct = {amount: 1, name: "", active: false}
        //Hvis linjen starter med et tal
        if (/^-?\d+$/.test(lines[i][0].description)) {
          //Mængden af det næste produkt må være dette tal
          nextProduct.amount = parseInt(lines[i][0].description)
          //Vi finder navnet af produktet ved at tilføje alle ord på linjen
          //til en string, bortset fra det første tal
          for (var m = 1; m < lines[i].length; m++) {
            nextProduct.name += lines[i][m].description + " "
          }
        } else {
          //Ellers tilføjer vi bare alle ord til navnet,
          //fordi det ikke starter med et tal
          for (var m = 0; m < lines[i].length; m++) {
            nextProduct.name += lines[i][m].description + " "
          }
        }
        //nextProduct skal nu være aktiv
        nextProduct.active = true;
      }
    }
    //Vi tilføjer prisen for hvert enkelt produkt til vores calcPrice variabel
    for (var i = 0; i < parsed.products.length; i++) {
      parsed.calcPrice += (parsed.products[i].price*parsed.products[i].amount)
    }
    parsed.length = parsed.products.length
    //Her finder vi blot summen som den står på kvitteringen
    //og sætter recPrice til at være denne (receiptprice)
    for (var i = 0; i < lines[total].length; i++) {
      var regex = /^-?((\d[\d\.\,]{0,9}\d)|\d)(?:(\,|\.)\d{1,2})-{0,1}$/i;
      if (regex.test(lines[total][i].description)) {
        var priceString = lines[total][i].description.replace(",", "").replace(".", "")
        var priceString = priceString.substring(0, priceString.length-2 )+"."+priceString.substring(priceString.length-2, priceString.length)
        parsed.recPrice = parseFloat(priceString)
      }
    }
    //Nu retunere vi produktobjektet med alle produkterne
    resolve(parsed)
  })
}

exports.handler = async function(event, context) {
  sharp(Buffer.from(event.body, "base64")).rotate().toBuffer(function (err, outputBuffer, info) {
    if(err) {
      console.log(err)
    }
    console.log(outputBuffer)
  })
  try {
    var buffer = await prepareImage(event.body)
    console.log("iMAGE TREATED")
    var lines = await getLines(buffer)
    console.log(lines)
    var products = await parseList(lines)
    console.log(products)
    return {
      'statusCode': 200,
      'body': JSON.stringify(products)
    }
  } catch(e) {
    return {
      'statusCode': 400,
      'body': e
    }
  }
}
