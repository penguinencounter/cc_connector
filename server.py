import asyncio
import websockets
import logging
import os


logging.basicConfig(level=logging.INFO)

async def echo(ws, path):
    async for message in ws:
        print(message)
        await ws.send(message)


async def send(ws, path):
    print('disconnected')
    async for message in ws:
        m = input('action? ')
        if not os.path.exists(f'actions/{m}.lua'):
            print("That doesn't exist.")
            await ws.send('\n')
        else:
            with open(f'actions/{m}.lua') as f:
                lines = f.read().split('\n')
            okcount = 0
            targetcount = len(lines)
            for line in lines:
                await ws.send(line)
                print(f'> {line}')
                result = await ws.recv()
                
            await ws.send('eof')


asyncio.get_event_loop().run_until_complete(
    websockets.serve(send, 'localhost', 8765))
asyncio.get_event_loop().run_forever()
