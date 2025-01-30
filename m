Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F81EC00D;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262968; cv=none; b=g5uvij5lRzKWoWUB0ysAeCuzQ+wvOgnrEei+4kJ4AIADlCQM2OPM/jlSxgpYEH7br0l0NYB7ifS65kkyUp+gGP4edpmbS3c36wGG7+4lCw8Sb+je9rX2zl1JhJ3LnZVtCjVg4APZkZLqaNIhWSmZyTZVBfnq5v4H+Z5lo/Sk9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262968; c=relaxed/simple;
	bh=CQAifkc0lIqDeOEOsjSPO+PQBOplNs56QQpJryBbrLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZk7moKxV6QMzc+r46mSUOO3aCdGVkYDgePK5gZbdzE4WBFBiI+HMYQqIILp5t2/gVZsltyf5mYdrFXhkEsRXrukXfQJnj3jOlaTs22qBFS2zVdPwDx55ydZQPup0mkhSQHnnGXgbAfOom9c2I4ZkLMj9kXWlusqbLQ2GgrSV1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbMpymJh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbMpymJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879D9C4CED3;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262967;
	bh=CQAifkc0lIqDeOEOsjSPO+PQBOplNs56QQpJryBbrLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nbMpymJhYCgyrCRMgJvQYua/kjgi52QCjdX3cJIC4uBSSAcK06dpRwLzxGjJboibf
	 97Ukll5QifFjMk6oj+ssrXONqShmnpanscEyME2QjQfvujAlrpABU/CDqTkWKutdV9
	 5dJKFjqKZfxD2oFzsD1x5qlDyreEPiwYpu+5ozZT2OPycpvMory+KQe7USRqkFJtbA
	 AhDWOmbBfeJ9Ml2bIwSDcnoTy75a54rAIWzIkaXICOMhGVC5UnT1U20keYIPTT2scw
	 I6SOWIXGX+Pq1rYTvGpt69nrgbHINJNEcBkKqYVU41LKoTxmzZG0bTvwphkBvN2c3a
	 Djyu1PiTG7q3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B129CE37DA; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-doc@vger.kernel.org
Subject: [PATCH rcu v2 2/7] docs: Improve discussion of this_cpu_ptr(), add raw_cpu_ptr()
Date: Thu, 30 Jan 2025 10:49:20 -0800
Message-Id: <20250130184925.1651665-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
References: <851fd11f-6397-4411-983b-96f7234326d5@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the this_cpu_*() operations may be used in preemptible code,
but not this_cpu_ptr(), and for good reasons.  Therefore, better explain
the reasons and call out raw_cpu_ptr() as an alternative in certain very
special cases.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/core-api/this_cpu_ops.rst | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/this_cpu_ops.rst b/Documentation/core-api/this_cpu_ops.rst
index 91acbcf30e9b..533ac5dd5750 100644
--- a/Documentation/core-api/this_cpu_ops.rst
+++ b/Documentation/core-api/this_cpu_ops.rst
@@ -138,12 +138,22 @@ get_cpu/put_cpu sequence requires. No processor number is
 available. Instead, the offset of the local per cpu area is simply
 added to the per cpu offset.
 
-Note that this operation is usually used in a code segment when
-preemption has been disabled. The pointer is then used to
-access local per cpu data in a critical section. When preemption
-is re-enabled this pointer is usually no longer useful since it may
-no longer point to per cpu data of the current processor.
-
+Note that this operation can only be used in code segments where
+smp_processor_id() may be used, for example, where preemption has been
+disabled. The pointer is then used to access local per cpu data in a
+critical section. When preemption is re-enabled this pointer is usually
+no longer useful since it may no longer point to per cpu data of the
+current processor.
+
+The special cases where it makes sense to obtain a per-CPU pointer in
+preemptible code are addressed by raw_cpu_ptr(), but such use cases need
+to handle cases where two different CPUs are accessing the same per cpu
+variable, which might well be that of a third CPU.  These use cases are
+typically performance optimizations.  For example, SRCU implements a pair
+of counters as a pair of per-CPU variables, and rcu_read_lock_nmisafe()
+uses raw_cpu_ptr() to get a pointer to some CPU's counter, and uses
+atomic_inc_long() to handle migration between the raw_cpu_ptr() and
+the atomic_inc_long().
 
 Per cpu variables and offsets
 -----------------------------
-- 
2.40.1

