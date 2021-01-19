from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

#Input: URL to scrape
#Output: array with the model's name, ID, imageURL
#Input: URL to scrape
#Output: array with all the page's bricks' names, IDs, imageURL, and color
#Note: it has an element ID and design ID.  In the database we treat this as one number with a '/' in the middle so I'll do that here
#Design decision: we can have each brick store its element & design ID and work using those in the database, then we can combine them when needed
def getBrickInfoOLD(inputURL):
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
            nameArr.append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[2]/span/span')
            print('THE COLOR IS '+ name.get_attribute('innerHTML'))
            colorArr.append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[4]/span/span')
            print('THE ELEMENT ID IS '+ name.get_attribute('innerHTML'))
            elementArr.append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[5]/span/span')
            print('THE DESIGN ID IS '+ name.get_attribute('innerHTML'))
            designArr.append(name.get_attribute('innerHTML'))

            name = browser.find_element_by_xpath('/html/body/div[5]/div/aside/div/div[2]/div/span[6]/span/span')
            print('THE PRICE IS ' + name.get_attribute('innerHTML'))
            priceArr.append(name.get_attribute('innerHTML'))

            #time.sleep(1)
            webdriver.ActionChains(browser).send_keys(Keys.ESCAPE).perform()
            time.sleep(1)

        #go to next page
        browser.find_element_by_xpath('//*[@id="main-content"]/div[3]/div/div/div/nav/a').click()
        time.sleep(1)

    return[nameArr, elementArr, designArr, priceArr]



def getModelInfo(inputURL):
    browser.get(inputURL)
    ID = browser.find_element_by_xpath('//*[@id="main-content"]/div/div[3]/div/div[4]/span[2]')
    name = browser.find_element_by_xpath('//*[@id="main-content"]/div/div[2]/div/div/div[2]/h1/span')
    imageURL = browser.find_element_by_xpath('//*[@id="main-content"]/div/div[2]/div/div/div[1]/div/div/div/div[1]/div/div[1]/ul/li[1]/div/div/div/div[1]/div/picture/img')
    return [ID.text, name.text, imageURL.get_attribute('src')]








    #for elem in browser.find_elements_by_xpath('/html/body/div/main/div[3]/div/div/ul/li[11]/div/button/span/span'):
    #    print
    #    elem.text




url = 'https://www.lego.com/en-us/page/static/Pick-a-Brick?page=1'
browser = webdriver.Chrome()

holder = getBrickInfoOLD(url)
i = 0

for x in holder:
    print(holder[i])
    i+=1

