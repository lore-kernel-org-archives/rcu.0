Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE4D3264E7;
	Sat, 19 Sep 2026 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778145; cv=none; b=Me4JgBLd0exFmYFp6n3kFNjkqOLEhfidZBp0OSMCYx90aW5tzY6Q65JazIbPuHIVZNzi8UEiiy0t2DI8ghZ8AlbZgxJNHH9RIeyMOVOgejAFofuJ0W8j1kWPzT3ecaUlrkHY6SSplqbe9ytrVP3OrU/sXqtZs2cXbfpxnTX4caI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778145; c=relaxed/simple;
	bh=c9E8tH5R9HbNPPHdaaaaSMdtH6Y8EMOVh2jZFXNMRQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ReFmYw4Fz3b38Y0MtlarnwL0TbsDR0ze81jhgwypb7W3MP46j9uEhL/WtRte18rnOHcgKM0c6OEWSigH9ewvj485xx5KGyiGmA6DaysL3blp3qVXsVq2P71CMHO1bTapA6YV8SIJSQfGesNZAFq42awtUNmsKKGD9X5J98mWytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy+toS/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy+toS/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F831F0089C;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=eY8eG/QzPAhUFqZzuOCdoIEzx1oXNmMLb0cl9ZcnNZk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zy+toS/i4zmH2XkqQDzor/oGQtOnPdAWYPi4VX2wNo1sJZsR6FM3JolNi/Vfgw4C0
	 if2XDZpg0KMrpD5x/0SYx1ZhlcCbBZHlFJT5DaF//YSGnwi/gwz0KS8bCqSK9EcYJ+
	 /U/VhEoF4k8I3VGX3CPc1R03DyXYSVxLDCfuTxJywt/8KNjM3XSNyEGWkD6HsCQRlr
	 6csKTMKcoWPO48V20b73A/EJ5LT+WJkG2efcPnGZoch8lnRG6qPqhpCorqEam07Cey
	 lhBEWCu/0YTPPcvIQb8Q1huCKUs5ZIj19A/uyo00VW8XYKAKoIt3IaLYdIKQPBcrHs
	 T7OhbcQAc7Ftg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C002FCE1DD2; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH 18/19] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
Date: Fri, 18 Sep 2026 17:35:20 -0700
Message-Id: <20260919003521.3134552-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Atomic SRCU must remain in the small size state. Warn if this
invariant is violated and avoid transitioning to big in that case.

[ paulmck: Folded "if" onto one line for 100-character limit. ]

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 4e9a0b8ea344..6a05bd8a6f39 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1073,8 +1073,10 @@ static void srcu_gp_end(struct srcu_struct *ssp, bool is_atomic)
 		raw_spin_unlock_irq_rcu_node(sup);
 	}
 
-	/* Transition to big if needed. */
-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
+	/* Transition to big if needed, but never for atomic SRCU. */
+	if (ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC && ss_state != SRCU_SIZE_SMALL) {
+		WARN_ON_ONCE(1);
+	} else if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
 		if (ss_state == SRCU_SIZE_ALLOC)
 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
-- 
2.40.1

