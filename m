Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C45431A49;
	Wed, 29 Jul 2026 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313294; cv=none; b=BfP8QxEAfkd+LBG7o8KPCbrJgsVLjTIAZ9YaQUSRqpnAtscUq/Ph3mKQv57rvNKowJChmwJY9DRP+ZpM956E8yeRLIshPRnBIytzLBmVyQ4sCTIzae1RocKmeU1ty/C3VzuZhxQeGKmIKnS3kMVQfwopHWM747OBjF7o7GscJZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313294; c=relaxed/simple;
	bh=LaxWN6EuYBIYMxdJS3Ar7dUuxQAJ0VgRy6A+BkLFPcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8lYaeBUiaIrzCwHoI28ZPmc4gwQShBgox6+9WAtN1YL2qiw8ufqjaPDfAKHk7KiswSm/Yx5sY5V+Vz7WtxhueDzPHVXa3jsEG5ItfgLilnbIDTlKW0sdrnk9kyaOnEcQvVtfvVuaa64W/JouNc1C2f1YAO84z5mT7O/G6eaX9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQALvU7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQALvU7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19FB1F00A3D;
	Wed, 29 Jul 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785313287;
	bh=P1d0ZrPSWSgL++PjfVv8vMUfwjJ5v7z9zclam76ZWUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YQALvU7Mf+/wrx7QNvIxWBiRtcDpQNcVu02yMb9SFOq+jZZ1K6RyzBFlSB+QuvRIV
	 QhlKOTvfpfiVp7SMTencBUjwycP9IPRL0ctU+b9TX1tJ3yjQFl8kBQPGCTXgOHBhBe
	 d85OSsfSB2akNKuKdY/RO8uM7zIblYwjF8wZjOMxGG6LJO7IEEqWQg9czxk6ddYBEO
	 /yb6A0ZHge+Coj+C8PC2nEZcv0/sXoJWCmVpeyjGxD70yIJCF9y/Ze7ZI0kI61K6Hu
	 50BQWwOkMPRkdL/fL/aan5exTbDtzpgCrnzPTqv+9Ede933XDQlnHGKal8o0pOnMPR
	 Od4jTJxe0/0VQ==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 29 Jul 2026 17:20:13 +0900
Subject: [PATCH v5 5/8] mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-kfree_rcu_nolock-v5-5-a28cdcda9673@kernel.org>
References: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
In-Reply-To: <20260729-kfree_rcu_nolock-v5-0-a28cdcda9673@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Puranjay Mohan <puranjay@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>, 
 Shengming Hu <hu.shengming@zte.com.cn>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org, 
 "Harry Yoo (Oracle)" <harry@kernel.org>
X-Mailer: b4 0.14.3

As suggested by Vlastimil Babka [1], kfree_rcu_sheaf() can be used
on PREEMPT_RT if we always assume spinning is not allowed on PREEMPT_RT.
This is because local_trylock and spinlock_t are safe to use with
trylock and unlock as long as the kernel does not spin and the context
is not NMI and not hardirq.

Now that __kfree_rcu_sheaf() knows how to handle SLAB_FREE_NOLOCK,
relax the limitation and try the sheaves path on PREEMPT_RT as well.

Keep the lockdep map on non RT kernels. However, do not use the lockdep
map on PREEMPT_RT to avoid suppressing valid lockdep warnings.

As pointed by Vlastimil Babka [2], on PREEMPT_RT it is unnecessary to
defer call_rcu() under IRQ-disabled section or raw spinlock. However,
let us avoid adding more complexity as the scenario is not supposed
to be common on PREEMPT_RT, with a hope that call_rcu_nolock() will be
soon supported in RCU.

Link: https://lore.kernel.org/linux-mm/6811cc17-8ee4-48c8-8cbf-6bf4d9f98162@kernel.org [1]
Link: https://lore.kernel.org/linux-mm/40591888-3a87-433e-b3d2-cda1cab543be@kernel.org [2]
Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slab_common.c | 12 ++++++++++--
 mm/slub.c        | 17 ++++++++++-------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d81cc2136c68..9c2cca9add89 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1628,6 +1628,14 @@ static bool kfree_rcu_sheaf(void *obj)
 {
 	struct kmem_cache *s;
 	struct slab *slab;
+	unsigned int free_flags = SLAB_FREE_DEFAULT;
+
+	/*
+	 * It is not safe to spin on PREEMPT_RT because the kernel might be
+	 * holding a raw spinlock and slab acquires sleeping locks.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		free_flags = SLAB_FREE_NOLOCK;
 
 	if (is_vmalloc_addr(obj))
 		return false;
@@ -1638,7 +1646,7 @@ static bool kfree_rcu_sheaf(void *obj)
 
 	s = slab->slab_cache;
 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id()))
-		return __kfree_rcu_sheaf(s, obj, SLAB_FREE_DEFAULT);
+		return __kfree_rcu_sheaf(s, obj, free_flags);
 
 	return false;
 }
@@ -1987,7 +1995,7 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
+	if (kfree_rcu_sheaf(ptr))
 		return;
 
 	// Queue the object but don't yet schedule the batch.
diff --git a/mm/slub.c b/mm/slub.c
index 92c99ff34a2c..6c81722afb18 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6085,12 +6085,13 @@ static void rcu_free_sheaf(struct rcu_head *head)
  * kvfree_call_rcu() can be called while holding a raw_spinlock_t. Since
  * __kfree_rcu_sheaf() may acquire a spinlock_t (sleeping lock on PREEMPT_RT),
  * this would violate lock nesting rules. Therefore, kvfree_call_rcu() avoids
- * this problem by bypassing the sheaves layer entirely on PREEMPT_RT.
+ * this problem by passing SLAB_FREE_NOLOCK on PREEMPT_RT.
  *
  * However, lockdep still complains that it is invalid to acquire spinlock_t
  * while holding raw_spinlock_t, even on !PREEMPT_RT where spinlock_t is a
  * spinning lock. Tell lockdep that acquiring spinlock_t is valid here
- * by temporarily raising the wait-type to LD_WAIT_CONFIG.
+ * by temporarily raising the wait-type to LD_WAIT_CONFIG. Skip the lockdep map
+ * on PREEMPT_RT to avoid suppressing valid lockdep warnings.
  */
 static DEFINE_WAIT_OVERRIDE_MAP(kfree_rcu_sheaf_map, LD_WAIT_CONFIG);
 
@@ -6100,10 +6101,10 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
 	struct slab_sheaf *rcu_sheaf;
 	bool allow_spin = free_flags_allow_spinning(free_flags);
 
-	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT)))
-		return false;
+	VM_WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT) && allow_spin);
 
-	lock_map_acquire_try(&kfree_rcu_sheaf_map);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lock_map_acquire_try(&kfree_rcu_sheaf_map);
 
 	if (!local_trylock(&s->cpu_sheaves->lock))
 		goto fail;
@@ -6202,12 +6203,14 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
 	local_unlock(&s->cpu_sheaves->lock);
 
 	stat(s, FREE_RCU_SHEAF);
-	lock_map_release(&kfree_rcu_sheaf_map);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lock_map_release(&kfree_rcu_sheaf_map);
 	return true;
 
 fail:
 	stat(s, FREE_RCU_SHEAF_FAIL);
-	lock_map_release(&kfree_rcu_sheaf_map);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lock_map_release(&kfree_rcu_sheaf_map);
 	return false;
 }
 

-- 
2.53.0

