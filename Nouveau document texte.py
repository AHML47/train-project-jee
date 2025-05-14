import json
import time
import asyncio
import websockets
import mysql.connector
import threading
from dataclasses import dataclass
from datetime import datetime
from typing import List, Dict, Set
from mysql.connector import Error

# Data classes
@dataclass
class MetroStation:
    id: int
    name: str
    lat: float
    lng: float

@dataclass
class MetroTrain:
    id: int
    line: str
    current_lat: float
    current_lng: float
    direction: int
    in_motion: bool

@dataclass
class RoutePoint:
    lat: float
    lng: float

class WebSocketManager:
    def __init__(self, host='localhost', port=8765):
        self.host = host
        self.port = port
        self.connected_clients: Set[websockets.WebSocketServerProtocol] = set()
        self.server_thread = threading.Thread(target=self.run_server, daemon=True)
        self.loop = None

    def run_server(self):
        self.loop = asyncio.new_event_loop()
        asyncio.set_event_loop(self.loop)
        start_server = websockets.serve(self.handler, self.host, self.port)
        self.loop.run_until_complete(start_server)
        self.loop.run_forever()

    async def handler(self, websocket):
        self.connected_clients.add(websocket)
        try:
            async for message in websocket:
                pass
        finally:
            self.connected_clients.remove(websocket)

    async def broadcast(self, message):
        if self.connected_clients:
            await asyncio.gather(
                *[client.send(message) for client in self.connected_clients]
            )

    def start(self):
        self.server_thread.start()

    def safe_broadcast(self, message):
        asyncio.run_coroutine_threadsafe(self.broadcast(message), self.loop)

