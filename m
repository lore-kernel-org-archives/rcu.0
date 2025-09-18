Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A152FB61F;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190472; cv=none; b=Cy37h40hG0gq2IRC+tx4kXyFQXRn6e4mH3xGVT2XCnah2RUVqy3sZVD3zJ9dJGz88WRSboF59BJiNRJ8WFbe5Yu2tjyBsydGpWtZMBpU8TmDTxEbuHjOuSfFjVvPi7daj7SQFTU+l4+TO2b1KNjpN/+oDAEFxKEBRgEU6wEJuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190472; c=relaxed/simple;
	bh=sx/aMTOwkIm8Zaz1kuQ2mUJmqtZSUqCr6SzbEBFIuVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pOGrQqjPGaooeBEerDSKDmBhU/3JOG+SYHH4CGP+ALBGcuCD6wdkVqUBxCkTbJQsFq6N2vjfyXHL5I0UMSusWAUgtjTX6zJ/5ExbINtPk7pacmnCHCZpCmBILvmVGPN5siqCR6NpBCrt9T/gxDvy2cbkxNGAA9uDN/aweA6UCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5deEj++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5deEj++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C79C4CEF0;
	Thu, 18 Sep 2025 10:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758190472;
	bh=sx/aMTOwkIm8Zaz1kuQ2mUJmqtZSUqCr6SzbEBFIuVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z5deEj++9GSLDEff9ZH/GhmPKjf3zNL366uhfQCbhYow4a2xuEFODAPAXDGZ12rjQ
	 rI8uwsx9QF55Vy/lIvY8KcJaxg7aFNH4qLethQIcS+4kAjD4j3+TmS6IMwo880wAs6
	 p9l6CB8stblPXSSt5YNvKFlZdvHN2qrhp//K6slFzp/Cd/zxc4NR/IXlD1z+osOk3+
	 m6ku1kaIRCH66DmwkDDNcfFVrKlTjPhIcVFPTvCjzrShyPtMK3RVO2Zotj1Bpg7x0D
	 xkh8w4JpbUBO+SzDoFarzDdGBpkBz2FG/sRCcJodQnNyYPmrCMwFWJ7MzY5TEcdqXO
	 /5qS2pEQArV5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BD5FDCE0D66; Thu, 18 Sep 2025 03:14:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 2/8] doc: Add RCU guards to checklist.rst
Date: Thu, 18 Sep 2025 03:14:24 -0700
Message-Id: <20250918101430.2592294-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
References: <921eb978-5f39-4480-bcf6-c735f859c694@paulmck-laptop>
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
index 7de3e308f330f6..c9bfb2b218e525 100644
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

