Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F172DC32E;
	Fri, 31 Jul 2026 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460044; cv=none; b=of/aosTYzZ8RCBqeiBotjzUfKd0B+q2s/5rU/Sq/DFHA7gclZOc50oDQ3AWBy7Knj2SRysajkOUIprSngGhKvHo+/vfQHUsCSyEAOTbECgvp6ybLFuZjUMv79LXKhd+0dq0fLHJ+DUcBBOtT0cOwD3GsnRssZCuhDaZlq6Wqaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460044; c=relaxed/simple;
	bh=/W5lZAtYm9U6aBqKQAvZSX9XoORfGoCpscwJMAyzn0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SO7E0z5Ci08PlNNspAQVB2+6ApA+7XAFeRoB3tGf7E625zylZR/V96xvOersa2G9tq3aZdXL3tDuFRLk5gQVcnhKGbvDQeKN6Q1ge4MGdBsVO55iM2Hrq30Q8hkoCA0uy8vfu8he/Bh8XvFskNqYT7+ZO3hnr5FFmxJrv30W4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ud5PaxOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ud5PaxOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027451F00ACF;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=OineOo0YggCVncV+xn8lWTpAymfLRzoS+vAB3fUvQEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ud5PaxOJK7yer7KxRL+y2KThv8UcVhfMD+KLsME2QaleoK9qOeAplVvJtnKDr5fOB
	 8mZ2T8fLCMPU9yo61U17XubIe3DIIVSMRbtfi1G2Q2Q7aj5JVRC4Kwv245k2EcSyjs
	 jNPtEAIglRQCjDzPyADXz39GAPlZHWLNPEpCEyJ9sI1bzNZAxWYAy9mcON8coND9qH
	 Hk9zHz9RvA23c/sJWGalyflPqUaYOHC4n4aBCuJhIKPmRtlaJgCUPoG/U4xRIVqI4Q
	 jhWJF/IeUMogMhWLkSjXJV8aCB6+VCgap+FrJkVv+lukILD4+Nuzj6yUCe8H8COmUi
	 eRylfvcpMVIzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 92444CE1059; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 07/13] rcutorture: Add a stall_only module parameter
Date: Thu, 30 Jul 2026 18:07:13 -0700
Message-Id: <20260731010719.3531912-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a stall_only module parameter that shuts off all
rcutorture kthreads other than the RCU CPU stall-warning test kthreads.
The purpose of this is to test production applictions' reactions to
CPU stalls, and with minimal additional overhead.  Or you can omit the
stall-warning tests as well and get a heavy no-op, your choice!

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt          |  9 +++++++++
 kernel/rcu/rcutorture.c                        | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b942149720c9bf..40d2831add4a21 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6211,6 +6211,15 @@ Kernel parameters
 			and stall_gp_kthread are specified, the
 			kthread is starved first, then the CPU.
 
+	rcutorture.stall_only= [KNL]
+			Shut off all rcutorture kthreads other than the
+			RCU CPU stall-warning test kthreads.  The purpose
+			of this is to test production applictions'
+			reactions to CPU stalls, and with minimal
+			additional overhead.  Or you can omit the
+			stall-warning tests as well and get a heavy
+			no-op, your choice!
+
 	rcutorture.stat_interval= [KNL]
 			Time (s) between statistics printk()s.
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index acda5c5fca5f28..6e9822baa236f2 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -140,6 +140,7 @@ torture_param(int, stall_cpu_irqsoff, 0, "Disable interrupts while stalling.");
 torture_param(int, stall_cpu_block, 0, "Sleep while stalling.");
 torture_param(int, stall_cpu_repeat, 0, "Number of additional stalls after the first one.");
 torture_param(int, stall_gp_kthread, 0, "Grace-period kthread stall duration (s).");
+torture_param(bool, stall_only, 0, "Suppress all non-CPU-stall kthreads.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, test_boost, 1, "Test RCU prio boost: 0=no, 1=maybe, 2=yes.");
@@ -4649,6 +4650,23 @@ rcu_torture_init(void)
 		cur_ops = NULL;
 		goto unwind;
 	}
+	if (stall_only) {
+		pr_alert("rcu-torture: stall_only specified, suppressing all else.\n");
+		fqs_stutter = 0;
+		fwd_progress = 0;
+		n_barrier_cbs = 0;
+		nfakewriters = 0;
+		nocbs_nthreads = 0;
+		nreaders = 0;
+		n_up_down = 0;
+		nwriters = 0;
+		onoff_interval = 0;
+		preempt_duration = 0;
+		read_exit_burst = 0;
+		shuffle_interval = 0;
+		stutter = 0;
+		test_boost = 0;
+	}
 	if (cur_ops->fqs == NULL && fqs_duration != 0) {
 		pr_alert("rcu-torture: ->fqs NULL and non-zero fqs_duration, fqs disabled.\n");
 		fqs_duration = 0;
-- 
2.40.1

