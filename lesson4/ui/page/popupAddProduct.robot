*** Variables ***
${locator_text_name_product}    //body/div[not(contains(@style,'display: none'))]//div[@k-options='options']//label[contains(text(), 'Tên hàng')]/following-sibling::div/input
${locator_text_seach_group_product}    //div[contains(@class,'k-animation-container')]//input[contains(@class,'k-textbox')]
${locator_item_group_product}    //div[contains(@class,'k-animation-container')]//span[contains(text(),'Thực phẩm chức năng')]
${locator_text_cost_product}    //body/div[not(contains(@style,'display: none'))]//div[@k-options='options']//label[contains(text(), 'Giá vốn')]/following-sibling::div/input
${locator_text_price_product}    //body/div[not(contains(@style,'display: none'))]//div[@k-options='options']//label[contains(text(), 'Giá bán')]/following-sibling::div/input
${locator_text_inventory_product}    //body/div[not(contains(@style,'display: none'))]//div[@k-options='options']//label[contains(text(), 'Tồn kho')]/following-sibling::div/input
${locator_text_code_product}    //body/div[not(contains(@style,'display: none'))]//div[@k-options='options']//label[contains(text(), 'Mã hàng hóa')]/following-sibling::div/input
${locator_icon_dropdown_group_product}    //body/div[not(contains(@style,'display: none'))]//label[contains(text(), 'Nhóm hàng')]/following-sibling::div//span[@class ='k-widget k-dropdown k-header product-select']//span[@class='k-icon k-i-arrow-s']
${locator_save_product}    //body/div[not(contains(@style,'display: none'))]//a[@ng-enter='SaveProduct()']
${url_product}    https://fnb.kiotviet.vn/chuyendb1/#/Products
${msg_create_product_success}    //div[@class='toast-message']
