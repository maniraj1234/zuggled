export class User {
  userName: string;
  bio: string;
  gender: 'male' | 'female';
  birthdate: string;
  profilePicture: string;
  interests: string[];
  phoneNumber: string;
  coins: number;

  constructor(data: Partial<User>) {
    this.userName = data.userName ?? '';
    this.bio = data.bio ?? '';
    this.gender = data.gender ?? 'male';
    this.birthdate = data.birthdate ?? '';
    this.profilePicture = data.profilePicture ?? '';
    this.interests = data.interests ?? [];
    this.phoneNumber = data.phoneNumber ?? '';
    this.coins = data.coins ?? 0;
  }

  toJSON() {
    return {
      userName: this.userName,
      bio: this.bio,
      gender: this.gender,
      birthdate: this.birthdate,
      profilePicture: this.profilePicture,
      interests: this.interests,
      phoneNumber: this.phoneNumber,
      coins: this.coins,
    };
  }
}
