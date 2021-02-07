import os
from dataclasses import dataclass
from io import StringIO

import selenium
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ChromeOptions, DesiredCapabilities
from selenium.webdriver.chrome.options import Options

from lxml import etree

import datetime

import time


@dataclass
class BrickInfo:
    elementID: int
    designID: int
    imageURL: str
    name: str
    color: str


def getBrickInfo(printLogs):
    # go to website
    browser.get('https://brickset.com/parts/category-Technic')
    time.sleep(3)
    # change the results per page to 500
    browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(1)
    browser.find_element_by_xpath('/html/body/div[2]/div/div/aside[1]/div[2]/ul[1]/li[5]/a').click()
    time.sleep(3)

    data = etree.Element('data')

    # iterate through pages, populating the arrays
    for j in range(1, 8):
        brick = BrickInfo
        time.sleep(1)
        browser.get('https://brickset.com/parts/category-Technic/page-' + str(j))
        time.sleep(4)
        if printLogs:
            print('PAGE NUMBER' + str(j))
        for i in range(1, 501):
            try:
                color = browser.find_element_by_xpath(
                    '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[5]')
                if printLogs:
                    print('COLOR IS ' + color.text)
                brick.color = color.text
            except selenium.common.exceptions.NoSuchElementException:
                print("incomplete data, skipping this entry")
                continue

            img = ""
            try:
                img = browser.find_element_by_xpath(
                    '/html/body/div[2]/div/div/section/article[' + str(i) + ']/a').get_attribute('href')
                if printLogs:
                    print('IMG LINK IS' + img)
            except selenium.common.exceptions.NoSuchElementException:
                print("no image found, replacing with a 404 instead")
                img = 'https://www.lego.com/cdn/cs/stores/assets/blt44cddd0b8360e0e2/404.jpg?disable=upscale&width=1920&quality=40'
            brick.imageURL = img

            elementID = browser.find_element_by_xpath(
                '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[1]')
            if printLogs:
                print('ELEMENT ID IS ' + elementID.text)
            brick.elementID = elementID.text

            designID = browser.find_element_by_xpath(
                '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[2]')
            if printLogs:
                print('DESIGN ID IS ' + designID.text)
            brick.designID = designID.text

            name = browser.find_element_by_xpath(
                '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/h1/a').text
            if printLogs:
                print('NAME IS ' + name.split(' ', 1)[1])
            brick.name = name.split(' ', 1)[1]

            legoBrickXML = etree.SubElement(data, 'brick')
            legoBrickXML.set('elementID', brick.elementID)
            legoBrickXML.set('designID', brick.designID)
            legoBrickXML.set('imageURL', brick.imageURL)
            legoBrickXML.set('name', brick.name)
            legoBrickXML.set('color', brick.color)
            xmlDataString = etree.tostring(data, pretty_print=True)
            xmlFile = open(str(datetime.date.today()) + "-LegoBrickDataTechnic.xml", "wb")
            xmlFile.write(xmlDataString)

    return 0


@dataclass
class SetBrick:
    elementID: int
    designID: int
    quantity: int

