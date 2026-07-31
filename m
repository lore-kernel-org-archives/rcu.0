Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474D12DEA6B;
	Fri, 31 Jul 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459717; cv=none; b=ozowrpQ6aiSwys9SBm1ysAIOKxUMV9s+pjIahhxjiaviyNxRHQvgnLsbJmDyLUkevjLy/FixH2shXxjIcwY4DX3YuN3N+7EUAwGOzT5d5+dVi4qIcShbdzKTaZMPsIRVN4AV22SqoFvydZPTDIuYH2PPJDdZCpw6zz5OKf8yY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459717; c=relaxed/simple;
	bh=SPQ1/BUBlVcPW0YL9pl+7LJ6fudss7Cc5flDcSz3Cxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHmx3gN014Yq6UlGxRME8hdkfWMOvjqmv6/gAzvXGROoCVD92xtgKtSTTbttodH/EORNZJSAFnK3K6tsVpdGRuZjvhjWL/Tna0E0rSCDWsRd9Sw0ofPC9GuZSbijBHCPp8EqHIcTmqFrc6zbVm6HFWC41Aq/hrfJRUrVllAav/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bprqa4Ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bprqa4Ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B14F1F00ACF;
	Fri, 31 Jul 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459715;
	bh=w3yDZIsaofBYHwPlrh6CqR5JrMhsol0jdD2BGuIKVOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bprqa4Ub3Pu39FxWUhvluMpCYw6kwP6Rpdzoz1SuEDYCPdQYXIC6OSJug+5TheC6M
	 OsycQ9Dd6DtkitMZgy7YJXXuMcz0RtGG6B9PSbSPDZuTMeSHLxuyvoYr7hLjnUrtEP
	 r4KKcA4/ZXbmHxO58VI2kW6E1eBKPkwpxk0cmspavcTcgt5IWOCx1ARl5ZFk8YmeI5
	 Iw5lG58H9djj0ZNQSvgqqKCne6GjLGK1M1KwIfIO/BMvvQsUTPN6ndekzRaqp2gRso
	 RbufSTtPMqQKkn4Mci2ZZ3e50GBlHhTSF5oFA25VkVlUB/PN+JyfLbikO7Wj+cQa+4
	 tQkR+twwjNpJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5242CE1497; Thu, 30 Jul 2026 18:01:54 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 08/16] rcu: Use WRITE_ONCE() for ->rcu_need_heavy_qs
Date: Thu, 30 Jul 2026 18:01:45 -0700
Message-Id: <20260731010153.3531313-8-paulmck@kernel.org>
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

Currently raw_cpu_write() is used to clear the ->rcu_need_heavy_qs
field of the per-CPU rcu_data structure.  However, on x86 this is a
normal assignment, which does not play well with concurrent accesses.
This commit therefore upgrades the uses of raw_cpu_write() to its
concurrency-safe counterpart WRITE_ONCE() of an rdp pointer obtained
from this_cpu_ptr(&rcu_data).

KCSAN located this issue.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 03a43d3d261607..91d5b4dd08bf5c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -357,9 +357,10 @@ bool rcu_watching_zero_in_eqs(int cpu, int *vp)
  */
 notrace void rcu_momentary_eqs(void)
 {
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
 
-	raw_cpu_write(rcu_data.rcu_need_heavy_qs, false);
+	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	seq = ct_state_inc(2 * CT_RCU_WATCHING);
 	/* It is illegal to call this from idle state. */
 	WARN_ON_ONCE(!(seq & CT_RCU_WATCHING));
-- 
2.40.1

