Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B51B3F32;
	Wed, 14 Aug 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723648145; cv=none; b=QSJazv3Uv696gtVaOKqPZ1u/1qoGq/gXnevnM6ioacyRjsG14Qyb2b/dHGNIlJ4G+V5RrKpKk27hufgY1HqU9GlVe6ujzOQyqWJ4yBwm2dcIR5Ly6p6RGrqkdktHG/MKv0qxBCexPRFlpcXXxitkRRb66uQ3zd7swMtoqR06+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723648145; c=relaxed/simple;
	bh=e6sAMiUX3GtLQq9riJitTJsvMdsIIIcPjPpZ2JAVQ2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usv2V1EWUYgRB/8HRfJBsXlZPL9SocKH6W9DWIMBuz0SvuCZrlu3xehXBMSLFNJvCjsfnXx+I3QBoeFf1yvHp68DmhlK9YEjWGxfECR+3r/YmF0nx9b66S3PtLB1Bb7n2N4nxpNEqjVoZur5hQwLfGcr7E9/V7ph1Q8x+t2FlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ58epVN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ58epVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E9DC4AF09;
	Wed, 14 Aug 2024 15:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723648144;
	bh=e6sAMiUX3GtLQq9riJitTJsvMdsIIIcPjPpZ2JAVQ2c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lZ58epVNPQS7W9qTq31xFecYgDHivNV3NMB7tmltxyfhTJr7D50TPuioi8o5kWNbz
	 yZhan4PrpyylwDmKbt519CA4y00OIv2a8G3CVgw32gq6P+qXvidXoGRxx6CuNh73NJ
	 DpyibF2c8BJGxenQbQBEhzBEG1EU2HyaTE98PqYxTX8qTrRMS6xBLONz9nG/x5mkNn
	 gc6p19d5lHJNU1hEp31FyyiYEsuBXneRv1pQVk+KKqLzTGMGae0AO9t5NiJTFxCuQm
	 8pVBDi8VBbXpUeMvT/ghUwGX9lsrImUGLxCIWX6fMH+tufqaJ9eqcyszt7Z3tq16Et
	 dgPvc0a2UaiYA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5E1B1CE0ACD; Wed, 14 Aug 2024 08:09:04 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:09:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 06/11] rcuscale: Provide clear error when async
 specified without primitives
Message-ID: <dfcc1432-6230-42ae-b3d4-0081918bc979@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <917e8cc8-8688-428a-9122-25544c5cc101@paulmck-laptop>
 <20240802004308.4134731-6-paulmck@kernel.org>
 <20240814124915.GA1412840@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814124915.GA1412840@neeraj.linux>

On Wed, Aug 14, 2024 at 06:19:15PM +0530, Neeraj Upadhyay wrote:
> On Thu, Aug 01, 2024 at 05:43:03PM -0700, Paul E. McKenney wrote:
> > Currently, if the rcuscale module's async module parameter is specified
> > for RCU implementations that do not have sync primitives such as
> > call_rcu(), there will be a series of splats due to calls to a NULL
> > pointer.  This commit therefore warns of this situation, but switches
> > to non-async testing.
> > 
> 
> I have changed this to below here [1]. Please let me know if I got it
> wrong.
> 
> Currently, if the rcuscale module's async module parameter is specified
> for RCU implementations that do not have async primitives such as
> RCU Tasks Rude, there will be a series of splats due to calls to a NULL
> pointer.  This commit therefore warns of this situation, but switches to
> non-async testing.

How about something like this, but perhaps wordsmithed a bit?

	"Currently, if the rcuscale module's async module parameter
	is specified for RCU implementations that do not have
	async primitives such as RCU Tasks Rude (which now lacks
	a call_rcu_tasks_rude() function), there will be a series of
	splats due to calls to a NULL pointer.	This commit therefore
	warns of this situation, but switches to non-async testing."

							Thanx, Paul

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/neeraj.upadhyay/linux-rcu.git/commit/?h=next.14.08.24b&id=22d36840adbcab8fd826a7ca827fd60b708f03de
> 
> - Neeraj
> 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/rcuscale.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> > index 933014b381ec0..315ced63ec105 100644
> > --- a/kernel/rcu/rcuscale.c
> > +++ b/kernel/rcu/rcuscale.c
> > @@ -525,7 +525,7 @@ rcu_scale_writer(void *arg)
> >  			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
> >  		wdp = &wdpp[i];
> >  		*wdp = ktime_get_mono_fast_ns();
> > -		if (gp_async) {
> > +		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
> >  retry:
> >  			if (!rhp)
> >  				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
> > @@ -597,7 +597,7 @@ rcu_scale_writer(void *arg)
> >  			i++;
> >  		rcu_scale_wait_shutdown();
> >  	} while (!torture_must_stop());
> > -	if (gp_async) {
> > +	if (gp_async && cur_ops->async) {
> >  		cur_ops->gp_barrier();
> >  	}
> >  	writer_n_durations[me] = i_max + 1;
> > -- 
> > 2.40.1
> > 
