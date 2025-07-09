Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2FE28D82F;
	Wed,  9 Jul 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057762; cv=none; b=n1i1naKqcNPsPrgF4VU2H5B+5S8LdgQQG8gu3JONxQiigctVDx+GlKi/4kIgYZ/fXoM0qxM19ygOwKNaemjWyE9FrGX+CZPw9jCyx1Idq91T1PQtIhEWeiErAERnbVizqlaFPc1KV2yF3h4P6/dkIfuWIFwHPEsDLX2kaanr1eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057762; c=relaxed/simple;
	bh=wUBGKF3tuqboI0ct3NbCXZ834tVW8bDTlFnBSWO6xWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8oOhoQVqorXNzxCFW0gn9kEwUjV0qpvXmzH9JpaQ2nugnOEqPTMZG11zibS4DK5jUbeaaOdVuhrZRCFGTx1xoLp+E62Y6/qDr8343s1Oh00DztLlWAPA59yl2RGO2EZgsiGjLeslzxn1pn/6s6v2zXqmTxyInzq1T1G0faTQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIDmdrhw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIDmdrhw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEC2C4CEF7;
	Wed,  9 Jul 2025 10:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057762;
	bh=wUBGKF3tuqboI0ct3NbCXZ834tVW8bDTlFnBSWO6xWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIDmdrhwriVle5grseJFdkOFmvNAShnFC0R40m7g0yJigz8XHp6aYNunVlwIrBofD
	 5dLTg3ZmiT6A6B7nzgSik826UrJzf1Muf1l19i32tfdl8avNVT62CZrUogDKoic+Ii
	 5q7nw5nLvD6Zw0G9Kqw2vZkDR3EQ3vWvfN+22DjE4ZSpYI8v16TTLmWHk9Zh6Qi+c1
	 zibgOHVXDPGabNfwtPrLXuWO/uk4rLYj1bZsPw8vBbxc4uh6MpuRfxUXcRmmE/58CK
	 3o2Ei/eGQ/jB0Ievfsun8sRTcl91JHFPIzPEGychnXO+ZcaUf3rGJXqxJe1IhPk0hK
	 FZGXSPDFBiHlA==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>
Subject: [PATCH rcu 02/15] rcutorture: Start rcu_torture_writer() after rcu_torture_reader()
Date: Wed,  9 Jul 2025 16:12:02 +0530
Message-Id: <20250709104215.15562-3-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
References: <20250709104215.15562-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

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
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcutorture.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d1e0d61d8815..a209d2419cfd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -4246,11 +4246,6 @@ rcu_torture_init(void)
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
@@ -4283,6 +4278,12 @@ rcu_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
+
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

