Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F62E1F0E;
	Sat, 19 Sep 2026 00:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776062; cv=none; b=TukRogRPpIrdPuRzsd+HDc1mmXmyi+ajxC0vYTw3A3kvN/2gZo/FAJLyEZOe+rTKaZOZ3FQf9yFsnTJwXH+NMCtc/ytP754D0GA3an+biZ68ReYMOEiFaSUNse91+xgcYYbwciq16tdaX0u5EJ7ToCEYCYFPPR3jMrObhTgYsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776062; c=relaxed/simple;
	bh=wTqnzWv4HcmzQNu1Ciof+W30xKQFFl3O6JrB+4Yt/Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V38y+rw9KQvLVpjUmBTkLeLkVI2GQfauaSaClvC121gtyF+bvDK0gtfn+upQASXkCSz7YjIibwtKaFej/qlpsfGUrIqshxYGOrAZLO4VFjAv5AHYwwWgYAqfLAttq7SEIgFjYoQ454CDOCLlmP4arbAQ5Guj+lOxmsrT+jmUHIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXR7IHKM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXR7IHKM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4ED1F008A2;
	Sat, 19 Sep 2026 00:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789776059;
	bh=ZlY1fRfzlngUScnswdrpmctWm7EvrHXSppPy3a62Huw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PXR7IHKMG8PWoy95xLvpoBCO9oPsojUOx4nGTUpf5U96LLoMWwI/1oLWQlm89+DqH
	 DtTjbNhLT6RYSn2Q6WuuRuNv0lvuVLFepOOEVKuJcHsWm3Mz+6hp5X8vuQzCbmsSAl
	 4yoPCN8LZtg7l5eUw+/vRXJ6GpIwk2sPTqiPcP4gZptQnoKaaG3Ufi78yDKGtq3UiP
	 CdtAdkQNezrdXBJLJDrIloRfKQnkRI2rsJLikuEwTHfhQYqx4zknrb0mAlyFbBIVEa
	 5P+1eZzmCHOigeVS4w0Lp1Y+P4LpVLrAt5jIXREBwcDCs/0kt4Xg200Th8UK638VQJ
	 eQUjyN1gNyjjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60459CE0AC0; Fri, 18 Sep 2026 17:00:59 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Boqun Feng <boqun@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	lkmm@lists.linux.dev,
	Zqiang <qiang.zhang@linux.dev>,
	Wang Lian <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Bradley Morgan <brads@mainlining.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 08/28] hazptrtorture: Use mnemonic local variables for context information
Date: Fri, 18 Sep 2026 17:00:36 -0700
Message-Id: <20260919000056.3132131-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
References: <e9669b34-12c2-4cf2-a887-315f581f0789@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces can_sleep and short_spin local variables to
hazptr_read_delay(). The can_sleep variable records whether unconstrained
sleeping is feasible, and the short_spin variable checks for the NMI
handlers, IRQ handlers, or disabled interrupts/softirqs suggesting short
spin times.  While in the area, it disables the reader_sleep_us module
parameter when invoked where sleeping is not permitted.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: <rcu@vger.kernel.org>
Cc: <lkmm@lists.linux.dev>
---
 kernel/rcu/hazptrtorture.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index e9ba25f156ac..c0ebabdcc72e 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -204,23 +204,25 @@ static struct hazptr_torture *hazptr_torture_read_lock(struct hazptr_ctx **hcpp)
 
 static void hazptr_read_delay(struct torture_random_state *rrsp)
 {
+	const bool can_sleep = !preempt_count() && !irqs_disabled();
 	const unsigned long shortdelay_us = 200;
 	unsigned long longdelay_ms = 300;
+	const bool short_spin = irqs_disabled() || irq_count();
 
 	 // We want a short delay sometimes to make a reader delay the grace
 	 // period, and we want a long delay occasionally to trigger
 	 // force_quiescent_state.
 
 	if (!(torture_random(rrsp) % (nrealreaders * 2000 * longdelay_ms))) {
-		if ((preempt_count() & HARDIRQ_MASK) || softirq_count())
+		if (short_spin)
 			longdelay_ms = 5; /* Avoid triggering BH limits. */
 		mdelay(longdelay_ms);
 	}
 	if (!(torture_random(rrsp) % (nrealreaders * 2 * shortdelay_us)))
 		udelay(shortdelay_us);
-	if (!preempt_count() && !(torture_random(rrsp) % (nrealreaders * 500)))
+	if (can_sleep && !(torture_random(rrsp) % (nrealreaders * 500)))
 		torture_preempt_schedule();  /* QS only if preemptible. */
-	if (reader_sleep_us > 0)
+	if (can_sleep && reader_sleep_us > 0)
 		torture_hrtimeout_us(reader_sleep_us, 0, NULL);
 }
 
-- 
2.40.1

