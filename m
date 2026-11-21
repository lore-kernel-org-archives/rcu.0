Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275364;
	b=uTQczgKkpt/bEbmJ6Boi+RhtbJDI9Rwq4Hae7/8WZmABBf0cdGvNSHy95Jpw58M2/lmP
	 J6i5uODyyq3c0r8Gq7PYQ/1OMZAln2hbo9SEJZ6xTS9WA7EE0faRDx9WcpKSjo2pRTNuO
	 yKR7zju0+KKy4DqIgy8YPXapaLsvhe1n37nwzMBRZ1GEgLuPpbD7NvEoGvKgdLuNEEw/g
	 F3kTUH/xLEryiCfIFYZRwYMjDHkzDsAfhD8zyNA+5pDVWq71xs70Ko0B6F+fsCj2sGnsi
	 JlyW8YsZJLSoRpmJr1P5oi9ziMfI1MhLet7SOj8uV+uoKRa9ahxF/wlsf2ITdLuuwmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275364;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WDmPszPXiGvGIYG+2x/PKmWhePHmT9BMsOM+6W8MAOQ=;
	b=WsiMZkV2bHiaEXIawP/0rxnv+wwREdLXF1KW9szXWNPRaNmU2atJGSUV5oAguemmrKAi
	 bX/q7C3a7809XOcCgodn8lhCoiVvsueT00aBOyJZEASc/QscA4HUlapEGZztOwMXcV/XK
	 fvg0UVNJCLuEcLKHam0AvNDfUreiQSpnwqWty7SGf0ykqKlA1UFwzsf/AXz01W+L9/vbv
	 b192eqTrj6gBLp0Ql/A7OCm4wCEo3pDYLVVPxJV/V7p8cHVhk1iVJZic0i7vN7OmlWQ+T
	 2veLq39S7GLO+SJGL0juFUtsNNRfI9XCoJPGejDIAdx1Yp6hvRgOQYl7fBu8QgcnqEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAgdW2aM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 08B74606A338;
	Sat, 21 Nov 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HAgdW2aM
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8FE031F000D2;
	Sat, 21 Nov 2026 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275363;
	bh=WDmPszPXiGvGIYG+2x/PKmWhePHmT9BMsOM+6W8MAOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAgdW2aM2OKtliwl1LhqrS7AE8yZKypO4bCvomN3yp25l+MSoC7kn/18cXGxbXPtd
	 Ah4daHkovPW4PTWlaQ9LRc3+G1cZ9iGXEjyYJaS3P5MVm92NVIuNW8+m0X9NS53bYh
	 ne3vRfrmJqm7Da4foUWOxToTNi6YmUv1xuCiY/kj/3/UbMRG3zzUdgx96PeAC/iGKx
	 hxyga7/4tinaSFZkU7DTxk7PuSlHinnV7WWNGVuVBR6V4/ytwkpJiYsmWGjll1VWpG
	 Kj+75Vs9Y7JYVgQ6NmMKEgN02Yrdtg87jpF7Ru7Qf0iI+ejCEHkazVPrtEz1sku0gG
	 toyYshaSOuiug==
From: Joel Fernandes <jfern@kernel.org>
To: paulmck@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/6] rcutorture: Add boost_disable to disable RCU priority boosting
Date: Sat, 21 Nov 2026 10:35:51 -0500
Message-ID: <20261121153552.68941-6-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261121153552.68941-1-jfern@kernel.org>
References: <20261121153552.68941-1-jfern@kernel.org>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_RCU_BOOST is now enabled automatically for preemptible RCU and
cannot be turned off, so rcutorture's BUSTED-BOOST scenario, which is
meant to show that rcutorture detects broken priority boosting, can no
longer break it.  Add an rcutorture.boost_disable parameter that keeps
rcu_spawn_one_boost_kthread() from creating the boost kthreads, which
gives that scenario a way to break boosting.

The parameter only has an effect when rcutorture is built in, because
the kthreads are created during boot.  Document it in
kernel-parameters.txt.

[ jfern: Apply feedback from Sebastian to not create the boost kthread ]
[ jfern: Apply feedback from Sebastian to limit this to rcutorture ]
[ jfern: Apply feedback from Sebastian to fold the docs into this patch ]

Signed-off-by: Joel Fernandes <jfern@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 kernel/rcu/rcu.h                                | 1 +
 kernel/rcu/rcutorture.c                         | 5 +++++
 kernel/rcu/tree_plugin.h                        | 4 ++++
 4 files changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac97cbd98b46..40e18ee3a1ba 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5964,6 +5964,15 @@ Kernel parameters
 			periods, but in jiffies.  The default of zero
 			says no holdoff.
 
+	rcutorture.boost_disable= [KNL]
+			Do not create the RCU priority-boost kthreads, so
+			that RCU priority boosting never happens.  This
+			is for testing that rcutorture detects broken
+			boosting, as in the BUSTED-BOOST scenario, and
+			should not be used otherwise.  It has an effect
+			only if rcutorture is built in, because the
+			kthreads are created during boot.
+
 	rcutorture.fqs_duration= [KNL]
 			Set duration of force_quiescent_state bursts
 			in microseconds.
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 93542e30b7f4..c01423985e3b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -716,5 +716,6 @@ bool rcu_is_task_rcu_boosted(void);
 static inline bool rcu_is_task_rcu_boosted(void) { return false; }
 #endif // #else // #if defined(CONFIG_RCU_TORTURE_TEST) && defined(CONFIG_RCU_BOOST)
 
+extern bool rcu_torture_boost_disable;
 
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ff674ace50a6..e5dbc77b09d5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -158,6 +158,11 @@ static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
+// Global because tree_plugin.h reads it during boot.
+bool rcu_torture_boost_disable;
+module_param_named(boost_disable, rcu_torture_boost_disable, bool, 0444);
+MODULE_PARM_DESC(boost_disable, "Do not create RCU boost kthreads, to test boost-failure detection.");
+
 static int nrealnocbers;
 static int nrealreaders;
 static int nrealfakewriters;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ae5d21bae7bc..3500e4874833 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1329,6 +1329,10 @@ static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 	if (rnp->boost_kthread_task)
 		return;
 
+	// With no boost kthread, rcu_initiate_boost() never boosts.
+	if (IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) && rcu_torture_boost_disable)
+		return;
+
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
-- 
2.54.0

