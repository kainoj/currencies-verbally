import Slownie	
import Data.List
import System.Environment
import Data.Maybe

	
main = do 
	[argLiczba, argWaluta] <- getArgs
	let liczba = read argLiczba :: Integer
	putStrLn (slownie (fromJust (lookup argWaluta waluty)) liczba )







----------------------------------------------------------------
---------------------------- Waluty ----------------------------
----------------------------------------------------------------

waluty = [
        ("AUD", Waluta "dolar australijski" "dolary australijskie" "dolarów australijskich" Meski),
        ("BGN", Waluta "lew" "lewy" "lewów" Meski),
        ("BRL", Waluta "real" "reale" "reali" Meski),
        ("BYR", Waluta "rubel białoruski" "ruble białoruskie" "rubli białoruskich" Meski),
        ("CAD", Waluta "dolar kanadyjski" "dolary kanadyjskie" "dolarów kanadyjskich" Meski),
        ("CHF", Waluta "frank szwajcarski" "franki szwajcarskie" "franków szwajcarskich" Meski),
        ("CNY", Waluta "yuan renminbi" "yuany renminbi" "yuanów renminbi" Meski),
        ("CZK", Waluta "korona czeska" "korony czeskie" "koron czeskich" Zenski),
        ("DKK", Waluta "korona duńska" "korony duńskich" "koron duńskich" Zenski),
        ("EUR", Waluta "euro" "euro" "euro" Nijaki),
        ("GBP", Waluta "funt szterling" "funty szterlingi" "funtów szterlingów" Meski),
        ("HKD", Waluta "dolar Hongkongu" "dolary Hongkongu" "dolarów Hongkongu" Meski),
        ("HRK", Waluta "kuna" "kuny" "kun" Zenski),
        ("HUF", Waluta "forint" "forinty" "forintów" Meski),
        ("IDR", Waluta "rupia indonezyjska" "rupie indonezyjskie" "rupii indonezyjskich" Zenski),
        ("ISK", Waluta "korona islandzka" "korony islandzkie" "koron islandzkich" Zenski),
        ("JPY", Waluta "jen" "jeny" "jenów" Meski),
        ("KRW", Waluta "won południowokoreański" "wony południowokoreańskie" "wonów południowokoreańskich" Meski),
        ("MXN", Waluta "peso meksykańskie" "peso meksykańskie" "peso meksykańskich" Nijaki),
        ("MYR", Waluta "ringgit" "ringgity" "ringgitów" Meski),
        ("NOK", Waluta "korona norweska" "korony norweskie" "korona norweskich" Zenski),
        ("NZD", Waluta "dolar nowozelandzki" "dolary nowozelandzkie" "dolarów nowozelandzkich" Meski),
        ("PHP", Waluta "peso filipińskie" "peso filipińsie" "peso filipińskich" Nijaki),
        ("PLN", Waluta "złoty" "złote" "złotych" Meski),
        ("RON", Waluta "lej rumuński" "leje rumuńskie" "lejów rumuńskich" Meski),
        ("RUB", Waluta "rubel rosyjski" "rubele rosyjskie" "rubli rosyjskich" Meski),
        ("SDR", Waluta "specjalne prawa ciągnienia" "specjalne prawa    ciągnienia" "specjalnych praw ciągnienia" Nijaki),
        ("SEK", Waluta "korona szwedzka" "korony szwedzkie" "koron szwedzkich" Zenski),
        ("SGD", Waluta "dolar singapurski" "dolary singapurskie" "dolarów singapurskich" Meski),
        ("THB", Waluta "bat" "baty" "batów" Meski),
        ("TRY", Waluta "lira turecka" "liry tureckie" "lir tureckich" Zenski),
        ("UAH", Waluta "hrywna" "hrywny" "hrywien" Zenski),
        ("USD", Waluta "dolar amerykański" "dolary amerykańskie" "dolarów amerykańskich" Meski),
        ("ZAR", Waluta "rand" "randy" "randów" Meski)
		]



--   moje źródła:
--   http://publications.europa.eu/code/pl/pl-5000700.htm
--   http://www.currency-iso.org/dam/downloads/lists/list_one.xml
--
--   https://pl.m.wiktionary.org/wiki/lej
--   W treści zadania jest błąd: SDR to waluta, której kodem jest XDR (a nie SDR!)
