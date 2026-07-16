Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7631DF980;
	Thu, 16 Jul 2026 00:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784161095; cv=none; b=Ik1WsGtU2RqUDuFIKsHt8UR/kUufBlVwjB0a91gztyI+W+7eh259GAz347p4dKCJDIGyiZ5hS2VVoLniNSFV99gmfKghCmX3CGjzUG2KUzWsKNqt53GnEQfltqF2lf8obr8/4nemoWvJWVSup9OruCUxgr3L3MrvJd89o54NMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784161095; c=relaxed/simple;
	bh=KCTqDcoSNBl3bpRi6VKE0ye3sMYgJQD/SmQAZWZocO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jV5UIJmrXnCvDC+9bRzSMP4+DfCpH2sjBnrv9GniL1CzzYLlTwC+gRKdNADOtmDpQxNc4rWaGudLhWswuQiVIVBMy1+fPBSwgU2/VQQYEb6oSYN9viBLkkpvVgBLYiQM10JKQapW54UBPJ/nSbSTXFAg3S4nJ4XsoO/2jTkx9zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkR4nF2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkR4nF2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0F11F0155B;
	Thu, 16 Jul 2026 00:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784161091;
	bh=OrmEDktF9ULNSe1gracoYBb5VOuwxPcRL2J82R2YnPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TkR4nF2JBXmEn4tOoSVvnT0SA7ey+cZevvJyRSZdvrJzaEHCbNDwiNCUvKrqU6T1y
	 El70jAiQK9/33ElHZk9jX3ZIJzUrQ1BNYh1WC/zKjx58E7sZ2P4g1yhLw+X8LiS2i2
	 JT5hG3ht2noLiRrscSC3opBFkmJjBvGTaqiCrAURcB5quoY0/tV5/v/KCw6kuQC9Da
	 y7lzncT70jH9N5GX7uAlUUBA3vgg+6+QAhMyO+Z3jPYKoN7JXrNY4wdvCi6+0OFOC1
	 4WiPHUO5Hqxnx9mrqzHN8ZuiPmOKXtCgof9Hf38rcxP5fTOmRxiL7JlMIETw0MxYA4
	 TKmxbZHGRy2Sg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 36F0CCE0E2A; Wed, 15 Jul 2026 17:18:11 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC v2 08/24] hazptrtorture: Use mnemonic local variables for context information
Date: Wed, 15 Jul 2026 17:17:53 -0700
Message-Id: <20260716001809.11084-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
References: <23e34c2e-67fd-45da-b130-e70a131a59ea@paulmck-laptop>
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
---
 kernel/rcu/hazptrtorture.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 21a72667554fe0..adaf250ecfd585 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -204,23 +204,25 @@ static struct hazptr_torture *hazptr_torture_read_lock(struct hazptr_ctx **hcpp)
 
 static void hazptr_read_delay(struct torture_random_state *rrsp)
 {
+	const bool can_sleep = !preempt_count() && !irqs_disabled();
 	const unsigned long shortdelay_us = 200;
 	unsigned long longdelay_ms = 300;
+	const bool short_spin = irqs_disabled() || irq_count();
 
 	/* We want a short delay sometimes to make a reader delay the grace
 	 * period, and we want a long delay occasionally to trigger
 	 * force_quiescent_state. */
 
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

