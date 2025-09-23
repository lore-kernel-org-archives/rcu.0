Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCDB328980;
	Tue, 23 Sep 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637316; cv=none; b=cCOGp7nxJxeECjEFWpZcrveINr1V4A1zFMBiU7aOYmd2Gm+C1LdrhAijYuLDpbwjNaVhlF7xCpJoVf7SXWLMvUmSVnKOCKxArEPeXiSFGipvb2xk74qRztPkFT8qWXvsS42K6oYzh03UoagOlJf5enXjTSytALCxjhWpoR3F4ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637316; c=relaxed/simple;
	bh=5+6cap8BHuj7LD+F6jHOG4xWIftMKuTGrdQG1g1VuNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JoF6jZ6ZtFi0lkOXMBUj4FYCiLtcfHuoD216t7pQJN5q3wrM/AHZRqLj0xDIKcOdNNNSl86Y6uxiaF8T5FITq4lfqjlljDnAMY7IWjhbJU5dsqxD9wELKGj5KnkvCSEgdWLfi8l1kKcOlEomoYddAFFCW2mWNu3R7QC7kYfv/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2jd3S49; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2jd3S49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF92C19425;
	Tue, 23 Sep 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637315;
	bh=5+6cap8BHuj7LD+F6jHOG4xWIftMKuTGrdQG1g1VuNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2jd3S491QmBDmq9L8to24wB3YThSK2EAkQSyg4uPIF0zDugc6D9vS9MioJZDH4oP
	 mGyzNGJEeTcAr2m/Q897xpXiH//1kZZ7bDJ6OZ5/R+UYwmDGzOAlaW1Ks42FE57sBk
	 g93tBLJssCeeHcXUfQHqXziHJ5Fg3dLPSDdLwSiuPQRq4lDy618j8mAT6u8OoGSKEb
	 RzMRlMUMWT4IpIG2aNwt1WWPYZFiazBP7psKDck+Rxdwv/BmL4cmsHIYb3tKclkIKw
	 d7ZiHHOgfCGmo/4ih77MVs7/sez1nQwoFOEfQMlHWSV8y3X0tseQF84U7e0VzpQoea
	 0KU5l0jkAyhqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ED820CE161F; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH 21/34] rcu: Mark diagnostic functions as notrace
Date: Tue, 23 Sep 2025 07:20:23 -0700
Message-Id: <20250923142036.112290-21-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rcu_lockdep_current_cpu_online(), rcu_read_lock_sched_held(),
rcu_read_lock_held(), rcu_read_lock_bh_held(), rcu_read_lock_any_held()
are used by tracing-related code paths, so putting traces on them is
unlikely to make anyone happy.  This commit therefore marks them all
"notrace".

Reported-by: Leon Hwang <leon.hwang@linux.dev>
Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c   | 2 +-
 kernel/rcu/update.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 31690ffa452afe..8ddd07fed36334 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4021,7 +4021,7 @@ bool rcu_cpu_online(int cpu)
  * RCU on an offline processor during initial boot, hence the check for
  * rcu_scheduler_fully_active.
  */
-bool rcu_lockdep_current_cpu_online(void)
+bool notrace rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
 	bool ret = false;
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index c912b594ba987f..dfeba9b3539508 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -117,7 +117,7 @@ static bool rcu_read_lock_held_common(bool *ret)
 	return false;
 }
 
-int rcu_read_lock_sched_held(void)
+int notrace rcu_read_lock_sched_held(void)
 {
 	bool ret;
 
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(debug_lockdep_rcu_enabled);
  * Note that rcu_read_lock() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_held(void)
+int notrace rcu_read_lock_held(void)
 {
 	bool ret;
 
@@ -367,7 +367,7 @@ EXPORT_SYMBOL_GPL(rcu_read_lock_held);
  * Note that rcu_read_lock_bh() is disallowed if the CPU is either idle or
  * offline from an RCU perspective, so check for those as well.
  */
-int rcu_read_lock_bh_held(void)
+int notrace rcu_read_lock_bh_held(void)
 {
 	bool ret;
 
@@ -377,7 +377,7 @@ int rcu_read_lock_bh_held(void)
 }
 EXPORT_SYMBOL_GPL(rcu_read_lock_bh_held);
 
-int rcu_read_lock_any_held(void)
+int notrace rcu_read_lock_any_held(void)
 {
 	bool ret;
 
-- 
2.40.1

