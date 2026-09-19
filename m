Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB342BEC52;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789777743; cv=none; b=BIUgWDlLUxbXxF67JOK24d4xJD0wVQLgbSOC+yWI7jpzoBtMlnkKyfmA5vnTns8DaRuTXkoMpzquCgRH2MDirJzQOxlBLdv9uUeg6ggM7UY0a8LaLQQm7vT2jBuyLYKdDIGhJbIxrTlu0lEDnxuoEN7MCJD6PgaU/rXVjBD53nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789777743; c=relaxed/simple;
	bh=5r0aFJMilyxPVZDw8S/Q4b5gXvI9CvR2/hEGzwjj0ek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PT0LNNKbfqOPqjfrzFGkvAL6zZ13EPkqkKoNRHV9dF1f+XlMSv1JWOb/9h6sRQQWr2MB/wK66xopPv5BeGfW29JK9vLWb4Db3kHx7FW/Vxt+aoZqsGRMkXm9V5AEUFrSSKEzH1bTe1IUMmyZt/iBDfV46yfelC7WKTWYnvAOoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbiAOdnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbiAOdnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AD51F00898;
	Sat, 19 Sep 2026 00:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789777741;
	bh=h6pjivworbIGRJpU93SremiGz1qvF7jjUU6p8kqS464=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HbiAOdnLClpxYVogK8oljTu+qktTwpOojvOV3/3Y3EkvZwZrAy2IhZJft/NLOnDcB
	 MukW9scWRb6/n3BB/BG3B4xkgfBIvXf3Nx+TtBuXvnfLqD2lcxZPitT1onPhB7iEqH
	 ksoYJBN/U7cYCSlXXGA/D5oF9TSMXIC3Z7w1s+70NVU0vO0RvqZ2ORCKTy+ezUXN6A
	 da7vhN9qmz/MJjBCzuizPyWAgf8xEu8whEZF5Fj6nqgbJsQTX/viFE5b9RUsWkhwCs
	 3nm///c4C7QelF8EKlbBkBuKGJcYdjSCDIZqhLmjn/tgwF+v0LBCF0DoFn/Pcx8W+d
	 lY8zxz/Ia0dpQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4A737CE178A; Fri, 18 Sep 2026 17:29:01 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Longlong Xia <xialonglong@kylinos.cn>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/9] rcu: fix shrink budget underflow in lazy_rcu_shrink_scan
Date: Fri, 18 Sep 2026 17:28:53 -0700
Message-Id: <20260919002900.3134117-2-paulmck@kernel.org>
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
index 19bb42672baf..b6cfee4e5039 100644
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

