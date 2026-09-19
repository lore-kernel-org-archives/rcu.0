Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43EB2D7DC6;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777743; cv=none; b=syDHPOLpyzS/5BWBcH/iWDKfHBLrh0wxuHB2l7AxjVzMhoXyQEXkxEC9rqAfE0/0VkySW0ssPDWtsQ1FPsj/czCgIOzLxNSUxunCgv4aMSqgXFSZpY9AropSmBxMLuAUusSk9Bc8QwdpJnWtTmmGWJ2l5Zx4DFpUiwc4kEr8knE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777743; c=relaxed/simple;
	bh=a4wbqYA3L+aRLVF8BSnrMwUBzd28T9Uh2tZ1BNXzljc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCLZitd+dFfVziXFUzXWeIDUZfEqiMxue9XwCaccbk0ipF+trdSVhcpKDNiSTCvX0IBA4Fa6M0jFYd/0mEjc4iS3TJweD4FxqOSUqiSoDo7XtfZpYtsn5wFKisG0ZXjVZPi/E7bpZd5DfzhMfwMpoUjEzZY2nnBgFdnO9xrf3S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgrAP00P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgrAP00P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B691F0089D;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=ORBy73Ci1p0ko8VKaST9sQqOvDAWnmToTUZsIly2law=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZgrAP00PD6/96Uz9Q0WA/Zrq75VYx3H0DFujiwFZeFUMACL56WEwg3j0BhP24LJGL
	 hOwhG3hES2f3eVS+KJGbVWwOA2jYM1PyeXuuxw3MDeOEfNeZuVAt6AnVLHa0mFhI7R
	 tinE5dQoyciGZjwKB34374l9enn3+rkh7O21yW4StrhpUbRgOBGzULTcLVKf2U+8yk
	 jWug1gxBY0GVfJd6Q2XLZ5DsC3rwnCEoRS+Xc3t6SA25jAqMUtgYr2VBSEZeeUhJtU
	 DbOyU33u6lvzWw73WUGO4yYcLVKSbEAXX+0V+EHkRhcSu8iw2EVoSNPdsIgmPAlqDc
	 6J7jFw3/pinuw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 527EECE1853; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Hemanth Selam <hemanth.selam@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 5/9] rcu: Fix typo "upto" in comment
Date: Fri, 18 Sep 2026 17:28:56 -0700
Message-Id: <20260919002900.3134117-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hemanth Selam <hemanth.selam@gmail.com>

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ed204b3f4b84..01f19bb17dd6 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -624,7 +624,7 @@ module_param(srcu_retry_check_delay, ulong, 0444);
 #define SRCU_UL_CLAMP_LO(val, low)	((val) > (low) ? (val) : (low))
 #define SRCU_UL_CLAMP_HI(val, high)	((val) < (high) ? (val) : (high))
 #define SRCU_UL_CLAMP(val, low, high)	SRCU_UL_CLAMP_HI(SRCU_UL_CLAMP_LO((val), (low)), (high))
-// per-GP-phase no-delay instances adjusted to allow non-sleeping poll upto
+// per-GP-phase no-delay instances adjusted to allow non-sleeping poll up to
 // one jiffies time duration. Mult by 2 is done to factor in the srcu_get_delay()
 // called from process_srcu().
 #define SRCU_DEFAULT_MAX_NODELAY_PHASE_ADJUSTED	\
-- 
2.40.1

