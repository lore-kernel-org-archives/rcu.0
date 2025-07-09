Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2A2C08AC;
	Wed,  9 Jul 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058021; cv=none; b=GcO2DP6hc7Aktouj9Xgr20NAu3L6bWqEXM6NhCU11wPKI1wJtAsh57gs+CntlW5UTJEkbzAHOdG5Ji73ht14uFQpzp9SfV1J1Z7e76ceQ9/W+n4zO8kCz8Z0FOi+Y0IaiQWhrU4ubGBvB0gBNKiZ3qpg30aAbGoc5Z+OOC23fdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058021; c=relaxed/simple;
	bh=5COjt3uAJjZ1DcFXHjY8wDD+SZYLGK6GkQYggnCf478=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IqvEPk3Hbhz0AyVNAb0U8kFn6XfQcFqRvPfmHGUltI4ROhFuuJYFhQfRPYSyK1P+eGQbOxGkn6bzTTxcXvdwzYW3xG+CI9x6ZX/79heKhW7SXi9DaUXVbu6OWPJMUXAOrjcO0xsYlNDIuiFvH6pblEQPaU+WgN78maD4hMxCFcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlwO7hhf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlwO7hhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB62C4CEEF;
	Wed,  9 Jul 2025 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752058020;
	bh=5COjt3uAJjZ1DcFXHjY8wDD+SZYLGK6GkQYggnCf478=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlwO7hhfXaV1EpMX3AXeLkAZEWLYwCbM2Xo+cgo0D5oY+NsTuNSgp8/dCkncjJAxf
	 gosxNuDaxscnUB2uDw2Nhot5VX5kWfd/XcGNRaa7ERYzKSzSL8LKYeepdSu1rFZh6V
	 SNpmdBBaqcorpaGGaPtdvym6ly6HO92sRVoSQhgH5Iy6yHAxAUWJUccodeBYk2ayqt
	 sIEMxTlqoJbEMEx9RN7Sv8O5CyG2n4M/1BipyoE1ndfBedcIbYTU0UkUSASvGdXqMC
	 8riXaXokyaqDac+uDWazM6lh+cIfN2EAibwzEY40Edx7qNOUd1WAfnePkk0fDMD+BK
	 +htVeXzPZil4g==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 1/2] rcu/nocb: Dump gp state even if rdp gp itself is not offloaded
Date: Wed,  9 Jul 2025 16:16:40 +0530
Message-Id: <20250709104641.15699-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104641.15699-1-neeraj.upadhyay@kernel.org>
References: <20250709104641.15699-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When a stall is detected, the state of each NOCB CPU is dumped along
with the state of each NOCB group. The latter part however is
incidentally ignored if the NOCB group leader happens not to be
offloaded itself.

Fix this to make sure related precious informations aren't lost over
a stall report.

Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_nocb.h  | 3 +++
 kernel/rcu/tree_stall.h | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index b473ff056f49..cb29b6bb0ed4 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1564,6 +1564,9 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 	if (rdp->nocb_gp_rdp == rdp)
 		show_rcu_nocb_gp_state(rdp);
 
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist))
+		return;
+
 	nocb_next_rdp = list_next_or_null_rcu(&rdp->nocb_gp_rdp->nocb_head_rdp,
 					      &rdp->nocb_entry_rdp,
 					      typeof(*rdp),
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 486c00536207..4fa64c959083 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -953,8 +953,7 @@ void show_rcu_gp_kthreads(void)
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		cbs += data_race(READ_ONCE(rdp->n_cbs_invoked));
-		if (rcu_segcblist_is_offloaded(&rdp->cblist))
-			show_rcu_nocb_state(rdp);
+		show_rcu_nocb_state(rdp);
 	}
 	pr_info("RCU callbacks invoked since boot: %lu\n", cbs);
 	show_rcu_tasks_gp_kthreads();
-- 
2.40.1

