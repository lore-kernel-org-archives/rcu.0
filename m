Return-Path: <SRS0=xc3B=77=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77D1C433DF
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DFA207D8
	for <rcu@archiver.kernel.org>; Thu, 18 Jun 2020 22:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592519247;
	bh=5LLHU83TJW662FBlQnZuvNz1/ymFXqtKCTV6ySPTQLE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=qG4rEmiFcXLfZNS+qM8t5sqbBvXnMnprStK4XHxWjDNx0/gzXh3vc7AZCVNoSKj6c
	 u/IV9JbZ0+x38n1VE5wXDcGYxsM/WePdVNEcgmVX4DKqZZtFqV73ZHdVoa9z2NoNEX
	 IpLRI98H+IDyovy0TdijAFkRrkXRf2ihs6er9ExU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbgFRW1X (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbgFRW1W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 18:27:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2E620732;
        Thu, 18 Jun 2020 22:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592519241;
        bh=5LLHU83TJW662FBlQnZuvNz1/ymFXqtKCTV6ySPTQLE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WlgqCujSPhVcnHCRV8QowhXtmrINgtijICinMfJNEQdcU1i3C6SPAjUK89r66cWlr
         TWmbzpI9tIK47gRj2sKxklr7rnmAFob5aKm5j2GQIU0OJ2dGJ7aQE07x17v8A5DBZI
         hM0WdWPZj4cFOrVBxtZRRUbeRa9FpW5bmeEedO0w=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 67DFC352264E; Thu, 18 Jun 2020 15:27:21 -0700 (PDT)
Date:   Thu, 18 Jun 2020 15:27:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 5/7] rcu/trace: Use rsp's gp_seq in acceleration's
 rcu_grace_period tracepoint
Message-ID: <20200618222721.GA2723@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618202955.4024-5-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 18, 2020 at 04:29:53PM -0400, Joel Fernandes (Google) wrote:
> During acceleration of CB, the rsp's gp_seq is rcu_seq_snap'd. This is
> the value used for acceleration - it is the value of gp_seq at which it
> is safe the execute all callbacks in the callback list.
> 
> The rdp's gp_seq is not very useful for this scenario. Make
> rcu_grace_period report the rsp's gp_seq instead as it allows one to
> reason about how the acceleration works.

Good catch, but please instead trace the gp_seq_req local variable.

							Thanx, Paul

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 81df1b837dd9d..c3bae7a83d792 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1437,9 +1437,9 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
>  
>  	/* Trace depending on how much we were able to accelerate. */
>  	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
> -		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccWaitCB"));
> +		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("AccWaitCB"));
>  	else
> -		trace_rcu_grace_period(rcu_state.name, "rdp", rdp->gp_seq, TPS("AccReadyCB"));
> +		trace_rcu_grace_period(rcu_state.name, "rsp", rcu_state.gp_seq, TPS("AccReadyCB"));
>  
>  	/* Count CBs for tracing. */
>  	rcu_segcblist_countseq(&rdp->cblist, cbs, gps);
> -- 
> 2.27.0.111.gc72c7da667-goog
> 
