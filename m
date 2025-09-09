Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEB2309B9
	for <rcu@vger.kernel.org>; Tue,  9 Sep 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757425181; cv=none; b=Lluei/TsUXuQcLXsbpria5HO5ooPD+dlLpWSLOy7ipOihYtkjyUMBz546T4sOLe8IiT8z2yyA5+tmeymuOk2Me2CffdHn+luEl3UNwZylE2xkhYMlSqKMavG+jd/wNusPv/FAJk0Uo7R846Ek1L0hjpL+U3vt3zpyyEi9HOFzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757425181; c=relaxed/simple;
	bh=eYuJ6qNBw3nt+6Ow7BNqZLeRtH+uFXn8TAZK1TjPSfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwGDo/QYNXYpVeKW1UbPMpS6Skq1rjgqM5sACds5lhuE/yB5NkmlZ5qH+5b7WOWMALbsmddqxVNg3VgmbCiQQobqqPUwskSsL2SwzxemWJmO9qWBivFpnqKryM81qUYAUGkG55R7DBjuhs6c6A1s2SS3LJjwykWDVfXwD5pAKBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DmAHSxJG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DmAHSxJG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757425174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OVTocMfKvqb5kZ+ACRAbircLYYL3Zc6f5Wp7dUPPYz0=;
	b=DmAHSxJGB7hs9UUVEmSmch88SUKoIqreLh60OlVVQCdDPQv0+//IjXY6gvexes515TB/jD
	gNngdC5D7B7SzIt/PE0W4kxV2T83oNOb2RsSV9FpijRTa4FmSsV3bQAsbmIg5FxmqYETeD
	8PH3JGJ+6rH6nYUTBqchUudSZTnBmdY=
From: Zqiang <qiang.zhang@linux.dev>
To: paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun.feng@gmail.com,
	urezki@gmail.com
Cc: qiang.zhang@linux.dev,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] srcu/tiny: Remove preempt_disable/enable() in srcu_gp_start_if_needed()
Date: Tue,  9 Sep 2025 21:39:28 +0800
Message-ID: <20250909133928.615218-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the srcu_gp_start_if_needed() is always be invoked in
preempt disable's critical section, this commit therefore remove
redundant preempt_disable/enable() in srcu_gp_start_if_needed()
and adds a call to lockdep_assert_preemption_disabled() in order
to enable lockdep to diagnose mistaken invocations of this function
from preempts-enabled code.

Fixes: 65b4a59557f6 ("srcu: Make Tiny SRCU explicitly disable preemption")
Signed-off-by: Zqiang <qiang.zhang@linux.dev>
---
 kernel/rcu/srcutiny.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index b52ec45698e8..b2da188133fc 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -181,10 +181,9 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
 
-	preempt_disable();  // Needed for PREEMPT_LAZY
+	lockdep_assert_preemption_disabled();
 	cookie = get_state_synchronize_srcu(ssp);
 	if (ULONG_CMP_GE(READ_ONCE(ssp->srcu_idx_max), cookie)) {
-		preempt_enable();
 		return;
 	}
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
@@ -194,7 +193,6 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
-	preempt_enable();
 }
 
 /*
-- 
2.48.1

