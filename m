Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223D20FA84;
	Tue, 18 Mar 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318293; cv=none; b=tiEgV9calW1021jfpg1oN8uKk9SnM5ImDntuO8jODWreesWglcytisHQTbOVfiDLhd2gr3lv75StfpH5FJVzzDdaXeXToyERF/L8oy1Smdw1GCdVrxcldJ+QcRg3sYpORAx0wdZVQh2RSVM3Ru34+Khm6M/Q/P3G4HEK5jkOQYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318293; c=relaxed/simple;
	bh=jWxpp9GIBPN1ge/OLToe81ZfIcGv2UXDL8D8GEn6A20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLnlBS5sicgPUxN8/cAjwJA1VNwRNyNOqaBwamEyu1ooD8Tf8/+uIvXmu4o08B5jEQSfcIEZK6X1YICvZJeZRuNG2MW8+WcKgs+jMmbVocb3GXzqKRgghz+jrCBINMj7zRYZi1AF+pNNBIiksPl2Qg7QueUAESJ6V6aUNyG86cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvxEpqAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvxEpqAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415B9C4CEDD;
	Tue, 18 Mar 2025 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742318293;
	bh=jWxpp9GIBPN1ge/OLToe81ZfIcGv2UXDL8D8GEn6A20=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EvxEpqAgSmROYdn3z4KDE0Cvpb2XOA14Bq/NLcbcZw49DrePbSRSkLnWiDiUBOjWf
	 jeRBF7x/rZHKAhy7IC+Q3OKDxvWDy2xes7nRtjPbxWYeymnRVBi/fcR6uRvA/L7FEt
	 gBQ8UKoEdLsCaK6eMriRxm57J7fFYs2VKDwsX0OYPnKjLghHGHD3+/Wsya4FGSO1eJ
	 uCn1MQ2EEBbDTrd+X0ldcikf8hrW+g7WTECzk25Zw1QLAJvEmFNdpeGcJd2wbOJ8x5
	 fTI/ZIu9gKaevOQ5rh4wTzDS38iuAMcGyqe4k+GW2g4gHTF2/Wu0vVtnBaCReVl/tI
	 Yq4Gy1c/lAlww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E5B98CE0843; Tue, 18 Mar 2025 10:18:12 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:18:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 2/5] rcu/exp: Remove confusing needless full barrier on
 task unblock
Message-ID: <6fa10edf-a04c-4a1d-9e11-fbed6332bff0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250314143642.72554-1-frederic@kernel.org>
 <20250314143642.72554-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314143642.72554-3-frederic@kernel.org>

On Fri, Mar 14, 2025 at 03:36:39PM +0100, Frederic Weisbecker wrote:
> A full memory barrier in the RCU-PREEMPT task unblock path advertizes
> to order the context switch (or rather the accesses prior to
> rcu_read_unlock()) with the expedited grace period fastpath.
> 
> However the grace period can not complete without the rnp calling into
> rcu_report_exp_rnp() with the node locked. This reports the quiescent
> state in a fully ordered fashion against updater's accesses thanks to:
> 
> 1) The READ-SIDE smp_mb__after_unlock_lock() barrier accross nodes
>    locking while propagating QS up to the root.
> 
> 2) The UPDATE-SIDE smp_mb__after_unlock_lock() barrier while holding the
>    the root rnp to wait/check for the GP completion.
> 
> 3) The (perhaps redundant given step 1) and 2)) smp_mb() in rcu_seq_end()
>    before the grace period completes.
> 
> This makes the explicit barrier in this place superflous. Therefore
> remove it as it is confusing.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Still cannot see a problem with this, but still a bit nervous.

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_plugin.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 3c0bbbbb686f..d51cc7a5dfc7 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -534,7 +534,6 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
>  		WARN_ON_ONCE(rnp->completedqs == rnp->gp_seq &&
>  			     (!empty_norm || rnp->qsmask));
>  		empty_exp = sync_rcu_exp_done(rnp);
> -		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
>  		np = rcu_next_node_entry(t, rnp);
>  		list_del_init(&t->rcu_node_entry);
>  		t->rcu_blocked_node = NULL;
> -- 
> 2.48.1
> 
