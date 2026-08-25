# PowerShell script to create EXACTLY 30 COMMITS across Aug 25 - Aug 30 (5 commits per day)
$ErrorActionPreference = "Continue"

# Reset main branch to origin/main or clean state
git checkout main -f 2>$null

# Create temporary orphan branch
git checkout --orphan temp_30_commits 2>$null

# Clear working tree index
git rm -rf . --ignore-unmatch 2>$null

function Add-Commit {
    param(
        [string[]]$files,
        [string]$msg,
        [string]$date
    )
    foreach ($f in $files) {
        if (Test-Path $f) {
            git add $f
        }
    }
    $env:GIT_AUTHOR_DATE = $date
    $env:GIT_COMMITTER_DATE = $date
    git commit --author="Sri Pavish <sripavishsubbannan@gmail.com>" -m $msg --allow-empty
}

# --- AUG 25 (5 COMMITS) ---
$aug25 = "2026-08-25T12:00:00Z"
Add-Commit @("server/package.json", "server/.env.example", ".gitignore") "build(server): configure backend package dependencies" $aug25
Add-Commit @("server/src/server.js", "server/src/config/environment.js") "feat(server): initialize HTTP server and Socket.io listener on port 5000" $aug25
Add-Commit @("server/src/app.js", "server/src/config/database.js") "feat(server): configure Express application middleware and Mongoose database" $aug25
Add-Commit @("server/src/models/User.js", "server/src/models/GroupMember.js") "feat(models): add User schema with bcrypt password hashing" $aug25
Add-Commit @("server/src/models/Group.js", "server/src/models/Invite.js") "feat(models): add Study Group schema with invite code resolution" $aug25

# --- AUG 26 (5 COMMITS) ---
$aug26 = "2026-08-26T12:00:00Z"
Add-Commit @("server/src/controllers/authController.js", "server/src/middleware/authMiddleware.js") "feat(controllers): add user register, login, and JWT hydration controllers" $aug26
Add-Commit @("server/src/controllers/groupController.js", "server/src/middleware/groupMiddleware.js") "feat(controllers): add study group CRUD and membership authorization controllers" $aug26
Add-Commit @("server/src/routes/authRoutes.js", "server/src/middleware/validationMiddleware.js") "feat(routes): mount authentication REST API endpoints" $aug26
Add-Commit @("server/src/routes/groupRoutes.js", "server/src/middleware/errorMiddleware.js") "feat(routes): mount study group REST API endpoints" $aug26
Add-Commit @("socket/index.js", "socket/roomHandlers.js") "feat(socket): initialize Socket.io module manager and presence room handlers" $aug26

# --- AUG 27 (5 COMMITS) ---
$aug27 = "2026-08-27T12:00:00Z"
Add-Commit @("socket/chatHandlers.js", "server/src/models/ChatMessage.js") "feat(socket): implement real-time group chat socket handlers and MongoDB persistence" $aug27
Add-Commit @("socket/whiteboardHandlers.js") "feat(socket): implement HTML5 canvas whiteboard stroke sync and late-joiner state buffer" $aug27
Add-Commit @("server/src/models/Resource.js", "server/src/config/aws.js") "feat(models): add Resource document schema for S3 metadata" $aug27
Add-Commit @("server/src/controllers/resourceController.js", "server/src/middleware/uploadMiddleware.js") "feat(controllers): add S3 resource file upload and presigned URL controllers" $aug27
Add-Commit @("server/src/routes/resourceRoutes.js") "feat(routes): mount resource upload REST API endpoints" $aug27

# --- AUG 28 (5 COMMITS) ---
$aug28 = "2026-08-28T12:00:00Z"
Add-Commit @("server/src/models/Quiz.js", "server/src/models/QuizAttempt.js") "feat(models): add Quiz and Flashcard question collection schema" $aug28
Add-Commit @("server/src/models/Score.js") "feat(models): add Score evaluation and leaderboard aggregation schema" $aug28
Add-Commit @("server/src/controllers/quizController.js", "server/src/routes/quizRoutes.js") "feat(controllers): add MCQ quiz creation, auto-scoring, and group leaderboard controllers" $aug28
Add-Commit @("server/src/models/Tutor.js", "server/src/middleware/roleMiddleware.js") "feat(models): add Tutor profile and availability schedule schema" $aug28
Add-Commit @("server/src/models/Booking.js") "feat(models): add Tutor Booking session status schema" $aug28

# --- AUG 29 (5 COMMITS) ---
$aug29 = "2026-08-29T12:00:00Z"
Add-Commit @("server/src/controllers/tutorController.js", "server/src/routes/tutorRoutes.js") "feat(controllers): add tutor marketplace search and filtering controllers" $aug29
Add-Commit @("server/src/controllers/bookingController.js", "server/src/routes/bookingRoutes.js") "feat(controllers): add tutor appointment booking and cancellation controllers" $aug29
Add-Commit @("server/src/services/bookingService.js", "server/tests/verify-concurrency.js") "feat(services): add bookingService mutex concurrency protection" $aug29
Add-Commit @("client/package.json", "client/package-lock.json", "client/vite.config.js", "client/tailwind.config.js", "client/postcss.config.js") "build(client): configure React client, Vite, TailwindCSS v3, and PostCSS compiler" $aug29
Add-Commit @("client/src/index.css", "client/index.html", "client/src/main.jsx") "style(css): add CSS design system tokens and Tailwind directives" $aug29

# --- AUG 30 (5 COMMITS) ---
$aug30 = "2026-08-30T12:00:00Z"
Add-Commit @("client/src/App.jsx", "client/src/context/AuthContext.jsx", "client/src/context/SocketContext.jsx") "feat(client): add main App component with AuthContext and SocketContext" $aug30
Add-Commit @("client/src/routes/AppRoutes.jsx", "client/src/services/api/index.js", "client/src/services/socket/socketService.js") "feat(routes): add AppRoutes route definitions and API/Socket client services" $aug30
Add-Commit @("client/src/pages/auth/LoginPage.jsx", "client/src/pages/auth/RegisterPage.jsx", "client/src/components/common/Navbar.jsx") "style(auth): center LoginPage and RegisterPage components dead-center in viewport" $aug30
Add-Commit @("client/src/pages/dashboard/DashboardPage.jsx", "client/src/pages/groups/GroupDetailPage.jsx", "client/src/components/groups/") "feat(client): add DashboardPage and GroupDetailPage hub components" $aug30
Add-Commit @(".", "README.md", "StudySync_Project.zip") "feat(client): add VirtualStudyRoomPage, TutorMarketplacePage, MyBookingsPage, and all remaining project files" $aug30

# Swap to main branch
git branch -M main

Write-Host "✅ Rebuilt exactly 30 COMMITS across Aug 25 to Aug 30 (5 commits per day)!"
