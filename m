Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579783E2AAF;
	Mon, 15 Jun 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521609; cv=none; b=c2+rLIcsZwAxABsGZGVE0zeRlUnFsqTI7KGszufwK+h7spzoaDxFRm7N7oG8vF0689Jb5VDvdJCUZl80nQ9Uv5X2vmwqrLcgQQRYTUzETSYcH6Qij4sbIiGNNpdu8u1XemsouX1dljPm7QaYdk6sNkiqA65h9DwapzZD27z2w/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521609; c=relaxed/simple;
	bh=b8GfsoxXAN1KbOMWtVHu3iw+OYtJJvEWu9RRBUjFjDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHHz8xvFpT4JqCQRSH07BBEc/3/BgenNU9ife3hStCRBtN0CHbAR5uHWf1dL3jtMAv3dLDcJ2z3lOrB/sprVB13UjtS7wqH6rhGlA3uPpzuk2QqcFf3H7/K4uoalaIJ9noXZSRUf+FnFyTju+CFJXVsP9VSFx72l0JC0frSUaks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOT7vJvY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOT7vJvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3541F000E9;
	Mon, 15 Jun 2026 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521608;
	bh=ZZ9OnjoQYtwIavekQOvzh5VlfzmJMinYHMm7ngBNx/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bOT7vJvYvvvQ4nZJ+Nn5/kJkUg/eOns2vWRX8geyKPAyFmNbbxyVVxqBbh4arRI6V
	 +g19CUu01CAPI/XVY7hpTKu/JAvArg/8bFj++Q7CYDdDUJ0edxgs/z1jW5T8R/eohS
	 0MZ+Q3asUJAHCZoF6Ho3qGfDEz0Ldd48u0KWRsn8Cfuwpej32CoMRsiEsYap0RDMsR
	 qRxvfPmnu3UuTRYKR7P5VWPJmk6SVd1rGMzjFDFWVbOn8bm+w3BGsIDR9+UaVoy62r
	 FgN8nK0QZdlBaeVFnHPNJwZHxaAlMeP1LHzbHYoDgOGiAmaZiDMGhmL4o3HxF+R+kx
	 AY2J7hXOS7VAQ==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Date: Mon, 15 Jun 2026 20:05:58 +0900
Subject: [PATCH for-next v3 4/9] mm/slab: use call_rcu() in unknown context
 if irqs are enabled
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-kfree_rcu_nolock-v3-4-70a54f3775bb@kernel.org>
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
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
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b0d38d515386..6a3552b70683 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6158,8 +6158,8 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj, bool allow_spin)
 	if (likely(rcu_sheaf->size < s->sheaf_capacity)) {
 		rcu_sheaf = NULL;
 	} else {
-		if (unlikely(!allow_spin)) {
-			/* call_rcu() cannot be called in an unknown context */
+		/* call_rcu() disables IRQs to protect percpu data structures */
+		if (unlikely(!allow_spin && irqs_disabled())) {
 			rcu_sheaf->size--;
 			local_unlock(&s->cpu_sheaves->lock);
 			goto fail;

-- 
2.53.0

