// Loading Animation
window.addEventListener('load', () => {
  setTimeout(() => {
      document.querySelector('.loader-wrapper').style.opacity = '0';
      setTimeout(() => {
          document.querySelector('.loader-wrapper').style.display = 'none';
      }, 500);
  }, 2000);
});

//document.addEventListener('mousedown', () => {
//  cursor.style.transform = 'translate(-50%, -50%) scale(0.8)';
//});
//
//document.addEventListener('mouseup', () => {
//  cursor.style.transform = 'translate(-50%, -50%) scale(1)';
//});

// Scrolled Header
window.addEventListener('scroll', () => {
  const header = document.querySelector('.header');
  if (window.scrollY > 100) {
      header.classList.add('scrolled');
  } else {
      header.classList.remove('scrolled');
  }
});

// Intersection Observer for animations
const observerOptions = {
  threshold: 0.1,
  rootMargin: "0px 0px -50px 0px"
};

const projectObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry, index) => {
      if (entry.isIntersecting) {
          setTimeout(() => {
              entry.target.classList.add('animated');
          }, index * 200);
      }
  });
}, observerOptions);

document.querySelectorAll('.project-card').forEach(card => {
  projectObserver.observe(card);
});

const timelineObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
      if (entry.isIntersecting) {
          entry.target.classList.add('animated');
      }
  });
}, observerOptions);

document.querySelectorAll('.timeline-content').forEach(item => {
  timelineObserver.observe(item);
});

const achievementObserver = new IntersectionObserver((entries) => {
  entries.forEach((entry, index) => {
      if (entry.isIntersecting) {
          setTimeout(() => {
              entry.target.classList.add('animated');
          }, index * 200);
      }
  });
}, observerOptions);

document.querySelectorAll('.achievement-card').forEach(card => {
  achievementObserver.observe(card);
});

// Smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
      e.preventDefault();

      const target = document.querySelector(this.getAttribute('href'));
      if (!target) return;

      window.scrollTo({
          top: target.offsetTop - 100,
          behavior: 'smooth'
      });
  });
});

// reload the page when hit on logo r.c.
document.addEventListener('DOMContentLoaded', function() {
  const logo = document.querySelector('.logo');
  if (logo) {
    logo.style.cursor = 'pointer';  // make cursor a pointer on hover
    logo.addEventListener('click', function() {
      window.location.reload(true);  // force reload from server
    });
  }
});



// Progress Loader Logic
window.addEventListener('load', () => {
  let progress = 0;
  const progressNumber = document.querySelector('.progress-number');
  const loaderText = document.querySelector('.loader-text');
  const loaderWrapper = document.querySelector('.loader-wrapper');

  const interval = setInterval(() => {
    progress += 1; // Increment progress by 1%

    // Update progress number
    progressNumber.textContent = progress + '%';

    // Gradually show "R.C." as progress increases
    loaderText.style.opacity = progress / 100;

    // Stop at 100 and fade out loader
    if (progress >= 100) {
      clearInterval(interval); // Stop incrementing

      // Fade out loader
      setTimeout(() => {
        loaderWrapper.style.opacity = '0'; // Smooth fade out
        setTimeout(() => {
          loaderWrapper.style.display = 'none'; // Hide completely
        }, 500);
      }, 800);
    }
  }, 15); // Adjust speed of increment (20ms per step)
});

// Add reload functionality to "R.C." logo
document.querySelector('.loader-text').addEventListener('click', () => {
  window.location.reload(); // Reload the page when "R.C." is clicked
});



