Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873918890A;
	Sat, 28 Sep 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727531635; cv=none; b=SeoksmkRSS8c9TS5RCU9/UBZ4XtO6ZTcYGqCsZ9yV6ie65fN500RRgo/PQEerbG6HxzOQuuHKTE31drT1Qsa0VOs39Z7dzZgc0dp8QvPuopCKFS7/4M/Qlv5+zNTjA3FVd6e259PyYe8Nh58UAMFO0PLF7c35UX7VH6who7Enww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727531635; c=relaxed/simple;
	bh=adr64DJrpL036YYqX3VlBhGw9oL6SMunripgcF3S5mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MndRobE69JjEOnZZ7nMrqmM6Fad09Uzqqm34pyUv7x14Febvw+AXaXLVAlusvYI/pp5bfXO46kU92Pui7IKf15PbG3toyTbOe3bGjQOZji08bQYprfQeZRnLXUdYYiOGWLKxrOSyeulg+lNEMOscFR53SXzR47WI+BO6PgsOoAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VZ2bjJPy; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VZ2bjJPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1727531632;
	bh=adr64DJrpL036YYqX3VlBhGw9oL6SMunripgcF3S5mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZ2bjJPyzV8LOr/fUK3q5+I26yAxJvJ8sorbWZ4MKmbGYZTIJ/fIr7Hyx30CAKpxO
	 WpIBkNQNlW+jolCn9hc284TT8OGzd/5YzG2DKaCz5NhwzMJGPWiHb3T3Q2ElKSsVQk
	 iY5gtCZDD8laZdfbhHUFc1K4XKjgTuoGqs8JP62v3fuje2aC3KS1EKrX9G6HQmkKQ9
	 afMfgD+0hWceM6vNAUQGUEgDUjAWBhXzNeWOA2qANQmQZadycqwMlcCHN1lkspEiZU
	 i4ggfozc1u0PYWQlkV8coab3oTkaE8OMtg/HAVLx7XKlwkGOVU3RwUet1Tk7XSLeES
	 KNMf+4kwaXmuQ==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XG8282zDgz1bsD;
	Sat, 28 Sep 2024 09:53:52 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
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
	Gary Guo <gary@garyguo.net>,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	rcu@vger.kernel.org,
	linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: [PATCH 2/2] Documentation: RCU: Refer to ptr_eq()
Date: Sat, 28 Sep 2024 09:51:28 -0400
Message-Id: <20240928135128.991110-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
References: <20240928135128.991110-1-mathieu.desnoyers@efficios.com>
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
---
 Documentation/RCU/rcu_dereference.rst | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 2524dcdadde2..c36b8d1721f6 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -104,11 +104,13 @@ readers working properly:
 	after such branches, but can speculate loads, which can again
 	result in misordering bugs.
 
--	Be very careful about comparing pointers obtained from
-	rcu_dereference() against non-NULL values.  As Linus Torvalds
-	explained, if the two pointers are equal, the compiler could
-	substitute the pointer you are comparing against for the pointer
-	obtained from rcu_dereference().  For example::
+-	Use relational operators which preserve address dependencies
+	(such as "ptr_eq()") to compare pointers obtained from
+	rcu_dereference() against non-NULL values or against pointers
+	obtained from prior loads. As Linus Torvalds explained, if the
+	two pointers are equal, the compiler could substitute the
+	pointer you are comparing against for the pointer obtained from
+	rcu_dereference().  For example::
 
 		p = rcu_dereference(gp);
 		if (p == &default_struct)
@@ -125,6 +127,23 @@ readers working properly:
 	On ARM and Power hardware, the load from "default_struct.a"
 	can now be speculated, such that it might happen before the
 	rcu_dereference().  This could result in bugs due to misordering.
+	Performing the comparison with "ptr_eq()" ensures the compiler
+	does not perform such transformation.
+
+	If the comparison is against a pointer obtained from prior
+	loads, the compiler is allowed to use either register for the
+	following accesses, which loses the address dependency and
+	allows weakly-ordered architectures such as ARM and PowerPC
+	to speculate the address-dependent load before rcu_dereference().
+	For example::
+
+		p1 = READ_ONCE(gp);
+		p2 = rcu_dereference(gp);
+		if (p1 == p2)
+			do_default(p2->a);
+
+	Performing the comparison with "ptr_eq()" ensures the compiler
+	preserves the address dependencies.
 
 	However, comparisons are OK in the following cases:
 
@@ -204,6 +223,11 @@ readers working properly:
 		comparison will provide exactly the information that the
 		compiler needs to deduce the value of the pointer.
 
+	When in doubt, use relational operators that preserve address
+	dependencies (such as "ptr_eq()") to compare pointers obtained
+	from rcu_dereference() against non-NULL values or against
+	pointers obtained from prior loads.
+
 -	Disable any value-speculation optimizations that your compiler
 	might provide, especially if you are making use of feedback-based
 	optimizations that take data collected from prior runs.  Such
-- 
2.39.2

