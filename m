Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02FE2DC350;
	Mon,  2 Feb 2026 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026113; cv=none; b=YVY9yEA5Ab4gcvYMBprhKWM0DPG5pWh/mJeaO60syjkDvaHzb2PTZBX2Liq3HghnsOah3g0OaXgaZKdRP+r/KBGzOTUeYUCAmRHD6N2n4ECPWc+CQqWDuP2oZ8mXV6XLoHYtPt/KVg0ho6uE/YY9Vf7mcQiIhTvzinaUELTHv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026113; c=relaxed/simple;
	bh=ywn8glYf/nfkdyk8+9no601jAurLF0APg0aSXFSnK4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OOhHJWnvHvpspaw++YF86rb8GXu4u9ksrKcyHnUq35Pj9ptiVjH6/JvYPGkRKaYWtjk8FvCk0p5P8xxfquU+hXB1jxh+BKj6RTsZ01nqKf2ZiGtxEKf6FO8ZBWU2melSkk05sQld42oqckhPbYQBAGYMHFZ2Yq9bogJvupBK35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrtvZrZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrtvZrZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3EDBC2BC86;
	Mon,  2 Feb 2026 09:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026113;
	bh=ywn8glYf/nfkdyk8+9no601jAurLF0APg0aSXFSnK4U=;
	h=From:To:Cc:Subject:Date:From;
	b=GrtvZrZDwyWnJ4lAjybRO/uB77Jo7wpp43gfUCPupNYwxHn3c6ebd2Rz2LF1ksODj
	 XpLCl0wCoatCwpua3hjWYUUUg7osakGKaUYn9oU2GIDmjxz6bIzmFWeIMz3K4vtSlr
	 4aSjSxYyMLNci1zgVkjYT/YK/V9jQDSiNlAcKdgO8t8OsCR9LDpoKWh42RTLA3KNyW
	 QpJa3Ob4dwYCtvvUgBpr0O/6lsFq7nFVw21ZRFP9Zk2LBsWYTvT6dzmIamvFVIllGO
	 lEhXEr4zukBrfuYa2iloOowg8Cu8iXKBSAcgzBBtoSOtoB+WQ1Aqo1Q3SURrwOtACC
	 Ea3pdZh+3lm2w==
From: Arnd Bergmann <arnd@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Marco Elver <elver@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: mark lockdep_assert_rcu_helper() __always_inline
Date: Mon,  2 Feb 2026 10:55:01 +0100
Message-Id: <20260202095507.1237440-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are some configurations in which lockdep_assert_rcu_helper() ends up
not being inlined, for some reason. This leads to a link failure because
now the caller tries to pass a nonexistant __ctx_lock_RCU structure:

ld: lib/test_context-analysis.o: in function `test_rcu_assert_variants':
test_context-analysis.c:(.text+0x275c): undefined reference to `RCU'
ld: test_context-analysis.c:(.text+0x276c): undefined reference to `RCU_BH'
ld: test_context-analysis.c:(.text+0x2774): undefined reference to `RCU_SCHED'

I saw this in one out of many 32-bit arm builds using gcc-15.2, but
it probably happens in others as well.

Mark this function as __always_inline to fix the build.

Fixes: fe00f6e84621 ("rcu: Support Clang's context analysis")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/rcupdate.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index ea1e979b290e..7729fef249e1 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -406,7 +406,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 // See RCU_LOCKDEP_WARN() for an explanation of the double call to
 // debug_lockdep_rcu_enabled().
-static inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx_lock_RCU *ctx)
+static __always_inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx_lock_RCU *ctx)
 	__assumes_shared_ctx_lock(RCU) __assumes_shared_ctx_lock(ctx)
 {
 	return debug_lockdep_rcu_enabled() &&
-- 
2.39.5

