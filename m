Received: from msa.smtpout.orange.fr (msa-212.smtpout.orange.fr [193.252.23.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D41C57A5;
	Tue,  6 Aug 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951034; cv=none; b=S92p9oxNRzK3AbREkW1yyRhJVRfFOiDJop3XdRnkctTZ9rnJR4Ug98D4NOvl+xIcomEpS/oq9cg9JHc/YMi8hyqoWnM5+CfN0z1JFFSmmldPkUUFQFr6EGOg8tsfhLbJyTSItLUfKjXFVnKJOolu6G30X1CGaP457ISK61sgSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951034; c=relaxed/simple;
	bh=1gt4DGlnEvk4C6I+MHr1KvC3pI+FOt8lCQxfWRZdjzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S/u7noSoN2vMeACTFUbmxuxNFJBy8OsrK9OCf+YRCn0f09VVM0ZKjiphxTZfCxZa7v1ji0UZuT5baXzQQKoCZmKVaOJGtqMEoXDUPYED7U/IExBXddx+D2gAhErw0hulu2gOXhAXfr1vbri1HgQTEK42PfdN50TlM8LJWjGcIJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=rELrWL69; arc=none smtp.client-ip=193.252.23.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rELrWL69"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id bKGasMrYrk1NHbKGbsryPR; Tue, 06 Aug 2024 15:30:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722951023;
	bh=d69VfSDFznZJlgGHUNUM34fDu7txnT5TK9v/Z+aWwNg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=rELrWL69hQHCACChtuDknbS5s4eLfnGaz47bWaGPjch0CNbOAuVHSFhGawJ1jGjvc
	 WmgSRehYY7MdIl8bw/Pu1K1pnFSCNEBjHPnXLoK4qfZBh96HxwvWAQ1Zgjt2Sf+56E
	 /OZMjdW/wHAN09NKEzJUJ+qFyxpdx3yYBMJ9G3PCkAbr7stysjVhdUGtwvWjWVyGmA
	 8XKpo6TSmcAWFui2kD0hnqefi1Cx+s4VvLXy/xvNDQR9t56VyY1+f1u/w2yEXBgLly
	 0rfxYWVn4YML22YLv9/26scAhEXtpUx8yb2Y6q9o0b0jy4cxvV8WtJJGMbdXPUKkvz
	 71SB7TytRlDaw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Aug 2024 15:30:23 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	rcu@vger.kernel.org
Subject: [PATCH] refscale: Constify struct ref_scale_ops
Date: Tue,  6 Aug 2024 15:30:16 +0200
Message-ID: <46cd762aeef493d8655e8a053bfd591f849d27ec.1722951006.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
Compile tested-only.
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
2.45.2

