import argparse
import cv2
from ultralytics import YOLO
import datetime
import json
import signal
import sys

def parse_args():
    parser = argparse.ArgumentParser(description="Object Detection Script")
    parser.add_argument('--video_path', type=str, required=True, help='Path to the video file or RTSP link')
    parser.add_argument('--phone_number', type=str, required=True, help='Receiver\'s WhatsApp number')
    return parser.parse_args()

def detect_and_display_elephants(video_path, yolo_model_path, phone_number):
    model = YOLO(yolo_model_path)
    cap = cv2.VideoCapture(video_path)

    if not cap.isOpened():
        print("Error: Could not open video.")
        return

    frame_index = 0
    start_time = datetime.datetime.now()

    detected_classes = {}

    def signal_handler(sig, frame):
        print("Termination signal received.")
        cap.release()
        cv2.destroyAllWindows()
        sys.exit(0)

    signal.signal(signal.SIGINT, signal_handler)
    signal.signal(signal.SIGTERM, signal_handler)

    try:
        while True:
            ret, frame = cap.read()
            if not ret:
                break
            frame_index += 1

            yolomodel = model(frame)

            for output in yolomodel:
                for detection in output.boxes:
                    confi = detection.conf[0]
                    class_id = int(detection.cls[0])
                    class_name = model.names[class_id]

                    if confi > 0.50:
                        if class_name in detected_classes:
                            detected_classes[class_name] += 1
                        else:
                            detected_classes[class_name] = 1

            key = cv2.waitKey(1) & 0xFF
            if key == ord('q'):
                print("Terminating detection...")
                break

    except KeyboardInterrupt:
        print("Detection interrupted.")

    finally:
        end_time = datetime.datetime.now()
        cap.release()
        cv2.destroyAllWindows()

        result_file_path = 'detection_results.json'
        results = {
            'start_time': start_time.strftime('%Y-%m-%d %H:%M:%S'),
            'end_time': end_time.strftime('%Y-%m-%d %H:%M:%S'),
            'detected_classes': detected_classes
        }
        with open(result_file_path, 'w') as result_file:
            json.dump(results, result_file)

        print(f"Results saved to {result_file_path}")
        print(f"Start Time: {results['start_time']}")
        print(f"End Time: {results['end_time']}")
        print("Detected Classes:")
        for cls, count in detected_classes.items():
            print(f"{cls}: {count}")

if __name__ == '__main__':
    args = parse_args()
    yolo_model_path = 'rstpmdl.pt'
    detect_and_display_elephants(args.video_path, yolo_model_path, args.phone_number)
