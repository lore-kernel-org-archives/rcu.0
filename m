Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B54690
	for <rcu@vger.kernel.org>; Mon, 10 Jun 2024 02:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717985454; cv=none; b=ELXVWpkAdzM3OY44UCPQywUa9O0BF6H387fiwOHTk2M8yJF59mK7d62JrieYgFPUJmBElQ7ec4Fqbf8jkp5t3GANSr3dPjVHxW+j4INrwN5H3pTUgwZNPzv4KInitmpNqEHkuUjITdj0EESw3ZNF2Xy6DptnTVtGjb7VDJNZun8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717985454; c=relaxed/simple;
	bh=fU76eFUwpp3NxkFtofjlpFSDKOiWFlC1jYSNUF/qtjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmCphV9c/XJU+LFr8g5t/rju2FMvtiW8pK1bkNiPuQ+mT9RzLXAaxi+AVFw59W4Gx/hnnlZm/juet4Il6DYVGHPtPm6vl/6fOrFpYZUv1YS0A1n9fCO9X7UlHmSJRin9zf3LiiXndu23C9xM1DSlNg+zopewUJutVxDC7yvcQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFx3qlrp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFx3qlrp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE115C2BD10;
	Mon, 10 Jun 2024 02:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717985454;
	bh=fU76eFUwpp3NxkFtofjlpFSDKOiWFlC1jYSNUF/qtjo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=eFx3qlrpJcr71apsgKJO+u4JJgJYrTTEO1qvMfc6sBOnxRYmGfKWMos4rzTO1eO9R
	 ii9A//8fU423jXTo8Rdz2w0BbZs9idScfYvzZSToP7JW7H+4ceRyJBEi6TREiPGKu7
	 C+0y+ZFJDnDT2r5v7ZRWPTZaHlPDwWlUA8bFE8q8mP9QQvjt5FEw51YHFmcJwBiUT8
	 1FZjuAwUPBtW3DqtWPQZrKkbR7bVxkSRc6nzYincnSBWPVjl5YuzMc76clq1pW82Y1
	 SZ7GY5BMpGVxQBKVt5nFExN6Mzc2rwsAv2VmAPL2JbPzeBu/JxCz4Vh0rm9Oos2n/O
	 1wX3uQiv9k9Ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8743FCE22D7; Sun,  9 Jun 2024 19:10:53 -0700 (PDT)
Date: Sun, 9 Jun 2024 19:10:53 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: rcu@vger.kernel.org
Subject: Re: srcu_cleanup warning
Message-ID: <9195be6e-69a0-4c8a-8a60-5611a822cbe3@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <y5hi7x5w3yi4i5sh2b5hgk7xu2mghkthabc7adrqteg3muc5y4@pbnkp7yyxcrp>
 <e7d313d4-04a7-4f24-bec6-8ade82e3be3b@paulmck-laptop>
 <lfqpkn4ailnaa3da45cnk33yorufv63accbrtnzf7chqa56lyc@jg6ldk4wexzz>
 <d21f257a-4056-43d9-80f5-f07f1285c7fa@paulmck-laptop>
 <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <irycqy4sinjdgm2hkyix2bffunpcmuwgeufsx6nlljvqme3wiu@ify3zdnrmzph>

On Sun, Jun 09, 2024 at 08:52:14PM -0400, Kent Overstreet wrote:
> On Sun, Jun 09, 2024 at 09:55:30AM -0700, Paul E. McKenney wrote:
> > On Sun, Jun 09, 2024 at 11:37:45AM -0400, Kent Overstreet wrote:
> > > On Sat, Jun 08, 2024 at 08:25:53PM -0700, Paul E. McKenney wrote:
> > > > Could you please try something like this just before the call to
> > > > cleanup_srcu_struct()?
> > > > 
> > > > 	WARN_ON_ONCE(poll_state_synchronize_srcu(&c->btree_trans_barrier, ck->btree_trans_barrier_seq);
> > > 
> > > Which seq was this supposed to be? All keys have been freed by this
> > > point...
> > 
> > Or, alternatively, where in the code is this supposed to be?
> > 
> > If there is no convenient point in the code to grab the most recent
> > return value from start_poll_synchronize_srcu(), another thing to do
> > is to invoke either synchronize_srcu() or synchronize_srcu_expedited()
> > just before the call to cleanup_srcu_struct().
> > 
> > Another approach is to use get_state_synchronize_srcu() instead of
> > start_poll_synchronize_srcu(), and have a self-reposting SRCU callback
> > to keep the grace periods going.  Then you would set a flag that
> > stopped it from self-posting, then do srcu_barrier().  With careful
> > memory ordering.
> > 
> > There are quite a few techniques to shut down the self-reposting SRCU
> > callback when there is nothing for it to do and to restart it if need be.
> > 
> > But just doing a synchronize_srcu() or synchronize_srcu_expedited() is
> > a lot simpler and probably does the job.
> 
> synchronize_srcu_expedited() seems like the simplest solution, yeah.
> 
> Thanks, I think I'm starting (hazily) to get an idea of how the RCU code
> is structured, but I'll have to dig more when I have more time, this is
> interesting :)
> 
> I am wondering why you couldn't just have cleanup_srcu_struct() do the
> appropriate cleanup (synchronize_srcu_expedited?) in this instance; if
> the caller is tearing down the srcu struct they don't need srcu
> synchronization anymore, I would think the only safety issue that would
> need a warning would be leaked read locks.

Starting a grace period and then invoking cleanup_srcu_struct() before
it has had a chance to finish seems worth a warning.  And preferable to
having something like poll_state_synchronize_rcu() segfault later on,
for example.

> Another question for you: is there a limit to the number of pending
> sequence numbers from start_poll_synchronize_srcu()? (e.g. 2?)
> 
> That affects the data structure I use for redoing this "track pending
> frees" code.

Yes, there is, and you are right, the number is two.  Would something
like the patch shown below help?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 236610e4a8fa5..f664cba7a80c2 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -61,6 +61,10 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+// Maximum number of unsigned long values corresponding to
+// not-yet-completed SRCU grace periods.
+#define NUM_ACTIVE_SRCU_POLL_OLDSTATE 2
+
 #ifdef CONFIG_NEED_SRCU_NMI_SAFE
 int __srcu_read_lock_nmisafe(struct srcu_struct *ssp) __acquires(ssp);
 void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx) __releases(ssp);
