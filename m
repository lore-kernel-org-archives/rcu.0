Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3599302152;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190675; cv=none; b=oKVuLdKViIBpyAaYN780fJg3zp5TecwX74yVDqq4EjbYzjmfnIfhTY7meV2xaz2VAasvvLyrBAPDvSGd7yAjdJfoVqFTUyLNw2mRZp1pyHlx+YQF0mSQ6EqeYVOVsyvebAhvRYOIETiu6Qa9AlZ2pPKLIjcmvNXbtbZKeLjyZNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190675; c=relaxed/simple;
	bh=6xDiGB8aFzb5XzIZSlcQKXA0X1480AudJy/Ai6h9dH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TW405nnqm7M88jR+kF1/dUavzFKqWikSWfyPHcyIsdwRKL6E1Xbwe0NZQqHGm0al1ucmRz0o4ernmJSFSLAxeYbeCDt5F/5ZMdOVAUno8mGF+wJu1SEwn6oRWp4/v3/b05TDJa8NWNQxtoyc1jU7NNy8UjL+DkGylTQqG9jGiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntAvZCfS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntAvZCfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA14C4CEFE;
	Thu, 18 Sep 2025 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190674;
	bh=6xDiGB8aFzb5XzIZSlcQKXA0X1480AudJy/Ai6h9dH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntAvZCfSC1oWndqNEcqf8wbc3Q8Vft39a/xYjoJakKVz/t7G4Iaks5RCTrjP2o+IF
	 GepSKHLkQVMSwP1MyQT+XZiy6TrJEmUa7i7apWiinbzByN82wTgjf7zvZeX86qHGxc
	 SVeldUxfrKIA6C2x2masO2A04YSlURrJe2UVjv65JEAhLoWI3z8zMDMYrd0LPe2jgJ
	 2i2O41laAaX3W6+D8BV3f5TApmJ55sbSoOV57Ttc9xpFdNfJHJYC0EaVwlW+qPFgFe
	 NrgjTXAu+Rkj7xbh5ng4w4dtSt6xNl+pRM5VAV/MKASm8u6bu3Q0JOVfOO59DxfooY
	 EUcKeUDcR9Vig==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 1CD7DCE10B6; Thu, 18 Sep 2025 03:17:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Marco Crivellari <marco.crivellari@suse.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 5/5] rcu: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 18 Sep 2025 03:17:52 -0700
Message-Id: <20250918101752.2592512-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
References: <3773a6e3-8ec8-48c5-9277-264cd8ccbb10@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Marco Crivellari <marco.crivellari@suse.com>

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1291e0761d70ab..c51c4a0af6aa5e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4890,10 +4890,10 @@ void __init rcu_init(void)
 	rcutree_online_cpu(cpu);
 
 	/* Create workqueue for Tree SRCU and for expedited GPs. */
-	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM, 0);
+	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!rcu_gp_wq);
 
-	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!sync_wq);
 
 	/* Respect if explicitly disabled via a boot parameter. */
-- 
2.40.1

