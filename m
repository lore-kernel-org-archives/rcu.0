Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F72F5A3C;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191395; cv=none; b=VuBZE27PlBnIte9Bmb6dZWyjdIrwXyc8t7GRFgyeH1Pjd6DtMXCoou90+w18z3xTujqkcpdxoLaADqNJaYBnWnuFkp9Ab2y5lY7zfTgaKAHNnjNKvxLqIFv8F9Qa1SBAbzQr7SIEb96Ljf9zBCYud77+76z371CxGKt3LIqQCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191395; c=relaxed/simple;
	bh=cqFDloOtTlaPzu/Dg/kSHk8p5W4VMt3ISrqsKrawZtI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RQlF2qf8vxNMN6mJkzixEsQ6nkMngK3qaAjqF5S5FmSK2tZdIkADd2KkqkuUdjK9i5VgJXAWfUH+svDk7Lp3w3usHZqAUDzF9AIQM4P6xedn5y4vK/PswuDa3z3v7qw78WCD1BTUvwQWTxyr+rpHvvH/e4h62E9Hi69Hfr0u2d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXEpahW8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXEpahW8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238B8C4CEF7;
	Thu, 18 Sep 2025 10:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191395;
	bh=cqFDloOtTlaPzu/Dg/kSHk8p5W4VMt3ISrqsKrawZtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jXEpahW8PUP0uzzt0LMPPXwWsjm360l72ObJeUDmDCEQfXxfticM+aIQqWsIaJkxm
	 OE6d7/Y3btvtLa71oY5mzjzR4m2dhkTYtYsbK0AREGWSFV62djQ3z2rDoopjQGoPQe
	 fFAmpXE5F9SYiF3GVMcnNW7XO+ZWIiAZcflBbbKe5elulV8W5tNBYEiNQ77WH72xmL
	 /H8W+4lOOCMVFtevYZToY9xFiOzZOU47ITDY+Zy3ACVClO9PtWo43bYjUlHeGHFX8y
	 1Sc9ziHZQOuw9mFxQrP2KqWcCby545sNuO53ExUvRsP1bLc+ScHTLClPSfQnLRFkwR
	 WXyi/mm8ifxsA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E61ACCE11D7; Thu, 18 Sep 2025 03:29:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 11/11] refperf: Set reader_tasks to NULL after kfree()
Date: Thu, 18 Sep 2025 03:29:52 -0700
Message-Id: <20250918102952.2593045-11-paulmck@kernel.org>
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

Set reader_tasks to NULL after kfree() in ref_scale_cleanup() to
improve debugging experience with kernel debugging tools. This
follows the common pattern of NULLing pointers after freeing to
avoid dangling pointer issues during debugging sessions.

Setting pointers to NULL after freeing helps debugging tools like
kdgb,drgn, and other kernel debuggers by providing clear indication
that the memory has been freed and the pointer is no longer valid.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 7f3d23762ef7c7..19841704d8f579 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -1133,6 +1133,7 @@ ref_scale_cleanup(void)
 					     reader_tasks[i].task);
 	}
 	kfree(reader_tasks);
+	reader_tasks = NULL;
 
 	torture_stop_kthread("main_task", main_task);
 
-- 
2.40.1

