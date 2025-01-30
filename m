Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECE41F0E3E;
	Thu, 30 Jan 2025 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738263324; cv=none; b=qpblz2wYAkGQc8XpfMQh4vpW4sYR3lovSnegt+RZ8nCZry8969CpES3W1dw4lcEzU0Ab0z3mzVmSUDNco8qvo5T580oS/Erk+GW0/8IX4aQkkH/1+zPr0nxgSBd6jVSKY5dOfJ9zvu0AERNb1OjrynJj1D0GNp48xH47OuoYIq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738263324; c=relaxed/simple;
	bh=r9OGFLBkXI9Ri79CPOx+IctSzTqznHVW3Jqiz3LjeDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOMMwcDLsTB99zP+xgHI3XB/5pZQgNGiyQ9gyz3gbvC2r6Z7Y8NIGUZN+OaawEGk+VIIcMJqYwH6oXw/LIyK22BJY059csJE7KMJ9GujCZC604WVDoldhm/PuvmJlg2pjL4rB45CNI/ClZ2r16N6sOOFYw7wo3Fv8ZM/tx46eGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlktGE0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlktGE0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5431C4CEE1;
	Thu, 30 Jan 2025 18:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738263324;
	bh=r9OGFLBkXI9Ri79CPOx+IctSzTqznHVW3Jqiz3LjeDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OlktGE0qttDwi8mmUSocOs7HWq6n43L1zwzh5h4IAqNpDRmQ4t9q/b8lbnnwH43iC
	 Be81GeCFGesnvL8BHlkgFJqFBN7Atq7Nvfgj58877Y++H0q7VsDgosAKGplySrVPY/
	 xesqkc384hJtThx2t+zSlTUBsTY63RWSvib2YXS8FdKT4HDl7reZDkX7fF+Cz+2ZDb
	 4vCOQ+nXdofTz3yBFeeYlizn9lvb8Za7CEwOnNSIuqyqARx/PMeuGR31n5KyHhxghw
	 UPr1VeXZ+oDEHwhpT1eQHsnL8LO7OAcohOneSWpuAYG4p7LaagYx16eXLAg4KfHzte
	 PF+S8rOO2si6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8A9EFCE37DC; Thu, 30 Jan 2025 10:55:23 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu v2] 3/9] sched: update __cond_resched comment about RCU quiescent states
Date: Thu, 30 Jan 2025 10:55:16 -0800
Message-Id: <20250130185522.1652093-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
References: <9bc6e5fe-d49f-495a-9f55-537ed97a3615@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

Update comment in __cond_resched() clarifying how urgently needed
quiescent state are provided.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..b0f7ffcc46a6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7281,7 +7281,7 @@ int __sched __cond_resched(void)
 		return 1;
 	}
 	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * In PREEMPT_RCU kernels, ->rcu_read_lock_nesting tells the tick
 	 * whether the current CPU is in an RCU read-side critical section,
 	 * so the tick can report quiescent states even for CPUs looping
 	 * in kernel context.  In contrast, in non-preemptible kernels,
@@ -7290,6 +7290,8 @@ int __sched __cond_resched(void)
 	 * RCU quiescent state.  Therefore, the following code causes
 	 * cond_resched() to report a quiescent state, but only when RCU
 	 * is in urgent need of one.
+	 * A third case, preemptible, but non-PREEMPT_RCU provides for
+	 * urgently needed quiescent states via rcu_flavor_sched_clock_irq().
 	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
-- 
2.40.1

