Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC214D28E;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717539837; cv=none; b=q5EFIMNJucwSD+VVEBmPloCLIsCLtJbbway3ysqw9SD62rL2iQZy5QdCibv1b52wObXs4cpL4DcaOT6dmts5WvAFgqAdxBViX38agZ+pKtnCZky0ixsuSiC65/7csFHYCesWJOIVEQmQrQ5irLvg7Apv0Jnhog7akfOOi5eDHKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717539837; c=relaxed/simple;
	bh=3cxpJfoy8T/KbD5i0taeL255jR0v95FOadtBWaxfrUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UY605izIvreICRcG8oharWEfuUzZ1fr6Ibetrynuy8XFbnaojK6WQELQ7PSoCfSj1Z52uAxggcNLaHrhpSl+id0x9V3oE6dGowHXUmJ7D8V9Q4+QFz/bzDc1TWnPrMPJ9QO7DHF1hxQ95NeYfNBRTTEmMTjQwIyzl++LsmhTgas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ1l9DSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ1l9DSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E48C4AF12;
	Tue,  4 Jun 2024 22:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717539837;
	bh=3cxpJfoy8T/KbD5i0taeL255jR0v95FOadtBWaxfrUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZ1l9DSbH/RQScpO9KFYfapGQp/GOEMXcSGIh/NWdipN1ejmD3EzK8bvwfQ9aX6pE
	 GCTh1c6SILCZWHSWQQDTEDIkNTFP36HuGJeAApSYDUiRiuL31N90sZT7atwP0E3o5E
	 i/FbeHtk27KBcBLm4rWlOeqUgPLxlVs0DjCQntGLeZG7p5QDuNOJnhf01bZZ9QwlA7
	 3oXNRFkF7dcQoiI92REbWdCYtv3ccFXQszoRmYqC8RG27rbuzsPUzRBL9gDPo7L8RP
	 kADVu5B0IYyeYHlD0UWphkYOUaNklI7MxuTMe/Ik3UZX4BsLV57TVnY6vDa5XPlWbp
	 3Fzu4swDy011g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6C4EFCE3F34; Tue,  4 Jun 2024 15:23:56 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 8/9] rcu: Eliminate lockless accesses to rcu_sync->gp_count
Date: Tue,  4 Jun 2024 15:23:54 -0700
Message-Id: <20240604222355.2370768-8-paulmck@kernel.org>
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

From: Oleg Nesterov <oleg@redhat.com>

The rcu_sync structure's ->gp_count field is always accessed under the
protection of that same structure's ->rss_lock field, with the exception
of a pair of WARN_ON_ONCE() calls just prior to acquiring that lock in
functions rcu_sync_exit() and rcu_sync_dtor().  These lockless accesses
are unnecessary and impair KCSAN's ability to catch bugs that might be
inserted via other lockless accesses.

This commit therefore moves those WARN_ON_ONCE() calls under the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/sync.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 6c2bd9001adcd..da60a9947c005 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		 * we are called at early boot time but this shouldn't happen.
 		 */
 	}
-	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
+	rsp->gp_count++;
 	spin_unlock_irq(&rsp->rss_lock);
 
 	if (gp_state == GP_IDLE) {
@@ -151,15 +151,11 @@ void rcu_sync_enter(struct rcu_sync *rsp)
  */
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
-	int gpc;
-
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
 
 	spin_lock_irq(&rsp->rss_lock);
-	gpc = rsp->gp_count - 1;
-	WRITE_ONCE(rsp->gp_count, gpc);
-	if (!gpc) {
+	WARN_ON_ONCE(rsp->gp_count == 0);
+	if (!--rsp->gp_count) {
 		if (rsp->gp_state == GP_PASSED) {
 			WRITE_ONCE(rsp->gp_state, GP_EXIT);
 			rcu_sync_call(rsp);
@@ -178,10 +174,10 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int gp_state;
 
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
+	WARN_ON_ONCE(rsp->gp_count);
 	if (rsp->gp_state == GP_REPLAY)
 		WRITE_ONCE(rsp->gp_state, GP_EXIT);
 	gp_state = rsp->gp_state;
-- 
2.40.1

