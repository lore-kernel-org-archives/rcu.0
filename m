Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1713D258;
	Fri, 16 Aug 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791868; cv=none; b=KTbLRFEMhuQylUbsKbkvec2YAWD+58/g6yhebDi8jh656OAalcXPNF3uBh1u4L47NpTy2l+thBAceLN8WOtHlxlLzNr1ae0ur/D3SsKiN6OOb0OJC5gD3bkmOEC0VZuB0m5i8y9s3dKpIz8OD4goWdJCdLdpZ8v4bsHcpy5JgGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791868; c=relaxed/simple;
	bh=Kpne2lKthjgBTkbEjIqIgS4eVjzf8xKIxkMykFK9Pns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=off2x3YFraWiGf2rWl0tPJN34jM2pEf0ZdhU+jlgVLbVVGxwUQ5jb+ULuGUufXtazebxbhVW9o7WKa/scKc5z4nRuQxeyb3U9lPYiHLXL/HFEuXTTWfjUMAq+irw2+w0hRjEurHB+vuSNEfj4TKtrMylNMExbiqvHDM1XylQeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRdZebFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRdZebFG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDDBC4AF09;
	Fri, 16 Aug 2024 07:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791868;
	bh=Kpne2lKthjgBTkbEjIqIgS4eVjzf8xKIxkMykFK9Pns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRdZebFGVm2sg2vgZYC+5MaF82Cz1Yp9ZknVXeBtd7X0B/PArVBwFnfwUiRGDFW5h
	 BwGheP3bEc9SNopA5tyTjC8Qb909ouTovoRWhLN+KG9yBG5/9lROKbwfYq7ZolztQ9
	 2fdK1Y0tSVZyaP5VjzJ+cfR809T9WsnHW5NG6HgAksfeuplXjYY05jC9rfK/0vwwus
	 D84c18oNkEttiLHm73YMw3KRywyVuJlyxTm8Vbz7sD4rJ8oLRVV8lJr9kUtrb/vNv1
	 OXWyMpw1VK4IzAkyuebpn7BrCkPt/UoVh1P+6P397BkJnvuOZ/00dMI5sMNxejec7N
	 RXcQrMA+IDB1w==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 06/14] rcu: Mark callbacks not currently participating in barrier operation
Date: Fri, 16 Aug 2024 12:32:48 +0530
Message-Id: <20240816070256.60993-6-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

RCU keeps a count of the number of callbacks that the current
rcu_barrier() is waiting on, but there is currently no easy way to
work out which callback is stuck.  One way to do this is to mark idle
RCU-barrier callbacks by making the ->next pointer point to the callback
itself, and this commit does just that.

Later commits will use this for debug output.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc681901..f931171daecd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4403,6 +4403,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 {
 	unsigned long __maybe_unused s = rcu_state.barrier_sequence;
 
+	rhp->next = rhp; // Mark the callback as having been invoked.
 	if (atomic_dec_and_test(&rcu_state.barrier_cpu_count)) {
 		rcu_barrier_trace(TPS("LastCB"), -1, s);
 		complete(&rcu_state.barrier_completion);
@@ -5424,6 +5425,8 @@ static void __init rcu_init_one(void)
 		while (i > rnp->grphi)
 			rnp++;
 		per_cpu_ptr(&rcu_data, i)->mynode = rnp;
+		per_cpu_ptr(&rcu_data, i)->barrier_head.next =
+			&per_cpu_ptr(&rcu_data, i)->barrier_head;
 		rcu_boot_init_percpu_data(i);
 	}
 }
-- 
2.40.1

