module TableFootballDomain exposing (..)

-- use type aliases to adopt ubiquitous language


type alias PlayerName =
    String


type alias Player =
    { name : PlayerName }


type alias TeamName =
    String



-- our team can be without players, this is a domain decision


type alias Team =
    { name : TeamName
    , player1 : Maybe Player
    , player2 : Maybe Player
    }


type alias TournamentName =
    String


type alias Rounds =
    Int


type alias Tournament =
    { name : TournamentName
    , rounds : Rounds
    , teams : List Team
    , playedGames : List Game
    }


type alias Game =
    { team1 : Team
    , team2 : Team
    , goalsScoredBy : List Player
    }


type Event
    = TeamWasCreated TeamName
    | PlayerWasCreated PlayerName
    | PlayerWasAddedToTeam Player Team
    | TournamentWasCreated TournamentName Rounds
    | TeamWasAddedToTournament Team Tournament
    | GameStarted Team Team
    | GoalScored Player
    | GameFinished


type Command
    = CreatePlayer PlayerName
    | CreateTeam TeamName
    | CreateTournament TournamentName Rounds
    | AddPlayerToTeam Player Team
    | AddTeamToTournament Team Tournament
