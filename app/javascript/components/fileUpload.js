console.log("LOADED");

document.addEventListener('turbolinks:load', function() {
  let $dropzone = $('.photoPicker-js'),
    $droptarget = $('.photoTarget-js'),
    $dropinput = $('.photoInput-js'),
    $dropimg = $('.photoPreview-js'),
    $remover = $('[data-action="remove_current_photo"]');

  $dropzone.on('dragover', function () {
    $droptarget.addClass('dropping');
    return false;
  });

  $dropzone.on('dragend dragleave', function () {
    $dropinput.removeClass('dropping');
    return false;
  });

  $dropzone.on('drop', function (e) {
    $droptarget.removeClass('dropping');
    $droptarget.addClass('dropped');
    $remover.removeClass('disabled');
    e.preventDefault();

    let file = e.originalEvent.dataTransfer.files[0],
        reader = new FileReader();

    console.log(e.originalEvent.dataTransfer.files[0]);
    document.getElementsByClassName('photoData').innerHTML = e.originalEvent.dataTransfer.files[0].name;

    reader.onload = function (event) {
      $dropimg.css('background-image', 'url(' + event.target.result + ')');
    };

    console.log(file); // byebug
    reader.readAsDataURL(file);

    return false;
  });

  $dropinput.change(function (e) {
    $droptarget.addClass('dropped');
    $remover.removeClass('disabled');

    var file = $dropinput.get(0).files[0],
        reader = new FileReader();

    console.log(file);

    reader.onload = function (event) {
      $dropimg.css('background-image', 'url(' + event.target.result + ')');
    }
    
    reader.readAsDataURL(file);
  });
});