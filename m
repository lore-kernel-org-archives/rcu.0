Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31D3E49EC;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405914; cv=none; b=c2sBbG9MsR4i/Pit+RYULCBZMvx5GNT7Uzp1wr4002FKdRWHPpSkgjMV+RlCBHk/eRfPMEovG/uYfEqOahA6uLarRDmhgOk9SqeddIKZTprIOLOZB54Kfb77vRquKs2+EuRrbTTFrirQfos7QdeHzXKCPtlv+74ZBELuy4wUrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405914; c=relaxed/simple;
	bh=YZc84RjPNXzLQTZU/gzVja2x+cv6M/QPck2bjGVhEZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i1pfkBJVRqIJXJ+5yVrb6pC2JeAgTasLDSfEXyqahciZ2+4Ta97x8pEQBBjxlw9dbtsCSQ2rsZSzoUx/fGx1Sf42bjOso5sZvdnXAoCBvRt9XC7TW6MCn1BVzyW2Ume2mgBxb1pZydOdlODrzccdXO3TPxAOOa8nVi7D0B8X6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iL2cZUVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iL2cZUVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D721F00893;
	Wed,  7 Oct 2026 20:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405913;
	bh=eBnSl7xTJxlcTr2sP/p6Mmh6N18lUIOEQa4wo/jObCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iL2cZUVkufzTcdsqa1iBkuJQ8CuE8Vs8/sGwZvuH4ZSGFfCKK5M6vfBVWwLwdzAI5
	 KqRjTSoDEyjcFAxRScpHW/R8nOFA3jEz5oH7pporvUlfn6m3K/G0vZPp08Q7N6Utm5
	 szoJG/jdwBlNNp5eegCtZJoPRSjw+nNeWssFw7ZbjrtumFeSYRkKr7fZeS4rGdz0v4
	 lnZhf1WSSALL1pq9p7ql22Lnh4BwJ0/BqXwZU6YUcJNX0YdrB14UzwYc8laBHXy2by
	 V51kpO8GRDFn9aHI5UAZiT4EePiQ1XjoFGA2fl/lMpLza3HG6FvFHNf+VjU64l2cWi
	 B6zVv8uSA4SVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26B58CE1716; Wed,  7 Oct 2026 13:45:13 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 02/10] rcu: fix shrink budget underflow in lazy_rcu_shrink_scan
Date: Wed,  7 Oct 2026 13:45:03 -0700
Message-Id: <20261007204511.1982646-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
References: <df33a614-9c3d-423d-9d31-b1846cb1f1d6@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

The lazy RCU shrinker decremented sc->nr_to_scan (unsigned long)
and then tested the result with <= 0.  When a single CPU's lazy
callback count exceeds the remaining budget, the subtraction wraps
to a large positive value and the <= 0 comparison, which is
equivalent to == 0 for an unsigned type, never fires again.  The
scan loop then iterates through every nocb CPU instead of honouring
the reclaim budget.

Accumulate into count and stop once count >= nr_to_scan.

Fixes: c945b4da7a448 ("rcu: Shrinker for lazy rcu")
Assisted-by: Zcode:GLM-5.2
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 19bb42672baf8..b6cfee4e50399 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1332,9 +1332,8 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp);
-		sc->nr_to_scan -= _count;
 		count += _count;
-		if (sc->nr_to_scan <= 0)
+		if (count >= sc->nr_to_scan)
 			break;
 	}
 
-- 
2.40.1

