<!DOCTYPE html>
<html>
<head></head>
<body>
@if (count($errors) > 0)
    @foreach ($errors as $error)
        {{ $error }}
    @endforeach
@endif

<form action="/Test/check" method="post" enctype="application/x-www-form-urlencoded">
    <table>
        <tbody>
        <tr>
            <td>用户名：</td>
            <td>
                <input type="text" name="name">
                {{ $errors->first('name') }}
            </td>
        </tr>
        <tr>
            <td>验证码：</td>
            <td>
                <input type="text" name="code">
                {!! captcha_img() !!}
                {{ $errors->first('code') }}
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <button type="submit">提交</button>
                {{ csrf_field() }}
            </td>
        </tr>
        </tbody>
    </table>
</form>
</body>
</html>