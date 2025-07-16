Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0D4315C;
	Wed, 16 Jul 2025 00:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626740; cv=none; b=WMfmnsAn0wXL4YxoX0BlLwi+/zzRVLwX7RtVH03vHz8idaN2vypH4NAuIUSLbjs7LxfEIhTZYQRHcCBXZ/gpt4gQCz3oMCVU1U6UgYbPdgvAQoBKDvReI8uhCY/bEgY7Ldb1TpKJVWpdgj2bFV6ATEBWqOJlia+6jATGuerEkAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626740; c=relaxed/simple;
	bh=4hZa1H+8tV2PdJc9DZTrt0zGwOLM6dKOexYzKnOiVxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bG6TbNaxNyqwjjqnZ8j+hCkcskzQpMJ5jAppNizloUS4ghi2vUERWOOBa0uqkGYoWfVevRjSKxnmYyxYIcG5cftfZGRJmNW3ZszHtT+8HzDW2SOyAWUu+0NsiS6O038Zh5sIRyxtYJoyCpV8aSJ4EY6gdxYqyy1Fagqyh7WoisY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7S+46ac; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7S+46ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EE5C4CEE3;
	Wed, 16 Jul 2025 00:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752626740;
	bh=4hZa1H+8tV2PdJc9DZTrt0zGwOLM6dKOexYzKnOiVxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7S+46accG5J4oZExQ55dMY46B24ULY6v98TbaecdtWMFS7S2pSv3+JGc6f8LghWL
	 JyRcQBuoW1qqXyNE4dcK8IE4MaRj6m2WmuXzgIpn41zKh9HmGMlWLID/tWu6XIfaUQ
	 HquXw0WVa2F+vsQERQSHAYlVP0iA3BoTCyBIvmqK494jR8JqDOIZobDVtrTM8qD0kp
	 e3xC4MKyuH70C7zLd323JjyxCUoVytAb75nAgC2gp91ouLY9BTlCKQ6sACXgVvo7cs
	 nhmCDzhcsin7FZGG3bX0CGZvm/IcNidDQOi9nfoHL7uGkyxIdYzJLqjf73tL+Uy0VX
	 +Gg2PRwBGHPiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id F37FBCE0ADE; Tue, 15 Jul 2025 17:45:39 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 2/2] doc: Add RCU guards to checklist.rst
Date: Tue, 15 Jul 2025 17:45:38 -0700
Message-Id: <20250716004538.2720239-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <70015517-57ab-4d07-9792-3ab1beced9e4@paulmck-laptop>
References: <70015517-57ab-4d07-9792-3ab1beced9e4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also note that RCU guards can be easier to use.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/checklist.rst | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 7de3e308f330f..c9bfb2b218e52 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -69,7 +69,13 @@ over a rather long period of time, but improvements are always welcome!
 	Explicit disabling of preemption (preempt_disable(), for example)
 	can serve as rcu_read_lock_sched(), but is less readable and
 	prevents lockdep from detecting locking issues.  Acquiring a
-	spinlock also enters an RCU read-side critical section.
+	raw spinlock also enters an RCU read-side critical section.
+
+	The guard(rcu)() and scoped_guard(rcu) primitives designate
+	the remainder of the current scope or the next statement,
+	respectively, as the RCU read-side critical section.  Use of
+	these guards can be less error-prone than rcu_read_lock(),
+	rcu_read_unlock(), and friends.
 
 	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
@@ -405,9 +411,11 @@ over a rather long period of time, but improvements are always welcome!
 13.	Unlike most flavors of RCU, it *is* permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
 	and srcu_read_unlock()), hence the "SRCU": "sleepable RCU".
-	Please note that if you don't need to sleep in read-side critical
-	sections, you should be using RCU rather than SRCU, because RCU
-	is almost always faster and easier to use than is SRCU.
+	As with RCU, guard(srcu)() and scoped_guard(srcu) forms are
+	available, and often provide greater ease of use.  Please note
+	that if you don't need to sleep in read-side critical sections,
+	you should be using RCU rather than SRCU, because RCU is almost
+	always faster and easier to use than is SRCU.
 
 	Also unlike other forms of RCU, explicit initialization and
 	cleanup is required either at build time via DEFINE_SRCU()
@@ -443,10 +451,13 @@ over a rather long period of time, but improvements are always welcome!
 	real-time workloads than is synchronize_rcu_expedited().
 
 	It is also permissible to sleep in RCU Tasks Trace read-side
-	critical section, which are delimited by rcu_read_lock_trace() and
-	rcu_read_unlock_trace().  However, this is a specialized flavor
-	of RCU, and you should not use it without first checking with
-	its current users.  In most cases, you should instead use SRCU.
+	critical section, which are delimited by rcu_read_lock_trace()
+	and rcu_read_unlock_trace().  However, this is a specialized
+	flavor of RCU, and you should not use it without first checking
+	with its current users.  In most cases, you should instead
+	use SRCU.  As with RCU and SRCU, guard(rcu_tasks_trace)() and
+	scoped_guard(rcu_tasks_trace) are available, and often provide
+	greater ease of use.
 
 	Note that rcu_assign_pointer() relates to SRCU just as it does to
 	other forms of RCU, but instead of rcu_dereference() you should
-- 
2.40.1

