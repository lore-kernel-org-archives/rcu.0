Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA693371D02;
	Mon, 15 Jun 2026 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521584; cv=none; b=q04HoC0WctgB8/uw4PUlzmpioOVy21NtsbEMgKzU3/f4GzfR6aY97SJdoOMPCOjidXEYQZGTD6mt3fgsJG30YJu2BfWVWeOSUG8i2puXGF+ipvVllRvtWNs2rOzxBkMDswuTi830FaMFaDubrdTMeWCWBjTNUmsdar2OtpfSeJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521584; c=relaxed/simple;
	bh=RKYKBLP52A7LOuxg36KLTaR1iGwES6PemUq6XdXdj+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ba+Enj5PBXnPhDN6xOPJbsVBJy5iqRsqlAK1Rvg/uSZViU1Xt9yAnCqMchT++X6Ojb2ayTJm/jdkCe0QKbb8mS9Vcp6sBL7eMPcTfb5jSYob4QQEjVzBSQAsi5ICR/baeZ0lpvr4kONN2M0QoR0tlRLY3uTMRJDrog3ACdFzkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNkXimwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNkXimwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3A21F000E9;
	Mon, 15 Jun 2026 11:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521581;
	bh=DEzGeZYgP0g65zZZplfnHWmn77H05/JBjDI6P7zmy+c=;
	h=From:Subject:Date:To:Cc;
	b=eNkXimwbNZv8ecFiizQ1mGPxgUthsssfa8+ShsXFhzz9AZRPiffPNOqesVpMmsTPo
	 TcrJG/XA/SdI9IPvOyvjRXUqeWKez81c49clENShHjFsc9rwjrz/Ss4q+xBKxKiCQk
	 PWopBB5GKccK9bZtT/m4gQLhUAIJqeZ5EgWmSAKqAEg9XMsNUA0tS22lO64tSaMlQR
	 S2UADW1WpLVi0zKML5mkHx1wtdKLOeTMu21uOZ9LuIJM2j8Eu7+fQnhEmNbNmz2HBk
	 9WBGmmxUVuZcUAZhmlExu27HLBGgalPtD7LEojBWH7fZ6Zrw6eGANybaN953w4ZWDa
	 61nKpTpLS+jjw==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Subject: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock() and
 improve slub_kunit coverage
Date: Mon, 15 Jun 2026 20:05:54 +0900
Message-Id: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDMBBG4avIrBuIkRHsVUSkxD86WBKZ1CKId
 ze4/BbvnZShgkzv6iTFX7KkWNC8KvLLJ84wMhWTs661bc1mDQqM6vcxpm/yqwGzdczcdS5QyTZ
 FkONZ9hSSmojjR8N13VjsbORsAAAA
X-Change-ID: 20260615-kfree_rcu_nolock-e5502555992f
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
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, bpf@vger.kernel.org
X-Mailer: b4 0.14.3

Not the best time to post a series, but didn't want to delay posting
the series for too long. no pressures ;)  This is aimed to be queued
for review and testing after the merge window closes.

This series is based on next-20260612, and is also available on
git.kernel.org [3].

To RCU folks: It would be great if you could kindly take a quick look at
patch 4 and either ack or nack the patch ;)

To BPF folks: Ulad asked to share workloads to measure performance
of kfree_rcu_nolock(). Unfortunately, I focused more on correctness
and have not spent much effort on that. It would be nice if BPF folks
could help evaluate it on their relevant workloads.

To PREEMPT_RT folks: The most relevant part is allowing
kfree_rcu_sheaf() on PREEMPT_RT (patch 6). It carefully avoids sleeping
by acquiring the locks via local_trylock() or spin_trylock_irqsave()
to avoid sleeping within a raw spinlock. When trylock or unlock is
unsafe, kmalloc_nolock() always fails.

Changes since RFC v2
====================

Reduced complexity and intrusiveness (Uladzislau Rezki)
-------------------------------------------------------

While discussing concerns about the complexity of adding allow_spin
handling with Ulad (Thanks!), I realized that adding complexity to the
kvfree_rcu batching is not strictly necessary: only slab objects need to
be batched, they are already batched by rcu sheaves, and slab already
supports unknown context. So it is enough to implement only a minimal
fallback for the sheaves path.

I tried to avoid making intrusive changes to the existing kvfree_rcu
path as much as possible. struct rcu_ptr is renamed to kfree_rcu_head
following Vlastimil's suggestion, and it is used only in the
kfree_rcu_nolock() path for now.

As a result, the complexity is significantly reduced and the series
became much less intrusive. This is also reflected well in the diffstat
below.

RFC v2 diffstat:
  8 files changed, 514 insertions(+), 163 deletions(-)

v3 diffstat:
  6 files changed, 370 insertions(+), 105 deletions(-)

v3 diffstat (slub_kunit improvements - patch 1, 2, 9 excluded):
  5 files changed, 199 insertions(+), 66 deletions(-)

kfree_rcu_sheaf() PREEMPT_RT support (Vlastimil Babka)
------------------------------------------------------

As suggested by Vlastimil (Thanks!), kfree_rcu_sheaf() can now be used
on PREEMPT_RT as well, by always assuming allow_spin is false on
PREEMPT_RT.

slub_kunit enhancements
-----------------------

