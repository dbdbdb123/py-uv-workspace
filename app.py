import streamlit as st
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import random
import time

# 앱의 메인 타이틀을 출력 1나만 가능
st.title('튜토리얼1 : 텍스트 출력')

#큰 제목
st.header("기본 텍스트 출력")

#일반적인 문자열 그대로 출력
st.text("기본 텍스트 출력")

#중간 제목
st.subheader("마크다운 활용")

#마크다운 문법을 활용하여 서식을 적용한 텍스트를 출력
st.markdown("**굵게**, _기울임_, [링크](https://streamlit.io)")
st.divider() # hr
st.subheader("코드 출력")
st.code("print('hello, streamlit')",language="python")


# 사용자 입력 관련 기능 소개
st.title('튜토리얼 2 : 입력 위젯')
name = st.text_input('이름을 입력하세요')
age = st.number_input('나이을 입력하세요',min_value=0,max_value=120)
hobby = st.selectbox("취미",["독서","운동","게임"])
agree = st.checkbox("개인정보 수집에 동의 합니다")

if name and agree:
    st.success(f'{name}님, {age}세 /취미 : {hobby}')
else:
    st.error("이름과 나이를 입력하시고 개인정보 수집에 동의를 체크하세요")

#streamlit - button
if st.button("누르세요"):
    st.balloons()
    st.write("버튼이 눌렸습니다")

st.divider()
st.header("st.button",divider="rainbow")
if st.button("Reset",type="primary"):
    st.write("리셋")
    
if st.button("Say hellow"):
    st.write("hellow there :smile:")
else:
    st.write("goodbye")


st.divider()
st.button("Button",key=1) #
#기본값
 
st.button("Button",key=2,use_container_width = True) #
#부모의
 
#너비
 
st.button("Button",key=3,use_container_width = False) #
#기본값
 
st.button("Button",key=4,disabled = True) #
#비활성
 
st.button("Button",key=5,disabled = False) #
#활성
 
st.button("Button",key=6,type = "secondary") #
#기본값


st.divider()
def handle_on_click():
    st.balloons()
    print("clicked on_click button")
def handle_on_click_args(*args):
    st.snow()
    print(f"clicked on_click args button with args={args}")
def handle_on_click_kwargs(**kwargs):
    st.snow()
    print(f"clicked on_click kwargs button with kwargs={kwargs}")
   
st.button("on_click", on_click=handle_on_click)
st.button("on_click args", on_click=handle_on_click_args, args=("123",))
st.button("on_click kwargs", on_click=handle_on_click_kwargs, kwargs={"one":1})

upload = st.file_uploader("CSV 업로드,",type=["csv","jpg","png"])

if upload:
    df = pd.read_csv(upload)
    st.dataframe(df.head())


upload2 = st.file_uploader("이미지 업로드,",type=["jpg","png"],accept_multiple_files=True)
for up in upload2:
    bytes_data = up.read()
    st.image(up,caption=up.name,use_column_width=True)

st.divider()
st.title("Download data")

st.header("CSV",divider="rainbow")
csv = pd.read_csv("./source/recode.csv").to_csv()

st.download_button(
    label="download csv",
    data=csv,
    file_name="./source/recode.csv",
    mime="text/csv"
)
st.header("img",divider="rainbow")
with open("./source/1.png","rb") as file:
    btn = st.download_button(label="image",data=file,file_name=file.name,mime="image/png")



st.header("차트",divider="rainbow")


# 예시용 숫자 데이터 생성
data = pd.DataFrame({
    "x": [1,2,3,4,5],
    "y": [-0.5, 1, -1, 2 , 0]
})

# matplotlib로 선 그래프를 생성
fig, ax = plt.subplots()
ax.plot(data["x"], data["y"], marker='o')


# Streamlit 차트 렌더링
st.pyplot(fig)

# 정규분포를 따르는 난수를 10행 2열로 구함
chart_data = pd.DataFrame(np.random.randn(10,2),columns=["s","t"])
st.line_chart(chart_data, width=0, height=300, use_container_width=True)


data = {"Year": [2015, 2016, 2017, 2018, 2019, 2020, 2021, 2022, 2023],
"Sales": [100, 150, 200, 180, 150, 130, 200, 250, 270],
"Revenue": [50, 80, 120, 90, 100, 80, 150, 200, 220]}
df = pd.DataFrame(data)
sns.set_palette("Set2")    # 그래프의 기본 색강테마를 'set2'로 설정
fig = plt.figure(figsize=(10, 6)) # 다중라인 그래프 그리기
 
