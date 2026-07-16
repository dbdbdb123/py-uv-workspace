import streamlit as st
import numpy as np
import tensorflow as tf


# 모델 불러오기
model = tf.keras.models.load_model("Model_iris.keras")


# 품종 라벨
class_names = ["setosa", "versicolor", "virginica"]


# Streamlit 앱 UI 구성
st.title("🌸 Iris 품종 분류기")
st.write("아래 입력값을 바탕으로 아이리스 품종을 예측합니다.")


# 사용자 입력 받기
sepal_length = st.number_input("1. 꽃받침 길이 (Sepal Length)", min_value=0.0, step=0.1, format="%.1f")
sepal_width = st.number_input("2. 꽃받침 너비 (Sepal Width)", min_value=0.0, step=0.1, format="%.1f")
petal_length = st.number_input("3. 꽃잎 길이 (Petal Length)", min_value=0.0, step=0.1, format="%.1f")
petal_width = st.number_input("4. 꽃잎 너비 (Petal Width)", min_value=0.0, step=0.1, format="%.1f")


# 예측 버튼
if st.button("🌼 품종 예측하기"):
    # 입력값 배열화
    input_data = np.array([[sepal_length, sepal_width, petal_length, petal_width]])


    # 모델 예측
    predictions = model.predict(input_data)
    predicted_class = class_names[np.argmax(predictions)]
    confidence = np.max(predictions)


    # 결과 출력
    st.success(f"예측된 품종은 **{predicted_class}** 입니다.")
    st.write(f"신뢰도: {confidence:.2%}")
