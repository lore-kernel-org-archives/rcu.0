Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E31898F2;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263202; cv=none; b=R8sTJwUnOSt1AS5IV8hRIW1CzZD6FflS57sioSywpm1Av9iSelU1L1Sg9v68Jb6Y9hvQCUaZaGQY+e1EcZ31ZTmtWohBugR6TRnb5lN8PibynhKYtVhMSYa6HQ+NCkVbCLzfnih37WLibgx2J0kTbC0oiuaYmAXXzgFd7RlHkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263202; c=relaxed/simple;
	bh=CqdIBDcqmCGr7hPiub0NBtmuCwzg+LOkL1Xy6BZg1xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TlWdrA2K192wnKXvW1hUbyHA88IiXduGvhuRX7R1WhsosPy4sFAEZkDyBwX+GZc771+5pgO9pivj7ne4eARNJ1/HVStg17DMaJbZDuqQKUanVGSIwcaN0fRHXXus6KUSDm6aTXChhEnU6boCTJMrv1JA6M/YBdxmuAPXZFzoPgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk4JTbpv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk4JTbpv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D22C4CEE5;
	Thu, 30 Jan 2025 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263202;
	bh=CqdIBDcqmCGr7hPiub0NBtmuCwzg+LOkL1Xy6BZg1xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pk4JTbpvfW8kqwYFZ+rY/16yHmtjxy69r6SSQjOHOevs5oNKWSSygOnm11aI0enug
	 bCBb2+CvumH1JFS/i6zlWuYkHbwePUZMbzjHoVp2ijVpSHukX4pbbprteNjaJvwL6X
	 JuNt+psYmaYXg/9bfKtjzmPmP3oTHT0xos53U59YEo/rH1IiQr3swgfO80JQDieBFE
	 XkmXoYPk82v2Hw6m9rH/kUVG571KoLOmqFXdrZZGdCioK6YXQKGJYp9fgcNWNipViq
	 stnhn6x2pC7Pyri7f37LXnpqs8EbS46STcrBfrvCAs4YHOjJWkGugKsalyzTMGD6WW
	 +X8wamCLNWDWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D807DCE37DF; Thu, 30 Jan 2025 10:53:21 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 5/5] rcu/nocb: Print segment lengths in show_rcu_nocb_gp_state()
Date: Thu, 30 Jan 2025 10:53:20 -0800
Message-Id: <20250130185320.1651910-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
References: <43f70961-1884-42bf-b303-1d33665d99d2@paulmck-laptop>
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
index 2605dd234a13..5ff3bc56ff51 100644
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

