Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BD3326951;
	Sat, 19 Sep 2026 00:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778144; cv=none; b=P2Qy+qB2tybqM0dUWwppqsonI9dvFPBwlAaj8xt10zHgHQb1n6hONvMpG7/yxrYvBzfScJv8BvwtFORP2re3fNFxqHfOv0hMAX++eiYOxewu/sjgq/UfPk7XxW2OtjN+1MULnjmbClGzw/YPUQJfnJKegc+j5jpxK1XcIb8dYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778144; c=relaxed/simple;
	bh=R62qS2zKFtOpdiEqV9ZFD2Tiav/SDiJXzxwuevtgBVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHR2e/qPis2Kw6qDW3EPocPsu/4CbZa91DC3G6HralUjm0QFVTZ3sXD8tQon2eOO+qqEjxOw7v+LdvKt49jESK7N2ipZ0KDmVxaJH/Hur8DBeuWdZph3+I5SiXKCsbU7fvgBVM7vVOCQ/+oqSylGBHR8aMEGakVaQqJjM1BEo0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dg+U9/dw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dg+U9/dw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9D11F008AB;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=SYTCZikcR2BFsI4FpUwyomm1XM+SLtLcZIqlQqV2aSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dg+U9/dwE5OOSeIbkinkBLY4xiKUg9T+DZYxTwoyIGvMZv9FqsEYFEWeuhAWhVeqd
	 oOmEwFqNmwtdiWOw4jbT7H2Fhr5SS4/okZG0OTz5g7Y7GfhlO3Uq+A3wBJdyBmnBJi
	 FJStEHEUf+zNiwLT9ZpimCBbuNJRzMFw7sv/WUWTPcUt4ZqfF3eqMBZR/X6+WxlyRm
	 WneuhKsJw7FhlC2sJY7m1ZK5kurM3Iqtax9Dy9Wgbu4DWe1RBb9VIhMru9EqjMPk13
	 jxIrY/x7TYVrooDp1F48EQJhhpvyjSIMQnVm1Ztf36Y1i8kJZaVb2p/3cInMjpzypf
	 UPjMS5YzYGRTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B80DECE1A13; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 15/19] srcutree: Remove srcu_barrier() sleep for atomic SRCU
Date: Fri, 18 Sep 2026 17:35:17 -0700
Message-Id: <20260919003521.3134552-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
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
index 0954486880c7..82e61421142e 100644
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

