Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C2E784BF
	for <rcu@archiver.kernel.org>; Mon,  2 Oct 2023 15:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbjJBPso (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Oct 2023 11:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238224AbjJBPsn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Oct 2023 11:48:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D4BAB;
        Mon,  2 Oct 2023 08:48:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44169C433C7;
        Mon,  2 Oct 2023 15:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261720;
        bh=ELvrTTc3tgkEtVZaFMDyJF1B3XJ0+YcocBLVouLOqvY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DcyhWZjtp0vISG7Vld77phnuaJgizDc+s1fNzDCVZ+YYxie8riQ0udlN3ij2KHOTP
         2hmsCQM+ItEeZD5zk9GuB8MyiabXCLEYjDRXoBInTb4+garra9mqaq40lhdodzO2VM
         Eou/to32emItUdzK0pwVvfNbmlUwCo2nOlmLMwSh5LEJBS4CBkIurT+Fw7CHp+sKTL
         zCp6AotjcckUL9+tkBqFjHW1v99TQjOzJ/OfC4eEds7P74FXsx79ILvQn7oDK4oEfG
         yV+wHBNJKn1CY4Lxyf36kzzTAlRsKhBcSEhee1xNA+gLnE/tqnUTke2gB0MNtUL7Ig
         6Qednt2xWd0TQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DFC70CE0CCF; Mon,  2 Oct 2023 08:48:39 -0700 (PDT)
Date:   Mon, 2 Oct 2023 08:48:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 10/10] rcu: Comment why callbacks migration can't wait
 for CPUHP_RCUTREE_PREP
Message-ID: <20c376e6-ba85-4c4a-bca6-727d3ef5e164@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-11-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908203603.5865-11-frederic@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 08, 2023 at 10:36:03PM +0200, Frederic Weisbecker wrote:
> The callbacks migration is performed through an explicit call from
> the hotplug control CPU right after the death of the target CPU and
> before proceeding with the CPUHP_ teardown functions.
> 
> This is unusual but necessary and yet uncommented. Summarize the reason
> as explained in the changelog of:
> 
> 	a58163d8ca2c (rcu: Migrate callbacks earlier in the CPU-offline timeline)
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/cpu.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index a41a6fff3c91..b135bb481be1 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1352,7 +1352,14 @@ static int takedown_cpu(unsigned int cpu)
>  	cpuhp_bp_sync_dead(cpu);
>  
>  	tick_cleanup_dead_cpu(cpu);
> +
> +	/*
> +	 * Callbacks must be re-integrated right away to the RCU state machine.
> +	 * Otherwise an RCU callback could block a further teardown function
> +	 * waiting for its completion.
> +	 */
>  	rcutree_migrate_callbacks(cpu);
> +
>  	return 0;
>  }
>  
> -- 
> 2.41.0
> 
