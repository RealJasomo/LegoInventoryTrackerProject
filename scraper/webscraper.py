import selenium
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver import ChromeOptions, DesiredCapabilities
from selenium.webdriver.chrome.options import Options

import time

#DONT USE THIS FUNCTION, IT'S DESIGNED FOR THE OFFICIAL LEGO WEBSITE'S SMALL DATABASE
#Input: URL to scrape
#Output: array with the model's name, ID, imageURL
#Input: URL to scrape
#Output: array with all the page's bricks' names, IDs, imageURL, and color
#Note: it has an element ID and design ID.  In the database we treat this as one number with a '/' in the middle so I'll do that here
#Design decision: we can have each brick store its element & design ID and work using those in the database, then we can combine them when needed

def getBrickInfoOLD(inputURL):
    outputArr = [[], [], [], [] ,[]]
    nameArr = []
    elementArr = []
    designArr= []
    colorArr = []
    priceArr = []
    browser.get(inputURL)
    #print("before")
    time.sleep(1)
    #print('after')
    browser.find_element_by_xpath('//*[@id="root"]/div[5]/div/div/div[1]/div[1]/div/button').click()
    time.sleep(1)
    browser.find_element_by_xpath('//*[@id="root"]/div[3]/div/div[2]/button').click()
    time.sleep(1)

    for j in range(1, 20):
        for i in range(1, 13):
            #click on the element
            browser.find_element_by_xpath('//*[@id="main-content"]/div[3]/div/div/ul/li['+ str(i) +']/div/button').click()
            time.sleep(1)

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/p/span')
            print('THE NAME IS ' + name.get_attribute('innerHTML'))
            #nameArr.append(name.get_attribute('innerHTML'))
            outputArr[0].append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[2]/span/span')
            print('THE COLOR IS '+ name.get_attribute('innerHTML'))
            #colorArr.append(name.get_attribute('innerHTML'))
            outputArr[1].append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[4]/span/span')
            print('THE ELEMENT ID IS '+ name.get_attribute('innerHTML'))
            #elementArr.append(name.get_attribute('innerHTML'))
            outputArr[2].append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[5]/span/span')
            print('THE DESIGN ID IS '+ name.get_attribute('innerHTML'))
            #designArr.append(name.get_attribute('innerHTML'))
            outputArr[3].append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[6]/span/span')
            print('THE PRICE IS ' + name.get_attribute('innerHTML'))
            #priceArr.append(name.get_attribute('innerHTML'))
            outputArr[4].append(name.get_attribute('innerHTML'))

            #time.sleep(1)
            webdriver.ActionChains(browser).send_keys(Keys.ESCAPE).perform()
            time.sleep(1)

        #go to next page
        browser.find_element_by_xpath('//*[@id="main-content"]/div[3]/div/div/div/nav/a').click()
        time.sleep(1)

    return[nameArr, elementArr, designArr, priceArr]


#Don't use this one either
def getModelInfoOLD(inputURL):
    browser.get(inputURL)
    ID = browser.find_element_by_xpath('//*[@id="main-content"]/div/div[3]/div/div[4]/span[2]')
    name = browser.find_element_by_xpath('//*[@id="main-content"]/div/div[2]/div/div/div[2]/h1/span')
    imageURL = browser.find_element_by_xpath('//*[@id="main-content"]/div/div[2]/div/div/div[1]/div/div/div/div[1]/div/div[1]/ul/li[1]/div/div/div/div[1]/div/picture/img')
    return [ID.text, name.text, imageURL.get_attribute('src')]

#_________________________________________________________________________________________________________________________
#Actual code below this line vv


#Outputs an array of 5 arrays:
#output[x][0] = color
#output[x][1] = image link
#output[x][2] = element number
#output[x][3] = design number
#output[x][4] = name
def getBrickInfo():
    outputArr = []
    tempArr = []
    # go to website
    browser.get('https://brickset.com/parts/category-System')
    time.sleep(3)
    # change the results per page to 500
    browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(1)
    browser.find_element_by_xpath('/html/body/div[2]/div/div/aside[1]/div[2]/ul[1]/li[5]/a').click()
    time.sleep(3)

    #iterate through pages, populating the arrays
    for j in range (1, 73):
        time.sleep(1)
        browser.get('https://brickset.com/parts/category-System/page-'+str(j))
        time.sleep(4)
        for i in range(1, 501):
            try:
                color = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/div[1]/a[5]')
                print('COLOR IS ' + color.text)
                tempArr.append(color.text)
                #outputArr[0].append(color.text)

            except selenium.common.exceptions.NoSuchElementException:
                print("incomplete data, skipping this entry")
                continue

            try:
                img = browser.find_element_by_xpath(
                    '/html/body/div[2]/div/div/section/article[' + str(i) + ']/a').get_attribute('href')
                print('IMG LINK IS' + img)
                tempArr.append(img)
                #outputArr[1].append(img)

            except selenium.common.exceptions.NoSuchElementException:
                print("no image found, replacing with a 404 instead")
                tempArr.append('https://www.lego.com/cdn/cs/stores/assets/blt44cddd0b8360e0e2/404.jpg?disable=upscale&width=1920&quality=40')
                #outputArr[1].append('https://www.lego.com/cdn/cs/stores/assets/blt44cddd0b8360e0e2/404.jpg?disable=upscale&width=1920&quality=40')


            elementID = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article['+str(i)+']/div[2]/div[1]/a[1]')
            print('ELEMENT ID IS '+elementID.text)
            tempArr.append(elementID.text)
            #outputArr[2].append(elementID.text)

            designID = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article['+str(i)+']/div[2]/div[1]/a[2]')
            print('DESIGN ID IS '+designID.text)
            tempArr.append(designID.text)
            #outputArr[3].append(designID.text)

            name = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article[' + str(i) + ']/div[2]/h1/a').text
            print('NAME IS ' + name.split(' ', 1)[1])
            tempArr.append(name.split(' ', 1)[1])

            outputArr.append(tempArr)
            tempArr = []
            #outputArr[4].append(name.split(' ', 1)[1])

    return outputArr

