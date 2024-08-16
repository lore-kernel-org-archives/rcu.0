Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE08563E;
	Fri, 16 Aug 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793014; cv=none; b=qtI/+O2OTBWF7OyUznouUE27bYOQodpAFjobngHEOdcO1+YYvOsUP+khw86tAMrpJdGQqHCpE4aMGm47aMQ8vPbDpSRGBW0o5clOzCHJLONvDd6rSI6nc5XaNZidhk705835u1gf+QeOD0OvqJkJOazWTdgghWkPlVFygQMNRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793014; c=relaxed/simple;
	bh=DDI4FoxxC/L6I2pp5Na005FZ5DQEP3zEoTs3qEaOV2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZZDYyyZLYpuY5YYvI2U80Gv5bBOfZZ9irlQdqDVYS5lnEEJmFsNSv+8aDHD/ojcQ9ydx8THmOsLWWhbF9xlgtLEEynZSje/UkfOR1ZVfSOrO/N3VXSlcNNecKceVsYRbfWIF04Aq7SdiFjlO3ZT8eogQOXGb3LZSAY01Cu1r+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnmgvZmH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnmgvZmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97268C4AF0F;
	Fri, 16 Aug 2024 07:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723793013;
	bh=DDI4FoxxC/L6I2pp5Na005FZ5DQEP3zEoTs3qEaOV2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnmgvZmHvzvi4epDDLTeHET0S5iAYpU8fcMXZHlFOJYMz/j0m5R46yKtyXbEOwg23
	 vUXm3NhYG7IidlMnhqabPf0P1m5RcvkohOGt5O69wF9pQA20hSoHGCotuB2kHhS9Ad
	 sPMB2TqxZmAeWUKPXobReBgXe4YIYdywSdavRohNxJckwSdDH99PCP8RPflypWT+U/
	 /QT+hggpJTMe+hD/Slmhrt8+rhy/Fu/mkgX3kKHTfXYxvEfvrKlOoJ21IjqKvCGKQg
	 mF254sGT5CwyxQz519Pjtxmx3jNT8U9dXueYI0PpieBg/yc4zSjg5rkYewNq6qVWeF
	 fMacw0fK031eA==
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
Subject: [PATCH rcu 1/3] rcu/kfree: Warn on unexpected tail state
Date: Fri, 16 Aug 2024 12:52:52 +0530
Message-Id: <20240816072254.65928-1-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816072210.GA65644@neeraj.linux>
References: <20240816072210.GA65644@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Within the rcu_sr_normal_gp_cleanup_work() function, there is an acquire
load from rcu_state.srs_done_tail, which is expected to be non-NULL.
This commit adds a WARN_ON_ONCE() to check this expectation.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..0f41a81138dc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1649,7 +1649,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
 	 * the done tail list manipulations are protected here.
 	 */
 	done = smp_load_acquire(&rcu_state.srs_done_tail);
-	if (!done)
+	if (WARN_ON_ONCE(!done))
 		return;
 
 	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
-- 
2.40.1

