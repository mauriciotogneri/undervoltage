import {UserRecord} from 'firebase-admin/auth';
import {MatchStatus} from '../types/match-status';
import {getDatabase} from 'firebase-admin/database';
import {Player} from './player';

export class Match {
  constructor(
    private id: string,
    private numberOfPlayers: number,
    private maxPoints: number,
    private createdAt: Date,
    private creator: string,
    private status: MatchStatus,
    private players: Record<string, Player>,
  ) {}

  public get playersJoined(): number {
    return Object.keys(this.players).length;
  }

  static new(params: {
    creator: UserRecord,
    numberOfPlayers: number,
    maxPoints: number,
  }): Match {
    return new Match(
        '',
        params.numberOfPlayers,
        params.maxPoints,
        new Date(),
        params.creator.uid,
        'waitingForPlayers',
        {
          [params.creator.uid]: Player.fromUser(params.creator),
        },
    );
  }

  static async load(matchId: string) {
    const snapshot = await getDatabase().ref(`matches/${matchId}`).get();

    return Match.parse(snapshot.toJSON());
  }

  static parse(data: any): Match {
    const players: Record<string, Player> = {};
    const playersMap = data['players'];

    for (const playerId of Object.keys(playersMap)) {
      players[playerId] = Player.parse(playersMap[playerId]);
    }

    return new Match(
        data['id'],
        data['numberOfPlayers'],
        data['maxPoints'],
        new Date(data['createdAt']),
        data['creator'],
        data['status'],
        players,
    );
  }

  public async create() {
    this.id = getDatabase().ref('matches').push().key ?? '';

    const matchesRef = getDatabase().ref(`matches/${this.id}`);
    await matchesRef.update(this.json());

    return this.id;
  }

  public async join(user: UserRecord) {
    if (this.playersJoined < this.numberOfPlayers) {
      this.players[user.uid] = Player.fromUser(user);

      if (this.playersJoined === this.numberOfPlayers) {
        this.status = 'started';
      }

      const matchesRef = getDatabase().ref(`matches/${this.id}`);
      await matchesRef.update(this.json());
    } else {
      throw new Error('Match is full');
    }
  }

  public json() {
    const players: any = {};

    for (const [key, value] of Object.entries(this.players)) {
      players[key] = value.json();
    }

    return {
      id: this.id,
      numberOfPlayers: this.numberOfPlayers,
      maxPoints: this.maxPoints,
      createdAt: this.createdAt,
      creator: this.creator,
      status: this.status,
      players: players,
    };
  }
}
