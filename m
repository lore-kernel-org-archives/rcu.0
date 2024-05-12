Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AB225D4;
	Sun, 12 May 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715526657; cv=none; b=Il8whai/D/sOk02r16U613RjpAexEG5S2BrGasCxAUWoLfwA0FnJN4WDKsHP3i/wmTCvSwj/ljsjVGktjv5uD7O5g/KdWeilvMOXKp4sTxvl2Sa+x/yFi/j528opqJbtStdzj9TScy7743Lu/JIjcia9jsPYfEZQPL9UWAUHpv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715526657; c=relaxed/simple;
	bh=JBGY/wsWLd5vVTru9Q0xWY6VF1Cf8EW9QzYMfA6Y29U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij4eZMKrIH2Kcnhb791HJBUSRS+nWFBcOOmxMuY7cZSYeX1wXH1wSFHbhYLcTN+pOlPVxpRj96pQTrC9izvcwntokUGCoIRRRqLwlLVSNCty1V29iZDoxPJugpQOUPJ0NZe4c+JajdpfjrK3/66CkvnDpfPi3LS8h59GooDlfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO163wqK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO163wqK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80272C32783;
	Sun, 12 May 2024 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715526656;
	bh=JBGY/wsWLd5vVTru9Q0xWY6VF1Cf8EW9QzYMfA6Y29U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PO163wqKaJrQOiwxxNYUuUqkagw8QmQqYjYShOr3uIcr/TTpO5RyGkGR2+8e+Zmeh
	 5Cgj3Myhin381ibDtc9Q8rulCWQF0wg5AoLJIqe14kGPfZG7GXmw9b8Iu2dDzXS7c4
	 HTwiygNBG2J9seenDEwe78pAWXcvG1DLd8M+vr+ukiwZsVIvrq3Yc6FGB0wDf97rbY
	 zaHFh7hK83mPD4fTmzVboT7UR38NVYkUvqwFoV6lTpwCfH7b04kX40WE4S+8/hzDZ9
	 U5JRDKTcZPb50cXyjnpcuEQVYOSHLTISM+n1jDUatM5i09aPXNF88wLtRf5cWA/02Z
	 wZjJoabN8dcow==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DDD4FCE105C; Sun, 12 May 2024 08:10:55 -0700 (PDT)
Date: Sun, 12 May 2024 08:10:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] rcu/sync: don't read rcu_sync->gp_count lockless
Message-ID: <550cf35c-4fb3-4f06-95b2-9206425d74cc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <20240512111948.GC7541@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512111948.GC7541@redhat.com>

On Sun, May 12, 2024 at 01:19:48PM +0200, Oleg Nesterov wrote:
> rcu_sync->gp_count is updated under the protection of ->rss_lock but read
> locklessly by the WARN_ON() checks, and KCSAN noted the data race.
> 
> Move these WARN_ON_ONCE()'s under the lock and remove the no longer needed
> READ_ONCE().
> 
> Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Very good, thank you!

Due to inattention on my part, the patches were sent late, so the patch
you are (rightly) complaining about is on its way in.  So what I did was
to port your patch on top of that one as shown below.  Left to myself,
I would be thinking in terms of the v6.11 merge window.  Please let me
know if this is more urgent than that.

And as always, please let me know if I messed anything on in the port.

							Thanx, Paul

------------------------------------------------------------------------

commit 8d75fb302aaa97693c2294ded48a472e4956d615
Author: Oleg Nesterov <oleg@redhat.com>
Date:   Sun May 12 08:02:07 2024 -0700

    rcu: Eliminate lockless accesses to rcu_sync->gp_count
    
    The rcu_sync structure's ->gp_count field is always accessed under the
    protection of that same structure's ->rss_lock field, with the exception
    of a pair of WARN_ON_ONCE() calls just prior to acquiring that lock in
    functions rcu_sync_exit() and rcu_sync_dtor().  These lockless accesses
    are unnecessary and impair KCSAN's ability to catch bugs that might be
    inserted via other lockless accesses.
    
    This commit therefore moves those WARN_ON_ONCE() calls under the lock.
    
    Signed-off-by: Oleg Nesterov <oleg@redhat.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
index 6c2bd9001adcd..05bfe69fdb0bb 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -151,15 +151,11 @@ void rcu_sync_enter(struct rcu_sync *rsp)
  */
 void rcu_sync_exit(struct rcu_sync *rsp)
 {
-	int gpc;
-
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
 
 	spin_lock_irq(&rsp->rss_lock);
-	gpc = rsp->gp_count - 1;
-	WRITE_ONCE(rsp->gp_count, gpc);
-	if (!gpc) {
+	WARN_ON_ONCE(rsp->gp_count == 0);
+	if (!--rsp->gp_count) {
 		if (rsp->gp_state == GP_PASSED) {
 			WRITE_ONCE(rsp->gp_state, GP_EXIT);
 			rcu_sync_call(rsp);
@@ -178,10 +174,10 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
 {
 	int gp_state;
 
-	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
 	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
 
 	spin_lock_irq(&rsp->rss_lock);
+	WARN_ON_ONCE(rsp->gp_count);
 	if (rsp->gp_state == GP_REPLAY)
 		WRITE_ONCE(rsp->gp_state, GP_EXIT);
 	gp_state = rsp->gp_state;
