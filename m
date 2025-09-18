Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0912F5A15;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191395; cv=none; b=soq6LoTvLZA5zdWeOfjBGdSpCq4ixpq7vy+VAKCrX0k0BVG0v86+ocEuqkTLOQBFGh2xmX3Ucl3c+bXt3DzNd89IlPkh+HBKTCQFyBH/MqEaZf//OR7EncsQnYKwCjY2ovbpaVpVsZcubSvwYyEjvDTaOdXSAjQMX3Zmg8WVioU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191395; c=relaxed/simple;
	bh=Ojqjdl0xYa7AVJyJ5wv5zQIWfqAIqiKEl8ukMG3AfY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YvW4aKlzN4gjEKwSJ5Eg7pE4LhJoqeWZ/lnMBWuWta82/NuYYy5LQ9Ubfj8wfnDP0+lwF8F/0INnZIOe5RPJGtGV5yI1Lemch7kQSI7JlDB6KUd0BvQM9jWeez0uGGOnKTnGL7te7qRbNYwa0cbAhvQotwZO4zv7o3Rb/fH8puE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovpzRpnd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovpzRpnd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABCEC4AF0B;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191395;
	bh=Ojqjdl0xYa7AVJyJ5wv5zQIWfqAIqiKEl8ukMG3AfY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovpzRpnd3iqgvMkrIcyIJ7iD6j9tdkuJFrMmoWCxBY/KjqxgndrfLDrc5ZzpWGoTM
	 n5XPPiB3Eq5A6feGiDRwCsSmFpI3TQ4338H2iYyOzsoRJREGfAfJbu354TwoBl4AKn
	 xVvfuHrlpadn1kzuUl3Y0sz6p0qgaTIbSLR0eCwI/iNTi4MM1i0TVlKnAqyzl1G/f5
	 cmDfxFvXdxa3DhKzzRTPk2wFQAvb94TRTX+Ya/eF7qjmPwzSh3MWeO3AwzVvaWxfpF
	 kuoEUvbpTN2KlJq21GnmoV28QT/bCqhkJ33KJ3pTviKMaBzopXxqC93JqdxPVMEPSn
	 JzaPas0UMMEcA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E3B6ECE11BD; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 10/11] refperf: Remove redundant kfree() after torture_stop_kthread()
Date: Thu, 18 Sep 2025 03:29:51 -0700
Message-Id: <20250918102952.2593045-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
References: <c0edd79a-f988-432c-b08a-18793b2e15d9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>

Remove unnecessary kfree(main_task) call in ref_scale_cleanup() as
torture_stop_kthread() already handles the memory cleanup for the
task structure internally.

The additional kfree(main_task) call after torture_stop_kthread()
is redundant and confusing since torture_stop_kthread() sets the
pointer to NULL, making this a no-op.

This pattern is consistent with other torture test modules where
torture_stop_kthread() is called without explicit kfree() of the
task pointer, as the torture framework manages the task lifecycle
internally.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 5840fac06feb7d..7f3d23762ef7c7 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1135,7 +1135,6 @@ ref_scale_cleanup(void)
 	kfree(reader_tasks);
 
 	torture_stop_kthread("main_task", main_task);
-	kfree(main_task);
 
 	// Do scale-type-specific cleanup operations.
 	if (cur_ops->cleanup != NULL)
-- 
2.40.1

