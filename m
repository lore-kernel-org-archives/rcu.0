Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C0F1B4223;
	Tue, 18 Mar 2025 17:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318509; cv=none; b=hMGpZYoxA+JyxSMuU4hxYgvuCyoUMbbUlqHVWP2hnPpMGGVpuilkTMI8SKbOvIhOs5+Vq2dIz32oGWT+SknAVBhdy6U3aiRgEggPHaoFP1etlMtz0VEgmU7aSABgQ6fGaoiI+hXwb0CK422Jx7dUvR8ay9EQfhIdJQpj54ORE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318509; c=relaxed/simple;
	bh=8hGkbvm6JuOdMjCcspq+QRdYGNxsSDkmDlmOna5SlP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne2FScI1iCkf6MmmBDF9K0eFlCgODb0rEOxIvqsYxfIshmPTkTzM0eYGSZ7BRyeoy3piwwNJIXpullO33xNFNoIaVlXvZjpPobTW8q70IqcAK+KnNA6kQ+kL6X2o8RaANXrAyIRva8l9FwJIZ5lXxpHb5jZesWqw6OfdyfPYmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiWDin6+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiWDin6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F57C4CEDD;
	Tue, 18 Mar 2025 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318509;
	bh=8hGkbvm6JuOdMjCcspq+QRdYGNxsSDkmDlmOna5SlP8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jiWDin6+KTKLY1pxr1S0lS1jNfWOCFRkknS1kgUDYBO3VHJv1JDPQbIzn4PcT5Buh
	 emeVfQD6Gka6JpY0WuK62MjvdrQIUZRZZOhVFR00EqmB2AvKVWNiatAzS6Qd4X542e
	 PJaiCbFV+FQHidbsjQCU5d/KYaYblGZ+W4arxCL3CfuaneIdQTMlsq6TBYjjiX7fFJ
	 Dgjq6cfKOE8/8bSNcU4URuMC0q6fmAbj/wPpdAE18kfA3P+VUPwf25q2WApHZKHEFJ
	 3bIpLadT1Nx5lIXPt8TLhxLF4/RYGmZg8U71Dh9jKuqy4mDNwC55aGw9eRWSWks0TJ
	 Db5NghNpk779w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 85C36CE0843; Tue, 18 Mar 2025 10:21:48 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:21:48 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 4/5] rcu/exp: Warn on QS requested on dying CPU
Message-ID: <476d11c8-ff63-4abc-a894-b9dabf92df8b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-5-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314143642.72554-5-frederic@kernel.org>

On Fri, Mar 14, 2025 at 03:36:41PM +0100, Frederic Weisbecker wrote:
> It is not possible to send an IPI to a dying CPU that has passed the
> CPUHP_TEARDOWN_CPU stage. Remaining unhandled IPIs are handled later at
> CPUHP_AP_SMPCFD_DYING stage by stop machine. This is the last
> opportunity for RCU exp handler to request an expedited quiescent state.
> And the upcoming final context switch between stop machine and idle must
> have reported the requested context switch.
> 
> Therefore, it should not be possible to observe a pending requested
> expedited quiescent state when RCU finally stops watching the outgoing
> CPU. Once IPIs aren't possible anymore, the QS for the target CPU will
> be reported on its behalf by the RCU exp kworker.
> 
> Provide an assertion to verify those expectations.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

But what do we do if this assertion triggers?  And do we want it to take
effect only in kernels built with CONFIG_PROVE_RCU?  Or is such a broken
assumption bad enough to justify a splat in production kernels?

If the answer to the last question is "yes" (and you, not me, work for
a distro, so it is your question to answer):

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3fe68057d8b4..79dced5fb72e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4321,6 +4321,12 @@ void rcutree_report_cpu_dead(void)
>  	 * may introduce a new READ-side while it is actually off the QS masks.
>  	 */
>  	lockdep_assert_irqs_disabled();
> +	/*
> +	 * CPUHP_AP_SMPCFD_DYING was the last call for rcu_exp_handler() execution.
> +	 * The requested QS must have been reported on the last context switch
> +	 * from stop machine to idle.
> +	 */
> +	WARN_ON_ONCE(rdp->cpu_no_qs.b.exp);
>  	// Do any dangling deferred wakeups.
>  	do_nocb_deferred_wakeup(rdp);
>  
> -- 
> 2.48.1
> 
