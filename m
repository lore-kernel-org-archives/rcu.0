Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579033859FA
	for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 21:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731250; cv=none; b=f0e6bnUKgl4fucUBlBK/Pn/9oMSCPKMaqKsvjSHvJ4ecBImZCvIUPtkoGMXBPzz+q0ZKuhP6ME6vuoMBG8R1OurYuti4sJzLztEFZjzyn3stQe0B3z2sE8kzh39wr0zh/W4HTXeu09tXXDTpncveEQLWSl/JoiEl38ZEgd3SYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731250; c=relaxed/simple;
	bh=P2KIs1InFMLk3jLFOimE35gTP0H6Qc2HMN+b7OYqzC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oR7Ra5nI1Rrc1wL2AisCRLUxkc40i6sdFFLFjVPP1ZyDS0gGmUTZTb6lqDSC0XY78ZTVHkw6g0vV7FueXmAAAAWLRRbI3I4IUGjWgh1am/3ispLJQ9rVSgKXkYiwWEZKPY5lkC/TCTGBXhsTyU4aFpJN/FvCn2A8vtHuaPuWAgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KXURNrrr; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KXURNrrr"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781731236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NxKAE3mx4SZ3ajKXEe7LV+ac5JDa8tMBrTdkqgpjU6c=;
	b=KXURNrrrxCxi7CRl0uOaWXDAITUHGhQgPisGOoYwszYf8dewubn7237AHV7/FIfzR37tB9
	EYMvyg2/iWKJNx5/2xTxIu7ca3pBH9wzXmF2i5V7K+jw1aPUFUwFy4OHHukxzeOg244C9C
	tQhtk3/CQYqku93zAYJ/xCujYk8WJYI=
From: Usama Arif <usama.arif@linux.dev>
To: lkmm@lists.linux.dev,
	joelagnelf@nvidia.com,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	paulmck@kernel.org,
	rafael.j.wysocki@intel.com,
	rdunlap@infradead.org,
	riel@surriel.com,
	sshegde@linux.ibm.com,
	tglx@kernel.org,
	ulfh@kernel.org,
	usama.arif@linux.dev,
	yury.norov@gmail.com,
	rcu@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	kernel-team@meta.com
Subject: [PATCH] smp: Use release stores for csd_lock_record() state
Date: Wed, 17 Jun 2026 14:20:01 -0700
Message-ID: <20260617212001.3658605-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

__csd_lock_record() publishes per-CPU CSD debug state that is read by
csd_lock_wait_toolong() on another CPU.  The remote side first reads
cur_csd with smp_load_acquire() and, when non-NULL, may then read the
matching cur_csd_func and cur_csd_info fields.

Use smp_store_release() when publishing cur_csd so that the preceding
cur_csd_func and cur_csd_info stores are ordered before the pointer
that csd_lock_wait_toolong() acquires.  This replaces the open-coded
smp_wmb() plus plain cur_csd store with the release operation that
matches the smp_load_acquire() in csd_lock_wait_toolong().

For the clear path, use smp_store_release(&cur_csd, NULL) so that
clearing the diagnostic state remains ordered after the preceding
callback/unlock work, without requiring a full barrier before the
store.  On x86 this removes the locked full barrier from the clear
path; on weaker memory models it uses the release operation needed by
the smp_load_acquire() in csd_lock_wait_toolong().

The old code also had smp_mb() calls around cur_csd updates. Those would
only be needed if cur_csd were treated as an exact live-state marker whose
publication had to be observed before callback execution or CSD unlock.
CSD stall warnings do not currently have RCU-style stall-ended checks, so
they already allow the stall to end while diagnostics are being assembled.
The cur_csd record is therefore best-effort diagnostic context, not a
precise completion/stall boundary.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/smp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index a0bb56bd8dda..5ba4a20ba77d 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -182,16 +182,12 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
 static void __csd_lock_record(call_single_data_t *csd)
 {
 	if (!csd) {
-		smp_mb(); /* NULL cur_csd after unlock. */
-		__this_cpu_write(cur_csd, NULL);
+		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
 		return;
 	}
 	__this_cpu_write(cur_csd_func, csd->func);
 	__this_cpu_write(cur_csd_info, csd->info);
-	smp_wmb(); /* func and info before csd. */
-	__this_cpu_write(cur_csd, csd);
-	smp_mb(); /* Update cur_csd before function call. */
-		  /* Or before unlock, as the case may be. */
+	smp_store_release(this_cpu_ptr(&cur_csd), csd);
 }
 
 static __always_inline void csd_lock_record(call_single_data_t *csd)
-- 
2.53.0-Meta

