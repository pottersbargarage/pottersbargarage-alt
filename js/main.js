/* Potters Bar Garage — main.js */

document.addEventListener('DOMContentLoaded', () => {

  /* ── Copyright year ── */
  document.querySelectorAll('[data-copyright-year]').forEach(el => {
    el.textContent = new Date().getFullYear();
  });

  /* ── Mobile nav toggle ── */
  const hamburger  = document.querySelector('.hamburger');
  const mobileNav  = document.querySelector('.mobile-nav');
  const servicesToggle = document.querySelector('.mobile-services-toggle');
  const mobileServicesMenu = document.querySelector('.mobile-nav-services');

  if (hamburger && mobileNav) {
    hamburger.addEventListener('click', () => {
      hamburger.classList.toggle('open');
      mobileNav.classList.toggle('open');
    });
  }

  if (servicesToggle && mobileServicesMenu) {
    mobileServicesMenu.style.display = 'none';
    servicesToggle.addEventListener('click', (e) => {
      e.preventDefault();
      const open = mobileServicesMenu.style.display !== 'none';
      mobileServicesMenu.style.display = open ? 'none' : 'block';
    });
  }

  /* ── Active nav link ── */
  const currentPath = window.location.pathname.replace(/\/$/, '');
  document.querySelectorAll('.nav-link, .mobile-nav a').forEach(link => {
    const href = link.getAttribute('href')?.replace(/\/$/, '');
    if (href && (currentPath === href || currentPath.endsWith(href))) {
      link.classList.add('active');
    }
  });

  /* ── Scroll-based header shadow ── */
  const header = document.querySelector('.site-header');
  if (header) {
    const onScroll = () => {
      header.style.boxShadow = window.scrollY > 10
        ? '0 4px 20px rgba(0,0,0,.12)'
        : '0 2px 16px rgba(0,0,0,.08)';
    };
    window.addEventListener('scroll', onScroll, { passive: true });
  }

  /* ── Intersection Observer — fade-up cards ── */
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.12 });

  document.querySelectorAll('.service-card, .testimonial-card, .pillar-card, .info-card, .service-full-card').forEach((el, i) => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(20px)';
    el.style.transition = `opacity .5s ease ${i * 0.07}s, transform .5s ease ${i * 0.07}s`;
    observer.observe(el);
  });

  // When visible, animate in
  const styleSheet = document.createElement('style');
  styleSheet.textContent = `
    .service-card.visible,
    .testimonial-card.visible,
    .pillar-card.visible,
    .info-card.visible,
    .service-full-card.visible {
      opacity: 1 !important;
      transform: translateY(0) !important;
    }
  `;
  document.head.appendChild(styleSheet);

  /* ── Animated stat counters ── */
  const statEls = document.querySelectorAll('.stat-num, .hero-stat-value');
  if (statEls.length) {
    const countObserver = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (!entry.isIntersecting) return;
        const el = entry.target;
        const target = parseInt(el.getAttribute('data-target') || el.textContent.replace(/\D/g, ''), 10);
        const suffix = el.getAttribute('data-suffix') || el.textContent.replace(/[\d]/g, '');
        if (!target) return;

        let current = 0;
        const duration = 1800;
        const step = target / (duration / 16);
        const timer = setInterval(() => {
          current += step;
          if (current >= target) {
            current = target;
            clearInterval(timer);
          }
          el.textContent = Math.floor(current).toLocaleString() + suffix;
        }, 16);

        countObserver.unobserve(el);
      });
    }, { threshold: 0.5 });

    statEls.forEach(el => {
      const text = el.textContent;
      const num  = parseInt(text.replace(/\D/g, ''), 10);
      const suf  = text.replace(/[\d,]/g, '').trim();
      if (num) {
        el.setAttribute('data-target', num);
        el.setAttribute('data-suffix', suf);
        countObserver.observe(el);
      }
    });
  }

  /* ── Smooth scroll for anchor links ── */
  document.querySelectorAll('a[href^="#"]').forEach(a => {
    a.addEventListener('click', e => {
      const target = document.querySelector(a.getAttribute('href'));
      if (target) {
        e.preventDefault();
        target.scrollIntoView({ behavior: 'smooth', block: 'start' });
      }
    });
  });

  /* ── Contact form – Formspree AJAX submission ── */
  const contactForm = document.querySelector('.contact-form');
  if (contactForm) {
    contactForm.addEventListener('submit', e => {
      e.preventDefault();
      const btn = contactForm.querySelector('button[type="submit"]');
      const originalHTML = btn.innerHTML;

      // Validate reCAPTCHA before doing anything else
      if (typeof grecaptcha !== 'undefined' && !grecaptcha.getResponse()) {
        btn.textContent = 'Please tick the reCAPTCHA box first';
        btn.style.background = '#b45309';
        btn.style.opacity = '1';
        setTimeout(() => {
          btn.innerHTML = originalHTML;
          btn.style.background = '';
        }, 3000);
        return;
      }

      btn.textContent = 'Sending…';
      btn.disabled = true;
      btn.style.opacity = '.75';

      // Build FormData and append reCAPTCHA token so Formspree can verify it
      const formData = new FormData(contactForm);
      if (typeof grecaptcha !== 'undefined') {
        formData.append('g-recaptcha-response', grecaptcha.getResponse());
      }

      fetch(contactForm.action, {
        method: 'POST',
        body: formData,
        headers: { 'Accept': 'application/json' }
      })
      .then(res => {
        if (res.ok) {
          btn.textContent = 'Message sent — we\'ll be in touch!';
          btn.style.background = 'var(--green-mid)';
          btn.style.opacity = '1';
          contactForm.reset();
          if (typeof grecaptcha !== 'undefined') grecaptcha.reset();
          setTimeout(() => {
            btn.innerHTML = originalHTML;
            btn.style.background = '';
            btn.disabled = false;
          }, 5000);
        } else {
          return res.json().then(data => {
            throw new Error(data.errors ? data.errors.map(err => err.message).join(', ') : 'Submission failed');
          });
        }
      })
      .catch(() => {
        btn.textContent = 'Something went wrong — please call us on 01707 644 465';
        btn.style.background = '#b91c1c';
        btn.style.opacity = '1';
        btn.disabled = false;
        if (typeof grecaptcha !== 'undefined') grecaptcha.reset();
        setTimeout(() => {
          btn.innerHTML = originalHTML;
          btn.style.background = '';
        }, 6000);
      });
    });
  }

});
