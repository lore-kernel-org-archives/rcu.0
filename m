Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA40418891F
	for <rcu@vger.kernel.org>; Thu,  5 Sep 2024 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561666; cv=none; b=aDubV4/X5JEPIV77SqhzWlRPYLFsbt7DdSzCDQCkPs/nlwmv/u1Ay1RC58yi5ijDhgpO883TmgkWJiHqzGwn1E5wQ1AW73MtXVs8HESFWU7ude+YjlX6GO33vE2GvElnGaeqTJ3uw7HoinIYFGMJUrTE0xkMj+ezf1icB4W8X4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561666; c=relaxed/simple;
	bh=KumDnj+0i+z7BWvyav7nuhvu227y11/XYPtNZn2Tx58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1bNT9eHbMql+jtRyWqF43+cdfl3mbQUNpfW5TXH317As8gcVkiI535G6GTUvhjJX1G+KGShd1FdPHBnPyTu/ttvrAZswNauMinlGXwsrZJ5j93IbCkcj7c47OjWNWi4yKPTMhQpQMHLsgnpHnsprzdh3wAYBFKaMxcV9tsU3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpfLkD/M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpfLkD/M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3881C4CEC3;
	Thu,  5 Sep 2024 18:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725561666;
	bh=KumDnj+0i+z7BWvyav7nuhvu227y11/XYPtNZn2Tx58=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpfLkD/MddqPgAgIQ9Zdz8xauasRHYspNom9wu4shu8Atgm2wEScz2ET0h5crgect
	 ihoOe+WeplyGV7OfWJhDE7BAJKyTF1T9Qkh7aVvcWrTXGYYWHLxJpcGHKvvwfQakAB
	 2e0WvzxLRhgCfNm26ftLMeQgXuW2+iq6UOwGTgJ+ySkAjxiuLiGQh4SBplm4SwYv9o
	 KsNi6IieEEn5SVcsRNTjJ28/e8lE7y+5KIeNEpgn20PktcOIV0lKgxRYtNO+OK3CfI
	 1ltAfGDxdGH9/uoADDu5kv29HJ7Pt7J+FtF3q0s0QDVi5vMM2s2Z44BxH3HXdRxFGR
	 fzBgjX83wRYog==
Date: Thu, 5 Sep 2024 20:41:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Z qiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: One-off rcu_nocb_rdp_deoffload bug
Message-ID: <Ztn7PpfFiYDRBjWX@localhost.localdomain>
References: <2747e596-5359-4f32-b3e0-0b2368d37017@paulmck-laptop>
 <CALm+0cV0GwT5umPRZrZWg4oqXwdjcWz-NkxkhgxQkv=NypQthA@mail.gmail.com>
 <CAFTL4hzY09QEGE+sTqc02d2LkuH_ObYKiuVTfGnrtwjtYiwt4A@mail.gmail.com>
 <d31bdc50-a61b-446b-926d-b3ddde832a91@paulmck-laptop>
 <236a1f66-f128-44e4-9272-7ae4dbad7485@paulmck-laptop>
 <ZthlEg2njJwXMk32@localhost.localdomain>
 <5bb81db1-bf62-4edc-8d71-dfa192dda39f@paulmck-laptop>
 <Ztn5MOwk4nIfTWv-@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ztn5MOwk4nIfTWv-@localhost.localdomain>

Le Thu, Sep 05, 2024 at 08:32:16PM +0200, Frederic Weisbecker a écrit :
> Le Wed, Sep 04, 2024 at 06:52:36AM -0700, Paul E. McKenney a écrit :
> > > Yes, I'm preparing an update for the offending patch (which has one more
> > > embarassing issue while I'm going through it again).
> > 
> > Very good, thank you!
> 
> So my proposal for a replacement patch is this (to replace the patch
> of the same name in Neeraj tree):

FYI, the diffstat against the previous version of the same patch is as follows.
The rationale being:

1) rdp->nocb_cb_kthread doesn't need to be protected by nocb_gp_kthread_mutex

2) Once rcuoc is parked, we really _must_ observe the callback list counter decremented
   after the barrier's completion.

3) This fixes another issue: rcuoc must be parked _before_
   rcu_nocb_queue_toggle_rdp() is called, otherwise a nocb locked sequence
   within rcuoc would race with rcuog clearing SEGCBLIST_OFFLOADED concurrently,
   leaving the nocb locked forever.


diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 755ada098035..97b99cd06923 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1056,6 +1056,13 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	/* Flush all callbacks from segcblist and bypass */
 	rcu_barrier();
 
+	/*
+	 * Make sure the rcuoc kthread isn't in the middle of a nocb locked
+	 * sequence while offloading is deactivated, along with nocb locking.
+	 */
+	if (rdp->nocb_cb_kthread)
+		kthread_park(rdp->nocb_cb_kthread);
+
 	rcu_nocb_lock_irqsave(rdp, flags);
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 	WARN_ON_ONCE(rcu_segcblist_n_cbs(&rdp->cblist));
@@ -1064,13 +1071,11 @@ static int rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
 	wake_gp = rcu_nocb_queue_toggle_rdp(rdp);
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
+
 	if (rdp_gp->nocb_gp_kthread) {
 		if (wake_gp)
 			wake_up_process(rdp_gp->nocb_gp_kthread);
 
-		if (rdp->nocb_cb_kthread)
-			kthread_park(rdp->nocb_cb_kthread);
-
 		swait_event_exclusive(rdp->nocb_state_wq,
 				      rcu_nocb_rdp_deoffload_wait_cond(rdp));
 	} else {
