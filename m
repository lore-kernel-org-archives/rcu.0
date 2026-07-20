Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91AA3D7A16;
	Mon, 20 Jul 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784551546; cv=none; b=ddWnwzX+L6WIjCnUPuvIw0tM233oObCsrI7iS1jlJnvOGmuoLFXdZE4tzYF5U/10UETphnA+MuhnEj7D38g1CIyUand4QS5hvcLXQDQJofJIR9zFqKPG0TB0+GwAih098Xgd4exROzSSLWMxSYyrNkNpcl4m10TU/1AT5+5uePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784551546; c=relaxed/simple;
	bh=gBca40z1NbOcdl7POOTl1q4QE43EIoZSZD2kATW63Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hO72aXjVyuRQNjd9vdGnSH16TU0wJkKfdhvoxUnUZK90g/+12O+DlOx9YRXRcLXEb5YLLAN5LH6uy0kZNFLiexjasrBcqKxgWKd/hremURDqtzhL4SEL+nKMEP/rEaiEK9p/3TLs1DxfQYp1lcJZq+MdtGCkVWoo17I8b9p7Mx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSe/I62a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSe/I62a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0951F000E9;
	Mon, 20 Jul 2026 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784551545;
	bh=gEdEptG0SQeRDcDet0HzsJ7ij1w4V3/phd6b9zQynDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JSe/I62a0Ly9w+RpYYJBwxSnl/fcB1i1i+ovbkac+K7zljbU1l40+93Xs9ETK/nQY
	 0ye6HHrTCwU0wr71HfK6CPqwYFw5hQcIAa8Hk2ae518qQl1QP8z41Q+RLWh1ObU537
	 AkAWqNhBPp5ZLV4OZqBzUvCG6IrpXb1HT8FxcEjKLsSKB1Gl3H8hKaMMhFtK7fJTIT
	 m2XTAQcrOLOAMCRT4Rtzt9qqMI23AtvrfVJFv1nbI5R9WwrA8WwX+rc1Ar2VkE2OhC
	 jCQXx9oE+gwDRDAQXiqlXkuhvihklWv0jIwGHvHR0E27/VlTC1rb7m2/ZdGQs2P9hS
	 KYY9IVpgfF00Q==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 20 Jul 2026 21:44:32 +0900
Subject: [PATCH slab/for-next v4 3/8] mm/slab: use call_rcu() in unknown
 context if irqs are enabled
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-kfree_rcu_nolock-v4-3-964e03c41a4e@kernel.org>
References: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
In-Reply-To: <20260720-kfree_rcu_nolock-v4-0-964e03c41a4e@kernel.org>
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
index 0c350274fbff..680fe64aff72 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6136,8 +6136,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, unsigned int free_flags)
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

