Return-Path: <SRS0=Lsu2=7H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AD4C433E0
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 18:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27EC2207D8
	for <rcu@archiver.kernel.org>; Mon, 25 May 2020 18:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590429855;
	bh=XgHlHnjCGUNTBTmrn5NBPKNl/rr2R/fQ/zB+IqMDgS4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=RGt9Sh4NWuWU2XFv6fmZwg5gqeIFuwUeGMRs3arcPGhWGodc07joke1z46P8WuffE
	 zw1xENHlgnDoVPVQBqxBGeLk+WrKV05bgzdnkqcSvb6l6ESjl2qmMUpJchGCjtz8Yn
	 RlkQNnjauORxKf3Cgy2Kxhr+KI4VaFWloLD97D0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgEYSEP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 25 May 2020 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYSEO (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 25 May 2020 14:04:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32035207DA;
        Mon, 25 May 2020 18:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590429854;
        bh=XgHlHnjCGUNTBTmrn5NBPKNl/rr2R/fQ/zB+IqMDgS4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fSJWlSwRmK/t4Wnfucbt3AIiTph7ZdShkIc+/oaSDZlUJUVgzQiB2HeaucFbT1dYx
         dglgOyqFUIwqg0pYmEy+0eUhetu/u8D3scJj0XldNPovquwRiiLwKPLXL/iIryCbQ1
         xFc9nxh2Z1EuY9sj5PO7lhOTmA8xZW050u8A8VKE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 18CA13522846; Mon, 25 May 2020 11:04:14 -0700 (PDT)
Date:   Mon, 25 May 2020 11:04:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcuperf: Remove useless while loops around wait_event
Message-ID: <20200525180414.GA2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200525043648.152547-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525043648.152547-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, May 25, 2020 at 12:36:47AM -0400, Joel Fernandes (Google) wrote:
> wait_event() already retries if the condition for the wake up is not
> satisifed after wake up. Remove them from the rcuperf test.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Queued the series, thank you, Joel!

							Thanx, Paul

> ---
>  kernel/rcu/rcuperf.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> index 16dd1e6b7c09f..246da8fe199e8 100644
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -576,11 +576,8 @@ static int compute_real(int n)
>  static int
>  rcu_perf_shutdown(void *arg)
>  {
> -	do {
> -		wait_event(shutdown_wq,
> -			   atomic_read(&n_rcu_perf_writer_finished) >=
> -			   nrealwriters);
> -	} while (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters);
> +	wait_event(shutdown_wq,
> +		   atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters);
>  	smp_mb(); /* Wake before output. */
>  	rcu_perf_cleanup();
>  	kernel_power_off();
> @@ -693,11 +690,8 @@ kfree_perf_cleanup(void)
>  static int
>  kfree_perf_shutdown(void *arg)
>  {
> -	do {
> -		wait_event(shutdown_wq,
> -			   atomic_read(&n_kfree_perf_thread_ended) >=
> -			   kfree_nrealthreads);
> -	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
> +	wait_event(shutdown_wq,
> +		   atomic_read(&n_kfree_perf_thread_ended) >= kfree_nrealthreads);
>  
>  	smp_mb(); /* Wake before output. */
>  
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
> 
