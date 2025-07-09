Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050528EC1C;
	Wed,  9 Jul 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057975; cv=none; b=NOjobmSRsPv8HYsRUAENfqAMbiulnevPH2qE3tLcDBMLI/gKGS+xDKhSj3rFS2nVnssDmu2dMWznFY6+r7SNydPEFhijegdDcoFdxGa556z27FPuzEXo5seRRru2kYhQ8c3QirofmYVHwg9xkrp1ByzunVOeHHr1azJujy53AYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057975; c=relaxed/simple;
	bh=8GTuELIWEWxwQDkgCyoSIjG7otZYJYRfYglBdDVAc0s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wc26GGOrCQKYdEaZyTnGX3+FzGkpm7iDU+qDoYc25gn/sHvsvA+OcfiiNSPR0hfInYLn5ZeGjKf7YgbOqi5PCn1/pG+LVQCwnXszey8dUVW7aQVY/USrm11YVc/rRxSRHVBT7IJOWGIYPHZBwI51iDHqnckQ3AYUzvVcjpda5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh0ekbKd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh0ekbKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34813C4CEEF;
	Wed,  9 Jul 2025 10:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752057975;
	bh=8GTuELIWEWxwQDkgCyoSIjG7otZYJYRfYglBdDVAc0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vh0ekbKdJVLwKq1Fmmie+dhsX26iQZXbXGzyvJ0HWpdtqbkYJUDApYBSpPKvMA1d1
	 pJwLoNQpVCnUUMUwkPrJ408H+W2tNlUDu0pq0qRx9/MMKEHBQg2BrX98YMyEIpTaOm
	 SuxGpaBMnSghwiY2XIB/Xaxry/l3h8grCknzLjVIIY7hPnr5F6Gr7gvJCC7ifMe6Du
	 BXtC62u4O8EvQBISQPMMQO4vS/vKLS/chVIwM/GyPq+mDEQjLb8oyyK26EWn1x9cLo
	 P9PzogaWHBHCDJceqBctX8LT6hY+NSEVp/vOeX06ZeAn5JobcGsrjtg3RRsL29uToo
	 ZtL4iKrvm+v9w==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	joelagnelf@nvidia.com,
	frederic@kernel.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang1211@gmail.com,
	neeraj.iitr10@gmail.com,
	neeraj.upadhyay@amd.com,
	"Neeraj Upadhyay (AMD)" <neeraj.upadhyay@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH rcu 1/3] srcu: Expedite SRCU-fast grace periods
Date: Wed,  9 Jul 2025 16:15:53 +0530
Message-Id: <20250709104555.15670-2-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250709104555.15670-1-neeraj.upadhyay@kernel.org>
References: <20250709104555.15670-1-neeraj.upadhyay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, SRCU-fast grace periods use synchronize_rcu() to provide the
needed ordering with readers, even given an expedited SRCU-fast grace
period, which isn't all that expedited.  This commit therefore instead
uses synchronize_rcu_expedited() if there is an expedited SRCU-fast
grace period in flight.

Of course, given an non-expedited SRCU-fast grace period blocked in
synchronize_rcu(), a later request for an expedited SRCU-fast grace
period will wait for that synchronize_rcu() to return before switching
to use of synchronize_rcu_expedited().  If this turns out to be a real
problem for a production workload, we can increase the complexity (but
likely also degrade the energy efficiency) to speed things up further.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 48047260697e..c5e8ebc493d5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -502,6 +502,8 @@ static bool srcu_readers_active_idx_check(struct srcu_struct *ssp, int idx)
 	 */
 	if (!did_gp)
 		smp_mb(); /* A */
+	else if (srcu_gp_is_expedited(ssp))
+		synchronize_rcu_expedited(); /* X */
 	else
 		synchronize_rcu(); /* X */
 
-- 
2.40.1

