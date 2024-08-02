Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDD10A24;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558868; cv=none; b=sJHOzR1ODLVVd6vYLtUAAgkcx1k1Cfu/HbnNy0istKKBUPd+jFMpWBLycxJg5yL8xVqrLWrveQ8TiX3ZbqedxV2v89Mzzbqao7ma8NwoQQxHW8NZWlWzgEaAexfCJ0cTw8L9c7Jvp8tPuM7CP1rm1F7HTIxiZj4f8PfdYTphRRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558868; c=relaxed/simple;
	bh=Bs6t1S51lhnIfRf7LZhnT/4oX7/PDkMznq5WhI41PoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLz3M11COXkT4Oej3J2E06cmm9nns5i6M8nCk81/OZyaC7/013st3esm0+wQZjkGAYHKiBVGMUhc3y2WbBGMADIBjuOBTSmDpF12Qb3E6Q2zAAXcpGnjvqhYPY5t5OPWm8nN80+WXim7kXRzAfXxQ3cxfjbZcn45i5z9FBVjBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dY2TyUYS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY2TyUYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B41C32786;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558868;
	bh=Bs6t1S51lhnIfRf7LZhnT/4oX7/PDkMznq5WhI41PoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dY2TyUYSoX3gzVYa2usg91lrH/mRiL+T9is4/2zCw7rke6ahHg9rjhCCcYPv0n6lE
	 QobqxTAsGzyXhBKXZOXq8lq0EnKOwG9uicJzohd0seNr1tMLwV3zlctKRdD5e/PpNb
	 uBNRY1JT1jO1aOoW789XWI0g0VUisAFhObTXULB9EoUt1A9IcKmyRfHI1VTsSZssP4
	 uK7FhbTuPI4OkYbqLtoO/WEkcoL1hwf+U6oUa1GCjmuYnXFLqh5jur3nIhpvV9rVXo
	 IriTwfwVvwVpNKqAkeSYTCsXX6AT+d5zohYrtXNz6prMy2ZiNjGfMpLv6qiOzTdEiW
	 Mly/w0bDOfFJA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E01F9CE09F8; Thu,  1 Aug 2024 17:34:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] rcu/tasks: Check processor-ID assumptions
Date: Thu,  1 Aug 2024 17:34:21 -0700
Message-Id: <20240802003426.4134196-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current mapping of smp_processor_id() to a CPU processing Tasks-RCU
callbacks makes some assumptions about layout.  This commit therefore
adds a WARN_ON() to check these assumptions.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b6fcf744af75d..d473846a572aa 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -355,6 +355,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rcu_read_lock();
 	ideal_cpu = smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift);
 	chosen_cpu = cpumask_next(ideal_cpu - 1, cpu_possible_mask);
+	WARN_ON_ONCE(chosen_cpu >= nr_cpu_ids);
 	rtpcp = per_cpu_ptr(rtp->rtpcpu, chosen_cpu);
 	if (!raw_spin_trylock_rcu_node(rtpcp)) { // irqs already disabled.
 		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
-- 
2.40.1

