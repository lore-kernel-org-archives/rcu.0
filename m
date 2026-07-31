Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B32BE033;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459845; cv=none; b=ufDGxODMzBbjulp7+cuCsXcOQafM9QVWq9qlYj+Kxv0IOYyp9SvCBxWRSFUEhrrlrp7fa/efhaAqWoqv/ULgspbF2991t61t8FAl1p4ZGFC78AKZwcVBe1xqDGCfFnLlCe3/dwylpkQt3O59SYXuLeF6HNJ4P5PwNyhNVKGo2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459845; c=relaxed/simple;
	bh=x1v3NISCPTvmugF4LUUhLDczxEsZx2rv5fgRjpex4OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4hG5w7+CbtES4UBdBPSU4oyqPjPdLImWVVpiyqxjJzojfMAuv4a6eX377I7ooJFAsmeEE6XkIYerHBpwLs0/LOPvKVrAUoweIUpYO90Bn/reE1pvg7uc/ylWHfgUfAb0AkCRAJqS+Z7L7vcKi2bDOV7n6pVgjZFu0Ja3vkTjRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z60qzlXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z60qzlXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C289D1F00A3A;
	Fri, 31 Jul 2026 01:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459843;
	bh=5awFt3rVsUFRv61tL7C01iSjH3iLbouNiQclS/ingoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z60qzlXCZ5mwv/Ys14dijt2wX+m3Gj5XS/U/s6fadhs3LT2KNh3UG0B+0s+LrSgqE
	 xAZqhI+LkAWVY4uiaJoEmdaE6fNmoxDaIQFuDXx7/A8rtI40qdyHEMefMDTquwObUf
	 dgCXShPieaelKNYL6iz9V3w865ezYeAjDCJ8i+gMrIY/lZvvYx1+eFhgtdx8SmRzqE
	 cczPPFHEG/XSDxuCdBqCSMA42voRIXuoiTO06LaIsRppCVLdedfVaMaCtEpIXJ8V6h
	 t2T7qeN3Lfj5oOp7+n+0+KA2WtC+AcxSD81SOOxfGxQTgEtBXPY4JhuOAiMtOKoUD+
	 F0yFCBklLqi6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C9F3CE0F6A; Thu, 30 Jul 2026 18:04:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Zqiang <qiang.zhang@linux.dev>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 02/10] rcu-tasks: Remove unused struct rcu_tasks's->n_ipis_fails variables
Date: Thu, 30 Jul 2026 18:03:53 -0700
Message-Id: <20260731010401.3531631-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
References: <c50fb3e6-8d9f-4311-953e-a4703ba1e863@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zqiang <qiang.zhang@linux.dev>

The RCU tasks trace has been reimplemented by 'commit c27cea4416a3
("rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast")', the
rcu_tasks structure's->n_ipis_fails is no longer used, this commit
therefore remove it.

Signed-off-by: Zqiang <qiang.zhang@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f4da5fad70f516..7f7d1e6362178a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -67,7 +67,6 @@ struct rcu_tasks_percpu {
  * @gp_start: Most recent grace-period start in jiffies.
  * @tasks_gp_seq: Number of grace periods completed since boot in upper bits.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
- * @n_ipis_fails: Number of IPI-send failures.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @lazy_jiffies: Number of jiffies to allow callbacks to be lazy.
  * @pregp_func: This flavor's pre-grace-period function (optional).
@@ -102,7 +101,6 @@ struct rcu_tasks {
 	unsigned long gp_start;
 	unsigned long tasks_gp_seq;
 	unsigned long n_ipis;
-	unsigned long n_ipis_fails;
 	struct task_struct *kthread_ptr;
 	unsigned long lazy_jiffies;
 	rcu_tasks_gp_func_t gp_func;
@@ -735,12 +733,12 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		if (havecbs && haveurgent && haveurgentcbs)
 			break;
 	}
-	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c%c%c l:%lu %s\n",
+	pr_info("%s: %s(%d) since %lu g:%lu i:%lu %c%c%c%c l:%lu %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
 		jiffies - data_race(rtp->gp_jiffies),
 		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
-		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
+		data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
 		".C"[havecbs],
 		".u"[haveurgent],
-- 
2.40.1