def getSetContents(directory, printLogs):
    for file in os.listdir(directory):
        filename = os.fsdecode(file)
        tree = etree.parse(directory + filename)
        root = tree.getroot()
        for element in root:
            setID = element.get("ID")
            setName = element.get("name")
            browser.get('https://brickset.com/sets/' + str(setID) + '-1')
            time.sleep(2)

            data = etree.Element('data')

            i = 1
            setBrick = SetBrick
            brickCount = 0
            waitTime = 1
            partsPage = -1

            try:
                if browser.find_element_by_xpath('/html/body/div[1]/div/div/section/div[1]/ul/li[1]/a').text.split(' ', 1)[0] == 'PARTS':
                    partsPage = 1
                elif browser.find_element_by_xpath('/html/body/div[1]/div/div/section/div[1]/ul/li[2]/a').text.split(' ', 1)[0] == 'PARTS':
                    partsPage = 2
                elif browser.find_element_by_xpath('/html/body/div[1]/div/div/section/div[1]/ul/li[3]/a').text.split(' ', 1)[0] == 'PARTS':
                    partsPage = 3
                elif browser.find_element_by_xpath('/html/body/div[1]/div/div/section/div[1]/ul/li[4]/a').text.split(' ', 1)[0] == 'PARTS':
                    partsPage = 4
                elif browser.find_element_by_xpath('/html/body/div[1]/div/div/section/div[1]/ul/li[5]/a').text.split(' ', 1)[0] == 'PARTS':
                    partsPage = 4
            except selenium.common.exceptions.NoSuchElementException:
                partsPage = -1

            if partsPage == -1:
                print("Parts page not found")
                continue

            browser.find_element_by_xpath('/html/body/div[1]/div/div/section/div[1]/ul/li[' + str(partsPage) + ']/a').click()
            time.sleep(1.5)

            while 1:
                # main case, where we're just iterating through bricks
                try:
                    elementID = browser.find_element_by_xpath(
                        '/html/body/div[1]/div/div/section/div[1]/div[' + str(partsPage) + ']/section/article[' + str(i) + ']/div[3]/div[1]/a[1]').text
                    if printLogs:
                       print('ELEMENT ID IS ' + elementID)

                    qty = browser.find_element_by_xpath(
                        '/html/body/div[1]/div/div/section/div[1]/div[' + str(partsPage) + ']/section/article[' + str(i) + ']/div[1]').text.split('x', 1)[0]
                    if printLogs:
                        print('QTY IS ' + qty)

                    designID = browser.find_element_by_xpath(
                        '/html/body/div[1]/div/div/section/div[1]/div[' + str(partsPage) + ']/section/article[' + str(i) + ']/div[3]/div[1]/a[2]').text
                    if printLogs:
                        ('DESIGN ID IS '+designID)

                    setBrick.elementID = elementID
                    setBrick.designID = designID
                    setBrick.quantity = qty
                    brickCount += int(qty)
                    i += 1

                    legoSetContentsXML = etree.SubElement(data, 'brick')
                    legoSetContentsXML.set('elementID', setBrick.elementID)
                    legoSetContentsXML.set('designID', setBrick.designID)
                    legoSetContentsXML.set('quantity', setBrick.quantity)
                    xmlDataString = etree.tostring(data, pretty_print=True)
                    xmlFile = open("../scrapedData/SetContains/" + str(datetime.date.today()) + "-LegoSet-" + str(setID) + "-contents-" + "Data.xml", "wb")
                    xmlFile.write(xmlDataString)
                except selenium.common.exceptions.NoSuchElementException:
                    if brickCount == 0 and waitTime < 15:
                        time.sleep(1)
                        waitTime += 1
                        continue
                    legoSetContentsXML = etree.SubElement(data, 'brickCount')
                    legoSetContentsXML.set('acquired', str(brickCount))

                    piecesIndex = 0
                    while piecesIndex < 15:
                        try:
                            piecesIndex += 1
                            if browser.find_element_by_xpath('/html/body/div[1]/div/aside/section[2]/div/dl/dt[' + str(piecesIndex) + ']').text == 'PIECES':
                                break
                        except selenium.common.exceptions.NoSuchElementException:
                            piecesIndex = -1
                            print("PieceIndex not found")
                            break

                    if piecesIndex == -1:
                        setFullBrickCount = -1
                    else:
                        try:
                            setFullBrickCount = browser.find_element_by_xpath('/html/body/div[1]/div/aside/section[2]/div/dl/dd[' + str(piecesIndex) + ']/a').text
                        except selenium.common.exceptions.NoSuchElementException:
                            setFullBrickCount = browser.find_element_by_xpath('/html/body/div[1]/div/aside/section[2]/div/dl/dd[' + str(piecesIndex) + ']').text
                    legoSetContentsXML.set('totalInSet', str(setFullBrickCount))
                    xmlDataString = etree.tostring(data, pretty_print=True)
                    xmlFile = open("../scrapedData/SetContains/" + str(datetime.date.today()) + "-LegoSet-" + str(setID) + "-contents-" + "Data.xml", "wb")
                    xmlFile.write(xmlDataString)
                    print('brick/row not found, ending')
                    break

    return 0


