curl -sI https://github.com/Plann1ng/1DV503DatabasaTehnology/blob/main/Assignment2/assignment2_Database.py | grep -i "Content-Disposition" > /dev/null
if [ $? -eq 0 ]; then
  filename=$(curl -sI https://github.com/Plann1ng/1DV503DatabasaTehnology/blob/main/Assignment2/assignment2_Database.py | grep -oP 'filename=.*' | cut -d= -f2 | tr -d '"')
else
  filename=$(echo https://github.com/Plann1ng/1DV503DatabasaTehnology/blob/main/Assignment2/assignment2_Database.py | rev | cut -d/ -f1 | rev)
fi

extension="${filename##*.}"
