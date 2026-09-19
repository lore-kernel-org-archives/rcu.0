Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D1431C567;
	Sat, 19 Sep 2026 00:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778136; cv=none; b=WSaNGKZq3oP6+19TSEL0PFqJmlFjNphgUNBSpDgqsJ89zdnzVJ3gXndoSEh7svIL0Z/WL/2UBkXPpVBh0ArPjTYtuN2WfLRuRC4AwKiuDvQAJypnlPwRN18MwtIyfNeBnZ3ziAl4AnEmTiYEOJvvPSErHCAAgrIPOfyz5Oa94Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778136; c=relaxed/simple;
	bh=pt48vUobXpPRVmkomV+/cYJIji1wk1FmuXMzhgi/024=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PyMHRaF4LJ8jUfKkIcsX5UDn6t+/y3lqXum8cSGaMZPDBgm9ui42mj8SYb/PYmoAoxTKxwO70Diu2gRwXHaJ1J2UzSKNSASTeq2tnUpm+VzWyb5dxb1lPDXhD1pT1KwrHfJoJA6OBPBOi4yXl6ssA0UCnuvJJ5dPlx3j98z/te8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYtFbiY+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYtFbiY+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3708B1F008A6;
	Sat, 19 Sep 2026 00:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789778123;
	bh=zSV7e2Jyzg57118bTg4VEFYNrh7eGqPVYX/zEoCkQjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kYtFbiY+zackLeuxHxTTI8Vcczc4SyNdZS7lzcLmfGojg1ADkE+RTJF/g46uG4np5
	 iHZaMgr8gWWGtyGq/z+Y9XvtaN2E65Sq+qsCNqM9L38QZnri0VU5dO7dFaYr1wO/ll
	 XDxVfiDu3BG0kDTYI89xqX+2nxa6oXfc54vFFLMaBF6h4AEIRNtJIAPaWxPg8aUFsK
	 DewKCbOTNeB0Z+KWhr7Ifq96Kh7vXmWPkYMk+WcZDrzmuSSm1CZbJ6qMdrfisrpOme
	 byyFNTjkwqM6pVwXU7/4Y41vXQkqBpbhxXnjSalLQ4ZlqXchp8ngPqiN5SBHwZkjyY
	 B+z32O6PdMsSw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AD744CE18B4; Fri, 18 Sep 2026 17:35:22 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Aring <aahringo@redhat.com>
Subject: [PATCH 11/19] srcutree: Explicitly note DEFINE_SRCU() needs for srcu_barrier()
Date: Fri, 18 Sep 2026 17:35:13 -0700
Message-Id: <20260919003521.3134552-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
References: <13d6be93-8d9d-47a2-beb0-99c8a90938d4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the core kernel, an srcu_struct structure created by DEFINE_SRCU()
or friends lives as long as the kernel does, so there are no particular
requirements surrounding the end of that structure's life.  In contrast,
when DEFINE_SRCU() and friends are used within a module, the corresponding
srcu_struct structures' lifetimes end when that module exits.  This in
turn means that if such a structure was passed to call_srcu(), then
srcu_barrier() must be invoked after the last call_srcu() invocation
but before the module exits.

This commit therefore adds a comment stating this.

Reported-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index ad9d9658b0a2..93b76e543894 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -214,6 +214,12 @@ struct srcu_struct {
  * instead of smp_mb(), and given that the first (for example)
  * srcu_read_lock_fast() might race with the first synchronize_srcu(),
  * this different must be specified at initialization time.
+ *
+ * If you use any of the DEFINE_SRCU() functions within a module, the
+ * module-entry code will invoke init_srcu_struct() and the module-exit
+ * code will invoke cleanup_srcu_struct().  This means that if your module
+ * passes the resulting srcu_struct structure to call_srcu(), you will
+ * need to also pass this structure to srcu_barrier() prior to module exit.
  */
 #ifdef MODULE
 # define __DEFINE_SRCU(name, fast, is_static)							\
-- 
2.40.1

