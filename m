Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CD61B2523;
	Thu, 26 Sep 2024 22:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390981; cv=none; b=U1Xyydh3vnqgKlKQnHQGW7puOM2Rx1QGy0P6W0q1FK+XtFEvcjBycTXlBZ9wW48vBCbzzuBjVkJ9Ln7W2t0WV2dayCq9lnMF7TBfJmAkNZxB0AfFnPeGrXw0wFoaZNgdfNzSeQI/RtoAy7Qy7ng/l0epFwo9QVPYlBHkC70YWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390981; c=relaxed/simple;
	bh=92oEHSM6E5QZI86HEze8W34mCNCuSP+gt4f24shWjnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyzA6gM8n3Z/t+Zd1X6/bzYE/vXeOcd68Ranw6k8Zmc674QKsI8Ls6fIQhK4o5mq8vtRLja95KWZhwojNL94JSmNSI8NBz+ZwV4tKiI5hnf+mmYWOLrdGrFqYzOvflmHBgFP+NwUPdDLoKInOliFdngf/yc+EOrOpJW5lUFfMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFOzyMhs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFOzyMhs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A699EC4CEC9;
	Thu, 26 Sep 2024 22:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727390981;
	bh=92oEHSM6E5QZI86HEze8W34mCNCuSP+gt4f24shWjnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OFOzyMhsolEevHbP5JheK/yJ2si1BnSND7B0gJHO4BQ729HVM9s9J1QexXf9Uh+En
	 bi8R19DQalwlsOGmVSKSZAkwf/sdUTNZ0Fr/CPppxA4QVcFCtcldRMgFfMWjNxbGkm
	 zCaXGzb3Ne+x7Ltl7pDAhty21/NSJ4KZrbPaQlaXMMJ7LbodhDfiOtxAl44i/N+j1H
	 R7cVtGRSDj6cSzB6j9J7LuZwfO3VDbO1k+PIg4/C5K3/JeogOODGuKTAmJA7Q78AU6
	 yh8S2+6wUdxDoBUlLpUKtZp8gE0yHnmuHsFEbUMvHR/zBF6c2B+31Y6J8ZA+xDQEJ+
	 jtF9W8+zKlpGg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Michal Hocko <mhocko@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	rcu@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 11/20] sched: Handle CPU isolation on last resort fallback rq selection
Date: Fri, 27 Sep 2024 00:48:59 +0200
Message-ID: <20240926224910.11106-12-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240926224910.11106-1-frederic@kernel.org>
References: <20240926224910.11106-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a kthread or any other task has an affinity mask that is fully
offline or unallowed, the scheduler reaffines the task to all possible
CPUs as a last resort.

This default decision doesn't mix up very well with nohz_full CPUs that
are part of the possible cpumask but don't want to be disturbed by
unbound kthreads or even detached pinned user tasks.

Make the fallback affinity setting aware of nohz_full. This applies to
all architectures supporting nohz_full except arm32. However this
architecture that overrides the task possible mask is unlikely to be
willing to integrate new development.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..d4b759c1cbf1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3421,6 +3421,21 @@ void kick_process(struct task_struct *p)
 }
 EXPORT_SYMBOL_GPL(kick_process);
 
+static const struct cpumask *task_cpu_fallback_mask(struct task_struct *t)
+{
+	const struct cpumask *mask;
+
+	mask = task_cpu_possible_mask(p);
+	/*
+	 * Architectures that overrides the task possible mask
+	 * must handle CPU isolation.
+	 */
+	if (mask != cpu_possible_mask)
+		return mask;
+	else
+		return housekeeping_cpumask(HK_TYPE_TICK);
+}
+
 /*
  * ->cpus_ptr is protected by both rq->lock and p->pi_lock
  *
@@ -3489,7 +3504,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 			 *
 			 * More yuck to audit.
 			 */
-			do_set_cpus_allowed(p, task_cpu_possible_mask(p));
+			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
 			state = fail;
 			break;
 		case fail:
-- 
2.46.0

