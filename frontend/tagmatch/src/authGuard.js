import axios from 'axios'

export const validateToken = async () => {
  const accessToken = window.localStorage.getItem('access-token') // 'token' を 'access-token' に変更
  if (!accessToken) {
    throw new Error('No access token found')
  }
  const client = window.localStorage.getItem('client'); // clientの取得
  const uid = window.localStorage.getItem('uid');       // uidの取得

  const response = await axios.get('http://localhost:8000/auth/validate_token', {
    headers: {
      'access-token': accessToken,  // Bearer形式からこの形式に変更
      'client': client,             // clientヘッダーを追加
      'uid': uid                    // uidヘッダーを追加
    }
  })

  if (response.status !== 200) {
    console.log('ここでエラー');
    throw new Error('Token validation failed')
  }
  return response.data
}
