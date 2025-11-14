enum ScoringScreen: Hashable {
    case addPlayer(ScoreData)
    case addScore(ScoreData)
    case detail(Player)
}
