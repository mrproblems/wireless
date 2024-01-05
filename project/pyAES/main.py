from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
import wave
import os

def encrypt_audio(input_file, output_file, key):
    block_size = 16  # AES block size in bytes
    cipher = AES.new(key, AES.MODE_ECB)

    with wave.open(input_file, 'rb') as audio_file:
        frames = audio_file.readframes(audio_file.getnframes())
        encrypted_frames = b''

        # Encrypt each block of audio data
        for i in range(0, len(frames), block_size):
            block = frames[i:i+block_size].ljust(block_size, b'\0')
            encrypted_block = cipher.encrypt(block)
            encrypted_frames += encrypted_block

    with wave.open(output_file, 'wb') as encrypted_file:
        encrypted_file.setnchannels(audio_file.getnchannels())
        encrypted_file.setsampwidth(audio_file.getsampwidth())
        encrypted_file.setframerate(audio_file.getframerate())
        encrypted_file.writeframes(encrypted_frames)

def decrypt_audio(input_file, output_file, key):
    block_size = 16  # AES block size in bytes
    cipher = AES.new(key, AES.MODE_ECB)

    with wave.open(input_file, 'rb') as encrypted_file:
        frames = encrypted_file.readframes(encrypted_file.getnframes())
        decrypted_frames = b''

        # Decrypt each block of audio data
        for i in range(0, len(frames), block_size):
            block = frames[i:i+block_size]
            decrypted_block = cipher.decrypt(block)
            decrypted_frames += decrypted_block

    with wave.open(output_file, 'wb') as decrypted_audio_file:
        decrypted_audio_file.setnchannels(encrypted_file.getnchannels())
        decrypted_audio_file.setsampwidth(encrypted_file.getsampwidth())
        decrypted_audio_file.setframerate(encrypted_file.getframerate())
        decrypted_audio_file.writeframes(decrypted_frames)

if __name__ == "__main__":
    input_audio_file = 'tii.wav'
    encrypted_audio_file = 'wencrypted_audio.wav'
    decrypted_audio_file = 'wdecrypted_audio.wav'
    key = bytes.fromhex('3d3493103922ac3fe84ee75aac940f4c')


    encrypt_audio(input_audio_file, encrypted_audio_file, key)
    decrypt_audio(encrypted_audio_file, decrypted_audio_file, bytes.fromhex('4d3234103945ac3fe66ee75aac940f4a'))
