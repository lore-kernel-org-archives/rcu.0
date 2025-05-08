Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EF233736;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747904; cv=none; b=qGe/VAVm7mLrPifg95koTq/MHICfTxioU3vWtdLv88s7FCJUiitRhnxrbkh8u5HCZbqybKOaKtT2uylXGv7hpjM/++saui7bFA+4wcFG4ELFFq4zF+hwOe3/iAIKvEYerMIdPomqs7eWiOjHVHZOxMu+8d6wAH+Al276hwaQuBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747904; c=relaxed/simple;
	bh=k1mtwuY4N05SGMOTXGfHc6NzT0+sC8UthwhkhK0hGqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HwihRo5r4ISUjqE+732HHNDDUdJ40QOh8l7OOW8snkO4VjbCDL3ITiS/I3RlQEAh9Hni9jUg7ldg5LfWEvVr9MDE/Mmj8lhRk9DqajUFc2VnBxe9Ihcw5eKgunAB9Ar3RDp99Wx/mDk/Sd1875YmT3ZobO7LAwvtAC8QDPsAFps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwcADmOS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwcADmOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28080C4CEF1;
	Thu,  8 May 2025 23:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746747904;
	bh=k1mtwuY4N05SGMOTXGfHc6NzT0+sC8UthwhkhK0hGqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kwcADmOSZs52VirpuzMPpmA1o7cAtFphM/sO7XHZexdp6RNILUeJNLLu3SCDF7tU+
	 3Rsf18QcTdHFUaPE4Jeyc02c+LSRJwo3kTOkV3teU5MDw0BD5+yacmUKs22t6eMsYb
	 bLTgeJB4tfBdGjs7DaQb7aiC+UR3g+bMbUl4k6eipgDzJu/dxK7id3XOlZ8vn8mIyJ
	 BUJAOP645syvK46aNyXvy3kHa9v2M7eT2DGwLPU+P1OLHy5MVY6ZHbd19jYaNMbWhs
	 EC6d54hXQjOGtIXdxWK6swkcICy+ZEHYMcPDJ+eRFBX37Yo2TWpfyo4VJ6XHLYnupK
	 s8TT4ei3Sgc3A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B7D04CE11F1; Thu,  8 May 2025 16:45:03 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 4/5] rcutorture: Start rcu_torture_writer() after rcu_torture_reader()
Date: Thu,  8 May 2025 16:45:01 -0700
Message-Id: <20250508234502.1996788-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
References: <a942066a-85cb-4932-b4de-0ee39287ab7d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Testing of rcutorture's SRCU-P scenario on a large arm64 system resulted
in rcu_torture_writer() forward-progress failures, but these same tests
passed on x86.  After some off-list discussion of possible memory-ordering
causes for these failures, Boqun showed that these were in fact due to
reordering, but by the scheduler, not by the memory system.  On x86,
rcu_torture_writer() would have run quickly enough that by the time
the rcu_torture_updown() kthread started, the rcu_torture_current
variable would already be initialized, thus avoiding a bug in which
a NULL value would cause rcu_torture_updown() to do an extra call to
srcu_up_read_fast().

This commit therefore moves creation of the rcu_torture_writer() kthread
after that of the rcu_torture_reader() kthreads.  This results in
deterministic failures on x86.

What about the double-srcu_up_read_fast() bug?  Boqun has the fix.
But let's also fix the test while we are at it!

Reported-by: Joel Fernandes <joelagnelf@nvidia.com>
Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d94b24f19cf59..62f082e24d3b9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4476,11 +4476,6 @@ rcu_torture_init(void)
 	/* Start up the kthreads. */
 
 	rcu_torture_write_types();
-	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
-					  writer_task);
-	if (torture_init_error(firsterr))
-		goto unwind;
-
 	if (nrealfakewriters > 0) {
 		fakewriter_tasks = kcalloc(nrealfakewriters,
 					   sizeof(fakewriter_tasks[0]),
@@ -4516,6 +4511,11 @@ rcu_torture_init(void)
 	firsterr = rcu_torture_updown_init();
 	if (torture_init_error(firsterr))
 		goto unwind;
+	firsterr = torture_create_kthread(rcu_torture_writer, NULL,
+					  writer_task);
+	if (torture_init_error(firsterr))
+		goto unwind;
+
 	nrealnocbers = nocbs_nthreads;
 	if (WARN_ON(nrealnocbers < 0))
 		nrealnocbers = 1;
-- 
2.40.1

