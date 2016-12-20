module Slownie (Rodzaj(..), Waluta(..), slownie) where
    data Rodzaj = Meski | Zenski | Nijaki deriving (Show, Eq)
    data Waluta = Waluta {
        mianownik_poj :: String,
        mianownik_mn :: String,
        dopelniacz_mn :: String,
        rodzaj :: Rodzaj
    } deriving Show
    
    slownie :: Waluta -> Integer -> String


----------------------------------------------------------------
-------------------------- Komentarz --------------------------- 
----------------------------------------------------------------
{-
        
        Przemysław Joniak, 282751

        Zmieniłem deklarację modułu. Przy `data Rodzaj` zamieniłem: `deriving Show` na: `deriving (Show, Eq)

        Treść tego zadania, przypis 6: zdecydowałem się na użycie pierwszego wariantu (1000000 - "milion").
    
        Kompilowałem używając: Glasgow Haskell Compiler, Version 7.6.3, stage 2 booted by GHC version 7.6.3

-}

----------------------------------------------------------------
----------------------- Rdzeń modułu --------------------------- 
----------------------------------------------------------------
    

    slownie waluta n 
        | n == 0 = "zero " ++ odmienionaWaluta
        | n<0    = "minus " ++ slownie waluta (-1*n)
        | digLength n > 6000 = "mnóstwo " ++ dopelniacz_mn waluta
        | n == 1 = wyjatek waluta n                        
        | otherwise = liczebnik ++ odmienionaWaluta
        where   liczebnikOrazKoncowka = slownieLiczba n 0 waluta
                liczebnik = fst liczebnikOrazKoncowka
                koncowka  = snd liczebnikOrazKoncowka
                odmienionaWaluta = walutaOdmiana waluta koncowka

    
    walutaOdmiana waluta k  -- mianownik_poj obsługiwany jest w funkcji `wyjatek`
        | elem k [2,3,4] = mianownik_mn waluta 
        | otherwise      = dopelniacz_mn waluta 
    
    wyjatek w n 
        | rodzaj w == Nijaki && n == 1 = "jedno " ++ mn
        | rodzaj w == Zenski && n == 1 = "jedna " ++ mn
        | rodzaj w == Meski  && n == 1 = "jeden " ++ mn
        where mn = mianownik_poj w


----------------------------------------------------------------
------- Funkcje odpowiadające za wypisanie liczebnika ----------
----------------------------------------------------------------

    slownieLiczba :: Integer -> Int -> Waluta -> (String, Int)
    slownieLiczba 0 _ _ = ("", 0)
    slownieLiczba n k waluta
        | (n `mod` 1000) == 0 =  (kolejnyRzad ++ liczba, odmianaKoncowki)
        | (n `mod` 1000) == 1 =  (kolejnyRzad ++ (slownieRzad k odmianaKoncowki), odmianaKoncowki)
        | otherwise           =  (kolejnyRzad ++ liczba ++ (slownieRzad k odmianaKoncowki),   odmianaKoncowki)
         
        where kolejnyRzad     = fst$ slownieLiczba  (n `div` 1000) (k+1) waluta
              liczbaPara      = slownieDoTysiaca (fromIntegral (n `mod` 1000)) k waluta
              liczba          = fst liczbaPara
              odmianaKoncowki = snd liczbaPara

    slownieRzad :: Int -> Int -> String
    slownieRzad k koncowka 
        | k  == 0 = ""
        | k' == 0 = odmianaTysiecy koncowka
        | k' < 10 = (male_k !! k') ++ odmiana
        | otherwise = (qa !! je) ++ (rb !! dz) ++ (sc !! se) ++ odmiana

        where   k' = k `div` 2
                i  = k `mod` 2
                se = (k' `mod` 1000) `div` 100
                dz = (k' `mod` 100 ) `div` 10
                je = (k' `mod` 10  )
                odmiana = (lionOrLiard !! i ) ++ (odmianaLionLiard koncowka)

              
    slownieDoTysiaca :: Int -> Int -> Waluta -> (String, Int)
    slownieDoTysiaca n rzad waluta
        | dziesiatki == 1  = ( (setkiMap !! setki) ++ (nastkiMap !! nastki), 0 ) -- dla nastek mamy: ...++" tysięcy"
        | otherwise  =  ( (setkiMap !! setki) ++ (dziesiatkiMap !! dziesiatki) ++ (jednosciMap !! (jednosci+indeksJednosci)), jednosci)

        where jednosci = (n `mod` 10)
              nastki   = n `mod` 10
              dziesiatki = (n `mod` 100) `div` 10
              setki    = n `div` 100
              indeksJednosci = if rzad == 0 && jednosci == 2 then 
                                    if rodzaj waluta == Nijaki   then 9
                                        else if rodzaj waluta == Zenski then 11
                                            else 0 
                                else 0

              -- Linię wyżej obsługuję speclalny przypadek gdy rzed jednosci == 2 oraz rodzaj waluty jest nijaki lub żeński (szczegóły: funkcja jednosciMap)


    lionOrLiard :: [String]
    lionOrLiard = ["lion", "liard"]

    odmianaTysiecy :: Int -> String
    odmianaTysiecy n 
       -- | n == 0         = ""
        | n == 1         = "tysiąc "
        | elem n [2,3,4] = "tysiące "
        | otherwise      = "tysięcy "

    odmianaLionLiard :: Int -> String
    odmianaLionLiard n 
        | n == 1         = " "
        | elem n [2,3,4] = "y "
        | otherwise      = "ów "


    digLength 0 = 0
    digLength n = 1 + digLength (n `div` 10)



----------------------------------------------------------------
---------------- Dane programu - liczby slownie ----------------
----------------------------------------------------------------


    jednosciMap :: [String]
    jednosciMap = ["", "jeden ", "dwa ", "trzy ", "cztery ", "pięć ", "sześć ", "siedem ", "osiem ", "dziewięć ", "jeden ", "dwa ", "jeden ", "dwie "]
    --                                                                                                                       ^nijaki>1        ^zenski      

    nastkiMap :: [String]
    nastkiMap =  ["dziesięć ", "jedenaście ", "dwanaście ", "trzynaście ", "czternaście ", "piętnaście ", 
                "szesnaście ", "siedemnaśie ", "osiemnaście ", "dziewiętnaście "]

    dziesiatkiMap :: [String]
    dziesiatkiMap = ["", "", "dwadzieścia ", "trzydzieści ", "czterdzieści ", "pięćdziesiąt ",
                  "sześćdziesiąt ", "siedemdziesiąt ", "osiemdziesiąt ", "dziewięćdziesiąt "]

    setkiMap :: [String]
    setkiMap = ["", "sto ", "dwieście ", "trzysta ", "czterysta ", "pięćset ", 
                "sześćset ", "siedemset ", "osiemset ", "dziewięćset "]


    male_k = ["", "mi", "bi", "try", "kwadry", "kwinty", "seksty", "septy", "okty", "noni"]

    qa = ["", "un", "do", "tri", "kwatuor", "kwin", "seks", "septen", "okto", "nowem"]
    rb = ["", "decy", "wicy", "trycy", "kwadragi", "kwintagi", "seksginty", "septagi", "oktagi", "nonagi"]
    sc = ["", "centy", "duocenty", "trycenty", "kwadryge", "kwinge", "sescenty", "septynge", "oktynge", "nonge"]
