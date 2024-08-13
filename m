Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76FD1AB528;
	Tue, 13 Aug 2024 22:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723589818; cv=none; b=aTSIE2ND5AfDf01EumCo8V+7lqpmizfRdbdBsX49/oXuQ4DllNnsGzQRJdkrdjouPFDXL9s+YulyejXkcqRCw4ik8puohACo1/DygZO8uz3LCxuFUzLMcxm4Pa1UjiRHMW8VchwtELCisCNdt0Y+QidQAEA4ObVnpfQNQmf6QDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723589818; c=relaxed/simple;
	bh=uzSPe7hDnBfbvVFiLqJZzljHfbGcKr4WlCE9pNxHl94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiE1HUCxrreIY4yevUKkw/DXqAW/xQDE5jPR+rK7AAAcOvltiGBJqmz7s/NbYyzgT6Sg6qPQfet6N+6egIka8D/IMURTT0rWREbuPdos42UNw7lygpzcXZx7e50xITXEtO+4wb9299wcjJthXhFwXcPC0e/oe3dYd8BJl0XDKgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn5GtNEP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn5GtNEP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AEAC4AF0C;
	Tue, 13 Aug 2024 22:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723589817;
	bh=uzSPe7hDnBfbvVFiLqJZzljHfbGcKr4WlCE9pNxHl94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jn5GtNEP0GkzXMTw46MyqEC4LjVcrP2oX6flTEe22Mpd7KIV/cR+MOztpdWJgbBuZ
	 gpvEizucKUfBw+j/D73kTleDmB87GA7bETVWEeezCRTTjMbpmpbGgR9Rx5FaJsPlig
	 B+6F3Wq1kIu+k1MVMyGGghGeFoupCuLKVxilupAmvvQHRE+IpkCIXer8zE8mODGO4T
	 su84wW4gNFh67ci/1yJ4QSFw8tPJD15NXgPer7psNXF0frkRCPYdhdoV6vLnygdAPZ
	 AbIw/OhnRSK3wxehym6psLXMBQ017cN9U2ahA4LNP7ZQA8ZWtXPsT0l7jHJn5I7rwy
	 qLQCJHOknAenQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 3/3] rcu/nocb: Remove superfluous memory barrier after bypass enqueue
Date: Wed, 14 Aug 2024 00:56:42 +0200
Message-ID: <20240813225642.12604-4-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813225642.12604-1-frederic@kernel.org>
References: <20240813225642.12604-1-frederic@kernel.org>
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

