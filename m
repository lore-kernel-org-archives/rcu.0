Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8B0156237;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737057761; cv=none; b=M4by0BjnkcWOxTonz1NkgHHBGLY9ItQIEkTvYcUQvv6OrZgl7+6Ibu0sqjQgsdL0FC5EG01T5zKIwtjKlADNwbeZxoVTzBOhmrZCc56z0CVbt6GScEjgOv5GtRC1j8bvbocDw42s3Tp0itZ5ZnLBu+DdGTyokFGJbiSHseO7d/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737057761; c=relaxed/simple;
	bh=vpYCxzM5TqeGtWd5gS64X54MnN9UyW5aYLPvOP20U3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fUW+/kxijrfX61s5AD+FAdcHGkd9aKkYrExriOGplBgD+48WlkDGxEU6WtC+5T+Z4YdyMPYHqLw92Xq4y2oQNfXMk2yTYISiZbQouJZkgc399wikdxs2pbZCnwYSTjWOlMn502KHF47e/zaegPDGJi1QkqJO0pn8GEqA4xckeec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYPueWTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYPueWTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87973C4CEDF;
	Thu, 16 Jan 2025 20:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737057761;
	bh=vpYCxzM5TqeGtWd5gS64X54MnN9UyW5aYLPvOP20U3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nYPueWTsbb0iMbGz4SjwMq3BvJwUZQR7QnJLpEQetku5niMZZSDNn2P+Gu7kyyh7v
	 g4sRQNwyVz6Z9CHwtMPNzJmAmwQzKFCVK1dAXpF7xv/2dAh+funVly2cANsm6LLNPK
	 9NZhsji0audzbtp9Jgno6KXHYFOoVW3cYaM8Ze9oyjYmmxXTgpXjueikC9td9jhhsg
	 XRJJcc1RyE3yRDg58NXn47ht2SL3ty1QDskxnTLUVwOm0OxFJC6sYzOyRnQOP900ih
	 rsoaqmlrDyGsi+hI9pNlEMp+knfHFdbcTjdonJNmHn5nTprgx5NoE1GdnK+xvOvuJk
	 euIuEt4fv9meQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2E169CE37B4; Thu, 16 Jan 2025 12:02:41 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH rcu 3/7] rcu: Document self-propagating callbacks
Date: Thu, 16 Jan 2025 12:02:35 -0800
Message-Id: <20250116200239.3782374-3-paulmck@kernel.org>
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

This commit documents the fact that a given RCU callback function can
repost itself.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 24f1cb292a92d..befe35058c49a 100644
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

