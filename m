Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CA41C30F;
	Wed,  7 Oct 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=ehcS7/oo2d0iDAa/ujkqGchBlgA+aZjJmmtsel4Zu1T1rtB5j3DEBm8jh/B+JBvptr18Nwl+ca84KaHJ7B2X4fSVFcg3OUPGbxWlr49CRtJaBIwWGBNS0WyHDp9xlv4xPzCdGZgUwkXJLthwMjj9WR93mFE9QCsiRazJridIKMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=d2jkGQSCU3DYwpz+ezO2oQr1lWXD4kYhearCA6KtS0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YriuuvvL/jckLLMGNSqQEViBCHNHatD8hvqilJRgwe3as9aamOcbSy/8SHXi2Li9KQfDgCJfsCfA3QpuwwHvWHMVl9iQcNbUYRsX8vz9X7XzBcQ5YV46VwmQMK944Ym1ixRdILXlKdV/ghV6Qf8QlnnGq9fZsCM/4bqprqiuNjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZwIiVKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZwIiVKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB85F1F008A6;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=NUlmnlkNd4HmlXKm8CflXWJ7cxKje+bzKwecoFTrkYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZwIiVKCEwXuBLrmGzwuKG/mk3VMt3dCWbgkjRe8dcrFceSlNRHORhCnCFDJWXeOS
	 t3BvouW4cPplKkusHy46kzdj19kiw3AiPVY2v43mL/5tslgoQMODUN/G1u3Kv9BW3g
	 9ImGUaB4IKxcIfskOnBHpX0TLP8xzCrL+WJrWD2ZsSlzmKIyTbvE8GQ37v/uMUEQRp
	 WPrxVfrtje4HEhiGOoSmVxLNEo91tfN/Ug2m4JaITGoDkoKwyXHrgJfpqx8rzQjQsl
	 XejMjCvwpFje2TFxJz+s1G+KRybDGXgqwr8oBGpESxz0pOUmaU8jIu486RgIH+/ktC
	 N33uX8n3sbn4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33236CE3992; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 14/21] srcutree: Remove srcu_barrier() sleep for atomic SRCU
Date: Wed,  7 Oct 2026 13:59:17 -0700
Message-Id: <20261007205924.1983367-14-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

The atomic-SRCU path in srcu_barrier() sleeps for 100 milliseconds just
in case there are callbacks to wait for.  But call_srcu() refuses
atomic SRCU with a WARN_ON_ONCE() before reaching the deferred-enqueue
path, so there can be no callbacks, deferred or otherwise.

Drop the sleep.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0954486880c7d..82e61421142e5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1892,12 +1892,9 @@ void srcu_barrier(struct srcu_struct *ssp)
 	unsigned long s;
 
 	check_init_srcu_struct(ssp, false);
-	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC)) {
-		// There shouldn't be any callbacks for atomic SRCU,
-		// but just in case.
-		schedule_timeout_uninterruptible(HZ/10);
+	// Atomic SRCU has no callbacks, so there is nothing to wait on.
+	if (WARN_ON_ONCE(ssp->srcu_reader_flavor == SRCU_READ_FLAVOR_ATOMIC))
 		return;
-	}
 
 	/*
 	 * Register any deferred callbacks before snapshotting the sequence.  The
-- 
2.40.1

