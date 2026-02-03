// Al-Huda Prototype - JavaScript

// ==================== MOCK DATA ====================
const mockUser = {
    id: 1,
    name: 'Ahmad',
    username: 'ahmad_k',
    email: 'ahmad@email.com',
    streak: 8,
    totalHasanat: 45230,
    versesRead: 4523,
    todayProgress: { read: 6, target: 10 }
};

const mockVerses = [
    { surah: 'Al-Baqarah', number: 255, arabic: 'اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ', translation: 'Allah - there is no deity except Him, the Ever-Living, the Sustainer of existence. Neither drowsiness overtakes Him nor sleep...' },
    { surah: 'Al-Baqarah', number: 256, arabic: 'لَا إِكْرَاهَ فِي الدِّينِ ۖ قَد تَّبَيَّنَ الرُّشْدُ مِنَ الْغَيِّ ۚ', translation: 'There shall be no compulsion in religion. The right path has become distinct from the wrong...' },
    { surah: 'Al-Baqarah', number: 257, arabic: 'اللَّهُ وَلِيُّ الَّذِينَ آمَنُوا يُخْرِجُهُم مِّنَ الظُّلُمَاتِ إِلَى النُّورِ ۖ', translation: 'Allah is the ally of those who believe. He brings them out from darknesses into the light...' }
];

const mockChats = [
    { id: 1, name: 'Sarah Ahmed', avatar: 'S', status: 'online', lastMessage: 'SubhanAllah, that verse is so beautiful!', time: '2m ago', unread: 2 },
    { id: 2, name: 'Omar Khan', avatar: 'O', status: 'offline', lastMessage: "Let's do a reading session together", time: '1h ago', unread: 0 },
    { id: 3, name: 'Fatima Ali', avatar: 'F', status: 'online', lastMessage: 'JazakAllah for sharing!', time: '3h ago', unread: 1 }
];

const mockGroups = [
    { id: 1, name: 'Quran Study Circle', members: 5, lastMessage: 'Who wants to join tonight?', time: '15m ago', unread: 3 },
    { id: 2, name: 'Daily Tilawah Group', members: 12, lastMessage: 'Alhamdulillah completed Surah Yaseen', time: '2h ago', unread: 0 }
];

const mockMessages = [
    { id: 1, sender: 'them', text: 'Assalamu Alaikum! How is your reading going today?', time: '10:30 AM' },
    { id: 2, sender: 'me', text: 'Wa Alaikum Assalam! Alhamdulillah, just finished Surah Al-Baqarah 255.', time: '10:32 AM' },
    { id: 3, sender: 'them', text: 'SubhanAllah! Ayatul Kursi is so powerful. Did you know it protects you until the next prayer?', time: '10:33 AM' },
    { id: 4, sender: 'me', text: 'Yes! I try to recite it after every Salah. The rewards are immense.', time: '10:35 AM' },
    { id: 5, sender: 'them', text: 'MashaaAllah, may Allah increase your knowledge and consistency! 📿', time: '10:36 AM' }
];

const mockPosts = [
    { id: 1, user: 'Fatima Ali', username: '@fatima_a', avatar: 'F', time: '2h ago', content: 'Just completed my 30-day streak of reading Quran! Alhamdulillah for this blessing. Never give up on your goals. 🌟', likes: 42, comments: 8 },
    { id: 2, user: 'Omar Khan', username: '@omar_k', avatar: 'O', time: '5h ago', content: '"Indeed, with hardship comes ease" - Surah Ash-Sharh 94:6\n\nThis verse gives me so much hope during difficult times. What verse inspires you the most?', likes: 128, comments: 23 }
];

const mockChallenges = [
    { id: 1, title: 'Complete Juz Amma', description: 'Finish the 30th Juz in 7 days', progress: 60, participants: 234 },
    { id: 2, title: 'Morning Routine', description: 'Read 10 verses after Fajr for 14 days', progress: 35, participants: 89 }
];

const mockLeaderboard = [
    { rank: 1, name: 'Ibrahim M.', avatar: 'I', hasanat: 125430, streak: 45 },
    { rank: 2, name: 'Aisha K.', avatar: 'A', hasanat: 98765, streak: 32 },
    { rank: 3, name: 'Yusuf A.', avatar: 'Y', hasanat: 87654, streak: 28 }
];

