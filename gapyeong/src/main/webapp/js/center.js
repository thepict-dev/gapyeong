// 인풋연락처
const hypenTel = (target) => {
target.value = target.value
    .replace(/[^0-9]/g, '')
    .replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
}


// 인풋 버튼 활성화
$('#name').on('input', checkInput);
$('#mobile').on('input', checkInput);

function checkInput() {
    var idCheck = $('#name').val();
    var passwordCheck = $('#mobile').val();
    var btnLogin = $('.login');

    if (idCheck === '' || passwordCheck === '') {
        btnLogin.removeClass('on');
    } else {
        btnLogin.addClass('on');
    }
}

