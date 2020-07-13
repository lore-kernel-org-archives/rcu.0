Return-Path: <SRS0=XkjU=AY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6C5C433E1
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 21:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C172084C
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 21:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594674165;
	bh=lgVYfTw+dPyNsK/MI5mOujzHg3a6HP/c0Gro5WJjAi4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=hRwNzfQAFR5avyLFGqPEoQsgjzCiUUustQaaSt4cvksJuTuZi038ARAp4ynIuI36l
	 x40WdwAL/4lMsNy26GLrXcbcI/oXt52CDRO0PKmPg1GZ05J69a2Kg4fGR1aKTDObzb
	 Jcqls45imdOBgt+EbX1z75kfNuIg+lPI2Vhrf6gM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgGMVCp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:02:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgGMVCp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jul 2020 17:02:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98B220849;
        Mon, 13 Jul 2020 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594674164;
        bh=lgVYfTw+dPyNsK/MI5mOujzHg3a6HP/c0Gro5WJjAi4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TflN22Vf15Ct7D1f+Zv5BusoL4CRVO61hhBD8cUYOiJJgeCN0vAlgkhdpXNKW7Lgl
         eyDor2VA4CsJ8JTl5DbYdhbw5DkeHGYQS/hcgFGwe6TSySCK0WYrB3krwr+3cVjKXU
         JuXHd8A43dTcnFC3/t0x67MisXWRnbdji0D0olXQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D622335226AF; Mon, 13 Jul 2020 14:02:44 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:02:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Fix _list_check_srcu() macro
Message-ID: <20200713210244.GL9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 13, 2020 at 11:18:46PM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> This patch fixes the macro _list_check_srcu() for CONFIG_PROVE_RCU_LIST =
> False.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Thank you, Madhuparna!  I am folding this into your original, but
with lowercase "true".

							Thanx, Paul

> ---
>  include/linux/rculist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 516b4feb2682..a435ad62b90b 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
>  #define __list_check_rcu(dummy, cond, extra...)				\
>  	({ check_arg_count_one(extra); })
>  
> -#define __list_check_srcu(cond)
> +#define __list_check_srcu(cond)	TRUE
>  #endif
>  
>  /*
> -- 
> 2.17.1
> 
