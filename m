Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E872F12C5;
	Fri, 31 Jul 2026 01:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785460045; cv=none; b=kb29n93RTBZlJ8QZuxP6LHR9+jMKKKHj/xVJsh+TqDBgjdmWe0pfCThscruqQdbEsttQ+NcYPJ5Gg9aE/SqFURj+mAB3A9/iZWzJ4K0QfZk5dkVtEBZNVo40ymEBEnsHa2TluWjt+w/MCoxxBNL4G4x7sdkfKXHnQkWCLrtHZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785460045; c=relaxed/simple;
	bh=xuRR3yoZpoglrYbBFUEfBGgutY7lZOA51A8NkDzJSdI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ey30QMc0r+X5qKQBjpH06UDVgQ9nbxM+3kKlLLputAAqye37FU1YRXjfeMYc5ncApWlCTQopkaAmF1SlyjCqvm7BlLDzp+HDEcXhGKh9vICqSHj0/+j1Kek9cAzT5FECmzGa62jicirjruRVwE2TllpCQqKmd9+QFMBFhfSLf3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4HkN3Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4HkN3Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197A21F00ADF;
	Fri, 31 Jul 2026 01:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785460041;
	bh=NgywxFLfegxFcuoGNSLhi1JpBpo5ReUp4CkoUNjAAGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H4HkN3FcGpHrYk2A4IJdfZOsjdKWf5ZyIk2ik7OTY1RhwrHokcArjWPhQHtUBSJxk
	 zrozvudPqH7n+hFjlcVAAaJXL0WIvWi8TpPw+iExrFfYlj1AaP1anEaORgp9Ptv+F1
	 HUBpw4pRgZUfH7RokTufqS5UoNerU3CNPHD/W81JIgpU2Fg8l6PboTeLlzu7ZkSfPX
	 OlN5NgW4Gwok2eYs6aEYPjwR57bCHT6VFymcWsbSIWTkugcQg0iLZCGcBgYCrv0/51
	 GgKhfN3ag6vZZphTXx0miqVNMwuG9nrbzh25iVOB2bpQx/S0HlLAj/mDA94gx1bGJg
	 V3Inc0NKD2rag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E1EFCE17C1; Thu, 30 Jul 2026 18:07:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 12/13] rcutorture: Announce declining to forward-progress test
Date: Thu, 30 Jul 2026 18:07:18 -0700
Message-Id: <20260731010719.3531912-12-paulmck@kernel.org>
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

Currently, rcu_torture_fwd_prog_cr() announces function entry,
but silently exits if rcu_fwd_emergency_stop is set or if there is no
->call() function available.  This could cause confusion, leading people
to believe that rcu_torture_fwd_prog_cr() is on the job when it is not.
This commit therefore also announces the early exits from this function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9180016d87c0ce..46d97055c2fcde 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3623,13 +3623,17 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 	unsigned long stopat;
 	unsigned long stoppedat;
 
-	pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
-	if (READ_ONCE(rcu_fwd_emergency_stop))
+	if (READ_ONCE(rcu_fwd_emergency_stop)) {
+		pr_alert("%s: Emergency stop, so no forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
 		return; /* Get out of the way quickly, no GP wait! */
-	if (!cur_ops->call)
+	}
+	if (!cur_ops->call) {
+		pr_alert("%s: No ->call(), so no forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
 		return; /* Can't do call_rcu() fwd prog without ->call. */
+	}
 
 	/* Loop continuously posting RCU callbacks. */
+	pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
 	atomic_inc(&rcu_fwd_cb_nodelay);
 	cur_ops->sync(); /* Later readers see above write. */
 	WRITE_ONCE(rfp->rcu_fwd_startat, jiffies);
-- 
2.40.1

