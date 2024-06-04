Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6112DDAF;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717540014; cv=none; b=efTsUEbi8UYw8zo3UvyKKJ+Wpte4R1cN+qbfLPCEteWEBcqZYoh/uSKKzgWFlFaKkd+rSdLoD5Kg7Zekdzpu/52bEv2DIsRkF7l5bjP0pfMYlZLEE+dnNRNtxmDjWLWqje609CPZhBPMLdQdHlEWbRxwbSNkIMmO0MjEa9WRV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717540014; c=relaxed/simple;
	bh=qkbOPPNcOof4xO9uLKIhmjR/JL9cMPc3uYhJKaAInxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMefKAOQGOCd9rJHyUFDptR7g4OQ7WuriZR1YMSWzVNXy67PY2SfPxP2RdUitgDrtQC4+cuaGnhYukkabG8ft1UTqeG6FRc/2c4/79Sk3TpqfnmXkNfag8umV8+BtDYXy2sJeCDGvdd97Ykdwu8nASGQMW6ngrqjRxHsqHxIL0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcUfXmE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcUfXmE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3D8C2BBFC;
	Tue,  4 Jun 2024 22:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717540014;
	bh=qkbOPPNcOof4xO9uLKIhmjR/JL9cMPc3uYhJKaAInxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JcUfXmE8dG7jeKn0l9eO+lD7Um6W3MenxheD2/QGTki7aKasEey1tETS9C2OXQ6Ln
	 p4Vs2hNkNj/I8IJoAf9W/PbbqplwZRc5M7ZqK4vwgFyzhFcmj6RgsU449jZNlaK1Vv
	 N+u87Bfkz7Orz01PdXfVYJUxuv6guSuDHbQpnv3y9Uo9+p7EEivA4wavrDd6NY5D0b
	 Uxl+0GzrvVn+Gz4nefTybZzNbc1cCTYHY6QaeS1eYBVQb0v74ZfxuhLdURUDkt4syn
	 /Zxf1dqWUN6lRmoD5eCRhfzSrk8fbU1soBY9BbLPpGnHziKndbY7XVqRlUFonCCm0E
	 Xw6UmtUgYTAxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id EB63FCE3ED6; Tue,  4 Jun 2024 15:26:53 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/6] rcu: Remove full ordering on second EQS snapshot
Date: Tue,  4 Jun 2024 15:26:47 -0700
Message-Id: <20240604222652.2370998-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frederic Weisbecker <frederic@kernel.org>

When the grace period kthread checks the extended quiescent state
counter of a CPU, full ordering is necessary to ensure that either:

* If the GP kthread observes the remote target in an extended quiescent
  state, then that target must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it exits that extended quiescent state. Also the GP kthread must
  observe all accesses performed by the target prior it entering in
  EQS.

or:

* If the GP kthread observes the remote target NOT in an extended
  quiescent state, then the target further entering in an extended
  quiescent state must observe all accesses prior to the current
  grace period, including the current grace period sequence number, once
  it enters that extended quiescent state. Also the GP kthread later
  observing that EQS must also observe all accesses performed by the
  target prior it entering in EQS.

This ordering is explicitly performed both on the first EQS snapshot
and on the second one as well through the combination of a preceding
full barrier followed by an acquire read. However the second snapshot's
full memory barrier is redundant and not needed to enforce the above
guarantees:

    GP kthread                  Remote target
    ----                        -----
    // Access prior GP
    WRITE_ONCE(A, 1)
    // first snapshot
    smp_mb()
    x = smp_load_acquire(EQS)
                               // Access prior GP
                               WRITE_ONCE(B, 1)
                               // EQS enter
                               // implied full barrier by atomic_add_return()
                               atomic_add_return(RCU_DYNTICKS_IDX, EQS)
                               // implied full barrier by atomic_add_return()
                               READ_ONCE(A)
    // second snapshot
    y = smp_load_acquire(EQS)
    z = READ_ONCE(B)

If the GP kthread above fails to observe the remote target in EQS
(x not in EQS), the remote target will observe A == 1 after further
entering in EQS. Then the second snapshot taken by the GP kthread only
need to be an acquire read in order to observe z == 1.

Therefore remove the needless full memory barrier on second snapshot.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 28c7031711a3f..f07b8bff4621b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -321,7 +321,7 @@ static bool rcu_dynticks_in_eqs(int snap)
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdp->cpu);
+	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
 }
 
 /*
-- 
2.40.1

