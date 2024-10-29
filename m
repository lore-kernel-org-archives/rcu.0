Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E08821;
	Tue, 29 Oct 2024 00:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730161372; cv=none; b=pyejGLU8ifahzSt7NMfr1ikGsjy3NAdj1oY3Oh0R9bYUfIjPURM4t8K15ePmGdwXB/zGeR1u00moc+FKzmvbMgngAUrJhVyyRKVqqpy0j6x5/IKzYxTL8MZsaZBI4GWi0YoXkQok13EUW8S6wOckFiziDeAp3cx+DqFFy1jeSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730161372; c=relaxed/simple;
	bh=sf2DLHnXioeu4dyPF9PAF5U2tKb3PtN/TrKmOh6Kqwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIFUgo/G1gKbGlagdB6T8ZswqEDEgPcyXwVmXH/9XmkcTC56YaCuDZBrk6rVxFLl4eOWd5avDa8+x5uZsUgpV643RTsdXw50M0bBc0YJwib16vvs0kZHLMZ7M4RiIHAmaGPE9PgCoaC2hdbYmPXcISt5sMQPOYDhYjN7zdP+a58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfEwV8Bk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfEwV8Bk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D1C4CEC3;
	Tue, 29 Oct 2024 00:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730161372;
	bh=sf2DLHnXioeu4dyPF9PAF5U2tKb3PtN/TrKmOh6Kqwk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=SfEwV8BkMCBKPnOzYol1SF8qv9pXTNFdGyDnBio7toj0ZGoywjhXSroCaKy/iWLKV
	 Rznk8g2wvy79RjIvD7xMqC4hoj+C6b0d8BB1gQ4Td/Duv+a7e40gTgwZ0KE0XeV2Gw
	 VziFZqysI+2gohmMN3ROmqtjXmBN4DYg1045979Ntt8UHVfqACTiSh7rh2rsnO5Er2
	 cRoqZSYubatitZ15sO8m3WSpEEH6xSw96cotfqJeErlfCPaVFEsiwduYIO1j7OpdpA
	 Ul7cLHQWJMyXLBfW5T0MClw0IP6C9VEvgWnjZk2HcA78yywlCpwnoDGOHFFQWvei79
	 JrbYQT42wK7RQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7EFB2CE0864; Mon, 28 Oct 2024 17:22:51 -0700 (PDT)
Date: Mon, 28 Oct 2024 17:22:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: frederic@kernel.org, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v3 rcu 3/3] rcu: Finer-grained grace-period-end checks in
 rcu_dump_cpu_stacks()
Message-ID: <c3218fbe-7bb1-4fd6-8b00-beee244ffeae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <92193018-8624-495e-a685-320119f78db1@paulmck-laptop>
 <20241016161931.478592-3-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016161931.478592-3-paulmck@kernel.org>

This commit pushes the grace-period-end checks further down into
rcu_dump_cpu_stacks(), and also uses lockless checks coupled with
finer-grained locking.

The result is that the current leaf rcu_node structure's ->lock is
acquired only if a stack backtrace might be needed from the current CPU,
and is held across only that CPU's backtrace.  As a result, if there are
no stalled CPUs associated with a given rcu_node structure, then its
->lock will not be acquired at all.  On large systems, it is usually
(though not always) the case that a small number of CPUs are stalling
the current grace period, which means that the ->lock need be acquired
only for a small fraction of the rcu_node structures.

[ paulmck: Apply Dan Carpenter feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index b530844becf85..925fcdad5dea2 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -342,20 +342,24 @@ static void rcu_dump_cpu_stacks(unsigned long gp_seq)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
-		if (gp_seq != data_race(rcu_state.gp_seq)) {
-			pr_err("INFO: Stall ended during stack backtracing.\n");
-			return;
-		}
 		printk_deferred_enter();
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		for_each_leaf_node_possible_cpu(rnp, cpu)
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			if (gp_seq != data_race(rcu_state.gp_seq)) {
+				printk_deferred_exit();
+				pr_err("INFO: Stall ended during stack backtracing.\n");
+				return;
+			}
+			if (!(data_race(rnp->qsmask) & leaf_node_cpu_bit(rnp, cpu)))
+				continue;
+			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
 				if (cpu_is_offline(cpu))
 					pr_err("Offline CPU %d blocking current GP.\n", cpu);
 				else
 					dump_cpu_task(cpu);
 			}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		}
 		printk_deferred_exit();
 	}
 }