// ==================== APP STATE ====================
const state = {
    currentScreen: 'splash',
    onboardingStep: 1,
    totalOnboardingSteps: 6,
    selectedLanguage: 'en',
    goalType: 'verse',
    goalValue: 10,
    preferredTimes: ['fajr'],
    currentVerseIndex: 0,
    sessionHasanat: 9850,
    chatTab: 'direct',
    currentConversation: null,
    readingMode: 'ayah',
    currentSurah: null,
    currentPage: 1
};


// ==================== UTILITY FUNCTIONS ====================
function showScreen(screenId) {
    document.querySelectorAll('.screen').forEach(s => s.classList.add('hidden'));
    document.getElementById(screenId)?.classList.remove('hidden');
    state.currentScreen = screenId;
}

function showAppScreen(screenId) {
    document.querySelectorAll('.app-screen').forEach(s => s.classList.remove('active'));
    document.getElementById(screenId)?.classList.add('active');

    document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
    document.querySelector(`[data-screen="${screenId.replace('-screen', '')}"]`)?.classList.add('active');

    const titles = { home: 'Home', read: 'Reading', chat: 'Chat', social: 'Community', more: 'Settings', challenges: 'Challenges', leaderboard: 'Leaderboard' };
    const key = screenId.replace('-screen', '');
    document.getElementById('current-screen-title').textContent = titles[key] || key;
}

function showToast(message, type = 'info') {
    const container = document.getElementById('toast-container');
    const toast = document.createElement('div');
    toast.className = `toast ${type}`;
    toast.textContent = message;
    container.appendChild(toast);
    setTimeout(() => toast.remove(), 3000);
}

function togglePassword(btn) {
    const input = btn.parentElement.querySelector('input');
    const icon = btn.querySelector('i');
    if (input.type === 'password') {
        input.type = 'text';
        icon.className = 'fas fa-eye';
    } else {
        input.type = 'password';
        icon.className = 'fas fa-eye-slash';
    }
}

// ==================== SPLASH & AUTH ====================
function initSplash() {
    showScreen('splash-screen');
    setTimeout(() => showScreen('login-screen'), 2500);
}

function initAuth() {
    // Login form
    document.getElementById('login-form')?.addEventListener('submit', (e) => {
        e.preventDefault();
        simulateLogin();
    });

    // Register form
    document.getElementById('register-form')?.addEventListener('submit', (e) => {
        e.preventDefault();
        simulateRegister();
    });

    // Forgot password form
    document.getElementById('forgot-form')?.addEventListener('submit', (e) => {
        e.preventDefault();
        simulateForgotPassword();
    });

    // Navigation links
    document.getElementById('go-to-register')?.addEventListener('click', (e) => {
        e.preventDefault();
        showScreen('register-screen');
    });

    document.getElementById('forgot-password-link')?.addEventListener('click', (e) => {
        e.preventDefault();
        showScreen('forgot-screen');
    });

    document.getElementById('register-back')?.addEventListener('click', () => showScreen('login-screen'));
    document.getElementById('forgot-back')?.addEventListener('click', () => showScreen('login-screen'));

    // Password toggles
    document.querySelectorAll('.toggle-password').forEach(btn => {
        btn.addEventListener('click', () => togglePassword(btn));
    });
}

function simulateLogin() {
    const username = document.getElementById('login-username').value;
    if (username) {
        mockUser.name = username;
        showToast('Login successful!', 'success');
        showScreen('onboarding-screen');
    }
}

function simulateRegister() {
    showToast('Account created!', 'success');
    showScreen('onboarding-screen');
}

function simulateForgotPassword() {
    showToast('Reset code sent to your email.', 'success');
    setTimeout(() => showScreen('login-screen'), 1500);
}

