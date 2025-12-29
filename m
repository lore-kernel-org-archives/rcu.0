Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEC2874FF;
	Mon, 29 Dec 2025 19:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035640; cv=none; b=WwzX0vktYqf3uvRM8LdZR6R9XqRCFYKQjV+AbZW5bu0Vpx5sh4Y24KB/ajlosBHpu3rPCaMFUU+apbx9brtrHCYvT1mtM/c2eIpXuF+ZC4oBAKHKbc2//7/5pd0shtyvWrKutozII7xtL1JDFOmK0cr/LESeIuLWR+AeWag3D3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035640; c=relaxed/simple;
	bh=HgAwY3wlHrQUmWmjO4oRSPl4cMdqBMH6VaPUV/rKWFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHdQuOcAO4ZE+iaTHJuX8Y1A0oo5PeABNTS7mazS/LbD90Z4lr4aue6bk6U9SvK++E1LWGLGNQLa1VfRlvBL2L0R2Lwvbg/fhV+lhUBmRkH2G+waebhpN/zN1HYV+k2vGvrL4yjOYOlvPzCDPd3uZfRA13N81sDuxeM1l6N9afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAnyumhC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAnyumhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8277C4CEF7;
	Mon, 29 Dec 2025 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035639;
	bh=HgAwY3wlHrQUmWmjO4oRSPl4cMdqBMH6VaPUV/rKWFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAnyumhCl6LmFXWkilZ8TMBQHPdvpvZy82Xv/+KEAuRUgUA8ZbWox+F0h/2PbaxzM
	 lDOKl0Xz+Ir/hNWAP+lzzIa3wFoqxR8x2vwwj9DqS1t9j0xoAm/jwuo7q7CdIbikp3
	 zWrA4/B3LUUnVUd5GWGb6XmSl2FjHTuefXn7BjOjImDFfVXEApjdCOAJfzd70UYoXL
	 mttCLkPMoQ70tl7bWb+nbJiw5BtCr8HtzkDdxV+LPhzr1hVQhezkCmChCHJTJI12iL
	 mxo4MbT8oe65V5OL7wd/RQQJesPJdT5stK1vkeHTqYmgS7rTCjsAfdTL6PQqBAEEhK
	 HvRtC9yEpzOkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8C665CE0C97; Mon, 29 Dec 2025 11:13:59 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 1/6] rcutorture: Add context checks to rcu_torture_timer()
Date: Mon, 29 Dec 2025 11:13:53 -0800
Message-Id: <20251229191358.693753-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
References: <eb69cddd-2e89-43a5-ba61-95af1d820dc0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds irq, NMI, and softirq context checks to the
rcu_torture_timer() function.  Just because you are paranoid does not
mean that they are not out to get you...  ;-)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d00b043823aef..63053031ade21 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2454,6 +2454,9 @@ static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
  */
 static void rcu_torture_timer(struct timer_list *unused)
 {
+	WARN_ON_ONCE(!in_serving_softirq());
+	WARN_ON_ONCE(in_hardirq());
+	WARN_ON_ONCE(in_nmi());
 	atomic_long_inc(&n_rcu_torture_timers);
 	(void)rcu_torture_one_read(this_cpu_ptr(&rcu_torture_timer_rand), -1);
 
-- 
2.40.1

