Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858284;
	b=zGCj4qNN1MBPNIZfY5Nr4ca3uSQPcqDLssVCWVmw9yHUh0p00rp9CuIQXhtbIGx1VlSx
	 fy+uG3rn6QKD+W/8My8/afmEVj/ub4rhFmxGWq0InU6bR5ZaAm+jFK5T7nmuC7/sehxgy
	 Ud03OmNgfmcEq4+m98IvKCnvr5BJ9Fnl5Q2ljcHAzTW//LJBSBE5PtqX/1mbn0YhpnbbI
	 91ke4ovrzo4nY+QzKs+P6rtqO6dDA8we4/w0WMyubukZWnGoOPBz5yrGLQGXIA+Ys/fTP
	 Ya3+CJ9UsnpVEXQPbx5AY2hZUxpioKyyNHzXxyjn0UJrp3s1aL8FoCsdsN3lMxf4tjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ys9zjXAdG9tWMfaRQoVA43Vcvsh41Ti8xoINI2rrnaE=;
	b=d+L3j6fIsWhFl/qe98M9LiUDmWSP4EpGu1X5FeUgPl00agHYfJ7D9zR+BB8rfDWCqtcG
	 9ToxZsY6Pfb8RqN3ZyBbzlABPHU7A3ra/d8aadcwvZZ/IygnXvHA3gqckB9C6Ae6p81AP
	 4GZMOveUfvC0FznvbmFXcYb689LWyxcQeDANqaDiQbbAI9FjU8+qT8wYl6Vk9fbOCHUet
	 5Jp8JdD2DwLu3AETZkLDh3rOlV6WdR271Sq5u/bcIblLSQMGA3obsyzW7aTFzfXr4tlO6
	 VM0xRLWdiU1DiThpsOfzlVU5tchyuPuRKjyHX4fsXdNKwTiiGlKaFsa0D2MdWIW8biw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RK3GzDHp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 19B19606A322;
	Mon, 16 Nov 2026 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RK3GzDHp
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A2AF01F000CB;
	Mon, 16 Nov 2026 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858284;
	bh=Ys9zjXAdG9tWMfaRQoVA43Vcvsh41Ti8xoINI2rrnaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RK3GzDHpl1dnFmW2jUUxFJKrM46qkX7HdLHnO5KAJETUbONdLBCHMI/2bET5aYyKi
	 i0qdXYVnGbSpFjNMUbhrBPZ0D7S8ptM/nrsfc0bgtBIsyTwCAYeaxMnyuAIOVhjtd5
	 sisr6g7wLD54Mj1NSdB5Zj/sZ8ZB/886gzvGgE36wx+BuL/3ujJqJyyTCf3hZT1gMM
	 Ls5ZN9qtGoSDq9SM80O/r+6gehqAVqus2wnder9FsspVAhrAfJykppeSFeXZL1qaay
	 agTtqj1XcuG0Zsw7DTczATGU0QScN1/IbDUV0VMu4nZMmh8c3lq54TQoLHoNkCO4rt
	 4aMrklmSMkffA==
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
Subject: [PATCH v2 2/7] rcutorture: Don't try to disable to RT throttling.
Date: Mon, 16 Nov 2026 14:44:33 -0500
Message-ID: <20261116194438.306618-3-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261116194438.306618-1-jfern@kernel.org>
References: <20261116194438.306618-1-jfern@kernel.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Commit 450efca7182a5 ("rcutorture: Disable RT throttling for boost
tests") added the ability to disable RT throttling while rcutorture was
run.

Since v6.12 the DL fair_server takes control of throttling and this
interface no longer serves this purpose. That sysctl control still
exists but serves a different cause.

There is no in-kernel interface to provide this feature, one needs to
echo 0 to each /sys/kernel/debug/sched/fair_server/cpu*/runtime file.

Since sysctl_sched_rt_runtime does not do what it once did, remove it
from rcutorture.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[ jfern: Rebase onto the rewritten priority-boost test ]
[ jfern: Remove the now-unneeded sched/sysctl.h include ]
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 kernel/rcu/rcu.h        |  2 --
 kernel/rcu/rcutorture.c | 29 -----------------------------
 2 files changed, 31 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 7cae7e64e96d..9f7e60e69275 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -69,8 +69,6 @@
 /* A complete grace period count */
 #define RCU_SEQ_GP (RCU_SEQ_STATE_MASK + 1)
 
-extern int sysctl_sched_rt_runtime;
-
 /*
  * Return the counter portion of a sequence number previously returned
  * by rcu_seq_snap() or rcu_seq_current().
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a81855efbf1f..4ec2c6e1d3ba 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -43,7 +43,6 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/debug.h>
-#include <linux/sched/sysctl.h>
 #include <linux/oom.h>
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
@@ -1349,32 +1348,6 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
  * rcu_node would wait for the first one's whole CPU burn.
  */
 
-static int old_rt_runtime = -1;
-
-static void rcu_torture_disable_rt_throttle(void)
-{
-	/*
-	 * Disable RT throttling so that rcutorture's boost threads don't get
-	 * throttled. Only possible if rcutorture is built-in otherwise the
-	 * user should manually do this by setting the sched_rt_period_us and
-	 * sched_rt_runtime sysctls.
-	 */
-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime != -1)
-		return;
-
-	old_rt_runtime = sysctl_sched_rt_runtime;
-	sysctl_sched_rt_runtime = -1;
-}
-
-static void rcu_torture_enable_rt_throttle(void)
-{
-	if (!IS_BUILTIN(CONFIG_RCU_TORTURE_TEST) || old_rt_runtime == -1)
-		return;
-
-	sysctl_sched_rt_runtime = old_rt_runtime;
-	old_rt_runtime = -1;
-}
-
 struct rcu_torture_boost_reader {
 	struct completion done;
 	bool in_cs;	// Reader is inside its RCU read-side critical section.
@@ -3422,7 +3395,6 @@ static int rcutorture_booster_cleanup(unsigned int cpu)
 	mutex_lock(&boost_mutex);
 	t = boost_tasks[cpu];
 	boost_tasks[cpu] = NULL;
-	rcu_torture_enable_rt_throttle();
 	mutex_unlock(&boost_mutex);
 
 	/* This must be outside of the mutex, otherwise deadlock! */
@@ -3460,7 +3432,6 @@ static int rcutorture_booster_init(unsigned int cpu)
 
 	/* Don't allow time recalculation while creating a new task. */
 	mutex_lock(&boost_mutex);
-	rcu_torture_disable_rt_throttle();
 	VERBOSE_TOROUT_STRING("Creating rcu_torture_boost task");
 	boost_tasks[cpu] = kthread_run_on_cpu(rcu_torture_boost, NULL,
 					      cpu, "rcu_torture_boost_%u");
-- 
2.54.0