class MetroService:
    _instance = None
    
    def __new__(cls, *args, **kwargs):
        if cls._instance is None:
            cls._instance = super().__new__(cls)
            cls._instance._initialized = False
        return cls._instance
    
    def __init__(self, host: str, user: str, password: str, database: str):
        if self._initialized:
            return
        self._initialized = True
        
        # Database configuration
        self.db_host = host
        self.db_user = user
        self.db_password = password
        self.db_name = database
        
        # WebSocket configuration
        self.ws_manager = WebSocketManager()
        
        # Metro system state
        self.connection = None
        self.stations: Dict[int, MetroStation] = {}
        self.trains: Dict[int, MetroTrain] = {}
        self.route_points: List[RoutePoint] = []
        self.train_position_indices: Dict[int, int] = {}
        
        # Initialize sample data
        self.init_sample_data()
        self.create_database()
        self.init_database_tables()
        self.ws_manager.start()

    def create_database(self):
        try:
            self.connection = mysql.connector.connect(
                host=self.db_host,
                user=self.db_user,
                password=self.db_password
            )
            if self.connection.is_connected():
                cursor = self.connection.cursor()
                cursor.execute(f"CREATE DATABASE IF NOT EXISTS {self.db_name}")
                print(f"Database '{self.db_name}' created or already exists.")
        except Error as e:
            print(f"Error while connecting to MySQL: {e}")
        finally:
            if self.connection.is_connected():
                self.connection.close()

    def init_database_tables(self):
        try:
            self.connection = mysql.connector.connect(
                host=self.db_host,
                user=self.db_user,
                password=self.db_password,
                database=self.db_name
            )
            if self.connection.is_connected():
                cursor = self.connection.cursor()
                cursor.execute("""
                    CREATE TABLE IF NOT EXISTS stations (
                        id INT PRIMARY KEY,
                        name VARCHAR(255),
                        lat FLOAT,
                        lng FLOAT
                    )
                """)
                cursor.execute("""
                    CREATE TABLE IF NOT EXISTS trains (
                        id INT PRIMARY KEY,
                        line VARCHAR(255),
                        current_lat FLOAT,
                        current_lng FLOAT,
                        direction INT,
                        in_motion BOOLEAN
                    )
                """)
                print("Database tables initialized successfully.")
        except Error as e:
            print(f"Error while initializing database tables: {e}")
        finally:
            if self.connection.is_connected():
                self.connection.close()

    def init_sample_data(self):
        self.route_points = [
            RoutePoint(lat=36.365, lng=10.642),
            RoutePoint(lat=36.350, lng=10.651),
        ]
        self.stations = {
            1: MetroStation(id=1, name="Sousse Bab Jedid", lat=36.365, lng=10.642),
            2: MetroStation(id=2, name="Sousse Sud", lat=36.350, lng=10.651),
        }
        self.trains = {
            101: MetroTrain(id=101, line="SahelLine", current_lat=36.365, current_lng=10.642, direction=1, in_motion=True),
            102: MetroTrain(id=102, line="SahelLine", current_lat=36.350, current_lng=10.651, direction=1, in_motion=True),
        }
        self.train_position_indices = {
            101: 0,
            102: 1,
        }

    def simulate_movement(self):
        for train_id, train in self.trains.items():
            current_index = self.train_position_indices[train_id]
            if train.direction == 1:
                next_index = current_index + 1
                if next_index >= len(self.route_points):
                    train.direction = -1
                    next_index = current_index - 1
            else:
                next_index = current_index - 1
                if next_index < 0:
                    train.direction = 1
                    next_index = current_index + 1
            self.train_position_indices[train_id] = next_index
            train.current_lat = self.route_points[next_index].lat
            train.current_lng = self.route_points[next_index].lng

    def save_to_json(self):
        data = {
            "trains": [
                {
                    "id": train.id,
                    "line": train.line,
                    "lat": train.current_lat,
                    "lng": train.current_lng,
                    "direction": train.direction,
                    "in_motion": train.in_motion
                }
                for train in self.trains.values()
            ]
        }
        with open("metro_data.json", "w") as file:
            json.dump(data, file, indent=4)
        print("Data saved to metro_data.json")

    def update_database(self):
        try:
            self.connection = mysql.connector.connect(
                host=self.db_host,
                user=self.db_user,
                password=self.db_password,
                database=self.db_name
            )
            if self.connection.is_connected():
                cursor = self.connection.cursor()
                for train in self.trains.values():
                    cursor.execute("""
                        INSERT INTO trains (id, line, current_lat, current_lng, direction, in_motion)
                        VALUES (%s, %s, %s, %s, %s, %s)
                        ON DUPLICATE KEY UPDATE
                        current_lat=VALUES(current_lat),
                        current_lng=VALUES(current_lng),
                        direction=VALUES(direction),
                        in_motion=VALUES(in_motion)
                    """, (train.id, train.line, train.current_lat, train.current_lng, train.direction, train.in_motion))
                self.connection.commit()
                print("Database updated successfully.")
        except Error as e:
            print(f"Error while updating database: {e}")
        finally:
            if self.connection.is_connected():
                self.connection.close()

    def prepare_realtime_data(self):
        return {
            'timestamp': datetime.now().isoformat(),
            'positions': {
                train.id: {
                    'lat': train.current_lat,
                    'lng': train.current_lng,
                    'line': train.line,
                    'speed': 50
                }
                for train in self.trains.values()
            }
        }

    def broadcast_positions(self):
        try:
            data = self.prepare_realtime_data()
            self.ws_manager.safe_broadcast(json.dumps(data))
        except Exception as e:
            print(f"Error broadcasting positions: {e}")

    def run_simulation(self, steps=100, interval=1):
        try:
            for step in range(steps):
                self.simulate_movement()
                self.save_to_json()
                self.update_database()
                self.broadcast_positions()
                time.sleep(interval)
                print(f"Completed simulation step {step+1}/{steps}")
        except KeyboardInterrupt:
            print("Simulation stopped by user")
        finally:
            if self.connection.is_connected():
                self.connection.close()

if __name__ == '__main__':
    service = MetroService(
        host="localhost",
        user="root",
        password="",
        database="basemetro"
    )
    service.run_simulation(steps=500, interval=0.5)