plt.title("Sales and Revenue Trend")
plt.xlabel("Year")
plt.ylabel("Amount")
sns.lineplot(x="Year", y="Sales", data=df, marker="o", label="Sales")
sns.lineplot(x="Year", y="Revenue", data=df, marker="o", label="Revenue")
plt.legend(loc="upper right")  # 범례
st.pyplot(fig)


labels = ["A", "B", "C", "D"]
sizes = [random.randint(1, 100) for _ in range(len(labels))]


#그래프
fig, ax = plt.subplots()
ax.pie(sizes, labels=["A", "B", "C", "D"] ,
 colors= ["lightsteelblue", "thistle", "bisque", "lightsalmon"],  
  autopct="%1.1f%%",  
  explode=[0 if s != min(sizes) else 0.1 for s in sizes])


st.pyplot(fig)

# 5 streamlit -side bar
# 사이드바와 조건부 표시 UI 소개
st.title("📑 튜토리얼 5: 사이드바와 토글")
with st.sidebar:
    # 사이드바에 타이틀 출력
    st.title("사이드바 메뉴")

    # 사이드바에 라디오 버튼으로 메뉴 선택 기능 추가
    menu = st.radio("메뉴 선택", ["홈", "소개", "설정"])

    # 선택된 메뉴를 출력
    st.write("선택한 메뉴:", menu)

    add_selectbox = st.selectbox("어떤 차트를 조회",("막대","꺽은선","히스토그램"))


if menu=='홈':
    st.title('🏠 홈')
    st.write('여기는 홈과 관련있는 페이지를')
elif menu=="소개":
    st.title('ℹ️ 소개')
    st.write('여기는 소개 관련있는 페이지를')
elif menu=="설정":
    st.title("⚙️ 설정")
    st.write('여기는 설정 관련있는 페이지를')



with st.sidebar:

    st.checkbox("제목")
    st.checkbox("축제목")
    st.checkbox("눈금선")
    st.checkbox("범례")

with st.sidebar:
    
    with st.echo():
        st.write("코드블록")
    with st.spinner("LOADING"):
        time.sleep(5)
    st.success("끝!")




# 토글 스위치를 통해 조건 제어
show = st.toggle("자세히 보기")

# 토글이 활성화되면 정보 메시지 출력
if show:
    st.info("여기에 자세한 내용이 표시됩니다.")

# 2개의 열이 생성되고 열의 크기는 3:1로 지정
col1, col2 = st.columns([3,1])

st.markdown('''<style> .custom-column{backgrond-color:lightblue;padding: 5px;} </style>''',unsafe_allow_html=True)
labels = ['man','woman']
valus = [20,30]
col1.subheader("col 1")
col1.markdown('<div class="custom-column">',unsafe_allow_html=True)
col1.bar_chart(valus)


data = {'Label1':labels,'values':valus}
df=pd.DataFrame(data)

col2.subheader("coumn 2")
col2.markdown('<div class="custom-column">',unsafe_allow_html=True)
col2.table(df)



if "count" not in st.session_state:
    st.session_state.count = 0

if st.button("세션 카운트"):
    st.session_state.count += 1
st.write("현제 카운트:", st.session_state.count)

with st.form('form'):
    chk1 = st.checkbox('낚시')
    chk2 = st.checkbox('골프')
    chk3 = st.checkbox('영화')
    submit = st.form_submit_button('확인')
    if submit:
        if chk1:
            st.write('낚시선택')
        if chk2:
            st.write('골프선택')
        if chk3:
            st.write("영화선택")


with st.form('myform'):
    name = st.text_input('이름:')
    age = st.number_input('나이:',value=0, step=1,
                           min_value=0, max_value=100 )
    birth = st.date_input('생일')
    time = st.time_input('시간')
    option = st.selectbox( label="옵션선택",options=['회사1','회사2','회사3'])
    radio = st.radio( label='색상선택', options=['빨강','파랑','노랑'] )
    slider = st.slider( 'slider')
    txt = st.text_area("여러줄입력")
    submit = st.form_submit_button('확인')
    if submit:
        s = f'이름:{name} 나이:{age} 생일:{birth} 시간:{time}, 회사:{option}'
        print( s )
        st.write( s )


#tab
tab1,tab2,tab3 = st.tabs(['TabA','TabB',"설정"])
with tab1:
    st.header("홈1")
    st.write("hellow1")

with tab2:
    
    st.header("홈2")
    st.write("hellow1")

with tab3:
    
    st.header("홈3")
    st.write("hellow1")




