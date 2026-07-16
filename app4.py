import streamlit as st
import pandas as pd

if __name__ == '__main__':
    st.header("CSV파일 편집기")
    csv_file = st.file_uploader("CSV 파일을 업로드", type=["csv"])

    with st.sidebar:
        # 사이드바에 타이틀 출력
        st.title("사이드바 메뉴")

    if csv_file:
        # 세션 상태(Session State)를 사용하여 데이터를 새로고침 후에도 유지.
        if 'df' not in st.session_state:
            st.session_state.df = pd.read_csv(csv_file)

        # 현재 상태의 데이터프레임 출력
        st.dataframe(st.session_state.df)

        with st.form('myform', clear_on_submit=True):
            num = st.text_input("학번")
            name = st.text_input("이름")
            jungong = st.text_input("전공")
            submit_btn = st.form_submit_button("추가하기")
            
            if submit_btn:
                # 세션 상태에 저장된 데이터프레임의 마지막 행에 추가
                new_row = {'학번': num, '이름': name, '전공': jungong}
                st.session_state.df.loc[len(st.session_state.df)] = new_row
                st.success(f"추가 완료! 이름:{name}, 학번:{num}, 전공:{jungong}")              
                st.balloons()
  
                # 데이터가 추가된 화면을 즉시 반영하기 위해 리런(Rerun)
                st.rerun()

        # 수정된 DataFrame을 CSV 바이너리로 변환
        csv_data = st.session_state.df.to_csv(index=False, encoding='utf-8-sig').encode('utf-8-sig')

        # 파일 다운로드 버튼 제공
        st.download_button(
            label="수정된 CSV 다운로드",
            data=csv_data,
            file_name="updated_data.csv",
            mime="text/csv"
        )
