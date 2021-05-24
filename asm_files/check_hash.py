import hashlib

seed = "0834876DCFB05CB167A5C24953EB"  # every time rewrite text itself


def hash256(data: str) -> str:
    global seed
    row = data + seed[len(data):]
    sha = hashlib.sha256()
    sha.update(row.encode('utf-8'))
    return sha.hexdigest()


if __name__ == "__main__":
    while True:
        print(hash256(input()).upper())
