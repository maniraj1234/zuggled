export class CallLog {
  callID: string;
  from: string;
  to: string;
  callType: 'video' | 'audio';
  direction: 'incoming' | 'outgoing';
  timestamp: string;
  durationSeconds: number;

  constructor(data: Partial<CallLog>) {
    this.callID = data.callID ?? '';
    this.from = data.from ?? '';
    this.to = data.to ?? '';
    this.callType = data.callType ?? 'audio';
    this.direction = data.direction ?? 'outgoing';
    this.timestamp = data.timestamp ?? new Date().toISOString();
    this.durationSeconds = data.durationSeconds ?? 0;
  }

  toJSON() {
    return {
      callID: this.callID,
      from: this.from,
      to: this.to,
      callType: this.callType,
      direction: this.direction,
      timestamp: this.timestamp,
      durationSeconds: this.durationSeconds,
    };
  }
}
