Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369841441E;
	Wed,  7 Oct 2026 20:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791406769; cv=none; b=C1ZjWcla8my3w6E8hZIkk9FEA9farB5Rz/K/7EU/+VN8LSV1fihs9XqJXI/uD6j1zZjPRLMbQ9GkO3xul6ZbLkn559EdE9EgFQz1CE8qUvVH/4qM1QMFb/151K7YOz+n+7ols1dbgj4YwGgaeO6Ilb/Qth5gH2uL7zQP+eMC9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791406769; c=relaxed/simple;
	bh=sgL7YLtpfztAKCpu7MpMzh3KRo1zPynwKLFAkjz9W3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaWfHCZ+Cu81UBkAnFi/FIUVOS2vbqmcdqZBH5Bcm3EfdaIY9j3W1g5l1lpyenpButwH1+/38X0TkygAPZ6Uw9wFcooVnGZ9DgSry0mh0KrjFl3F4kaX5bxrvCYxzYRJCr9ZZKnIOyMKt56/02BKF2gvtfbSllHPcI47fCoAVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPy89/GZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPy89/GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59B91F0089F;
	Wed,  7 Oct 2026 20:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791406765;
	bh=DWvX8vDwFoZjuOlvA5zPtI5PHodCQDl6radtWp17sXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TPy89/GZlfbuAcWr6wdfi/ujHkIZ3kciagLjuk5vGhAL+gTJYcALhGsUXphkGJwOY
	 uYlttQNpur6ndB+OJ/W3UuMyiJ567V5OilQJbMjCARsOdQa1Qsz6y9RepARXgpZx4n
	 hKgei+L0PUAsx/a19E+zTOOdR+uUlxvW0zALyBYDPQVd6xZ6D+FsuIG1x57amWAMCQ
	 CXcg6ga1twmM9csIdXJHzclNYk2Y2iUnhJYiDZlq1bmhXUhoXmpQqweoNdwJpKmCzX
	 y6OnwR0YV0XcgK2C8gU1mEQpliUYz4IFzbj5lSfwZAQ1FAyC0pe4ObZREGrxpqIVvt
	 aWRlVvx8NuSXw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2893BCE274F; Wed,  7 Oct 2026 13:59:25 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Aring <aahringo@redhat.com>
Subject: [PATCH v2 10/21] srcutree: Explicitly note DEFINE_SRCU() needs for srcu_barrier()
Date: Wed,  7 Oct 2026 13:59:13 -0700
Message-Id: <20261007205924.1983367-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
References: <546c81a7-f677-4d8e-a304-746b227058b0@paulmck-laptop>
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
index ad9d9658b0a2f..93b76e5438943 100644
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

