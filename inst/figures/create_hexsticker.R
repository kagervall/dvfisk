
imgurl <- "inst/figures/slu_logo.png"
s <- hexSticker::sticker(imgurl, s_x = 1.03, s_y = .9, s_width = .5,
                         h_size = 2,
             package="dvfisk", p_size = 20, p_y = 1.6,
             h_fill =  "#888B8D", h_color = "#672146",
             filename="inst/figures/hexsticker.png")


usethis::use_logo("inst/figures/hexsticker.png")

# Druva   Plommon    Hallon    Korall   Aprikos      Skog      Oliv Klorofyll     Äpple  Lindblom  Havsdjup
# "#502B3A" "#672146" "#CE0037" "#FF585D" "#FBD7C9" "#154734" "#79863C" "#509E2F" "#C4D600" "#D8ED96" "#004851"
# Havsvik    Turkos    Himmel      Duva   Choklad     Kanel      Kåda      Majs   Solsken       Kol     Titan
# "#007681" "#00B0B9" "#6AD1E3" "#B9D3DC" "#4B3D2A" "#996017" "#FFB81C" "#FCE300" "#F6EA61" "#000000" "#53565A"
# Betong   Glimmer    Fjäder       Snö
# "#888B8D" "#BBBCBC" "#D9D9D6" "#FFFFFF"
