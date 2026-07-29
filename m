Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00851EA7DB;
	Wed, 29 Jul 2026 08:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785313281; cv=none; b=Lpy8tsgWtwGYZl94/sMcAG8W02TpQLQOkC0wqdi73u53nYRtnvt85JRRNTLbeEqOpyXTVXCcNXug/7ouSRfwFwNu6uuThMo672ml2BhmOpAAqTyLHnqmva6CHMaVcamTwGNxtVz2dqqOSacA1TqJzJ5qmyqGy4d/3muiR1sAZEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785313281; c=relaxed/simple;
	bh=gE4cqJChHxSD1dC0AYIdXXAiRF2w90QXlzSN2cJfao8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVJxhddb5yd02KEUjxYEa0OLU1BNjHygdMvjsijg1LGWGlTBjw9vxCJFUR9HTYDnVVJHO7LEAfqSnLJ1rQBKNUtQHwmv8nIJ2GUBKpmIbLTbHerXlKgfNmBnv8IKn6fVHukWZPqnP43Ng3P0jOvuxvImVwqiijx7g+mLNOV9rMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuuMECmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuuMECmZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694DA1F000E9;
	Wed, 29 Jul 2026 08:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785313275;
	bh=ePeO/xV71/tQ7SCmp4Ak6LnQ1NWK+HHBAZv1O4FNQqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SuuMECmZ5xpzrc3KetrA48u8o+/4Vz8wZ0RNzb5JNCGJx9YIoNwybXjC1ztkYZpT8
	 58P1ug9lPsrbsZcRVa2JNWIldKHQM9IGHW6zgXJK6GUc2OXx/h3mNhboSaa0TWfX5K
	 O02ePjEI4Emm47SQ+OcpROXnTIawTzf2hiMmjQ0TjCQK6uDVunemV8J8o9a1/nGsia
	 poHCRzuX0LXE3O65gpRS3u4SJyceijqgc3EDHU09ItS2tjhqBdNHRwaJ0JJ+8vAjtg
	 Ns1M9AK9++p4cUiZ2joRBWYfYbNADuEO+J73B+4gif2Lr/jeEH4sEtJLN6HU4Gg0Ge
	 XvQEEin9+l3wg==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Wed, 29 Jul 2026 17:20:11 +0900
Subject: [PATCH v5 3/8] mm/slab: use call_rcu() in unknown context if irqs
 are enabled
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-kfree_rcu_nolock-v5-3-a28cdcda9673@kernel.org>
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

call_rcu() disables IRQs with local_irq_save() to protect its per-cpu
data structures. Therefore, if IRQs are not disabled, they cannot be
corrupted by reentrance into call_rcu(). So fall back to the deferred
path only when !allow_spin && irqs_disabled().

The RCU subsystem does not guarantee this contractually, and this
optimization relies on RCU's implementation details. Ideally, it should
be removed once call_rcu_nolock() is supported by the RCU subsystem.

Link: https://lore.kernel.org/linux-mm/CAADnVQKRVD5ZSnEKbZZU7w86gHbGHUug2pvzpgZTngNS+fg4rw@mail.gmail.com
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
---
 mm/slub.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2c5ba8c326e7..bb0f2975c95b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6157,8 +6157,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
 	} else {
-		if (unlikely(!allow_spin)) {
-			/* call_rcu() cannot be called in an unknown context */
+		/*
+		 * With !allow_spin, we might have interrupted call_rcu()'s
+		 * IRQ-disabled critical section. If IRQs are not disabled,
+		 * we know that's not the case.
+		 */
+		if (unlikely(!allow_spin && irqs_disabled())) {
 			rcu_sheaf->size--;
 			local_unlock(&s->cpu_sheaves->lock);
 			goto fail;

-- 
2.53.0

