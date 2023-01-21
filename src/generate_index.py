import pykakasi
import whisper
import argparse
import csv
from pathlib import Path
from natsort import natsorted

parser = argparse.ArgumentParser(
    prog="generate_index",
    description="generate subscript and phonome"
)
parser.add_argument("splitted_voice_directory")
parser.add_argument("output_file_path")

model = whisper.load_model("large")


def main(args):
    directory_path = Path(args.splitted_voice_directory)
    output_file_path = args.output_file_path
    file_paths = directory_path.glob("*.wav")
    with open(output_file_path, mode="w", encoding="utf-8") as f:
        for file_path in natsorted(file_paths, key=lambda x: x.name):
            subscript = extract_subscript(str(file_path))
            romaji = to_romaji(subscript)
            writer = csv.writer(f, delimiter=",")
            writer.writerow([file_path.name, subscript, romaji])


def extract_subscript(file_path):
    result = model.transcribe(file_path, best_of=5, beam_size=5, language="ja")
    return " ".join(map(lambda segment: segment["text"], result["segments"]))


def to_romaji(subscript):
    kakasi = pykakasi.kakasi()
    result = kakasi.convert(subscript)
    return "".join(map(lambda item: item["kunrei"], result))


main(parser.parse_args())
