Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD51917E8;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029400; cv=none; b=pNsz0Jlt9mJygBVZe01NhAuShFKJmaDdMVWHat3ZNxJgCjHTCAvf3zOwIMO/oSMh2J08nDgLJ0T6QYYN1LCFhMsAmV/y2t7Ki6eHUbM9SH2SVmoPgSkGCf1byzXLKiw/nAhu7SvskomgSTgAz1WsHX/H3CjSc7L4DOJqbSlDaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029400; c=relaxed/simple;
	bh=EC44T8wipTNN3ub3B85kJOORyowKiTYlaaaJPPAvAJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPnniOCVpiEIdbvBrY+I4/guGC/ffIS9D7Gv1tM7zt0lJMlg3t+hkDbeFKv6g1m1NzNDaSTsnarIa83jygHufLocvMY0+YyUP9RABFVshKKZWJcm5WLSNDNLFCTAjkq7vxf+bIiMU4OsWQg8cwrLr6OxLFzYrWTooL2iprbzREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lv9n2wj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lv9n2wj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CE5C4CED1;
	Thu, 12 Dec 2024 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029400;
	bh=EC44T8wipTNN3ub3B85kJOORyowKiTYlaaaJPPAvAJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lv9n2wj2qvrpQyNo5+ch+30mRSYc5tVnNltpipdRBMm/nOdSLT1cqa0VqikTziF+G
	 I+Dcj4OvoVHtIwqzABtB6NNdqLUJuUrnnvsmXma/T/wVDtSbA4gZYgqk1lnS67Ai3m
	 +QxShEZfFV63EExT7cf5wMpV/eYJ4jTET4vD9WWmnL2P/cnTkBJMZnQggno5H++KhV
	 wVlZV7r0Bo0uv7dqWAn+VXQ7YU/4wxTb6SpU1vmiLT9f7iRzmenneHyx3zLNBqLp6S
	 J4XMWxcMUKYC15hwjugZZTg5JWTWr1g/5a0mErG1FdcbKU8oqMOd209sxUrdXp41l9
	 uPpOmpZmUqGVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2C46CE13AA; Thu, 12 Dec 2024 10:49:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 12/18] rcutorture: Ignore attempts to test preemption and forward progress
Date: Thu, 12 Dec 2024 10:49:51 -0800
Message-Id: <20241212184957.2127441-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
References: <62e4d9a4-18ad-49b3-9656-23e17b78033f@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of the rcutorture preempt_duration and the default-on fwd_progress
kernel parameters can result in preemption of callback processing during
forward-progress testing, which is an excellent way to OOM your test
if your kernel offloads RCU callbacks.  This commit therefore treats
preempt_duration in the same way as stall_cpu in CONFIG_RCU_NOCB_CPU=y
kernels, prohibiting fwd_progress testing and splatting when rcutorture
is built in (as opposed to being a loadable module).

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8c7820a00f3c3..3595ce889b44f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3145,12 +3145,12 @@ static int __init rcu_torture_fwd_prog_init(void)
 		fwd_progress = 0;
 		return 0;
 	}
-	if (stall_cpu > 0) {
-		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, conflicts with CPU-stall testing");
+	if (stall_cpu > 0 || (preempt_duration > 0 && IS_ENABLED(CONFIG_RCU_NOCB_CPU))) {
+		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, conflicts with CPU-stall and/or preemption testing");
 		fwd_progress = 0;
 		if (IS_MODULE(CONFIG_RCU_TORTURE_TEST))
 			return -EINVAL; /* In module, can fail back to user. */
-		WARN_ON(1); /* Make sure rcutorture notices conflict. */
+		WARN_ON(1); /* Make sure rcutorture scripting notices conflict. */
 		return 0;
 	}
 	if (fwd_progress_holdoff <= 0)
-- 
2.40.1

