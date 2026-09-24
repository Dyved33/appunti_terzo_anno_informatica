const btn = document.querySelector('button');

btn.addEventListener('mouseover', () => {
  btn.style.backgroundColor = 'red';
});

btn.addEventListener('mouseout', () => {
  btn.style.backgroundColor = 'blue';
});   
