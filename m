Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EDC1741D2;
	Fri, 13 Sep 2024 21:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263747; cv=none; b=Ft8QJgycsA8mfmGbvH3WBSb7SBKXyrFOTXRIUGjDbzPnu+tqmhzLv9937Apkm0NMAZO8ony5emgWEpih9LpQCuc5vm6PMLIyHceIqX5JFEXHv1gIWfUCg1LKxjzKe+mkPHHXaB0ip31PoODwgiyFFRg0td/+YGBuh80l7WelaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263747; c=relaxed/simple;
	bh=uzSPe7hDnBfbvVFiLqJZzljHfbGcKr4WlCE9pNxHl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK+7ZSv1tNwQfTIBXZzRO5fSTHBloTvW73hnPaXZdzOaTsjkW397ak9U4ziRs9Li3heM7+0poG4iNLmRFewo5ssUkoyErYSoOCIhp1NcN6I0w+uzqfHl6dKeSZ/B9TwAb7Z3q5iN9Pum/CHw2FzqcFvaHJDYTuxJhN4shLmGCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGJn/uDD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGJn/uDD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C9CC4CECF;
	Fri, 13 Sep 2024 21:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726263747;
	bh=uzSPe7hDnBfbvVFiLqJZzljHfbGcKr4WlCE9pNxHl94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGJn/uDDzv+YCESfMg2kuj8ZSSPBlrR4FFRWm31QOST+//BOtPIw5aGIrvWlQerO9
	 GG6h8uOpnyRcEf9t9p7mnhIzphMryVSHpmQCJzg8fgKNhTiSHl7u+8ip4yLJb3eUjd
	 s3kQzVV9WB6cwUUY+Gsp8/c55IAvqQwmTtyYdH7bA6kPNu2vAtXKdhE786K3GMcJQC
	 irLX22nZDagT3IvDRz9lkY0Ae8yjHP/8/4PEuVr3UGW9fbG4I+ES/o5mYaVwxysIHL
	 TDvZtu54gI5I8FTm9Zx4W8mCqw7N6Qnk+ss6LTmBYgUiOraIrW0rKPpn1uN12GCOM+
	 IAzVXqWapGGWA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 3/3] rcu/nocb: Remove superfluous memory barrier after bypass enqueue
Date: Fri, 13 Sep 2024 23:42:05 +0200
Message-ID: <20240913214205.12359-4-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240913214205.12359-1-frederic@kernel.org>
References: <20240913214205.12359-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pre-GP accesses performed by the update side must be ordered against
post-GP accesses performed by the readers. This is ensured by the
bypass or nocb locking on enqueue time, followed by the fully ordered
rnp locking initiated while callbacks are accelerated, and then
propagated throughout the whole GP lifecyle associated with the
callbacks.

Therefore the explicit barrier advertizing ordering between bypass
enqueue and rcuo wakeup is superfluous. If anything, it would even only
order the first bypass callback enqueue against the rcuo wakeup and
ignore all the subsequent ones.

Remove the needless barrier.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 0c9eca1cc76e..755ada098035 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -493,7 +493,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
 	}
 	rcu_nocb_bypass_unlock(rdp);
-	smp_mb(); /* Order enqueue before wake. */
+
 	// A wake up of the grace period kthread or timer adjustment
 	// needs to be done only if:
 	// 1. Bypass list was fully empty before (this is the first
-- 
2.45.2

