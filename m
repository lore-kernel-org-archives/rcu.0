Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56213BC1B;
	Fri, 16 Aug 2024 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791918; cv=none; b=TNXKdimyuwB9BrrvAJUuSi1s0CP7Rq7K2rk8g2UYRsXE9ZjkMSceHGNX7+3Zzbe1+QV1AGpiUSoNdAdRfmvfQM59Hqu0GevtRPaM4UGcdpK6j0lrBRK/V8X9takwjAovWuww1bMR+1E2yECkUniWcmbpsiCa9fY9sFDufOu/eJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791918; c=relaxed/simple;
	bh=8pjw6uKpTTYrTKlKksDSIG0o84ZLVtTrpHbW5hmvNOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YbPjsBLP31Zbk/Xj61umyuEocJhMLW7ArDfcnO3llYHu3yrtrSGJaskFxjQ1TqZk3G6r1vYRH3jFseghJZnnEmzy7omzqjOReP9FKJbIDxZgGgfVUTdlstC/ZkjcsRnFXUqIsBqfWwdQsAG1vN2hsPi8ivu/7th0t2t2wRoNN54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtpWgPG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtpWgPG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67210C32782;
	Fri, 16 Aug 2024 07:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791917;
	bh=8pjw6uKpTTYrTKlKksDSIG0o84ZLVtTrpHbW5hmvNOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AtpWgPG2K+2P8vca/MtMmTfCTwXci91pdkbVwHq5qc3C/doTL/hc09MC26LrZJ5HT
	 0ZLoTOGZkPZgVIRsSI488mxxOvWZmsqiPDdy1m8Wv1BOJI5r5GTutm7gFneoeKCtPP
	 vw6HQWZf8F/1FPH+2VU+BAyyx9kL2h0oXWW53nfJJ+ToSI17rlgJdOOUw6hvvZggRM
	 FXa/f142S8FloRs8RNJ+kfl2MLByI1KnLO9RRPgNGyWRuaLbNnQZl/nKmnEeEwwBRa
	 Q3E0TjtBbLwHg6859YD6zWoWCQo1/jF7tMvt0V1XXHvEaAepHKyUuxdcjHiJk7hLsR
	 0uVRDwH/HEdow==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH rcu 14/14] refscale: Constify struct ref_scale_ops
Date: Fri, 16 Aug 2024 12:32:56 +0530
Message-Id: <20240816070256.60993-14-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'struct ref_scale_ops' are not modified in these drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  34231	   4167	    736	  39134	   98de	kernel/rcu/refscale.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  35175	   3239	    736	  39150	   98ee	kernel/rcu/refscale.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Tested-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/refscale.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index cfec0648e141..0db9db73f57f 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -135,7 +135,7 @@ struct ref_scale_ops {
 	const char *name;
 };
 
-static struct ref_scale_ops *cur_ops;
+static const struct ref_scale_ops *cur_ops;
 
 static void un_delay(const int udl, const int ndl)
 {
@@ -171,7 +171,7 @@ static bool rcu_sync_scale_init(void)
 	return true;
 }
 