@dataclass
class SetInfo:
    ID: str
    imageURL: str
    name: str


# Make sure the theme has -'s between words
def getSetInfo(themes, printLogs):
    for theme in themes:
        urlStr = 'https://brickset.com/sets/theme-' + theme
        browser.get(urlStr)

        time.sleep(3)
        # change the results per page to 200

        browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(1)
        if theme == themes[0]:
            browser.find_element_by_xpath('/html/body/div[2]/div/div/aside[1]/div[2]/ul[1]/li[4]/a').click()
        time.sleep(3)
        skippedSets = 0

        data = etree.Element('data')

        # iterate through pages, populating the arrays
        j = 0
        while True:
            j = j + 1
            breakBool = False
            missesInARow = 0
            time.sleep(1)
            browser.get(urlStr + '/page-' + str(j))
            time.sleep(4)
            if printLogs:
                print('PAGE NUMBER ' + str(j))
            for i in range(1, 201):
                setInfo = SetInfo
                try:
                    year = browser.find_element_by_xpath(
                        '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[4]')
                except selenium.common.exceptions.NoSuchElementException:
                    try:
                        year = browser.find_element_by_xpath(
                            '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[3]')
                    except selenium.common.exceptions.NoSuchElementException:
                        skippedSets = skippedSets + 1
                        missesInARow = missesInARow + 1
                        if printLogs:
                            print("incomplete data, skipping this entry")
                        if missesInARow > 10:
                            skippedSets = skippedSets - missesInARow
                            breakBool = True
                            break
                        continue

                if browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article[' + str(
                        i) + ']/div[2]/div[1]/a[3]').text == "MINIFIG PACK":
                    if printLogs:
                        print("no minifigs")
                    skippedSets = skippedSets + 1
                    missesInARow = missesInARow + 1
                    if missesInARow > 10:
                        skippedSets = skippedSets - missesInARow
                        breakBool = True
                        break
                    continue

                img = ""
                try:
                    img = browser.find_element_by_xpath(
                        '/html/body/div[2]/div/div/section/article[' + str(i) + ']/a/img').get_attribute('src')
                    if printLogs:
                        print('IMG LINK IS ' + img)
                except selenium.common.exceptions.NoSuchElementException:
                    if printLogs:
                        print("no image found, replacing with a 404 instead")
                    img = 'https://www.lego.com/cdn/cs/stores/assets/blt44cddd0b8360e0e2/404.jpg?disable=upscale&width=1920&quality=40'
                setInfo.imageURL = img

                elementID = browser.find_element_by_xpath(
                    '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[1]')
                if printLogs:
                    print('ELEMENT ID IS ' + elementID.text.split('-', 1)[0])
                setInfo.ID = elementID.text.split('-', 1)[0]

                name = browser.find_element_by_xpath(
                    '/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/h1/a').text
                if setInfo.ID + ':' == name.split(' ', 1)[0]:
                    setInfo.name = name.split(' ', 1)[1]
                else:
                    setInfo.name = name
                if printLogs:
                    print('NAME IS ' + setInfo.name)

                if setInfo.name != '{?}':
                    legoSetXML = etree.SubElement(data, 'set')
                    legoSetXML.set('ID', setInfo.ID)
                    legoSetXML.set('imageURL', setInfo.imageURL)
                    legoSetXML.set('name', setInfo.name)
                    xmlDataString = etree.tostring(data, pretty_print=True)
                    xmlFile = open(str(datetime.date.today()) + "-" + theme + "-LegoSetData.xml", "wb")
                    xmlFile.write(xmlDataString)
                    missesInARow = 0

            if breakBool:
                break

    print('Total skipped sets: ' + str(skippedSets))
    return 0

    # for elem in browser.find_elements_by_xpath('/html/body/div/main/div[3]/div/div/ul/li[11]/div/button/span/span'):
    #    print
    #    elem.text


