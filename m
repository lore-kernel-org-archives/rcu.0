Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59914AD2B;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057945; cv=none; b=VBjbTwPEg/sSwH4DHUsYh0PbqpZqtyorPw0zGw70xlod8pS2XeEl3HCGXUnWs69hbmrQ5VKd6vfqLRmS/JVscY5Wknu0Iw7wbWgr2LL3F6/xPkBrcuIIvYp+ji3yIleblqaGISICalFJ+6afmjO7AhXPYTJQT7thGb3HyV/COaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057945; c=relaxed/simple;
	bh=NP/CK3qlbbTrzpBV1+3fFxhbMdYgJcUACRadRqSIOlU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=it+/WIMTxIR/Ia6UDCm5YBZSka0UUbgKjKL85E7/k+l8HdBTrDWyl1Aasj8gLdfbsI4iCTDN+hda2VZBrvDGR+B/VSCDecQgXcpmipOoTh60rLXmVg9JPeBiIpG888wrbz1h2GXMW35enbZqsh0oH3WP7KAxXH7kuAHqQKl056E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foXRttxb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foXRttxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7199CC4CEE6;
	Thu, 16 Jan 2025 20:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057945;
	bh=NP/CK3qlbbTrzpBV1+3fFxhbMdYgJcUACRadRqSIOlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foXRttxbGiSK8jAUDaijACmdlwrAwCe1qQ/OZkefWBPlanZgtZYE0SyNObw+JTPks
	 XMNzeRXcGt/4/2zGdJkoiN/5d+WUzVAlBhbXKm5v2JKmbcv4rxkDb5CoWb/CLKe6Xl
	 GzapcHq/F1NppAaEA1X5BgTxW5ebO6/BNAidJ/vRzgDEPp1flS6k9XGX4uQiBA4xIU
	 0QHvgpXjpTMx7G0XE5d9MBjMLQnwV8aR3ZFS72Itn8O++QRmVowbfP78+Sf6G45M2u
	 L2o42QfTh67lazQcH6VDlGyhwGE/N44I3j2vxw/fRRqH5hCUSFzevKw892DNxMUARw
	 Sfd/+ymlhmhdg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0C072CE37C1; Thu, 16 Jan 2025 12:05:45 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] rcu/nocb: Print segment lengths in show_rcu_nocb_gp_state()
Date: Thu, 16 Jan 2025 12:05:43 -0800
Message-Id: <20250116200543.3782539-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
References: <7b24a850-7d56-4386-8544-be5e643b6b9f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analysis of an rcutorture callback-based forward-progress test failure was
hampered by the lack of ->cblist segment lengths.  This commit therefore
adds this information, so that what would have been ".W85620.N." (there
are some callbacks waiting for grace period sequence number 85620 and
some number more that have not yet been assigned to a grace period)
now prints as ".W2(85620).N6." (there are 2 callbacks waiting for grace
period 85620 and 6 not yet assigned to a grace period).  Note that
"D" (done), "N" (next and not yet assigned to a grace period, and "B"
(bypass, also not yet assigned to a grace period) have just the number
of callbacks without the parenthesized grace-period sequence number.

In contrast, "W" (waiting for the current grace period) and "R" (ready
to wait for the next grace period to start) both have parenthesized
grace-period sequence numbers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 2605dd234a13c..5ff3bc56ff515 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1557,8 +1557,11 @@ static void show_rcu_nocb_gp_state(struct rcu_data *rdp)
 /* Dump out nocb kthread state for the specified rcu_data structure. */
 static void show_rcu_nocb_state(struct rcu_data *rdp)
 {
-	char bufw[20];
-	char bufr[20];
+	char bufd[22];
+	char bufw[45];
+	char bufr[45];
+	char bufn[22];
+	char bufb[22];
 	struct rcu_data *nocb_next_rdp;
 	struct rcu_segcblist *rsclp = &rdp->cblist;
 	bool waslocked;
@@ -1572,9 +1575,13 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 					      typeof(*rdp),
 					      nocb_entry_rdp);
 
-	sprintf(bufw, "%ld", rsclp->gp_seq[RCU_WAIT_TAIL]);
-	sprintf(bufr, "%ld", rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
-	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%c%s%c%s%c%c q%ld %c CPU %d%s\n",
+	sprintf(bufd, "%ld", rsclp->seglen[RCU_DONE_TAIL]);
+	sprintf(bufw, "%ld(%ld)", rsclp->seglen[RCU_WAIT_TAIL], rsclp->gp_seq[RCU_WAIT_TAIL]);
+	sprintf(bufr, "%ld(%ld)", rsclp->seglen[RCU_NEXT_READY_TAIL],
+		      rsclp->gp_seq[RCU_NEXT_READY_TAIL]);
+	sprintf(bufn, "%ld", rsclp->seglen[RCU_NEXT_TAIL]);
+	sprintf(bufb, "%ld", rcu_cblist_n_cbs(&rdp->nocb_bypass));
+	pr_info("   CB %d^%d->%d %c%c%c%c%c F%ld L%ld C%d %c%s%c%s%c%s%c%s%c%s q%ld %c CPU %d%s\n",
 		rdp->cpu, rdp->nocb_gp_rdp->cpu,
 		nocb_next_rdp ? nocb_next_rdp->cpu : -1,
 		"kK"[!!rdp->nocb_cb_kthread],
@@ -1586,12 +1593,15 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
 		jiffies - rdp->nocb_nobypass_last,
 		rdp->nocb_nobypass_count,
 		".D"[rcu_segcblist_ready_cbs(rsclp)],
+		rcu_segcblist_segempty(rsclp, RCU_DONE_TAIL) ? "" : bufd,
 		".W"[!rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL)],
 		rcu_segcblist_segempty(rsclp, RCU_WAIT_TAIL) ? "" : bufw,
 		".R"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL)],
 		rcu_segcblist_segempty(rsclp, RCU_NEXT_READY_TAIL) ? "" : bufr,
 		".N"[!rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL)],
+		rcu_segcblist_segempty(rsclp, RCU_NEXT_TAIL) ? "" : bufn,
 		".B"[!!rcu_cblist_n_cbs(&rdp->nocb_bypass)],
+		!rcu_cblist_n_cbs(&rdp->nocb_bypass) ? "" : bufb,
 		rcu_segcblist_n_cbs(&rdp->cblist),
 		rdp->nocb_cb_kthread ? task_state_to_char(rdp->nocb_cb_kthread) : '.',
 		rdp->nocb_cb_kthread ? (int)task_cpu(rdp->nocb_cb_kthread) : -1,
-- 
2.40.1

