from robot.api.deco import library, keyword
from robot.libraries.BuiltIn import BuiltIn

@library
class Shop:

    @keyword
    def add_item_to_cart_and_checkout(self, productList):
        seleniumLibr = BuiltIn().get_library_instance('SeleniumLibrary')
        i=1
        productsTitles = seleniumLibr.get_webelements("css:.card-title")
        for productsTitle in productsTitles:
            if productsTitle.text in productList:
                seleniumLibr.click_button("css:app-card:nth-of-type("+str(i)+") .btn.btn-info")
            i = i+1

        seleniumLibr.click_element("xpath://div[@id='navbarResponsive']/ul//a")

    @keyword
    def hello_world(self):
        print("hello")

    