baseThemes = ['Adventurers', 'Agents', 'Alpha-Team', 'Aqua-Raiders', 'Aquazone', 'Architecture', 'Art', 'Atlantis',
             'Avatar-The-Last-Airbender', 'Batman', 'Ben-10-Alien-Force', 'Bionicle', 'Boost', 'Brick-Sketches',
             'Brickheadz', 'Cars', 'Castle', 'City', 'Creator', 'Creator-Expert', 'DC-Comics-Super-Heroes',
             'DC-Super-Hero-Girls', 'Dino', 'Dino-2010', 'Dino-Attack', 'Discovery', 'Disney', 'Elves', 'Exo-Force',
             'Factory', 'FORMA', 'Friends', 'Fusion', 'Games', 'Ghostbusters', 'Harry-Potter', 'Hero-Factory',
             'Hidden-Side', 'Hobby-Set', 'Ideas', 'Indiana-Jones', 'Juniors', 'Jurassic-World', 'Legends-of-Chima',
             'LEGOLAND', 'Life-of-George', 'Make-and-Create', 'Marvel-Super-Heroes', 'Master-Builder-Academy',
             'Minecraft', 'Minions-The-Rise-of-Gru', 'Miscellaneous', 'Mixels', 'Model-Team', 'Monkie-Kid',
             'Monster-Fighters', 'Nexo-Knights', 'Ninjago', 'Overwatch', 'Pharaoh-s-Quest', 'Pirates',
             'Pirates-of-the-Caribbean', 'Power-Miners', 'Prince-of-Persia', 'Racers', 'Rock-Raiders', 'Scooby-Doo',
             'Seasonal', 'Space', 'Speed-Champions', 'SpongeBob-SquarePants', 'Sports', 'Spybotics', 'Star-Wars',
             'Stranger-Things', 'Super-Mario', 'Technic', 'Teenage-Mutant-Ninja-Turtles', 'The-Angry-Birds-Movie',
             'The-Hobbit', 'The-LEGO-Batman-Movie', 'The-LEGO-Movie', 'The-LEGO-Movie-2', 'The-LEGO-Ninjago-Movie',
             'The-Lone-Ranger', 'The-Lord-Of-The-Rings', 'The-Powerpuff-Girls', 'The-Simpsons', 'Time-Cruisers',
             'Toy-Story', 'Trains', 'Trolls-World-Tour', 'Ultra-Agents', 'Unikitty', 'Universe', 'Vikings', 'Western',
             'World-City', 'World-Racers']

# skipped catagorites
# assorted is weird
# Basic seems to having missing piece information
# Belville is missing piece info
# Boats is missing piece info
# Books seems like a bad idea overall
# Bricks and more is a possible include TODO: look at this one latter
# Building set with people is missing piece info
# Bulk Bricks is not sets
# Classic is missing part info and is a lot of not sets
# Clikits is bracelets
# Collectable minifigures is not sets TODO: debate this one
# Dacta is old education 'sets'
# Dimensions is something I don't know what to do with TODO: look at this one
# Dinosaurs is missing the specific dino parts
# Dots is odd
# Education is odd TODO: look at this
# Fabuland is too old
# Freestyle is old TODO: look at this
# Galidor no part info
# Homemaker seems too old TODO: look at this
# Island-Xtreme-Stunts seems too old TODO: look at this
# Jack-Stone seems too old TODO: look at this
# Mickey-Mouse is too old
# Mindstorms has a bunch of individual bricks TODO: look at this
# Minitalia has conflicting IDs TODO: look at this
# Power-Functions seems to be bricks TODO: look at this
# Powered-Up seems to be bricks TODO: look at this
# Promotional has odd sets TODO: look at this
# Samsonite is odd TODO: look at this
# Serious-Play is kits TODO: look at this
# Spider-Man seems too old
# Studios I dont know what to do with this TODO: look at this
# System seems too old TODO: look at this
# Town seems too old TODO: look at this
# Universal-Building-Set seems too old TODO: look at this
# Znap is missing parts

option = webdriver.ChromeOptions()

option.add_extension(r'.\uBlockOrigin_1_31_2_0.crx')

browser = webdriver.Chrome(options=option)

holder = [0]

# To call getBrickInfo:
# getBrickInfo(True)

# To call getSetInfo:
# getSetInfo(baseThemes, True)

# to call getSetContents:
directory = "../scrapedData/Sets/"
getSetContents(directory, True)
