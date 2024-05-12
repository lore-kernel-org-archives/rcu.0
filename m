Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EDB4CDF9;
	Sun, 12 May 2024 17:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715533867; cv=none; b=q6Q1t+nySevKgGMUEkeesW6IcLWbvlmZ9RnfbOi2cZvwCHEh+3vd4dYdltflPVhZA7JGndA95pSy6a5mmpMMlLZajhrtym49FaOEWLh34SLPGqI5t1RLj3oBZ3Rve8OAQaqBt9GDAAn0DRzZ5+AJJqw43kzHqlwwlue5vHOxGxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715533867; c=relaxed/simple;
	bh=VzGeKoslKNbw1gw65/BLyxBwwDzyJ5nPATxrOsC5LtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqbR7T56nrbw6JOdVA+SbZh7TGw1w7xT+l/Ieij7/zCZNgnOCntxfsSnnk7w329As6DYXShCxK/jX3c3qghyeT3dYLtaFJdYoL24bN9ZMebB+5oH4h9hfERHLLW8l/xLjkx/jsLtzLvokxpAhsbnFRSpe2/TGwRZ8x9JOQoZ3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rd1+OPEh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rd1+OPEh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C38FC116B1;
	Sun, 12 May 2024 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715533866;
	bh=VzGeKoslKNbw1gw65/BLyxBwwDzyJ5nPATxrOsC5LtE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Rd1+OPEhC6k5RANKKZEX9xTvEs6L7vgAsmaHdJAcB1XdcN1szp9hN2FVUg+t0KIKc
	 jv0llclutcC5JsWuSBkycpwuUTuPGhSUqo0N8vukvZkK0bMcUbCeI4YyL4OLFwXuJ+
	 KmNQpGHp1Mdf8EaptC6zyYrywklLf+ZwlvU4QA92qNGG5YjiUlpX+tXaTba4ZuutD9
	 Fo+wPPF3HT25LyuB3HfMZR4pvDxaRh4veF1mDTWQgEkk2F/6MNeYiyPr8hYuHp0h6l
	 zJCY9fNPDnRizcIZpIA9hqKf8NoXK4c3JSFPVKDfzFpBf0fRh7CMm5ycvUpeswgT4/
	 KuV+vz57Zhj0Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E05F7CE105C; Sun, 12 May 2024 10:11:05 -0700 (PDT)
Date: Sun, 12 May 2024 10:11:05 -0700
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
Message-ID: <bbc3648c-0965-41d1-b245-3a4ca0c9629c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <20240512111948.GC7541@redhat.com>
 <550cf35c-4fb3-4f06-95b2-9206425d74cc@paulmck-laptop>
 <20240512165529.GD7541@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512165529.GD7541@redhat.com>

On Sun, May 12, 2024 at 06:55:29PM +0200, Oleg Nesterov wrote:
> On 05/12, Paul E. McKenney wrote:
> >
> > --- a/kernel/rcu/sync.c
> > +++ b/kernel/rcu/sync.c
> > @@ -151,15 +151,11 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> >   */
> >  void rcu_sync_exit(struct rcu_sync *rsp)
> >  {
> > -	int gpc;
> > -
> >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
> > -	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
> >
> >  	spin_lock_irq(&rsp->rss_lock);
> > -	gpc = rsp->gp_count - 1;
> > -	WRITE_ONCE(rsp->gp_count, gpc);
> > -	if (!gpc) {
> > +	WARN_ON_ONCE(rsp->gp_count == 0);
> > +	if (!--rsp->gp_count) {
> >  		if (rsp->gp_state == GP_PASSED) {
> >  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
> >  			rcu_sync_call(rsp);
> > @@ -178,10 +174,10 @@ void rcu_sync_dtor(struct rcu_sync *rsp)
> >  {
> >  	int gp_state;
> >
> > -	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));
> >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_PASSED);
> >
> >  	spin_lock_irq(&rsp->rss_lock);
> > +	WARN_ON_ONCE(rsp->gp_count);
> >  	if (rsp->gp_state == GP_REPLAY)
> >  		WRITE_ONCE(rsp->gp_state, GP_EXIT);
> >  	gp_state = rsp->gp_state;
> 
> Thanks Paul!
> 
> But then I think this change can also revert this chunk from the previous
> patch:
> 
> 	@@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> 			 * we are called at early boot time but this shouldn't happen.
> 			 */
> 		}
> 	-	rsp->gp_count++;
> 	+	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
> 		spin_unlock_irq(&rsp->rss_lock);
> 	 
> 		if (gp_state == GP_IDLE) {

Good catch, thank you!  How about like this?

							Thanx, Paul

------------------------------------------------------------------------

commit 3e75ce9876396a770a0fcd8eecd83b9f6469f49c
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
index 6c2bd9001adcd..da60a9947c005 100644
--- a/kernel/rcu/sync.c
+++ b/kernel/rcu/sync.c
@@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
 		 * we are called at early boot time but this shouldn't happen.
 		 */
 	}
-	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
+	rsp->gp_count++;
 	spin_unlock_irq(&rsp->rss_lock);
 
 	if (gp_state == GP_IDLE) {
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
