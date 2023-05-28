const imagePreview =
  document.getElementsByClassName('image-preview')[0];
const imageInput = document.getElementById('post_image');

imageInput.addEventListener('change', (e) => {
  const image = e.target.files[0];
  imagePreview.src = URL.createObjectURL(image);
  imagePreview.alt = image.name;
});