- Currently the test is skipped when there is no hardware PMU. This can
  happen on machines without a PMU, or in virtualized environments
  (e.g., automated testing or virtme). Implement a fallback based on SW
  perf events so that the test can still run in such environments, even
  though the coverage is slightly smaller.

- While testing on PREEMPT_RT, I found that kmalloc_nolock() fails every
  time, so the fallback path is not properly tested. This is a limitation
  of perf events: the handler is called in NMI (HW perf events) or
  interrupt context (SW perf events), where kmalloc_nolock() cannot
  succeed.

  slub_kunit now registers a kprobe pre-handler at the points in the slab
  allocator where lockdep_assert_held() is invoked. The pre-handler calls
  kmalloc_nolock() and friends, to improve coverage on PREEMPT_RT instead
  of relying on perf events.

One thing that needs to be further explored
-------------------------------------------

The global deferred_free_by_rcu (introduced by patch 8) list for the
fallback should probably be per-CPU [5].

Actual Cover Letter
===================

This series improves kmalloc_nolock() and kfree_nolock() coverage
in slub_kunit (patch 1 and 2) and introduces kfree_rcu_nolock() for
an unknown context as suggested by Alexei Starovoitov.

Unknown context means the caller does not know whether spinning on a lock
is safe (e.g., a BPF program attached to an arbitrary kernel function or
in NMI context).

The slab allocator already supports unknown context via kmalloc_nolock()
and kfree_nolock(), but te slab allocator does not support freeing
objects by RCU in unknown context.

It is not ideal to have completely separate batching for unknown context
because the worst scenario where spinning on a lock would lead to
deadlock is very rare, and in most cases, it is safe to use the
existing mechanism (kfree_rcu_sheaf()).

Since most part of the slab allocator already supports unknown context
and sheaves support batching kvfree_rcu() calls for slab objects,
implement kfree_rcu_nolock() with minimal changes by teaching
kfree_rcu_sheaf() how to support unknown context and making
it a little bit harder to allocate an empty sheaf, instead of making
intrusive changes to the existing kvfree_rcu batching logic.

kfree_rcu_nolock() tries to free the object to the rcu sheaf if
trylock succeeds. Once the rcu sheaf becomes full, it is submitted to
RCU via call_rcu() if spinning is allowed or IRQs are enabled (to avoid
calling call_rcu() in the middle of call_rcu()). Otherwise, call_rcu()
is deferred via irq work.

In unknown context, when there is no sheaf available, kfree_rcu_sheaf()
falls back to defer_kfree_rcu(), which inserts the object to a global
lockless list [5] and those objects are freed after synchronize_rcu() in
a workqueue.

Unlike kfree_rcu(), only the 2-argument variant is supported.
This is because the last resort of the 1-arg variant is
synchronize_rcu(), which cannot be used in an unknown context.

As suggested by Alexei Starovoitov, kfree_rcu_nolock() can be used with
struct kfree_rcu_head (8 bytes), which is smaller than struct rcu_head
(16 bytes).

For more background and future plans, please see [4].

[1] RFC v1: https://lore.kernel.org/linux-mm/20260206093410.160622-1-harry.yoo@oracle.com

[2] RFC v2: https://lore.kernel.org/linux-mm/20260416091022.36823-1-harry@kernel.org

[3] https://git.kernel.org/pub/scm/linux/kernel/git/harry/linux.git/log/?h=kfree_rcu_nolock-v3r3

[4] kmalloc_nolock() follow-ups, including kfree_rcu_nolock(),
    https://lore.kernel.org/linux-mm/esepccfhqg7m6jo76ns2znj2cnuaepx2xvw5zaygtwohq4psma@563ypprp6rr3

[5] However, we should probably make the list percpu because,
    unlike RFC v2, it can be triggered more frequently under memory
    pressure.

    https://lore.kernel.org/linux-mm/805c33d7-3a7b-470c-bd9d-065717a3e3e2@paulmck-laptop

Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
Harry Yoo (Oracle) (9):
      slub_kunit: fall back to SW perf events when HW PMU is not available
      mm/slab, slub_kunit: register kprobe to trigger _nolock APIs
      mm/slab: handle the !allow_spin case in kfree_rcu_sheaf()
      mm/slab: use call_rcu() in unknown context if irqs are enabled
      mm/slab: extend deferred free mechanism to handle rcu sheaves
      mm/slab: allow kfree_rcu_sheaf() on PREEMPT_RT
      mm/slab: introduce kfree_rcu_nolock()
      mm/slab: introduce struct kfree_rcu_head and use in kfree_rcu_nolock()
      slub_kunit: extend the test for kfree_rcu_nolock()

 include/linux/rcupdate.h |  12 +++
 include/linux/types.h    |   4 +
 lib/tests/slub_kunit.c   | 174 ++++++++++++++++++++++++++++------
 mm/slab.h                |   5 +-
 mm/slab_common.c         |  38 ++++++--
 mm/slub.c                | 242 ++++++++++++++++++++++++++++++++++-------------
 6 files changed, 370 insertions(+), 105 deletions(-)
---
base-commit: c425609d6ac4012c8bbf01ec2e10e801b1923a7b
change-id: 20260615-kfree_rcu_nolock-e5502555992f

Best regards,
-- 
Harry Yoo (Oracle) <harry@kernel.org>

