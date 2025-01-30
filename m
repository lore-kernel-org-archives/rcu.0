Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543A1BEF84;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262968; cv=none; b=spC5t8iiOXWxT0Fj36NuPpCPd3itbNF4vJGKEJ9V/idR6wU1b+5SWgj+Kdi8w9nizYCY9nzZuPRPFFotLeOKMjlDud20aMPlmMVJXR3qRwVz1Zp+kzmZYniD15c97/wEb4CehLmISXUnPN0dpmfSkfshJzY/h70bGP2PcWuhCY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262968; c=relaxed/simple;
	bh=hppjbdGwAgZh5PQvuEjTAlQFTjFVaIiFFrVhDyXxF0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EsARO1t8nckDaRH2qtDQGzmkdbQbr2IL6AU29RHFlg0ilaPodarp4gFqJC9qI9mOxM6SSiCmwAN5XNd0qdXNwE5s77geGSanUrYeVK+EP9Eele9wCw2bYOBjlu/oygIuAxKZ+qPlKncxF9mLJyZkxrItK1X8p1VcGh/Lgz1pP3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDg8V2FQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDg8V2FQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9802FC4CEE1;
	Thu, 30 Jan 2025 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738262967;
	bh=hppjbdGwAgZh5PQvuEjTAlQFTjFVaIiFFrVhDyXxF0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDg8V2FQLussyptYSfVR/V73YPFEE7HkQGCsNzFNPiAcW44Ze0Xo1LLTNxLdFtbhY
	 YUkSpEMoXl/YK177X08sJG+4ZmunDooTFpYamnunaZ/5jc+MVoOusLO/mFFBuJSKfN
	 qmJd+hKmuaiT9VJiYPR1j9Uxn+S+47/3SpdhTTqhXO3l11otSdU9/9OeB/c+Hhuxjo
	 i0XfHFpeiv0bjPX8ZunAK6VvEXD6gqLRxOkfX4mnqzxfnm8Oq73Dy+FMA91auKY47k
	 JZLzN78EYA9cZciKKHEBNVTIVrYq9zqFgg4U+jYWQT6twZGyMxkmq3rYRvJmcR2TAR
	 IFfocnS1HCdaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2E509CE37DC; Thu, 30 Jan 2025 10:49:27 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH rcu v2 3/7] rcu: Document self-propagating callbacks
Date: Thu, 30 Jan 2025 10:49:21 -0800
Message-Id: <20250130184925.1651665-3-paulmck@kernel.org>
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

This commit documents the fact that a given RCU callback function can
repost itself.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 24f1cb292a92..befe35058c49 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3128,7 +3128,7 @@ module_param(enable_rcu_lazy, bool, 0444);
  * critical sections have completed.
  *
  * Use this API instead of call_rcu() if you don't want the callback to be
- * invoked after very long periods of time, which can happen on systems without
+ * delayed for very long periods of time, which can happen on systems without
  * memory pressure and on systems which are lightly loaded or mostly idle.
  * This function will cause callbacks to be invoked sooner than later at the
  * expense of extra power. Other than that, this function is identical to, and
@@ -3159,6 +3159,12 @@ EXPORT_SYMBOL_GPL(call_rcu_hurry);
  * might well execute concurrently with RCU read-side critical sections
  * that started after call_rcu() was invoked.
  *
+ * It is perfectly legal to repost an RCU callback, potentially with
+ * a different callback function, from within its callback function.
+ * The specified function will be invoked after another full grace period
+ * has elapsed.  This use case is similar in form to the common practice
+ * of reposting a timer from within its own handler.
+ *
  * RCU read-side critical sections are delimited by rcu_read_lock()
  * and rcu_read_unlock(), and may be nested.  In addition, but only in
  * v5.0 and later, regions of code across which interrupts, preemption,
-- 
2.40.1