#Input: set ID
#Output: array with 2 arrays:
#       output[x][0] = array of all the brick element IDs
#       output[x][1] = array of all the brick design IDs
#       output[x][2] = array of all the quantities
def getSetContents(inputID):
    browser.get('https://brickset.com/inventories/'+str(inputID)+'-1')
    time.sleep(5)

    output = []
    tempArr = []
    i = 1
    ads = 1
    while 1:
        #main case, where we're just iterating through bricks
        try:
            elementID = browser.find_element_by_xpath('/html/body/div['+str(ads)+']/div/div[1]/section/table/tbody/tr['+str(i)+']/td[1]/a').text
            print('ELEMENT ID IS ' + elementID)
            qty = browser.find_element_by_xpath('/html/body/div['+str(ads)+']/div/div[1]/section/table/tbody/tr['+str(i)+']/td[3]').text
            print('QTY IS ' + qty)
            designID = browser.find_element_by_xpath('/html/body/div['+str(ads)+']/div/div[1]/section/table/tbody/tr['+str(i)+']/td[6]/a').text
            print('DESIGN ID IS '+designID)

            tempArr.append(elementID)
            tempArr.append(designID)
            tempArr.append(qty)
            output.append(tempArr)
            tempArr = []
            i +=1


        except selenium.common.exceptions.NoSuchElementException:
            if ads == 1:
                print('ads loaded badly, updating xpaths')
                ads = 2
            elif ads == 2:
                print('brick/row not found, ending')
                return output


    return 0


#Make sure the theme has -'s between words
def getSetInfo(theme):
    urlStr = 'https://brickset.com/sets/theme-'+theme
    browser.get(urlStr)
    outputArr = []
    tempArr = []

    time.sleep(3)
    # change the results per page to 500
    browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(1)
    browser.find_element_by_xpath('/html/body/div[2]/div/div/aside[1]/div[2]/ul[1]/li[4]/a').click()
    time.sleep(3)

    # iterate through pages, populating the arrays
    for j in range(1, 6):
        time.sleep(1)
        browser.get(urlStr + '/page-' + str(j))
        time.sleep(4)
        for i in range(1, 201):
            try:
                year = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article['+str(i)+']/div[2]/div[1]/a[4]')
            except selenium.common.exceptions.NoSuchElementException:
                print("incomplete data, skipping this entry")
                continue

            if browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article['+str(i)+']/div[2]/div[1]/a[3]').text == "MINIFIG PACK":
                print("no minifigs")
                continue

            try:
                img = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article['+str(i)+']/a/img').get_attribute('src')
                print('IMG LINK IS ' + img)
                tempArr.append(img)

            except selenium.common.exceptions.NoSuchElementException:
                print("no image found, replacing with a 404 instead")
                tempArr.append(
                    'https://www.lego.com/cdn/cs/stores/assets/blt44cddd0b8360e0e2/404.jpg?disable=upscale&width=1920&quality=40')

            elementID = browser.find_element_by_xpath('/html/body/div[2]/div/div/section/article['+str(i)+']/div[2]/div[1]/a[1]')
            print('ELEMENT ID IS ' + elementID.text.split('-', 1)[0])
            tempArr.append(elementID.text.split('-', 1)[0])
            # outputArr[2].append(elementID.text)

            outputArr.append(tempArr)
            tempArr = []
            # outputArr[4].append(name.split(' ', 1)[1])

    return outputArr
















    #for elem in browser.find_elements_by_xpath('/html/body/div/main/div[3]/div/div/ul/li[11]/div/button/span/span'):
    #    print
    #    elem.text





baseTheme = 'Star-Wars'
baseID = 'FANEXPO001'
browser = webdriver.Chrome()#chrome_options=options)


#To call getBrickInfo:
#holder = getBrickInfo()

#To call getSetInfo:
#baseTheme is starwars, currently it can't scrape anything with more than 1000 entries (don't think things that huge exist for themes anyway)
holder =getSetInfo(baseTheme)

#to call getSetContents:
#base ID is a random starwars set, make sure you do NOT include the -1 that brickset appends to id's
#holder = getSetContents(baseID)
#holder = [0]

for x in holder:
    print(x)



