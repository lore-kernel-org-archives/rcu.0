Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343A22FDEC;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057761; cv=none; b=GPVjA+2VYiSw1XGqWEjckDSWVWCjnKHtZQN62H0eye7H7UoRLBStnAacLGM4fSLQNUQs9NX9XocQN60Rsc+TW0a/VOxccKsnRWs6VxpgBY2crNhky9Q2hN+DnRWgx26zoERhnkIKcyxEV6aagEtqKyA2K78p8XggSIj34A+3LcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057761; c=relaxed/simple;
	bh=F+8+Q9SIp7U9jRLhjSu8vofJvIuuC8FLrTqiXt/jqag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BKWNYqwCbn8DkeS2Oo0T0yWr4LmTrUAUipzmYUUgXJb01hPDmjZwM90OyRikv4nSU6b4b/bwdxGitmQJZF/23V8Q1rKYCJHK/pudqiih00qu0j1KiqEFF0wpKJPt/TTMp0i/wPGEP8cL330sAS1ObirG4o19tTLnLTrq6jjUudc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grOwb6iw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grOwb6iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D21FC4CEDD;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=F+8+Q9SIp7U9jRLhjSu8vofJvIuuC8FLrTqiXt/jqag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grOwb6iwUE2pGQI6EYvOqpj8fYJxW/+VTF90/nVQKvr3b787/sE67+cW5j4hzQjIL
	 oKn4oSmi/yl8gbeV6swhRvwMp/44Gk9tPdlCWq6M+iQNwbLQUDHaf9jjbsm5+EloSh
	 XAtWGxEcpS8xX1bcCZLV5EaqrZqIh7OyfRHo9A0/75v5MZJee9aCrYrdzKYf4Btg+Z
	 vCG6BMMA6uWov1rsnMKeRMQiCB2J8HjXSfUXmoH6TqtIssje6Q9hUhmsn5X0vyAZE7
	 Nq6+D1KzJAuU2C66jqtsZZsHXjpITrXCUkXH0yzMQbZkZ+S+FsrjWUlLKDVHsKbFYX
	 IXC0O5DSw6GfA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2BEFBCE10F9; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
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
Subject: [PATCH rcu 2/7] docs: Improve discussion of this_cpu_ptr(), add raw_cpu_ptr()
Date: Thu, 16 Jan 2025 12:02:34 -0800
Message-Id: <20250116200239.3782374-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
References: <a2c2793d-771a-436e-8c42-4cb38def0e2f@paulmck-laptop>
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
index 91acbcf30e9bd..11e3e48731553 100644
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
+The special cases where it makes sense do obtain a per-CPU pointer in
+preemptible code are addressed by raw_cpu_ptr(), but please note that such
+use cases need to handle cases where two different CPUs are accessing
+the same per cpu variable, which might well be that of a third CPU.
+These use cases are typically performance optimizations.  For example,
+SRCU implements a pair of counters as a pair of per-CPU variables,
+and rcu_read_lock_nmisafe() uses raw_cpu_ptr() to get a pointer to some
+CPU's counter, and uses atomic_inc_long() to handle migration between
+the raw_cpu_ptr() and the atomic_inc_long().
 
 Per cpu variables and offsets
 -----------------------------
-- 
2.40.1

