Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AE204F8A;
	Tue, 18 Mar 2025 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742289828; cv=none; b=jKxQGSyfUUebP4IsLATKOEkAkO+wrmprc+V+2SNQ21Nb6x8pl6jW9Ek6Cm0/j/71r/ICDfjQ7kg3AcXO0GKOpr8pAbSB2i3VMyECcCm1QzDfbNfQejl7ZVnaXXZLSYd0qNlcmBLy+ddwxnBXYPr2E8Pa8BcrcPTJE4WJ5J/aYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742289828; c=relaxed/simple;
	bh=R0M5EAGk8J0hCXZk2/cxpLT8DWi+CNp5aemSvl68gGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH4eJzwpdIoXWoZ0lI42IONS3O3m+JJMJQjXrMCqX4L2RqV7UQjw+Op3im8tIEa39Q07gyaDFJ7ieyfLjgv9oCGBHFe+eu3l3f3PPV+0cYp2wd4GWmG7XBNqhducHm18SCh0bs+iMVkCvdW+H8XACFABX2ihIsityfKBOtiCEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCxrZKWM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCxrZKWM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC20C4CEF0;
	Tue, 18 Mar 2025 09:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742289827;
	bh=R0M5EAGk8J0hCXZk2/cxpLT8DWi+CNp5aemSvl68gGE=;
	h=From:To:Cc:Subject:Date:From;
	b=uCxrZKWMD1RFEREqIqZFcmiVayU/Bw6gNlkQY9GGLH6sr4IPCBwaMqiK66Hg1aRjy
	 2eL1bLrY4X/RtEKjBM31bWyP4kpzOnoetOqGIeZRoX1IawfU1OJ5rNKftvP9jbMBS3
	 5K/DqCZaCSY5cwmyfkGlQUrE3FS6beP8hmYXEAyjySYf6syrgnph3k3kQuMKsUW2SX
	 AjDomyRE+w2qtvGVgDBhHOVHfPpAM9TC/nu8slEVENcaFTr3TmiO+h0QEpA1DrRrbX
	 VmABE1TDIyCQtKTD+OFOb24cLPFvjofV2mvVBidbomnT7usFq8/o9GgeT2keBAmog1
	 UdHj1GM9N6xLA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH] rcu/nocb: Dump gp state even if rdp gp itself is not offloaded
Date: Tue, 18 Mar 2025 10:23:36 +0100
Message-ID: <20250318092336.5794-1-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a stall is detected, the state of each NOCB CPU is dumped along
with the state of each NOCB group. The latter part however is
incidentally ignored if the NOCB group leader happens not to be
offloaded itself.

Fix this to make sure related precious informations aren't lost over
a stall report.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h  | 3 +++
 kernel/rcu/tree_stall.h | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 4a954ecf1c36..56baa78c6e85 100644
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
index 56b21219442b..f96235d51642 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -927,8 +927,7 @@ void show_rcu_gp_kthreads(void)
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
2.48.1

