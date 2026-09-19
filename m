Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A22F7EE6;
	Sat, 19 Sep 2026 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777745; cv=none; b=J96vgdLQeOiayWYuU6ObQ5AGfjtmbTTkD53vDI7f0PtWQHMFYvFFr3enGsjOjcJfdl7COOg/BwYiDYaZFtfBPtuG9YWMZ4CjqwNkGinPCKi+o2wefysEoiPjfyf8kiLoLKkEo3qh4vdCJYKgH0vs2xr48YeN7a8A0dxs6SP1oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777745; c=relaxed/simple;
	bh=wpzhTNE6Vj0jlng9k4hEaQfN3qQ4FYgzLuPJpIXV6ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pYXiusp0lLq+M1MlHDkLAWjzlktJQD3RoXw+P7OciBkahh26D+N9KibpPafOsCjGXm+xE5JFs4ix1hl95EL+rjlexm61iKFf9mK78vgMy06ZVN2NSx6K8FkkJu+RJ0P983Cib5SQNU70zsX9T3W20TIv1B4TUBhUQKrS3YtFgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVk6qkR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVk6qkR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20F01F0089C;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=Qy3p8GOfYcm8rh4QOnYYu1Kfrm68bdM+E5jFiTkaQT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GVk6qkR+CbyZqIGW3Qh84nVu1uoQ6EClEx1SsCWue0W0NEU4R2A2UF5HrfxB/45GG
	 dakIJa9PovOvbiuVU7LRJV8t5GrbAYsnMCRrV13537CNO5SZY2YqMl598ztVcUOI/Y
	 3BHoPg++bMhBYlsIRqu+/abgJWkF/b80GkzXlH2TpkX0t1UT3DD+X5T4mZsBeU3Wc3
	 9RKg5p9HMhQCNkElBNsP6j/rrazJZ0AauEVoXlML1yb4HUCTbLaEbq5MI2jvZL/IfZ
	 5ymG9+LQUdhYP270gS6O+Kv0YQJaLxQJ7/659Bja5BzkTksmAUHazG3QLLtUy5v32a
	 j/3yMV6NjFWpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5A4FCCE1886; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 8/9] rcuref: Fix the rcuread_is_dead reference in rcuref_read() kernel-doc
Date: Fri, 18 Sep 2026 17:28:59 -0700
Message-Id: <20260919002900.3134117-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
References: <7dc2d858-44cc-4efa-8e94-1fe27d691f2b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karl Mehltretter <kmehltretter@gmail.com>

The kernel-doc comment of rcuref_read() refers to rcuread_is_dead, which
does not exist. The name is rcuref_is_dead. Say rcuref_is_dead.

Fixes: 3efa66ce6ee1 ("rcuref: Provide rcuref_is_dead()")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcuref.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
index 2fb2af6d9824..01fee161b67c 100644
--- a/include/linux/rcuref.h
+++ b/include/linux/rcuref.h
@@ -34,7 +34,7 @@ static inline void rcuref_init(rcuref_t *ref, unsigned int cnt)
  * indicate that it is safe to schedule the object, protected by this reference
  * counter, for deconstruction.
  * If you want to know if the reference counter has been marked DEAD (as
- * signaled by rcuref_put()) please use rcuread_is_dead().
+ * signaled by rcuref_put()) please use rcuref_is_dead().
  */
 static inline unsigned int rcuref_read(rcuref_t *ref)
 {
-- 
2.40.1

