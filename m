Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795275358;
	b=UY5AAW7mAHRS42hzSg3nVlP29EP1kOCcc7wcmbPF/42QxlfEZI1KIKgMFXYePcSzRtKR
	 klccgqoK5JzwzDURnCj/od2boe5B0CT20YrTojIA2YryFO4mnEg6CmzPP7YIEtKC11tVz
	 pp/o4s+ozFk2pl7+8HRA2bkZhyaT6pT6BSU4fQn4iloaGULOEMesAsge7+mXQTG739R7U
	 /DtsqoSx3BY7iAhONlCXel/97OYcusrpvGnlaLsqmxJiOeHJyQxDKYxBmQSH5HayWw5jd
	 J9zge+oOyXutTm7fj/qeP7UMAZ0ZZYjJ30p0SpMN8pU1CfUJJ7MF5yX4E416/hwlwJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795275358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hmn6L2WF6Lx4dTC9D8qdEMw9E1mFKrXUndeRNP2Dy5Y=;
	b=2na+u6OqLNfCIUg0uSbo1OsFaZdnD+CZ9LHJA4hMZVsjjhFHTLSCp1IkPblLLvVpLWlq
	 BT23BCcMN5qGjFZUHdDTGPb0XzRE/PicLzcbB9JnSICbyQ7gG8Pix8S5GUJELf0PmLJNZ
	 AiXicUmlzQ9xmN2xEUx6SWEFYWOPf7Ehi+lsMzRvSvJ/zh4uiKlHVUfj+T4n6aNT26+zX
	 CcqkHEmiJAU8SYIfIzAV3jqJxI9RMcaQ+ClKeP6vW4t+48yRpAgFp11TqWHJpp2eGrcao
	 95HF9RQPFk5R03NqiTmMgqo6KfwrxIXisAnBjzb9vN0juihJlacbA4M0hkrSd/G5S8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqrcGrrY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D472F606A68F;
	Sat, 21 Nov 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PqrcGrrY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 66D4D1F000D1;
	Sat, 21 Nov 2026 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795275358;
	bh=hmn6L2WF6Lx4dTC9D8qdEMw9E1mFKrXUndeRNP2Dy5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PqrcGrrYSg1ePVoyF2NRMRbd7YUMPWREWn8xOBnZB1cSeH8KEfVBNK0qmfAYHKuGX
	 HrubUVS4Ske++rGWnVo4zSoXUL2gEAizZzPwVd5vkhDy4jsYh/xxzdsHzJOiLmSJ1C
	 rj+aKYmOppZgGO0RYpmWxudm6tfNHFLEAHMIOro7D2vv4dmQaObve8SPFyLgH61Ze0
	 BFi4y3X1Qof9YUf4whuBe16+tLVqLGZmIzkktYpHgT6ICeIc6myrJ4vR6kz1ZkX3Wx
	 i9WLBRz/gR9ybMEqLSiXrd3+8UsVOXUaOZij+Ns/fI8kzoOiuuf2eAYekscGiVkS7f
	 hLDHaASM3zCUw==
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
Subject: [PATCH v3 2/6] rcutorture: Don't try to disable to RT throttling.
Date: Sat, 21 Nov 2026 10:35:48 -0500
Message-ID: <20261121153552.68941-3-jfern@kernel.org>
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
Tested-by: Paul E. McKenney <paulmck@kernel.org>
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