// ==================== ONBOARDING ====================
function initOnboarding() {
    const nextBtn = document.getElementById('onboarding-next');
    nextBtn?.addEventListener('click', nextOnboardingStep);

    // Language selection
    document.querySelectorAll('.language-option').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.language-option').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            state.selectedLanguage = btn.dataset.lang;
        });
    });

    // Goal type selection
    document.querySelectorAll('.goal-type-option').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.goal-type-option').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            state.goalType = btn.dataset.type;
            updateGoalValueUI();
        });
    });

    // Goal slider
    document.getElementById('goal-slider')?.addEventListener('input', (e) => {
        state.goalValue = parseInt(e.target.value);
        document.getElementById('goal-value-num').textContent = state.goalValue;
        updateGoalHint();
    });

    // Prayer time chips
    document.querySelectorAll('.prayer-chip').forEach(chip => {
        chip.addEventListener('click', () => {
            chip.classList.toggle('active');
            const time = chip.dataset.time;
            if (chip.classList.contains('active')) {
                if (!state.preferredTimes.includes(time)) state.preferredTimes.push(time);
            } else {
                state.preferredTimes = state.preferredTimes.filter(t => t !== time);
            }
        });
    });
}

function nextOnboardingStep() {
    if (state.onboardingStep < state.totalOnboardingSteps) {
        state.onboardingStep++;
        updateOnboardingUI();
    } else {
        completeOnboarding();
    }
}

function updateOnboardingUI() {
    // Update progress segments
    document.querySelectorAll('.progress-segment').forEach((seg, i) => {
        seg.classList.toggle('active', i < state.onboardingStep);
    });

    // Show current page
    document.querySelectorAll('.onboarding-page').forEach(page => {
        page.classList.toggle('active', parseInt(page.dataset.step) === state.onboardingStep);
    });

    // Update button text
    const btn = document.getElementById('onboarding-next');
    btn.textContent = state.onboardingStep === state.totalOnboardingSteps ? 'GET STARTED' : 'CONTINUE';
}

function updateGoalValueUI() {
    const unitLabels = { verse: 'verses', time: 'minutes', page: 'pages' };
    const maxValues = { verse: 100, time: 120, page: 30 };

    document.getElementById('goal-unit-label').textContent = unitLabels[state.goalType];
    const slider = document.getElementById('goal-slider');
    slider.max = maxValues[state.goalType];
    if (state.goalValue > slider.max) {
        state.goalValue = Math.floor(slider.max / 2);
        slider.value = state.goalValue;
        document.getElementById('goal-value-num').textContent = state.goalValue;
    }
    updateGoalHint();
}

function updateGoalHint() {
    const hints = {
        verse: 'Consistent reading builds a strong spiritual habit.',
        time: `Approximately ${Math.floor(state.goalValue / 2)} verses at a moderate pace.`,
        page: `About ${state.goalValue * 15} verses depending on the surah.`
    };
    document.getElementById('goal-hint').textContent = hints[state.goalType];
}

function completeOnboarding() {
    showScreen('main-app');
    document.getElementById('main-app').classList.remove('hidden');
    initMainApp();
}

// ==================== MAIN APP ====================
function initMainApp() {
    initNavigation();
    initHome();
    initReading();
    initChat();
    initSocial();
    initChallenges();
    initLeaderboard();
}

function initNavigation() {
    document.querySelectorAll('.nav-item').forEach(item => {
        item.addEventListener('click', () => {
            const screen = item.dataset.screen;
            showAppScreen(`${screen}-screen`);
        });
    });

    document.querySelectorAll('.action-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const nav = btn.dataset.nav;
            showAppScreen(`${nav}-screen`);
        });
    });

    document.getElementById('continue-reading-btn')?.addEventListener('click', () => {
        showAppScreen('read-screen');
    });
}

// ==================== HOME ====================
function initHome() {
    document.getElementById('user-name').textContent = mockUser.name;
    document.getElementById('current-streak').textContent = mockUser.streak;
    document.getElementById('total-hasanat').textContent = mockUser.totalHasanat.toLocaleString();
    document.getElementById('verses-read').textContent = mockUser.todayProgress.read;
    document.getElementById('verses-target').textContent = mockUser.todayProgress.target;

    const progress = Math.round((mockUser.todayProgress.read / mockUser.todayProgress.target) * 100);
    document.getElementById('daily-progress').style.width = `${progress}%`;
    document.getElementById('progress-percent').textContent = `${progress}%`;
}