-static struct ref_scale_ops rcu_ops = {
+static const struct ref_scale_ops rcu_ops = {
 	.init		= rcu_sync_scale_init,
 	.readsection	= ref_rcu_read_section,
 	.delaysection	= ref_rcu_delay_section,
@@ -205,7 +205,7 @@ static void srcu_ref_scale_delay_section(const int nloops, const int udl, const
 	}
 }
 
-static struct ref_scale_ops srcu_ops = {
+static const struct ref_scale_ops srcu_ops = {
 	.init		= rcu_sync_scale_init,
 	.readsection	= srcu_ref_scale_read_section,
 	.delaysection	= srcu_ref_scale_delay_section,
@@ -232,7 +232,7 @@ static void rcu_tasks_ref_scale_delay_section(const int nloops, const int udl, c
 		un_delay(udl, ndl);
 }
 
-static struct ref_scale_ops rcu_tasks_ops = {
+static const struct ref_scale_ops rcu_tasks_ops = {
 	.init		= rcu_sync_scale_init,
 	.readsection	= rcu_tasks_ref_scale_read_section,
 	.delaysection	= rcu_tasks_ref_scale_delay_section,
@@ -271,7 +271,7 @@ static void rcu_trace_ref_scale_delay_section(const int nloops, const int udl, c
 	}
 }
 
-static struct ref_scale_ops rcu_trace_ops = {
+static const struct ref_scale_ops rcu_trace_ops = {
 	.init		= rcu_sync_scale_init,
 	.readsection	= rcu_trace_ref_scale_read_section,
 	.delaysection	= rcu_trace_ref_scale_delay_section,
@@ -310,7 +310,7 @@ static void ref_refcnt_delay_section(const int nloops, const int udl, const int
 	}
 }
 
-static struct ref_scale_ops refcnt_ops = {
+static const struct ref_scale_ops refcnt_ops = {
 	.init		= rcu_sync_scale_init,
 	.readsection	= ref_refcnt_section,
 	.delaysection	= ref_refcnt_delay_section,
@@ -347,7 +347,7 @@ static void ref_rwlock_delay_section(const int nloops, const int udl, const int
 	}
 }
 
-static struct ref_scale_ops rwlock_ops = {
+static const struct ref_scale_ops rwlock_ops = {
 	.init		= ref_rwlock_init,
 	.readsection	= ref_rwlock_section,
 	.delaysection	= ref_rwlock_delay_section,
@@ -384,7 +384,7 @@ static void ref_rwsem_delay_section(const int nloops, const int udl, const int n
 	}
 }
 
-static struct ref_scale_ops rwsem_ops = {
+static const struct ref_scale_ops rwsem_ops = {
 	.init		= ref_rwsem_init,
 	.readsection	= ref_rwsem_section,
 	.delaysection	= ref_rwsem_delay_section,
@@ -419,7 +419,7 @@ static void ref_lock_delay_section(const int nloops, const int udl, const int nd
 	preempt_enable();
 }
 
-static struct ref_scale_ops lock_ops = {
+static const struct ref_scale_ops lock_ops = {
 	.readsection	= ref_lock_section,
 	.delaysection	= ref_lock_delay_section,
 	.name		= "lock"
@@ -454,7 +454,7 @@ static void ref_lock_irq_delay_section(const int nloops, const int udl, const in
 	preempt_enable();
 }
 
-static struct ref_scale_ops lock_irq_ops = {
+static const struct ref_scale_ops lock_irq_ops = {
 	.readsection	= ref_lock_irq_section,
 	.delaysection	= ref_lock_irq_delay_section,
 	.name		= "lock-irq"
@@ -490,7 +490,7 @@ static void ref_acqrel_delay_section(const int nloops, const int udl, const int
 	preempt_enable();
 }
 
-static struct ref_scale_ops acqrel_ops = {
+static const struct ref_scale_ops acqrel_ops = {
 	.readsection	= ref_acqrel_section,
 	.delaysection	= ref_acqrel_delay_section,
 	.name		= "acqrel"
@@ -524,7 +524,7 @@ static void ref_clock_delay_section(const int nloops, const int udl, const int n
 	stopopts = x;
 }
 
-static struct ref_scale_ops clock_ops = {
+static const struct ref_scale_ops clock_ops = {
 	.readsection	= ref_clock_section,
 	.delaysection	= ref_clock_delay_section,
 	.name		= "clock"
@@ -556,7 +556,7 @@ static void ref_jiffies_delay_section(const int nloops, const int udl, const int
 	stopopts = x;
 }
 
-static struct ref_scale_ops jiffies_ops = {
+static const struct ref_scale_ops jiffies_ops = {
 	.readsection	= ref_jiffies_section,
 	.delaysection	= ref_jiffies_delay_section,
 	.name		= "jiffies"
@@ -706,9 +706,9 @@ static void refscale_typesafe_ctor(void *rtsp_in)
 	preempt_enable();
 }
 
-static struct ref_scale_ops typesafe_ref_ops;
-static struct ref_scale_ops typesafe_lock_ops;
-static struct ref_scale_ops typesafe_seqlock_ops;
+static const struct ref_scale_ops typesafe_ref_ops;
+static const struct ref_scale_ops typesafe_lock_ops;
+static const struct ref_scale_ops typesafe_seqlock_ops;
 
 // Initialize for a typesafe test.
 static bool typesafe_init(void)
@@ -769,7 +769,7 @@ static void typesafe_cleanup(void)
 }
 
 // The typesafe_init() function distinguishes these structures by address.
-static struct ref_scale_ops typesafe_ref_ops = {
+static const struct ref_scale_ops typesafe_ref_ops = {
 	.init		= typesafe_init,
 	.cleanup	= typesafe_cleanup,
 	.readsection	= typesafe_read_section,
@@ -777,7 +777,7 @@ static struct ref_scale_ops typesafe_ref_ops = {
 	.name		= "typesafe_ref"
 };
 
-static struct ref_scale_ops typesafe_lock_ops = {
+static const struct ref_scale_ops typesafe_lock_ops = {
 	.init		= typesafe_init,
 	.cleanup	= typesafe_cleanup,
 	.readsection	= typesafe_read_section,
@@ -785,7 +785,7 @@ static struct ref_scale_ops typesafe_lock_ops = {
 	.name		= "typesafe_lock"
 };
 
-static struct ref_scale_ops typesafe_seqlock_ops = {
+static const struct ref_scale_ops typesafe_seqlock_ops = {
 	.init		= typesafe_init,
 	.cleanup	= typesafe_cleanup,
 	.readsection	= typesafe_read_section,
@@ -1026,7 +1026,7 @@ static int main_func(void *arg)
 }
 
 static void
-ref_scale_print_module_parms(struct ref_scale_ops *cur_ops, const char *tag)
+ref_scale_print_module_parms(const struct ref_scale_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" SCALE_FLAG
 		 "--- %s:  verbose=%d verbose_batched=%d shutdown=%d holdoff=%d lookup_instances=%ld loops=%ld nreaders=%d nruns=%d readdelay=%d\n", scale_type, tag,
@@ -1081,7 +1081,7 @@ ref_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
-	static struct ref_scale_ops *scale_ops[] = {
+	static const struct ref_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, RCU_TRACE_OPS RCU_TASKS_OPS &refcnt_ops, &rwlock_ops,
 		&rwsem_ops, &lock_ops, &lock_irq_ops, &acqrel_ops, &clock_ops, &jiffies_ops,
 		&typesafe_ref_ops, &typesafe_lock_ops, &typesafe_seqlock_ops,
-- 
2.40.1

