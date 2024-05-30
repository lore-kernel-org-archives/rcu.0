Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B11317622C;
	Thu, 30 May 2024 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076781; cv=none; b=orGlTqE9y88SWxUSIUzieLfTjNTplmcQBuxOsrGRg06l+Phb3prG1grB6FalgFD5TAvwtaD1WLhO9c02v3v5FBXfu1ixZjph/VPR83dhrK7WUpQtaFUHsV/mraOFKc4UhlSBpU5Ltogtm9mg64x4t9r+VPZ1qGdQj4HFeQbJq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076781; c=relaxed/simple;
	bh=G7hgw2ekfOoOLYzqZVIcD2ljsQr8OX70amcE7dyLSUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEvXaX8C7TEYYcm/2Y1Rk0UoApNMYtHQhIvRbf7E5u3lSGeSLM79sLbL6ecMwkD0/hpktiHW643szjh1DpvJW3PnYX/BIQjI4g1zq/ybBKsOTeZnH+KQHi0t28fsQ6hLXYmN5rgD1dslvOsGnWNxegU+JqK3wUV7GnUXTlQ23S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3Tkc9cE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3Tkc9cE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6BBC4AF09;
	Thu, 30 May 2024 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717076780;
	bh=G7hgw2ekfOoOLYzqZVIcD2ljsQr8OX70amcE7dyLSUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3Tkc9cEw3jhxmznAFGQwQw+0ZMcZRVyAMfCJRBk51b3hyTrGmOxnIfdrqEflI8Mu
	 C+yeAs/FIKtqWtmkhiFik/rS7mKQuSfzU+8DibRhM2IsX+V22Fb8dycjMS2uwbMbFz
	 OpY9xz6MCE5jv6Kdq1GFF2rpPnCmdSMNPtfuX0zWmQNmA8PcfOonyN8oJNPG5mU905
	 vTiK3mtJ16aoJYkar7FaEwUBw59SzHimY7dTj383F//trdn8wJvtfNaNsF3ibLp8lp
	 mYy6Q3xYD0+JqI5Wem1S3tMEssqmOA3ICU0pEzGpyzQ+ae5+ifjtzodvJIlHDRK80P
	 ajxYr7SPEGwzg==
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
Subject: [PATCH 06/11] rcu/nocb: Remove halfway (de-)offloading handling from bypass
Date: Thu, 30 May 2024 15:45:47 +0200
Message-ID: <20240530134552.5467-7-frederic@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530134552.5467-1-frederic@kernel.org>
References: <20240530134552.5467-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bypass enqueue can't happen anymore in the middle of (de-)offloading
since this sort of transition now only applies to offline CPUs.

The related safety check can therefore be removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree_nocb.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8e766396df3a..af44e75eb0cd 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -409,14 +409,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		return false;
 	}
 
-	// In the process of (de-)offloading: no bypassing, but
-	// locking.
-	if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
-		rcu_nocb_lock(rdp);
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
-		return false; /* Not offloaded, no bypassing. */
-	}
-
 	// Don't use ->nocb_bypass during early boot.
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
 		rcu_nocb_lock(rdp);
-- 
2.45.1