// ==================== READING ====================
const mockSurahs = [
    { number: 1, nameEn: 'Al-Fatihah', nameAr: 'الفاتحة', verses: 7, type: 'Meccan', page: 1 },
    { number: 2, nameEn: 'Al-Baqarah', nameAr: 'البقرة', verses: 286, type: 'Medinan', page: 2 },
    { number: 3, nameEn: 'Ali \'Imran', nameAr: 'آل عمران', verses: 200, type: 'Medinan', page: 50 },
    { number: 4, nameEn: 'An-Nisa', nameAr: 'النساء', verses: 176, type: 'Medinan', page: 77 },
    { number: 5, nameEn: 'Al-Ma\'idah', nameAr: 'المائدة', verses: 120, type: 'Medinan', page: 106 },
    { number: 36, nameEn: 'Ya-Sin', nameAr: 'يس', verses: 83, type: 'Meccan', page: 440 },
    { number: 55, nameEn: 'Ar-Rahman', nameAr: 'الرحمن', verses: 78, type: 'Medinan', page: 531 },
    { number: 67, nameEn: 'Al-Mulk', nameAr: 'الملك', verses: 30, type: 'Meccan', page: 562 },
    { number: 112, nameEn: 'Al-Ikhlas', nameAr: 'الإخلاص', verses: 4, type: 'Meccan', page: 604 },
    { number: 113, nameEn: 'Al-Falaq', nameAr: 'الفلق', verses: 5, type: 'Meccan', page: 604 },
    { number: 114, nameEn: 'An-Nas', nameAr: 'الناس', verses: 6, type: 'Meccan', page: 604 }
];

function initReading() {
    renderSurahList();

    // Reading mode toggle
    document.querySelectorAll('.mode-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            document.querySelectorAll('.mode-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            state.readingMode = btn.dataset.mode;
        });
    });

    // Search
    document.getElementById('surah-search')?.addEventListener('input', (e) => {
        const query = e.target.value.toLowerCase();
        renderSurahList(query);
    });

    // Ayah navigation
    document.getElementById('prev-verse-btn')?.addEventListener('click', () => {
        if (state.currentVerseIndex > 0) {
            state.currentVerseIndex--;
            updateVerseDisplay();
        }
    });

    document.getElementById('next-verse-btn')?.addEventListener('click', () => {
        if (state.currentVerseIndex < mockVerses.length - 1) {
            state.currentVerseIndex++;
            updateVerseDisplay();
            addHasanat(35);
        }
    });

    document.getElementById('done-btn')?.addEventListener('click', showSessionComplete);

    // Back buttons
    document.getElementById('ayah-back')?.addEventListener('click', () => showAppScreen('read-screen'));
    document.getElementById('mushaf-back')?.addEventListener('click', () => showAppScreen('read-screen'));

    // Mushaf navigation
    document.getElementById('prev-page-btn')?.addEventListener('click', () => {
        state.currentPage = Math.max(1, (state.currentPage || 1) - 1);
        document.getElementById('mushaf-page').textContent = `Page ${state.currentPage}`;
    });

    document.getElementById('next-page-btn')?.addEventListener('click', () => {
        state.currentPage = (state.currentPage || 1) + 1;
        document.getElementById('mushaf-page').textContent = `Page ${state.currentPage}`;
    });
}

function renderSurahList(filter = '') {
    const container = document.getElementById('surah-list');
    const filtered = mockSurahs.filter(s =>
        s.nameEn.toLowerCase().includes(filter) ||
        s.nameAr.includes(filter) ||
        s.number.toString().includes(filter)
    );

    container.innerHTML = filtered.map(surah => `
        <div class="surah-item" data-surah="${surah.number}" data-page="${surah.page}">
            <div class="surah-number">${surah.number}</div>
            <div class="surah-info">
                <div class="surah-name-en">${surah.nameEn}</div>
                <div class="surah-name-ar">${surah.nameAr}</div>
            </div>
            <div class="surah-meta">
                <div class="surah-verses">${surah.verses} verses</div>
                <div class="surah-type">${surah.type}</div>
            </div>
        </div>
    `).join('');

    container.querySelectorAll('.surah-item').forEach(item => {
        item.addEventListener('click', () => openSurah(item.dataset.surah, item.dataset.page));
    });
}

