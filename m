Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906A2EEE6E;
	Fri, 31 Jul 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460044; cv=none; b=gbjrl7tiJok8CPZGb4kLVm0UoKcl5H9h6F4gT7j9AiCLr2dkUAizHDjIXRFW4RU1hLfSS7hxLw7AqZVaQ+wXtP2KgOLlOJt4bkIu+Z2C66htg/I1/T5mH2iSw1dGJkkJ4Dq6mcRKrrl/RCJVPkbdoKe1XdOg0vg8Q/hrHHP8S7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460044; c=relaxed/simple;
	bh=xKG6dqWLS9aXv2qsMIelwq+X3eYQYJm2aula4pYRaEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjDN17lSnX7orGGc94nky5gNwPy6m9DQkl/bj37YXG+aAy6RiyIwNDeSoGBbRMlJkWb5Pnnl7xJFa0lxl6LM9ilkn8StetSQosJA1VXqPRCuBFUEB/db7AktfGwYU9PhOK2qswJVfrf5XIYjnFxWpkPv7ai0dm5p3HjD1e+octw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dleQ+Xcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dleQ+Xcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D1D1F01558;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=t6i0canJdafTzp2z3z+LCW+Cxa+nxG3O3xDeE0LYf20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dleQ+XcgY8IvnLtvnW5k5pLTKThts2mgn7m8/4WEX32fSuIVL1vFdxHH6o8IkovAY
	 B8fkMsCPT8eEmN0gQqovEX1cINwsedi2cuyEmeBbO2pk7DNgp7xk93YOILk0JPU1Bq
	 nVDxn4lobqa7iFtj5334FAiCEG3iFHkXsKghgB8tn61ugVBdzvbCt2aAow/d4mCTjt
	 ddeQeFE2t/qHmnpwNPtDL44dfU4UlvRiLM8FpAVqAi9EEu/v5SljHeXlfCDkd+z6lu
	 rrjfHgoUB/CzfBJZiXJ62W4aSXCRioqBZzILMK9ygzHPzL5ZhpV/FmL/UDT0jG1KBi
	 Snmz4w/vSz5lQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94A49CE1497; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 08/13] rcutorture: Test RCU Tasks Trace GP implying RCU GP
Date: Thu, 30 Jul 2026 18:07:14 -0700
Message-Id: <20260731010719.3531912-8-paulmck@kernel.org>
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

An RCU Tasks Trace grace period is supposed to imply an RCU grace period,
and this implication is relied on by BPF.  But this is not currently
tested.  This commit therefore makes tasks_tracing_torture_read_lock()
sometimes use rcu_read_lock() instead of rcu_read_lock_trace(), thus
testing the required implication.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6e9822baa236f2..c8118c38812aee 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -766,11 +766,12 @@ srcu_read_delay(struct torture_random_state *rrsp, struct rt_read_seg *rtrsp)
 	const long uspertick = 1000000 / HZ;
 	const long longdelay = 10;
 
-	/* We want there to be long-running readers, but not all the time. */
+	// We want there to be long-running readers, but not all the time.
+	// The !rcu_preempt_depth() is for RCU Tasks Trace.
 
 	delay = torture_random(rrsp) %
 		(nrealreaders * 2 * longdelay * uspertick);
-	if (!delay && in_task()) {
+	if (!delay && !in_atomic() && !rcu_preempt_depth() && !irqs_disabled()) {
 		schedule_timeout_interruptible(longdelay);
 		rtrsp->rt_delay_jiffies = longdelay;
 	} else {
@@ -1219,15 +1220,24 @@ static struct rcu_torture_ops tasks_rude_ops = {
  * Definitions for tracing RCU-tasks torture testing.
  */
 
+// Note that an RCU Tasks Trace GP must imply an RCU GP.
 static int tasks_tracing_torture_read_lock(void)
 {
-	rcu_read_lock_trace();
-	return 0;
+	int use_rcu = !(jiffies & 0xff);
+
+	if (use_rcu)
+		rcu_read_lock();
+	else
+		rcu_read_lock_trace();
+	return use_rcu;
 }
 
-static void tasks_tracing_torture_read_unlock(int idx)
+static void tasks_tracing_torture_read_unlock(int use_rcu)
 {
-	rcu_read_unlock_trace();
+	if (use_rcu)
+		rcu_read_unlock();
+	else
+		rcu_read_unlock_trace();
 }
 
 static void rcu_tasks_tracing_torture_deferred_free(struct rcu_torture *p)
-- 
2.40.1

