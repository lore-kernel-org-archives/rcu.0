Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC967770F0;
	Fri, 16 Aug 2024 04:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723784240; cv=none; b=MIm1hjQBPG+fmV/YBvheo/GyVHw6TTKSetO5w/hrORfqo4GfBoWB9dumrVSPJV9T1W+FAihjROGIw8wimS3QIrG8xouWJh6tkmW3Fu6OBfVbgWKPSQF0iw0krwnxXu728Vhft2/60cD+Jz68wHih5LUB8Mz/7gZMyz/BLTjl+PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723784240; c=relaxed/simple;
	bh=nfjpDroIqy0RRS0eQziwDCF8pjQKekqUjluLtM/2UH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JjwHpxjI20+O9RD3nCow3GXs0L92zK5N+vqUnntRVflLTXy+dQHzyDHiUIhCOy4G/BDM392iX0TZeX8k7MaEYz3/NmtnPbgp3LqYQOzG9hZdHAnmlPL4OlDbcVTkpYKGTY9WdK8jOb27Lh3L1MPu7OiC+J2EvbEPe2yJpQUFvjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/N0pvTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/N0pvTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0C7C4AF09;
	Fri, 16 Aug 2024 04:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723784240;
	bh=nfjpDroIqy0RRS0eQziwDCF8pjQKekqUjluLtM/2UH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/N0pvTZzw1fYmzmQqFoYI7qFWXwxdgZ2zwn+1OOtdzwGtJwYaclXAXoMu3bmM/nW
	 mhbA2GzlSXDKFdjXvhQiLqNvWn4Freo6GECao2QyoiiD8UOhLpLOKpQdXUp34xm3Iz
	 0w27Vb5cnJoA+7egbFz+l3oTggdfYHwtbz5G10NDc/ywrOvnBVa3WW37Df+oCyu00I
	 zb5Rv6gaaQUXa7IPu6gWlBu5X3LuubSdDb5NfitVU+QtOWy8ri7Q26H/sL6iiWqRNf
	 D8WwvWBc7EGnPYWyzZXtmTY6LWD+OuPkjnjmzeoQPWvkEG/1FlmldVDT0Sbqm3McGs
	 QMahBzc/If04Q==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 06/11] rcu/nocb: Remove halfway (de-)offloading handling from bypass
Date: Fri, 16 Aug 2024 10:26:03 +0530
Message-Id: <20240816045608.30564-7-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
References: <20240816045608.30564-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

Bypass enqueue can't happen anymore in the middle of (de-)offloading
since this sort of transition now only applies to offline CPUs.

The related safety check can therefore be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8e766396df3a..af44e75eb0cd 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -409,14 +409,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		return false;
 	}
 
-	// In the process of (de-)offloading: no bypassing, but
-	// locking.
-	if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
-		rcu_nocb_lock(rdp);
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
-		return false; /* Not offloaded, no bypassing. */
-	}
-
 	// Don't use ->nocb_bypass during early boot.
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
 		rcu_nocb_lock(rdp);
-- 
2.40.1