function openSurah(surahNumber, page) {
    const surah = mockSurahs.find(s => s.number == surahNumber);
    state.currentSurah = surah;
    state.currentPage = parseInt(page);

    if (state.readingMode === 'mushaf') {
        // Open mushaf mode
        document.getElementById('mushaf-surah-name').textContent = surah.nameEn;
        document.getElementById('mushaf-page').textContent = `Page ${page}`;
        showAppScreen('mushaf-screen');
    } else {
        // Open ayah-by-ayah mode (default)
        document.getElementById('ayah-surah-name').textContent = surah.nameEn;
        document.getElementById('ayah-location').textContent = `${surah.number}:1`;
        state.currentVerseIndex = 0;
        updateVerseDisplay();
        showAppScreen('ayah-screen');
    }
}

function updateVerseDisplay() {
    const verse = mockVerses[state.currentVerseIndex];
    const surahName = state.currentSurah?.nameEn || verse.surah;
    document.getElementById('ayah-surah-name').textContent = surahName;
    document.getElementById('ayah-location').textContent = `${state.currentSurah?.number || 2}:${state.currentVerseIndex + 1}`;
    document.getElementById('arabic-verse').textContent = verse.arabic;
    document.getElementById('translation-verse').textContent = verse.translation;
}

function addHasanat(amount) {
    state.sessionHasanat += amount;
    document.getElementById('session-hasanat').textContent = state.sessionHasanat.toLocaleString();
    document.getElementById('hasanat-change').textContent = `(+${amount})`;
}

function showSessionComplete() {
    const modal = document.getElementById('session-complete-modal');
    modal.classList.remove('hidden');
    document.getElementById('session-verses').textContent = state.currentVerseIndex + 1;
    document.getElementById('modal-hasanat').textContent = (state.sessionHasanat - 9850 + 100).toLocaleString();
    document.getElementById('modal-streak').textContent = mockUser.streak;

    document.getElementById('continue-modal-btn')?.addEventListener('click', () => {
        modal.classList.add('hidden');
        showAppScreen('home-screen');
    });
}


// ==================== CHAT ====================
function initChat() {
    renderChats();

    // Tab switching
    document.querySelectorAll('.chat-tab').forEach(tab => {
        tab.addEventListener('click', () => {
            document.querySelectorAll('.chat-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
            state.chatTab = tab.dataset.tab;
            renderChats();
        });
    });

    // Back buttons
    document.getElementById('conversation-back')?.addEventListener('click', () => showAppScreen('chat-screen'));
    document.getElementById('group-back')?.addEventListener('click', () => showAppScreen('chat-screen'));

    // Send messages
    document.getElementById('send-message-btn')?.addEventListener('click', sendMessage);
    document.getElementById('message-input')?.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') sendMessage();
    });

    document.getElementById('send-group-message-btn')?.addEventListener('click', sendGroupMessage);
}

function renderChats() {
    const container = document.getElementById('chat-list');
    const data = state.chatTab === 'direct' ? mockChats : mockGroups;

    container.innerHTML = data.map(chat => `
        <div class="chat-item" data-id="${chat.id}" data-type="${state.chatTab}">
            <div class="chat-avatar">
                <img src="https://placehold.co/48x48/13ec5b/102216?text=${chat.avatar || chat.name[0]}" alt="">
                ${chat.status === 'online' ? '<div class="online-dot"></div>' : ''}
            </div>
            <div class="chat-info">
                <div class="chat-name">${chat.name}</div>
                <div class="chat-preview">${chat.lastMessage}</div>
            </div>
            <div class="chat-meta">
                <div class="chat-time">${chat.time}</div>
                ${chat.unread > 0 ? `<div class="unread-badge">${chat.unread}</div>` : ''}
            </div>
        </div>
    `).join('');

    container.querySelectorAll('.chat-item').forEach(item => {
        item.addEventListener('click', () => openConversation(item.dataset.id, item.dataset.type));
    });
}

function openConversation(id, type) {
    state.currentConversation = id;

    if (type === 'direct') {
        const chat = mockChats.find(c => c.id == id);
        document.getElementById('conv-name').textContent = chat.name;
        document.getElementById('conv-status').textContent = chat.status === 'online' ? 'Online' : 'Offline';
        document.getElementById('conv-status').className = `conv-status ${chat.status}`;
        renderMessages();
        showAppScreen('conversation-screen');
    } else {
        const group = mockGroups.find(g => g.id == id);
        document.getElementById('group-name').textContent = group.name;
        document.getElementById('group-members').textContent = `${group.members} members`;
        renderGroupMessages();
        showAppScreen('group-screen');
    }
}

