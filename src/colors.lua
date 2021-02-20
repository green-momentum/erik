-- Color palette: https://lospec.com/palette-list/japanese-woodblock
function GetRGB(r, g, b)
    return {r / 255, g / 255, b / 255}
end

return {
    BLACK_ZEUS = GetRGB(43, 40, 33), -- #2b2821
    BROWN_KABUL = GetRGB(98, 76, 60), -- #624c3c
    BROWN_BRANDY = GetRGB(217, 172, 139), -- #d9ac8b
    BROWN_GRAIN = GetRGB(227, 207, 180), -- #e3cfb4
    BLUE_CLOUD_BURST = GetRGB(36, 61, 92), -- #243d5c
    BLUE_NEVADA = GetRGB(93, 114, 117), -- #5d7275
    BLUE_SMALT = GetRGB(92, 139, 147), -- #5c8b93
    RED_HILLARY = GetRGB(177, 165, 141), -- #b1a58d
    RED_NIGHT_SHADZ = GetRGB(176, 58, 72), -- #b03a48
    ORANGE_RAW_SIENNA = GetRGB(212, 128, 77), -- #d4804d
    YELLOW_CHENIN = GetRGB(224, 200, 114), -- #e0c872
    GREEN_MINERAL = GetRGB(62, 105, 88) -- #3e6958
}
