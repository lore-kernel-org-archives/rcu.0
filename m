Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52DA148FED;
	Thu, 27 Jun 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487680; cv=none; b=FpOJOr2One9N0GWK69t6kLWUZLZ/41vopWZpOe3SW8tXpn44UJMATjOvwvdBl77nsJ1kJSR238VL1GIiCFH7NwhsiwMk6cHm3u2EKaqt/lUf/6NgdPXF+X1Msp+oERwzevQtWYvqXVZZ0LIkidPSG5QGjLplMNKjRpqSu69eOXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487680; c=relaxed/simple;
	bh=5AGW7pZM39ka5fK1CF7IYjzVqdaHxNVUi7SSr7A3uxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU1oxyqWZAeAr+sZSMVCDROfVWlTyHLseeYacTkmvcXW7/ZA5xElqsv5KJcFhiwpU4EoX33UY7Qg4029J+Pe9JEO+lBFkXom3nLhW9R4LRk/CoJ/OUSeFL4zIGPxKckV+ETec+lO+dVen1l/fFm06yJNWM4Jb5MQIyKn46HIevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0aJSBxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0aJSBxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C7CC2BBFC;
	Thu, 27 Jun 2024 11:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719487680;
	bh=5AGW7pZM39ka5fK1CF7IYjzVqdaHxNVUi7SSr7A3uxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0aJSBxlNp072UP0ITDI5kx4tWkppIZJlsT8pbpfBIYt4oAmjkOeNqdkzwSvPHHZf
	 RNnoM0or5OzVYYLf2ToRrj7G/bCfdcdAx76lRt2RH6bqnEicwRHp3xQLhHyoeAw/vg
	 pxE4Y5NsTW22y6m/eOUQfgLBVtp+UVl/zg3iJEXXxolBuPIQzjd9uS2rjn9VNI4mEr
	 vGMG4GkFmD0WPupOmz1mqZJNliv0QDCxy0NcNKVgExvlgpzys3VoLX3j75YwCtR6cZ
	 tlmDn150fGE/TTYjK/4HAmoXoX5Q3MjsFpQWJfYxhIgDEBK4MWc/Px+o5zPB50vmY8
	 27q6qtDir0S9g==
Date: Thu, 27 Jun 2024 13:27:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: [PATCH rcu 1/6 v2] rcu: Remove full ordering on second EQS snapshot
Message-ID: <Zn1Mvcl8r5WC6u-r@pavilion.home>
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-1-paulmck@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604222652.2370998-1-paulmck@kernel.org>

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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 28c7031711a3..b7d943e98a9a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -321,7 +321,15 @@ static bool rcu_dynticks_in_eqs(int snap)
  */
 static bool rcu_dynticks_in_eqs_since(struct rcu_data *rdp, int snap)
 {
-	return snap != rcu_dynticks_snap(rdp->cpu);
+	/*
+	 * The first failing snapshot is already ordered against the accesses
+	 * performed by the remote CPU after it exits idle.
+	 *
+	 * The second snapshot therefore only needs to order against accesses
+	 * performed by the remote CPU prior to entering idle and therefore can
+	 * rely solely on acquire semantics.
+	 */
+	return snap != ct_dynticks_cpu_acquire(rdp->cpu);
 }
 
 /*
-- 
2.45.2

