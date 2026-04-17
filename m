Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F33199D8;
	Fri, 17 Apr 2026 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467583; cv=none; b=n2UgRByVtG2sCN0jTZKFqKZqucGwfosmPtwckajqSkTJreptNMNh0mA+nfpouw6JB0xdByvTcMMnClsj+0vAPoB1I2snqkIaa+6T8lRh3fZG6yOmvAS+Vo5gCATGjOXkza50NdBC7v+iH/MpuUYTHhjbMYCVS6erhobb8s/56Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467583; c=relaxed/simple;
	bh=8ixe/3/zGAF570L53VBz6mu9l7AOdT6UgUvfFbLI0Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avM0wHrdOauK9i1W9jnK64cRXrszWpHyKjgXoQMXBfE+22HHJEn7pGflRL0k4T3hPtfNxpNRjF8FZrlwlHAbkgJMLbWQXAnwT/U2HykRlxp1QEdywbdDPOZkax1D831y06znCfpbZJhEkblVUkKJ9m+RMQMG1CtuZQgeq+c0Nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF9ouTbt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF9ouTbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73254C2BCB5;
	Fri, 17 Apr 2026 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776467582;
	bh=8ixe/3/zGAF570L53VBz6mu9l7AOdT6UgUvfFbLI0Yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KF9ouTbtZT3ST3tg47dzBqPCJdWtY72D5xhfI5auKqatcRbqngvNdkPfmqJigQHBs
	 UUR/DC7nXXXbQQS4ytlFM8pz2oZUMi8V+xwx3oVF85MBvZJXRTMTTSICXbCJX2ePqz
	 GfTMgle+ebgkXJi0V1eGjx01PGKifF/TybgXhN0ocmYtEvtmRJgxvsDSPFsJc4uZYP
	 BgfR//1mnMO9tryNJrCJSvWXGaynY+N/ZZgGswBlGsxkbze6jLihf4bWiixqzpRyMX
	 CDMK/GmysJyLm1Dyz6IbFqdPwmjEqrWcPQ1kUkY4aamY/Q04UmrfyXznpN4JOHhVCn
	 AYJ8Uyv/OkHww==
From: Puranjay Mohan <puranjay@kernel.org>
To: rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [RFC PATCH 08/10] rcu: Detect expedited grace period completion in rcu_pending()
Date: Fri, 17 Apr 2026 16:11:56 -0700
Message-ID: <20260417231203.785172-9-puranjay@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417231203.785172-1-puranjay@kernel.org>
References: <20260417231203.785172-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcu_pending() is the gatekeeper that decides whether rcu_core() should
run on the current CPU's timer tick. Currently it checks if the CPU has
callbacks ready to invoke or a grace period has completed or started.

It does not check that an expedited GP has completed. After an expedited
GP, callbacks remain in RCU_WAIT_TAIL (not yet advanced to
RCU_DONE_TAIL) and So rcu_core() never runs to advance them.

Add a check using rcu_segcblist_nextgp() combined with
poll_state_synchronize_rcu_full() to detect when any pending callbacks'
grace period has completed.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
---
 kernel/rcu/tree.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0e43866dc4cd..309273a37b0a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3671,6 +3671,7 @@ EXPORT_SYMBOL_GPL(cond_synchronize_rcu_full);
 static int rcu_pending(int user)
 {
 	bool gp_in_progress;
+	struct rcu_gp_oldstate gp_state;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -3701,6 +3702,12 @@ static int rcu_pending(int user)
 	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
+	/* Has a GP (normal or expedited) completed for pending callbacks? */
+	if (!rcu_rdp_is_offloaded(rdp) &&
+	    rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
+	    poll_state_synchronize_rcu_full(&gp_state))
+		return 1;
+
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    !rcu_rdp_is_offloaded(rdp) &&
-- 
2.52.0

