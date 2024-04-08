# ทำการเลือก base image (จาก docker hub) มาเป็นตัว runtime เริ่มต้น เพื่อให้สามารถ run project ได้
# ในทีนี้เราทำการเลือก node image version 18 ออกมา
FROM node:18

# กำหนด directory เริ่มต้นใน container (ตอน run ขึ้นมา)
WORKDIR /user/src/app

# ทำการ copy file package.json จากเครื่อง local เข้ามาใน container
# ./ แรกเป็นการจะใช้ file ไหนในการ copy ./ ที่สองเป็นการจะเอา file ไว้ที่ไหน
COPY ./package.json ./

# ทำการลง dependency node
RUN npm install

# copy file index.js เข้ามาใน container
COPY ./index.js ./ 

# ทำการปล่อย port 8000 ออกมาให้ access ได้
EXPOSE 8000

# กำหนด command สำหรับเริ่มต้น run application (ตอน run container)
CMD [ "node", "index.js" ]

# command
# CML : docker build -t <ชื่อ image ที่ต้องการตั้ง> -f <ตำแหน่ง dockerfile> <path เริ่มต้นที่จะใช้ run docker file>

# example ที่เราจะ run
# CML : docker build -t node-server -f ./Dockerfile .
# ถ้าเกิดเป็น Dockerfile อยู่แล้ว (ไม่ใช่ชื่ออื่น) สามารถย่อเหลือเพียงแค่
# CML : docker build -t node-server .

# ลองทำการ run ออกมาด้วยคำสั่ง docker run แต่คราวนี้จะต้องมีการ map port ออกมา เพื่อให้สามารถ access ไปยัง port ภายในที่ run node อยู่ได้ ด้วย -p

# เพิ่ม -d เพื่อให้สามารถ run background ได้
# CML : docker run -d -p 8000:8000 node-server
# เมื่อเราลองใช้คำสั่ง docker ps จะสามารถดู container ทั้งหมดที่กำลัง run อยู่ได้ และจะเจอ container ที่ run โดยใช้ image node-server ขึ้นมา

# command
# docker logs <ชื่อ container> // 
# docker rm -f <ชื่อ container> // หยุด run container 