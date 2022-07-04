
from app.weeve.egress import send_data
from logging import getLogger
from app.config import APPLICATION
import time
from bluepy.btle import Scanner
"""
All logic related to the module's main application
Mostly only this file requires changes
"""
log = getLogger(__name__)
def module_main():
    """
    Finds ,filter by mac address and returns the advertised ble data found
    """
    while True:
        scanner = Scanner()
        devices = scanner.scan(float(APPLICATION['SCAN_TIMEOUT']),passive=True)
        if not devices:
            raise OSError(
        'ble access problem')
        if len(devices) < 1:
            raise OSError(
                'No nearby Devices found. Make sure your Bluetooth Connection '
                'is on.')
        else:
            for dev in devices:
                #The manufacturer data is advertized data in ble like deice name should be maximum 50 digits if the device name composed by 2 or less digits
                #Digits could be the hex ocnversion of any or many of [0,1,2,3,4,5,6,7,8,9,1,b,c,d,e.f] ,the letters in the last list could be upper case also
                if dev.addr==APPLICATION['MAC_ADDR']:
                        print("device name ", dev.getValueText(9))
                        manufData=dev.getValueText(255)
                        bluetooth_data={"bleData":""}
                        bluetooth_data['bleData']=str(manufData)
                        print("ble Dta",bluetooth_data)
                        sent = send_data(bluetooth_data)
                        if sent:
                            log.info("Data sent successfully")
                        else:
                            log.error("Error while sending data")
        time.sleep(int(APPLICATION['PERIOD']))
