Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2251C4332F
	for <rcu@archiver.kernel.org>; Sun, 18 Dec 2022 21:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiLRVmu (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 18 Dec 2022 16:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRVms (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 18 Dec 2022 16:42:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647CDB7C6;
        Sun, 18 Dec 2022 13:42:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE87160DF4;
        Sun, 18 Dec 2022 21:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD983C433D2;
        Sun, 18 Dec 2022 21:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671399766;
        bh=1ExGREq5LdbOPWuIxtFwOnvs+PhzJXC6rOn7jUHuVZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSuBw1O+JjB8SKxv2i8sQ9TKUatD4DAol6eRzYCfbsnTPhtBn4QKnz6zjg6DoQVji
         Uy7wN2DcYTT8y0jgQnEcCibJRPKzbbJHq507oDzBaz84Vif0jKtavHquqz7V5W1XFz
         C0IM++C/NDJIkX6FW5h/YhJiqxj1e/XOvb5hrErf/9nQTQbg0/ys836JD0wOHDEIPi
         vwlVP8kZCEi5le7dmuabpYaZoT6Fkd5ImwyrjNjVtppDGfDl5fZ6G8P79cRaQBUII1
         VvpeVWv+DChe21p2FoIRRI7OFguN8M/+9cstPhMa648ptCN9phi4IzBkeztvUTNPx+
         c2m/i7pV8/BPQ==
Date:   Sun, 18 Dec 2022 22:42:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 2/2] srcu: Remove memory barrier "E" as it is not required
Message-ID: <20221218214243.GA1990383@lothringen>
References: <20221218191310.130904-1-joel@joelfernandes.org>
 <20221218191310.130904-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221218191310.130904-3-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Dec 18, 2022 at 07:13:09PM +0000, Joel Fernandes (Google) wrote:
> During a flip, we have a full memory barrier before idx is incremented.
> 
> The effect of this seems to be to guarantee that, if a READER sees srcu_idx
> updates (srcu_flip), then prior scans would not see its updates to counters on
> that index.
> 
> That does not matter because of the following reason: If a prior scan did see
> counter updates on the new index, that means the prior scan would would wait
> for the reader when it probably did not need to.

I'm confused, isn't it actually what we want to prevent from?
The point of the barrier here is to make sure that the inactive index that
we just scanned is guaranteed to remain seen as inactive during the whole scan
(minus the possible twice residual increments from a given task that we debated
on Paul's patch, but we want the guarantee that the inactive index won't be
incremented thrice by a given task or any further while we are scanning it).

If some readers see the new index and increments the lock and we see that while
we are scanning it, there is a risk that the GP is going to be delayed indefinetly.

> @@ -982,14 +982,6 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
>   */
>  static void srcu_flip(struct srcu_struct *ssp)
>  {
> -	/*
> -	 * Ensure that if a given reader sees the new value of ->srcu_idx, this
> -	 * updater's earlier scans cannot have seen that reader's increments
> -	 * (which is OK, because this grace period need not wait on that
> -	 * reader).
> -	 */
> -	smp_mb(); /* E */  /* Pairs with B and C. */

That said, I've been starring at this very barrier for the whole day, and I'm
wondering what does it match exactly on the other end?

      UPDATER                               READER
      -------                               ------
      idx = ssp->srcu_idx;                  idx = srcu_idx;
      READ srcu_unlock_count[srcu_idx ^ 1]  srcu_lock_count[idx]++
      smp_mb();                             smp_mb();
      READ srcu_lock_count[srcu_idx ^ 1]    srcu_unlock_count[old_idx]++
      smp_mb()
      srcu_idx++;

For a true match, I would expect a barrier between srcu_idx read and
srcu_lock_count write. I'm not used to ordering writes after reads.
So what is the pattern here? I would expect something like the below
but that doesn't match the above:

C rwrw

{}


P0(int *X, int *Y)
{
	int x;

	x = READ_ONCE(*X);
	smp_mb();
	WRITE_ONCE(*Y, 1);
}

P1(int *X, int *Y)
{

	int y;

	y = READ_ONCE(*Y);
	smp_mb();
	WRITE_ONCE(*X, 1);
}

exists (0:x=1 /\ 1:y=1)


> -
>  	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
>  
>  	/*
> -- 
> 2.39.0.314.g84b9a713c41-goog
> 
