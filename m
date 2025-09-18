Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3612302174;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190675; cv=none; b=iIFzi/RzSDWbfbdcmCEVTQ3/EPuMD3zgXAN/T8wu0XjlQgWvQ5bMxNHSBqJHI+BY8109swcmWOIiq+H0tvSNcMASv2eTt2J3fpezUaFggjh+Jl9TWvZ+20cBInsIN//02PC6Gxo2psZ8RLb4LjrVGReXW+5UJ2IlxXxF1WZFwEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190675; c=relaxed/simple;
	bh=OmlAZwLbOfV/U6YckvaKFi8EfINIzzau42SR+69WELM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sLbFY67eHlTGP+aRMs0kDnkbwRIgQSUslw4Dmg/awHxR24FLr+zMpvE/VN+hiiVF7+c0itUzcqHgt1qip9+LVbUAYHTodlJ4CGURf0wrq7CuHSfMzLwpAQOqIfgrPTlkHQVTaR2r+d5LF6n9fU4kJnvIhj+OaJmKAPmyHVsqG9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN5ra0Bn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN5ra0Bn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5485C4CEEB;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190674;
	bh=OmlAZwLbOfV/U6YckvaKFi8EfINIzzau42SR+69WELM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QN5ra0BnO82Cl55DDuat1rXGYCdh1ifE0O05l/3GeZyqxp58abTCS9wkzKJfcrTjm
	 uh7DBao3ybasOXQYhCX6b6hGfiZ6X+3V3o0abCff+B8HvfYuDDbaj1aPj+GwMNGCEf
	 9gZ93KS/grhpzY1KPRFpDDUZ3I1StGBhXnB6o4IFl86o6qxMcZh0DSBnkakl0qgbXn
	 RSB/LQ3XJYIO6eM6khfbj1s0fW5dj7e0PrRWbgP9lYcz2KYXC895XLfsREF1pBFgXl
	 7g9VtTcNoAvKj6W/L93RwI9g8R9N6fSZ6zg1yrn2JyTb9qTiGdyEIyXLxAwCYrht9X
	 vF4VLpU/sBptw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1A52CCE0F82; Thu, 18 Sep 2025 03:17:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 4/5] rcu: replace use of system_wq with system_percpu_wq
Date: Thu, 18 Sep 2025 03:17:51 -0700
Message-Id: <20250918101752.2592512-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
References: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marco Crivellari <marco.crivellari@suse.com>

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f92443561d365a..2dc044fd126eb0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -553,13 +553,13 @@ static void rcu_tasks_invoke_cbs(struct rcu_tasks *rtp, struct rcu_tasks_percpu
 		rtpcp_next = rtp->rtpcp_array[index];
 		if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 			cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-			queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+			queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
 			index++;
 			if (index < num_possible_cpus()) {
 				rtpcp_next = rtp->rtpcp_array[index];
 				if (rtpcp_next->cpu < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
 					cpuwq = rcu_cpu_beenfullyonline(rtpcp_next->cpu) ? rtpcp_next->cpu : WORK_CPU_UNBOUND;
-					queue_work_on(cpuwq, system_wq, &rtpcp_next->rtp_work);
+					queue_work_on(cpuwq, system_percpu_wq, &rtpcp_next->rtp_work);
 				}
 			}
 		}
-- 
2.40.1

