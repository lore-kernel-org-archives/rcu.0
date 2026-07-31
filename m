Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239F52E7398;
	Fri, 31 Jul 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460045; cv=none; b=lVVVQB95BYxI6+Nfdi+ZtRk3y71JrVuschP9hMLZXsILe6JslIwGsXrB2IPsmFGPI0hnO11U4b4k8PSQv96nkrh9wAibfT9zOkKESNti1j8vCrYLxbWxtx19Emopc0uGPAks/smB728oRiS0j8mhsb/IbuDrkoqHM37oXUn5q04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460045; c=relaxed/simple;
	bh=D3UihkmaX8iofokhmsBg7ItxFs59XnxNVqvabzZFOdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B9VLmK8Nc3GgSpG1Lek27cgcjoA7kbMg8TeekjJqy/2B5zjJeSpOIWFKxXY/PmQ+Tq2wbtUrORTKyw7gX63GYomT4m4hD6HowQe/Jg2lryRBKiJixBHeFvhUzZnEbhpWQu4JITEaGpDcaO7ihUBJ9wCcusTGaQeh8re/NjvjiaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYjXuXqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYjXuXqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1779D1F00A3D;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=mEzZINOiDiUDMtZrpOsprUlDWOMRe3pCtnaYSb66Rn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYjXuXqs/ZZ+VbtCSFW8y4h9b4/edyOp6N8xPJc1F72z3NMW+clFMwT8ZmBP9cKzm
	 F/bnop3wbcS4O1XqglgblYvFbiLrERP8lIhSVtP2v5ZVi/2AoqfcMCIZLQkCsBQmQs
	 TyoK79XjFUGa4SdxIQqNvq3zhBml+2/xHJ0sj8ylYfzajxy6tBxd2YgMcS7U3UkQQ8
	 ddjbcDzP6HzglxUxymd/nDOlr45PQoE9w5wvLvoDnlu3cBRiKKsOWwEmXN7r0Sx8F9
	 ZzcMGyi28js2AV/ABIqpDqDvyMeb2eelhRkl8zCWqP5U8AyG9FtpxojuERCHZ1PHZf
	 FGoNsgjMZgrgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BDFCCE1716; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 11/13] torture: Don't leak shuffle_tmp_mask when shuffler kthread fails to start
Date: Thu, 30 Jul 2026 18:07:17 -0700
Message-Id: <20260731010719.3531912-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
References: <d1db6e52-06c2-401d-b6fe-85aa588196d8@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

If torture_shuffle_init() successfully allocates shuffle_tmp_mask but
then fails to create the torture_shuffle kthread, the cpumask is never
freed.

Free the cpumask directly on the kthread-creation error path.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 77cb3589b19f9c..8c4e6b2fe8babb 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -577,6 +577,8 @@ static int torture_shuffle(void *arg)
  */
 int torture_shuffle_init(long shuffint)
 {
+	int ret;
+
 	shuffle_interval = shuffint;
 
 	shuffle_idle_cpu = -1;
@@ -587,7 +589,10 @@ int torture_shuffle_init(long shuffint)
 	}
 
 	/* Create the shuffler thread */
-	return torture_create_kthread(torture_shuffle, NULL, shuffler_task);
+	ret = torture_create_kthread(torture_shuffle, NULL, shuffler_task);
+	if (ret)
+		free_cpumask_var(shuffle_tmp_mask);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(torture_shuffle_init);
 
-- 
2.40.1

