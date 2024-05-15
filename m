Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D228564F;
	Wed, 15 May 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715777620; cv=none; b=pjzismJS9l0aciAu9zfqDmfvUARTcckJNDdblwkuOQb5NJpOSKlGYB3cwvuNy+YLwIZmv3e87cwqQ+jSbJixsbBB+eDcKdyTw1JVzp9eRIzquF62R7pkcSXzp0iZgvxMVpEhHsjpkgPMc9zUJu8Yn2Q95IkSvLUQFFgCWVGz3II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715777620; c=relaxed/simple;
	bh=+Ijc3TFzSdS3MOMdPr/UmaBupSlN/ypWN9jGVIpDD2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqxKpwEuJsBOzXLHe3VI4njsjro1BZ8xerWHRaLLfyUTqOfYHGkLh1eF1X81MWe+i1eYgCH8Lh+er55lo5dSbXED80xmNwiWXkmJtHv2dRyf3oVO/Tjn+rNym2y0yEamVMT5ntSyb4ROR+2mZhZ/lUr6C+9lHlVFfSFmBjhi/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsDVcVQw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsDVcVQw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535D4C4AF07;
	Wed, 15 May 2024 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715777620;
	bh=+Ijc3TFzSdS3MOMdPr/UmaBupSlN/ypWN9jGVIpDD2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsDVcVQwZYfLnq6Woi6YVeDig7BPG3NdiNj2USEC43sJM01981goiAoG5mhmMySPa
	 vWYoUpvYeW3hHtGcQaO95p4DJUfOrsU+9fgzRd/ayLqSRCiu4CQSEprWrLbvXU8F7Y
	 Gith46EPn1Yv8INVoMTuoqSpksIQgblNAWAR5yC4T+g6GaQA+i/awNxw1ejdwUkKpL
	 OhrcazveQAOXr2wbFaMCu4e02REJpI/djlBt40LSHiuFlMl+IREJPAl3gjQQesAAnU
	 QSPBSZ+jhuKZ5ba9NCfXccomLb4jNiAYOALiWfwn1mWMwpB7k6LUa56XQFlrNoqTCR
	 NnhAHhoDoTmUQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	rcu <rcu@vger.kernel.org>
Subject: [PATCH 1/6] rcu: Remove full ordering on second EQS snapshot
Date: Wed, 15 May 2024 14:53:27 +0200
Message-ID: <20240515125332.9306-2-frederic@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240515125332.9306-1-frederic@kernel.org>
References: <20240515125332.9306-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5e6828132007..58415cdc54f8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -325,7 +325,7 @@ static bool rcu_dynticks_in_eqs(int snap)
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdp->cpu);
+	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
 }
 
 /*
-- 
2.44.0