function renderMessages() {
    const container = document.getElementById('messages-container');
    container.innerHTML = mockMessages.map(msg => `
        <div class="message ${msg.sender === 'me' ? 'sent' : 'received'}">
            <div class="message-text">${msg.text}</div>
            <div class="message-time">${msg.time}</div>
        </div>
    `).join('');
    container.scrollTop = container.scrollHeight;
}

function renderGroupMessages() {
    const container = document.getElementById('group-messages');
    container.innerHTML = `
        <div class="message received">
            <div class="sender-name" style="font-size: 11px; color: var(--primary); margin-bottom: 4px;">Omar Khan</div>
            <div class="message-text">Assalamu Alaikum everyone! Who wants to join a reading session tonight?</div>
            <div class="message-time">7:30 PM</div>
        </div>
        <div class="message received">
            <div class="sender-name" style="font-size: 11px; color: var(--gold); margin-bottom: 4px;">Sarah Ahmed</div>
            <div class="message-text">Wa Alaikum Assalam! I'm in, inshaAllah. What time?</div>
            <div class="message-time">7:32 PM</div>
        </div>
        <div class="message sent">
            <div class="message-text">Count me in too! 9 PM works best for me.</div>
            <div class="message-time">7:35 PM</div>
        </div>
    `;
    container.scrollTop = container.scrollHeight;
}

function sendMessage() {
    const input = document.getElementById('message-input');
    if (input.value.trim()) {
        mockMessages.push({
            id: mockMessages.length + 1,
            sender: 'me',
            text: input.value,
            time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
        });
        input.value = '';
        renderMessages();
    }
}

function sendGroupMessage() {
    const input = document.getElementById('group-message-input');
    if (input.value.trim()) {
        const container = document.getElementById('group-messages');
        container.innerHTML += `
            <div class="message sent">
                <div class="message-text">${input.value}</div>
                <div class="message-time">${new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</div>
            </div>
        `;
        input.value = '';
        container.scrollTop = container.scrollHeight;
    }
}

// ==================== SOCIAL ====================
function initSocial() {
    renderPosts();

    document.getElementById('compose-btn')?.addEventListener('click', () => {
        const input = document.getElementById('compose-input');
        if (input.value.trim()) {
            mockPosts.unshift({
                id: Date.now(),
                user: mockUser.name,
                username: `@${mockUser.username}`,
                avatar: mockUser.name[0],
                time: 'Just now',
                content: input.value,
                likes: 0,
                comments: 0
            });
            input.value = '';
            renderPosts();
            showToast('Reflection shared!', 'success');
        }
    });
}

function renderPosts() {
    const container = document.getElementById('feed-container');
    container.innerHTML = mockPosts.map(post => `
        <div class="post-card">
            <div class="post-header">
                <div class="post-avatar"><img src="https://placehold.co/40x40/13ec5b/102216?text=${post.avatar}" alt=""></div>
                <div class="post-user-info">
                    <div class="post-username">${post.user}</div>
                    <div class="post-handle">${post.username}</div>
                </div>
                <div class="post-time">${post.time}</div>
            </div>
            <div class="post-content">${post.content}</div>
            <div class="post-actions">
                <button class="post-action like-btn" data-id="${post.id}"><i class="far fa-heart"></i> ${post.likes}</button>
                <button class="post-action"><i class="far fa-comment"></i> ${post.comments}</button>
                <button class="post-action"><i class="far fa-share-from-square"></i></button>
            </div>
        </div>
    `).join('');

    container.querySelectorAll('.like-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const post = mockPosts.find(p => p.id == btn.dataset.id);
            post.likes++;
            btn.innerHTML = `<i class="fas fa-heart" style="color: var(--error)"></i> ${post.likes}`;
        });
    });
}

// ==================== CHALLENGES ====================
function initChallenges() {
    const container = document.getElementById('active-challenges');
    container.innerHTML = mockChallenges.map(ch => `
        <div class="challenge-item">
            <h4>${ch.title}</h4>
            <p>${ch.description}</p>
            <div class="progress-bar-container" style="margin-top: 12px;">
                <div class="progress-bar"><div class="progress-fill" style="width: ${ch.progress}%"></div></div>
                <span class="progress-percent">${ch.progress}%</span>
            </div>
            <p style="font-size: 11px; color: var(--text-muted); margin-top: 8px;">${ch.participants} participants</p>
        </div>
    `).join('');
}

