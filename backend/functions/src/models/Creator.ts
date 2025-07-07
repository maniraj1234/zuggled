import { User } from './User';

export class Creator extends User {
  videoCallAvailable: boolean;
  audioCallAvailable: boolean;
  total_earnings: number;

  constructor(data: Partial<Creator>) {
    super(data);
    this.videoCallAvailable = data.videoCallAvailable ?? false;
    this.audioCallAvailable = data.audioCallAvailable ?? false;
    this.total_earnings = data.total_earnings ?? 0;
  }

  override toJSON() {
    return {
      ...super.toJSON(),
      videoCallAvailable: this.videoCallAvailable,
      audioCallAvailable: this.audioCallAvailable,
      total_earnings: this.total_earnings,
    };
  }
}
