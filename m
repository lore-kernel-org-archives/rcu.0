Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF37260583;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762119881; cv=none; b=dVJwu2IEFJ7Dnx3zwphPwX/dDifK7+aEY2RsrmgTuXmS0brN1bDDlC+Xj+RAC0472EOczunc6qY2g/m94KcM+6zs5De8TIwaQcXbvLcDEZoyMsT0RYgu3qkdWpZMm2jgOVHsF5olU929sOCH1RI76BPL7lU2ZOZsJyeR8M38CeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762119881; c=relaxed/simple;
	bh=rZXvfrA3YGviZHzZMYqMHXTK7X68+gQX9VG+uQe++ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRRwlqtkgC7po2gfv6dunZDiwoDy9+pK4Vfjwy/J9YQ1eLxA4mYffKuumSdhnm0yyEhuidd5Pq/ASLpnjcoKmlh5XW1AyyM8y46WYHGwjFaakRUBAwHvoUI/r2mGSbvyqz2v4fIhXMONhB2dCnsnwmkKlvx0IHo+fx3Um+xdxhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2fw3VdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2fw3VdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFE0C116D0;
	Sun,  2 Nov 2025 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762119880;
	bh=rZXvfrA3YGviZHzZMYqMHXTK7X68+gQX9VG+uQe++ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2fw3VdOZzJ3lx/k31T7AdEtUPtF3EaPp5nk7XbSiaHqrmOfOqhvyEhs7IS1orJyz
	 K4Ifyqtsaqq9VwDUE+J62RCtf8KIsNtBMon+Urt/UsuAGPu6oQL07JSUSfR0z4IVfa
	 zuAnUw/MN7lpnQrE4hJrISU6GI1E0p6Wws1bJ6cQzHBydGHEIPenfBFrxw+8VYE27S
	 +ZOdO4fgXBpFKbEFfe9buSD06zCCP5EtskfVsQJP36/SogSeT8Qk/vB4EYj087TvwC
	 g6alcrj5qE9DIXs0YVAA2ovQ3a5BPcAi/0Dmthy7QH9JSqYOeHuPM0rz5ZA4f687H4
	 forJg0cQ0ovfQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A80C6CE16CA; Sun,  2 Nov 2025 13:44:37 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 18/19] rcutorture: Make srcu{,d}_torture_init() announce the SRCU type
Date: Sun,  2 Nov 2025 13:44:35 -0800
Message-Id: <20251102214436.3905633-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
References: <082fb8ba-91b8-448e-a472-195eb7b282fd@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit causes rcutorture's srcu_torture_init() and
srcud_torture_init() functions to announce on the console log
which variant of SRCU is being tortured, for example: "torture:
srcud_torture_init fast SRCU".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 4a9b6866c0cc..820c5e5b106b 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -701,10 +701,20 @@ static struct rcu_torture_ops srcud_ops;
 static void srcu_torture_init(void)
 {
 	rcu_sync_torture_init();
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (!reader_flavor || (reader_flavor & SRCU_READ_FLAVOR_NORMAL)) {
+		VERBOSE_TOROUT_STRING("srcu_torture_init normal SRCU");
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_NMI) {
+		VERBOSE_TOROUT_STRING("srcu_torture_init NMI-safe SRCU");
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
 		srcu_ctlp = &srcu_ctlf;
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
+		VERBOSE_TOROUT_STRING("srcu_torture_init fast SRCU");
+	}
+	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
 		srcu_ctlp = &srcu_ctlfud;
+		VERBOSE_TOROUT_STRING("srcu_torture_init fast-up/down SRCU");
+	}
 }
 
 static void srcu_get_gp_data(int *flags, unsigned long *gp_seq)
@@ -920,12 +930,21 @@ static struct rcu_torture_ops srcu_ops = {
 static void srcud_torture_init(void)
 {
 	rcu_sync_torture_init();
-	if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN)
-		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
-	else if (reader_flavor & SRCU_READ_FLAVOR_FAST)
+	if (!reader_flavor || (reader_flavor & SRCU_READ_FLAVOR_NORMAL)) {
+		WARN_ON(init_srcu_struct(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init normal SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_NMI) {
+		WARN_ON(init_srcu_struct(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init NMI-safe SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_FAST) {
 		WARN_ON(init_srcu_struct_fast(&srcu_ctld));
-	else
+		VERBOSE_TOROUT_STRING("srcud_torture_init fast SRCU");
+	} else if (reader_flavor & SRCU_READ_FLAVOR_FAST_UPDOWN) {
+		WARN_ON(init_srcu_struct_fast_updown(&srcu_ctld));
+		VERBOSE_TOROUT_STRING("srcud_torture_init fast-up/down SRCU");
+	} else {
 		WARN_ON(init_srcu_struct(&srcu_ctld));
+	}
 	srcu_ctlp = &srcu_ctld;
 }
 
@@ -2440,6 +2459,9 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
  */
 static void rcu_torture_timer(struct timer_list *unused)
 {
+	WARN_ON_ONCE(!in_serving_softirq());
+	WARN_ON_ONCE(in_hardirq());
+	WARN_ON_ONCE(in_nmi());
 	atomic_long_inc(&n_rcu_torture_timers);
 	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand), -1);
 
-- 
2.40.1