// ==================== LEADERBOARD ====================
function initLeaderboard() {
    const container = document.getElementById('leaderboard-list');
    container.innerHTML = mockLeaderboard.map(entry => `
        <div class="lb-entry">
            <div class="lb-rank">#${entry.rank}</div>
            <div class="lb-avatar"><img src="https://placehold.co/40x40/13ec5b/102216?text=${entry.avatar}" alt=""></div>
            <div class="lb-info">
                <div class="lb-username">${entry.name}</div>
                <div class="lb-hasanat">${entry.hasanat.toLocaleString()} hasanat</div>
            </div>
            <div class="lb-streak">🔥 ${entry.streak}</div>
        </div>
    `).join('');
}

// ==================== APP BLOCKING ====================
const mockApps = [
    { id: 1, name: 'Instagram', category: 'Social', icon: 'instagram', blocked: true },
    { id: 2, name: 'TikTok', category: 'Entertainment', icon: 'tiktok', blocked: true },
    { id: 3, name: 'YouTube', category: 'Entertainment', icon: 'youtube', blocked: false },
    { id: 4, name: 'Twitter / X', category: 'Social', icon: 'social', blocked: true },
    { id: 5, name: 'Games', category: 'Gaming', icon: 'games', blocked: false }
];

function initAppBlocking() {
    renderBlockedApps();
    
    // Toggle Focus Mode
    document.getElementById('focus-mode-toggle')?.addEventListener('change', (e) => {
        const isEnabled = e.target.checked;
        updateBlockingStatus(isEnabled);
        if (isEnabled) {
            showToast('Focus Mode Enabled', 'success');
        } else {
            showToast('Focus Mode Disabled');
        }
    });

    // Schedule Toggles
    document.querySelectorAll('.schedule-toggle').forEach(toggle => {
        toggle.addEventListener('change', (e) => {
            const schedule = e.target.dataset.schedule;
            if (e.target.checked) {
                showToast(`${capitalize(schedule)} schedule enabled`, 'success');
            }
        });
    });

    // Back Button
    document.getElementById('blocking-back')?.addEventListener('click', () => {
        showAppScreen('more-screen');
    });

    // Open from Settings
    document.getElementById('open-app-blocking')?.addEventListener('click', () => {
        showAppScreen('blocking-screen');
    });
}

function renderBlockedApps() {
    const container = document.getElementById('blocked-apps-list');
    container.innerHTML = mockApps.map(app => `
        <div class="app-item ${app.blocked ? 'blocked' : ''}">
            <div class="app-icon ${app.icon}">
                <i class="fab fa-${app.icon === 'games' ? 'gamepad' : app.icon === 'social' ? 'twitter' : app.icon}"></i>
            </div>
            <div class="app-info">
                <div class="app-name">${app.name}</div>
                <div class="app-category">${app.category}</div>
            </div>
            <div class="app-status">
                ${app.blocked ? '<span class="blocked-badge">Blocked</span>' : ''}
                <label class="toggle-switch">
                    <input type="checkbox" ${app.blocked ? 'checked' : ''} onchange="toggleAppBlock(${app.id})">
                    <span class="slider"></span>
                </label>
            </div>
        </div>
    `).join('');
}

window.toggleAppBlock = function(id) {
    const app = mockApps.find(a => a.id === id);
    if (app) {
        app.blocked = !app.blocked;
        renderBlockedApps();
    }
};

function updateBlockingStatus(enabled) {
    const card = document.getElementById('blocking-status-card');
    const icon = card.querySelector('.blocking-icon');
    const text = document.getElementById('blocking-status-text');
    
    if (enabled) {
        card.classList.add('active');
        icon.classList.add('active');
        text.textContent = 'Active';
        text.style.color = 'var(--primary)';
        text.style.fontWeight = '700';
    } else {
        card.classList.remove('active');
        icon.classList.remove('active');
        text.textContent = 'Disabled';
        text.style.color = 'var(--text-secondary)';
        text.style.fontWeight = '400';
    }
}

function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

// ==================== INITIALIZATION ====================
document.addEventListener('DOMContentLoaded', () => {
    initAuth();
    initOnboarding();
    initSplash();
    initAppBlocking();
});
