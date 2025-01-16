Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E423F296;
	Thu, 16 Jan 2025 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737058410; cv=none; b=Djy6E/OhGNxbtuWGgoTjDj3nsoO81Fb1YBONmXHODgOecT81VVWQEWRALZrhQLhL3iVeVARospEguV6NMdCgRYCfKQCKC+6ESqzE94v2zNDnUdbTiqsVJI20t9mesk9EwHe0AUcxqFYIa1+Oo/+CPTVPNrmduJuObB8Vs2WmLFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737058410; c=relaxed/simple;
	bh=M4IGtN6BovqfzK1PpNFL5ipM2kvkjsr8kEJp1L/pIXs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RXdKTUMol711RxUvTz3msdosUKhEFmgZtJK3l7GTD6laVEsCsQIYVnC2JLo/eYj/jlajA2/5dyvzlxGQcaoQs9CuL8D0tB6Jl8wgdplbd3l2qSCOYPjJTqbymZN47gpg0Ytejrq7TZA9YNQlZPgBQN1eIQdKWSHV1q6vpxU55NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SPAYcHkf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SPAYcHkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2131C4CEEF;
	Thu, 16 Jan 2025 20:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737058410;
	bh=M4IGtN6BovqfzK1PpNFL5ipM2kvkjsr8kEJp1L/pIXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SPAYcHkfxm/X2v7LZoMJJKYg/Vdv63ooxeCgB1MtkhTw2sQ3K61ui0TqoBbhHIILx
	 H0rpssxf8zAaW45W5m7OIMDFmHix5pXaB2zrBqckox6VhkcsmvoPNthXJN55vT9kDM
	 1OMa2YG20u6pPfG0n9aTu/sWfS15l9mx9LEHnXEBpNUZ4Kd9fH6dDM3S1Z0QZNf+Dx
	 8fpbA1DWzfFlsbpvz2P8paLb06aQDmAgvWwcBwX7c30XAbhm/XUN8IssKocV48h38h
	 JJYgrPUA3jYzNYEjgosQvgCdb75vPo50B9oHRvyQUMgEP5SjGph76ZD0xZugn2wCWi
	 loUpiAJmWPUMw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 56556CE37C4; Thu, 16 Jan 2025 12:13:29 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH rcu 6/9] osnoise: provide quiescent states
Date: Thu, 16 Jan 2025 12:13:24 -0800
Message-Id: <20250116201327.3782963-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
References: <df73d8ef-ef52-4f99-ac22-e2b66f0c644e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

To reduce RCU noise for nohz_full configurations, osnoise depends
on cond_resched() providing quiescent states for PREEMPT_RCU=n
configurations. For PREEMPT_RCU=y configurations -- where
cond_resched() is a stub -- we do this by directly calling
rcu_momentary_eqs().

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), however, we have a
configuration with (PREEMPTION=y, PREEMPT_RCU=n) where neither
of the above can help.

Handle that by providing an explicit quiescent state here for all
configurations.

As mentioned above this is not needed for non-stubbed cond_resched(),
but, providing a quiescent state here just pulls in one that a future
cond_resched() would provide, so doesn't cause any extra work for
this configuration.

Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/trace/trace_osnoise.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index b9f96c77527db..2340ffcefb9d1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1531,27 +1531,25 @@ static int run_osnoise(void)
 
 		/*
 		 * In some cases, notably when running on a nohz_full CPU with
-		 * a stopped tick PREEMPT_RCU has no way to account for QSs.
-		 * This will eventually cause unwarranted noise as PREEMPT_RCU
-		 * will force preemption as the means of ending the current
-		 * grace period. We avoid this problem by calling
-		 * rcu_momentary_eqs(), which performs a zero duration
-		 * EQS allowing PREEMPT_RCU to end the current grace period.
-		 * This call shouldn't be wrapped inside an RCU critical
-		 * section.
+		 * a stopped tick PREEMPT_RCU or PREEMPT_LAZY have no way to
+		 * account for QSs. This will eventually cause unwarranted
+		 * noise as RCU forces preemption as the means of ending the
+		 * current grace period.  We avoid this by calling
+		 * rcu_momentary_eqs(), which performs a zero duration EQS
+		 * allowing RCU to end the current grace period. This call
+		 * shouldn't be wrapped inside an RCU critical section.
 		 *
-		 * Note that in non PREEMPT_RCU kernels QSs are handled through
-		 * cond_resched()
+		 * Normally QSs for other cases are handled through cond_resched().
+		 * For simplicity, however, we call rcu_momentary_eqs() for all
+		 * configurations here.
 		 */
-		if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-			if (!disable_irq)
-				local_irq_disable();
+		if (!disable_irq)
+			local_irq_disable();
 
-			rcu_momentary_eqs();
+		rcu_momentary_eqs();
 
-			if (!disable_irq)
-				local_irq_enable();
-		}
+		if (!disable_irq)
+			local_irq_enable();
 
 		/*
 		 * For the non-preemptive kernel config: let threads runs, if
-- 
2.40.1

