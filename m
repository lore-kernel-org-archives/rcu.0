Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9651DF27A;
	Tue,  8 Oct 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728395570; cv=none; b=Uvfl0tPCDKBXa45rsL7ViKFt1tyVWObegM7NoVuZrhr5CuD5eg21+L88KzkzVUk0siElkNyigjai59p/bvfZ08eOyBFKW3CwHVLKhEKmCOIdyp+yGMXkUY9ddrSr/Wo03T8ZfzmQh72rJ19s/pcz35V/OzRDNk+1uKVTrl46AUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728395570; c=relaxed/simple;
	bh=yje+Nf53ZMDX2ciH9OYWiJcxOcJxvL0v/cML/xD8LJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcLGycvD6kp3LDu1hsiNdU+Z5unuW83aCoaTElsvD76Huv6rSPIcnb5NpkOllRyWbmQ+WmGbXbxqQchi7AgyJZi3/YqceHQBdQ/RjU5BTD3lW4DGoFUxKMl02flQ8OOKbVn2vrarlCN7MZ3nVgQvAErFGw9b5udXyTa6PlNP0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JUhZup11; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JUhZup11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1728395562;
	bh=yje+Nf53ZMDX2ciH9OYWiJcxOcJxvL0v/cML/xD8LJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JUhZup11xZUM5lXz8AmFl7eRRRbNdTVJn/MAouIeqyExpdpC7wwzSy9hI/bDD7sTZ
	 zMS9WBOhOM6injeA4saJAsztMqLPoIHRVPMs9V6IGJ7OLZUFUAbHuGH7I2h3JMmPTM
	 dKXT7l/hdTnifrGM8Nctf6T/VvE4JryCejgDRtQ4aIiW7NFqaLuyjMnDIEkRXQC2c8
	 AXZBOW/Lg9c/MmCwqVIp60r7R/DHkbkd9yjFgUEQVD48fYXvqco8rKZLfZNJxTssgk
	 QctXWViwcxB7jAFx2bZZGRV7318YPgpZOPtHD0kNVZsevNkm7LfIYya52amK3TQzov
	 ly7soWyCuYxoQ==
Received: from thinkos.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XNHX965gyzLcG;
	Tue,  8 Oct 2024 09:52:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	John Stultz <jstultz@google.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	maged.michael@gmail.com,
	Mateusz Guzik <mjguzik@gmail.com>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev,
	Gary Guo <gary@garyguo.net>,
	Nikita Popov <github@npopov.com>,
	llvm@lists.linux.dev
Subject: [RFC PATCH v3 2/4] Documentation: RCU: Refer to ptr_eq()
Date: Tue,  8 Oct 2024 09:50:32 -0400
Message-Id: <20241008135034.1982519-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com>
References: <20241008135034.1982519-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refer to ptr_eq() in the rcu_dereference() documentation.

ptr_eq() is a mechanism that preserves address dependencies when
comparing pointers, and should be favored when comparing a pointer
obtained from rcu_dereference() against another pointer.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: John Stultz <jstultz@google.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: maged.michael@gmail.com
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Gary Guo <gary@garyguo.net>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: rcu@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: lkmm@lists.linux.dev
Cc: Nikita Popov <github@npopov.com>
Cc: llvm@lists.linux.dev
---
Changes since v0:
- Include feedback from Alan Stern.

Changes since v1:
- Include feedback from Paul E. McKenney.
---
 Documentation/RCU/rcu_dereference.rst | 38 +++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 2524dcdadde2..de6175bf430f 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -104,11 +104,12 @@ readers working properly:
 	after such branches, but can speculate loads, which can again
 	result in misordering bugs.
 
--	Be very careful about comparing pointers obtained from
-	rcu_dereference() against non-NULL values.  As Linus Torvalds
-	explained, if the two pointers are equal, the compiler could
-	substitute the pointer you are comparing against for the pointer
-	obtained from rcu_dereference().  For example::
+-	Use operations that preserve address dependencies (such as
+	"ptr_eq()") to compare pointers obtained from rcu_dereference()
+	against non-NULL pointers. As Linus Torvalds explained, if the
+	two pointers are equal, the compiler could substitute the
+	pointer you are comparing against for the pointer obtained from
+	rcu_dereference().  For example::
 
 		p = rcu_dereference(gp);
 		if (p == &default_struct)
@@ -125,6 +126,29 @@ readers working properly:
 	On ARM and Power hardware, the load from "default_struct.a"
 	can now be speculated, such that it might happen before the
 	rcu_dereference().  This could result in bugs due to misordering.
+	Performing the comparison with "ptr_eq()" ensures the compiler
+	does not perform such transformation.
+
+	If the comparison is against another pointer, the compiler is
+	allowed to use either pointer for the following accesses, which
+	loses the address dependency and allows weakly-ordered
+	architectures such as ARM and PowerPC to speculate the
+	address-dependent load before rcu_dereference().  For example::
+
+		p1 = READ_ONCE(gp);
+		p2 = rcu_dereference(gp);
+		if (p1 == p2)  /* BUGGY!!! */
+			do_default(p2->a);
+
+	The compiler can use p1->a rather than p2->a, destroying the
+	address dependency.  Performing the comparison with "ptr_eq()"
+	ensures the compiler preserves the address dependencies.
+	Corrected code::
+
+		p1 = READ_ONCE(gp);
+		p2 = rcu_dereference(gp);
+		if (ptr_eq(p1, p2))
+			do_default(p2->a);
 
 	However, comparisons are OK in the following cases:
 
@@ -204,6 +228,10 @@ readers working properly:
 		comparison will provide exactly the information that the
 		compiler needs to deduce the value of the pointer.
 
+	When in doubt, use operations that preserve address dependencies
+	(such as "ptr_eq()") to compare pointers obtained from
+	rcu_dereference() against non-NULL pointers.
+
 -	Disable any value-speculation optimizations that your compiler
 	might provide, especially if you are making use of feedback-based
 	optimizations that take data collected from prior runs.  Such
-- 
2.39.2

