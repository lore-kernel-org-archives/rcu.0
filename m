Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ABE2DEA7B;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459717; cv=none; b=Gc4CW2oNSb2n7PIFhm1Fj76KyUUuNQ/91mHhkjM1+3H3co5wbBCuthAPJjsZOrnJRevGVGfVl0JyE0sx0uwRSvCJBk0zz5I7Fmy4riiC0XrloddWNC134QKbbVoeJHbeV9VaUh+pNzLptMChdLryr+IjAo1OXJcrvBvkw9oJ0KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459717; c=relaxed/simple;
	bh=pCRX8+l1IN+X5y8V4I17znb7He/4+TOcNXkyr+OWpN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnxyF4nFugOjAi2XovV35Ze3DYoMWnhNaq4Ald2KMbNyLNQEuBI6I5QAS7omtRqbJqJdwuLEALaZda3CbUd6K2v7pYCXtpzDGK3QRx5D8oloR8HqmW8qQEk1g9AYFJoMBq3xQ+ccZalK8ua4HzXlSppa518M7w0jX6eSLGYQSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpL0Fkl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpL0Fkl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324101F01558;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=CbTCQ1g3TRtR5B10oGb8BErMIh3Q8zsIuXKRGr+KqM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XpL0Fkl4WUWPPNFJN7KdODAGnIaj7fsUdfx+nbmxTrB0UZ8ld/saHw3WFsyKNr/2A
	 J6xerWoAjFrZTtxkVrodt/kviMiwndzlgDZ2+fiFgqp9x3JbARlDpk3IWTB0sVujzh
	 u4SjYqwvZ7F7N+wpM7f/K24CA33h4hucGDK2KHdPo4Nxx02e6b48DU0ksueDctp9s5
	 DvJ9BIu0soDjgBTa9e4N+ZJkS2VBuJPbX2czupbTfM80+oxkSQ4altU6U7WE70BX4F
	 ssnQk5xa+Y77uSL+OIj2DrHfHJG7wHphSczK9CNfM0QFzY7gl+IHq49MaJAFd9Llr5
	 R4wce8Jw7h/+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B774FCE14D9; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 09/16] rcu: Remove unused expedited_need_qs field from rcu_state
Date: Thu, 30 Jul 2026 18:01:46 -0700
Message-Id: <20260731010153.3531313-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
References: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joel Fernandes <joelagnelf@nvidia.com>

The ->expedited_need_qs counter was part of the old expedited
grace-period machinery that spun waiting for each CPU to check in.
The current implementation instead tracks holdout CPUs via the
rcu_node structures' ->expmask fields and waits on the ->exp_wq[]
wait queues, so nothing reads or writes ->expedited_need_qs any
longer.

Remove the field to avoid wasting space in rcu_state and to keep
readers of the expedited code from searching for nonexistent users.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4069132f9d4446..587bd71396eaa3 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -391,7 +391,6 @@ struct rcu_state {
 	struct mutex exp_mutex;			/* Serialize expedited GP. */
 	struct mutex exp_wake_mutex;		/* Serialize wakeup. */
 	unsigned long expedited_sequence;	/* Take a ticket. */
-	atomic_t expedited_need_qs;		/* # CPUs left to check in. */
 	struct swait_queue_head expedited_wq;	/* Wait for check-ins. */
 	int ncpus_snap;				/* # CPUs seen last time. */
 	u8 cbovld;				/* Callback overload now? */
-- 
2.40.1

