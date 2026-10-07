Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B30841D11A;
	Wed,  7 Oct 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406771; cv=none; b=VpBC/GEY+wNGFZ/1JIlWGok364ZCYiVUEbwqNum4j0Me3RuHWCb+Kqi1kPsA7lvcQOPEPlejxB7ijU58trwtjlg5VgYtg+1gf0AfrKUTh5gPkeh8eVSzqDNsKl7nVXG++pFuCWro9hMyo9PPWLQllUtyVY8VNmKynDyFhFxmCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406771; c=relaxed/simple;
	bh=5HUROkvlrWpLCJQ3KhsvTq3HpcOeR4SevkRqSsqGOEs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rTmLKfLEr9mWVwbWXSRk/b326L4NExLQPCB7k5lZ+zAb/ycIottWVrAdZoZsgECVlbi0OQVKl24Voa23FyurzFl36+ViDVkjDq0c/NebQLrJyUH9lXOpv2pjDe2EBcSsn0JDoMEmFvh8t6FdxfgEM4DBz+e4njyJJQWIKOO/+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oorH6LNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oorH6LNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA7C1F008BF;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406766;
	bh=vRmdc37gkRMdv0yt2vCrcCm2+Z/3sqNHXoVXxtTyUCI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oorH6LNGgzuoo+pGnRLHK2Kcbq/Dx5MVunYHamr3Dnk/ArEa5yiBJhlo1ywq7zsPL
	 rV3vCQm1GJTOtzLVqjBjW1NCinOMF3Jv6SW/4Zu6P3VsvefZsd4zz5sr1BlXt7Fd4S
	 4zop4SdKXDguTmJwbOrD3gMMhdZN4KKv3/QrdpTJ4O/ucq9WEtm3XDanP+xBZq0h/j
	 wuZRCgOKdvcRo1tN3NI0HHpdB5YplL1fMcFhyrF0f1gLOOaAujjbnDzPl7Ecuej3h8
	 jWQCPeQdCVwJWlyGVOALScTCe8NMvBvHVIUTCoMIVv7DUCcK2Otm0GEe0fiqBNZgsG
	 HMzRkWQe5VqGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AB82CE3995; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v2 17/21] srcutree: Don't transition atomic SRCU to big in srcu_gp_end()
Date: Wed,  7 Oct 2026 13:59:20 -0700
Message-Id: <20261007205924.1983367-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
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
index 4e9a0b8ea3449..6a05bd8a6f390 100644
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

