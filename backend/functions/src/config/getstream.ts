import { StreamClient } from '@stream-io/node-sdk';
import dotenv from 'dotenv';
dotenv.config({ path: './config/.env' });

const apiKey = process.env.STREAM_API_KEY;
const apiSecret = process.env.STREAM_API_SECRET;

if (!apiKey || !apiSecret) {
    throw new Error('Missing Stream credentials.');
}
export const streamClient = new StreamClient(apiKey, apiSecret, {
    timeout: 30000,
});