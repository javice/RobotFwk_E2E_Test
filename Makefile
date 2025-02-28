
### Makefile

```makefile
install:
    pip install -r requirements.txt

test:
    robot -r ./reports tests/avis_navigation.robot

clean:
    rm -rf reports/