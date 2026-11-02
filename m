Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630142;
	b=qVozUO9eTY2od6u96bIFSLY3UgaGtPA+Xn6idKkSVVnJJPVYtXRtJHioPZyG3VFnxZbQ
	 gZlsst/uWgixkQ1TgOdog6qsE9Lu3CTIrIhjFEs8g3QvZXKYZdEQO6Y6fR7JegoOZVn/g
	 bNtCe0y0QU1k38+2GMG2CZySxciNdr1uGsLcKFQ7n1kpdbkplmw29zAgnbZoumddYDZMg
	 rFfdnpC34ejso8sebDIB/2HdAV+a6yTw/wMjievFnqF231iTpg17VhzmXQigVSoSXWKfu
	 uBKMcDznGm/IssP33VmWTAyq0H1PU2U8bFkeaTnircGwj8JtfhQWzvNsVSnpuN9/yag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630142;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+KH9DKnobF6DQUWg/9OINh8veQE+eSIIBbaMlh5YSf0=;
	b=AnuXYW35LzC+KqQFkIwMaYks6RcxTZd2Sa6Z1Bq7IbL8yOH96O6o/NbHuLlIh6pc1t+i
	 f56IB7fTdB/Ajk+oXdwWiNsIC7W/8lrHYUHCSciNWax43xpKYyoetBP3s4dg9zfdhOlZk
	 F3QKo9RW1ik/Oj2xoKfc62cN46yx+QE2zeleBMHkJ4ux01ButNA2/5lcuw3gfxl8UIoyk
	 zCmcoXNPewlm+ZTNsRpr2liSE9YX65wohVrfbwpOiwpGaZfvLTveBpr7s95K76eTG7yKX
	 45lDuyz2zYDtBl2sLiode1sRC9DVQRpgg3xl8SJu7HTjDVDrpVv8OwPVyHecLTbYHGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ikn1y6ry;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DB606D801;
	Mon,  2 Nov 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ikn1y6ry
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E1F1F00A16;
	Mon,  2 Nov 2026 14:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793630142;
	bh=+KH9DKnobF6DQUWg/9OINh8veQE+eSIIBbaMlh5YSf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ikn1y6ryTPUoeZWCunevYgyGsdCva6xgumlNAVWW5Xw1G1m7YhcfouBu0crpxQ01H
	 zw3kj4Fzllj0s/gES72EKL7lmVdFd9+upRks3Az6+sycu4SgIBaieLz37micyH6qij
	 Fbh5Nfzn1pkfP/SOUBdlk37bPE6Cr5NBRJyZMWYAN1tMglddycvGqd8lPQnuPdk7e1
	 kOp7TbA7D/Kb7ezIlJeqediV5rZqmM2dmksRAUWt08p2yvZDvF5QG8qUu1X/+sJU25
	 JXZuu/14JcWcosmYHhryfwLwD4qeqnRlYhrcQV7EYkDsnnDawHHR8t49JUxdMMjT2v
	 3JIO0LBpLHX2A==
Date: Mon, 2 Nov 2026 14:35:40 +0000
From: Harry Yoo <harry@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: vbabka@kernel.org, urezki@gmail.com, paulmck@kernel.org, 
	qiang.zhang@linux.dev, akpm@linux-foundation.org, hao.li@linux.dev, cl@gentwo.org, 
	rientjes@google.com, roman.gushchin@linux.dev, linux-mm@kvack.org, 
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com
Subject: Re: [PATCH 2/2] mm/slab: don't queue the page cache work under
 krcp->lock
Message-ID: <auifTNDwbBTJeu81@thinkstation>
References: <20261028134647.3176080-1-zhanxusheng1024@gmail.com>
 <20261028134647.3176080-2-zhanxusheng1024@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028134647.3176080-2-zhanxusheng1024@gmail.com>

Here I added bit more context and adjusted comment. End result:

mm/slab: don't queue the page cache work under krcp->lock

Commit 56292e8609e3 ("rcu/tree: Defer kvfree_rcu() allocation to a
clean context") deferred page allocations to a workqueue. To avoid
deadlocks with the scheduler, it used hrtimer to queue the work instead
of queueing it directly.

Commit d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory
pressure") later added a backoff mechanism under memory pressure, but
did not consider that queue_delayed_work() with delay = 0 immediately
queues the work and introduced the deadlock commit 56292e8609e3 tried to
avoid.

run_page_cache_worker() runs under krcp->lock, from kvfree_call_rcu()
callers that may hold more, such as set_cpus_allowed_force() under
pi_lock, so it kicks the refill work from an hrtimer. Under memory
pressure it instead queues the work with a delay of
rcutree.rcu_delay_page_cache_fill_msec, which may be 0, and a zero delay
queues it at once, taking pool->lock under krcp->lock.

With the delay set to 0, calling kvfree_rcu() on vmalloc memory under
pi_lock after a drop_caches makes lockdep report:

  Chain exists of:
    &pool->lock --> &p->pi_lock --> krc.lock

Use the hrtimer when the delay is 0.

Fixes: d0bfa8b3c411 ("kvfree_rcu: Release a page cache under memory pressure")
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Link: https://patch.msgid.link/20261028134647.3176080-2-zhanxusheng1024@gmail.com
[ harry@kernel.org: add more context to changelog and adjust comment ]
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 mm/slab_common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 41dea01a8c1f..051ca63c0b67 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1987,7 +1987,15 @@ run_page_cache_worker(struct kfree_rcu_cpu *krcp)
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 			!atomic_xchg(&krcp->work_in_progress, 1)) {
-		if (atomic_read(&krcp->backoff_page_cache_fill)) {
+		/*
+		 * Use the hrtimer to avoid a deadlock with the scheduler
+		 * by waking up the worker directly. queue_delayed_work()
+		 * uses a timer to queue the work, so it's fine.
+		 * But with delay = 0 it queues the work immediately.
+		 * Fall back to the hrtimer in that case.
+		 */
+		if (atomic_read(&krcp->backoff_page_cache_fill) &&
+		    rcu_delay_page_cache_fill_msec) {
 			queue_delayed_work(rcu_reclaim_wq,
 				&krcp->page_cache_work,
 					msecs_to_jiffies(rcu_delay_page_cache_fill_msec));
-- 
2.54.0
