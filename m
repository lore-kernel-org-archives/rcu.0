Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2824E1442FE;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=XKFCA6rbRB2koH6BuOI/543T7AnC/heUbWV1qKh9/0EPt3ibiu4CFp+MfBVx2sexYxYB9HUeF0zHt5uZPOQLf73101Vj7mraknqgVd8B/2CfVBRAW6HUna4atxcoslS1+ehAW54HmJykvJ0b3Ezt+w77eOCDFcJPePTILtBR2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=cSJFd+VMxpJPGTTylKf3LUw/sJdSsIpeVfT0Z+nfmlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ANlO6qIAJpy6wZ13c9FITFqbqm8TmtTe7qlADWxZQgHzcchr6F6ntW2kuPgvLhya9MNY4whTby6ggjGn/9Gg9IAdLg1Bc0bYiRETNpribNqSZl4oNbMOPrfX3h5/9m6LGY9wHbIupt7tZPfKt0PJCHm6vZWankGWRkOir8Mzu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTjPybFM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTjPybFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C839CC4AF07;
	Tue,  4 Jun 2024 22:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539836;
	bh=cSJFd+VMxpJPGTTylKf3LUw/sJdSsIpeVfT0Z+nfmlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oTjPybFMsz8Iy9BYREe5CNlP0iHsbid6J1MzhckH7NnNXuNvG6DPvUuph59muncRX
	 aMQ8w9r+pdiHW8iKsY696KjC8anAhA7x1FX0KSBTxvyOYqALJboSydbDNUsoJ14MLG
	 qhmnwKY0IeiKWPiLQPDePHvhRVZaeiT+YmFGit2EGUpjukN1LvmdCWBTbqULDxFACy
	 7v5oA9ZqAUVFIryEc41YIn4bdMkYwTXr8kt1xoRpHnCvk63CNEO8FN8OUpWwSUmy6y
	 BPTVWwxl45PCDYEu7ptZk/fXslfM6M9GwrO1ei3BCxpo7XCshNvMRHYTo2nqUG1xmP
	 zslkg7oXr3iaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 61E6BCE3F27; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH rcu 4/9] rcu: Disable interrupts directly in rcu_gp_init()
Date: Tue,  4 Jun 2024 15:23:50 -0700
Message-Id: <20240604222355.2370768-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupts are enabled in rcu_gp_init(), so this commit switches from
local_irq_save() and local_irq_restore() to local_irq_disable() and
local_irq_enable().

Link: https://lore.kernel.org/all/febb13ab-a4bb-48b4-8e97-7e9f7749e6da@moroto.mountain/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2fe08e6186b4d..35bf4a3736765 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1841,7 +1841,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 	WRITE_ONCE(rcu_state.gp_state, RCU_GP_ONOFF);
 	/* Exclude CPU hotplug operations. */
 	rcu_for_each_leaf_node(rnp) {
-		local_irq_save(flags);
+		local_irq_disable();
 		arch_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1849,7 +1849,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_rcu_node(rnp);
 			arch_spin_unlock(&rcu_state.ofl_lock);
-			local_irq_restore(flags);
+			local_irq_enable();
 			continue;
 		}
 
@@ -1886,7 +1886,7 @@ static noinline_for_stack bool rcu_gp_init(void)
 
 		raw_spin_unlock_rcu_node(rnp);
 		arch_spin_unlock(&rcu_state.ofl_lock);
-		local_irq_restore(flags);
+		local_irq_enable();
 	}
 	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
-- 
2.40.1

