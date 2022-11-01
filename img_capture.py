import cv2
import os

#XML Tree Setups

xml_body_1="""<annotation>
        <folder>{FOLDER}</folder>
        <filename>{FILENAME}</filename>
        <path>{PATH}</path>
        <source>
                <database>Unknown</database>
        </source>
        <size>
                <width>{WIDTH}</width>
                <height>{HEIGHT}</height>
                <depth>3</depth>
        </size>
"""
xml_object=""" <object>
                <name>{CLASS}</name>
                <pose>Unspecified</pose>
                <truncated>0</truncated>
                <difficult>0</difficult>
                <bndbox>
                        <xmin>{XMIN}</xmin>
                        <ymin>{YMIN}</ymin>
                        <xmax>{XMAX}</xmax>
                        <ymax>{YMAX}</ymax>
                </bndbox>
        </object>
"""
xml_body_2="""</annotation>        
"""

#Initialise Webcam
cam = cv2.VideoCapture(0)
cv2.namedWindow("test")

img_counter = 100
letter = ""

img_w = 640
img_h = 480
x1 = 0
x2 = 0
y1 = 0
y2 = 0

def define_bbox(): #Hard Code Bounding Box Cordinates for Different Letter Sizes
    bbox_type = input("What type of bounding box? \n1. Regular \n2. Wide \n3. Tall")
    letter = input("What Letter (Caps doesnt Matter?")
    letter = letter.capitalize()
    if str(bbox_type) == "1":
        x1 = 97
        x2 = 347
        y1 = 97
        y2 = 347
    if str(bbox_type) == "2":
        x1 = 97
        x2 = 447
        y1 = 97
        y2 = 260
    if str(bbox_type) == "3":
        x1 = 97
        x2 = 300
        y1 = 97
        y2 = 422
    return x1, y1, x2, y2, letter


x1, y1, x2, y2, letter = define_bbox()
save_dir = f"D:/projects/ASLearner/Imgs/{letter}"

def create_voc_xml(xml_file, img_file, display=False): #Function ot Generate & Save .xml file
    with open(xml_file, "w") as f:
        f.write(xml_body_1.format(**{'FOLDER': letter,'FILENAME': os.path.basename(img_file), 'PATH': img_file, 'WIDTH': img_w, 'HEIGHT': img_h}))
        f.write(xml_object.format(**{'CLASS': letter, 'XMIN': x1, 'YMIN': y1, 'XMAX': x2, 'YMAX': y2}))
        f.write(xml_body_2)
    if display: print("New xml", xml_file)


while True:
    ret, frame = cam.read() #Read Frames
    if not ret:
        print("failed to grab frame")
        break
    cv2.rectangle(frame, (x1 + 3, y1 + 3), (x2+3, y2+3), (0, 255, 0), 1) #Overlay Rectangle over Set BOunding Box Cordinates
    cv2.imshow("test", frame)

    k = cv2.waitKey(1)
    if k % 256 == 27: #Wait for Esc key pressed
        # ESC pressed
        print("Escape hit, closing...")
        break
    elif k % 256 == 32: #Wait for Space key Pressed to Take Image
        # SPACE pressed
        img_name = f"{save_dir}/{letter}_{img_counter}.jpg"
        xml_fn = f"{save_dir}/{letter}_{img_counter}.xml"
        cv2.imwrite(img_name, frame)
        create_voc_xml(xml_fn, img_name, letter) #Same Image and Corresponding .xml File
        print(f"{img_name} written!")
        img_counter += 1
cam.release()

cv2.destroyAllWindows()

