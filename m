Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B69C433E0
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8835B22B45
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 14:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhAEO5k (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbhAEO5k (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 09:57:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F57922B45;
        Tue,  5 Jan 2021 14:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609858619;
        bh=w1bEs4zhq0kpj3szSiXxBo4NuMk+DYW4Z7udcUjbIYo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IpxMDW8wAC8OgXtoUNezxGGAoUmUu+lUcJTGjKcVrulIQ1dIjOh73hfNEYseB2NWz
         tlYvL46IAj718N94a9Yx9mkGZcA3/WCkUgpXkBocGedDSjk6qRrWBjK72Iagq2c8Y6
         Khoc9De5b3Mu2h6FfhhhwmH+O1XCkdptbSURbA5rsEVbv1be40eJQcNQSjWHnK7S+1
         P2lQEqFOcEQIIv7WOtRiaSzpfNXqYfsf65B+GmvM6QnjsEkoi5VQYvwhvf+uCJWR74
         ezSrReyJFc5DYXWmWBT5NeffznXOQIS9XIhN1XLbw3VOfG3ZlLdJrco/CKP81ldJkn
         OY95A0Xb2TW+w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6337E3521C49; Tue,  5 Jan 2021 06:56:59 -0800 (PST)
Date:   Tue, 5 Jan 2021 06:56:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
Message-ID: <20210105145659.GD17086@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
 <20210105131441.GA2457@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105131441.GA2457@pc638.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 05, 2021 at 02:14:41PM +0100, Uladzislau Rezki wrote:
> Dear, Lukas.
> 
> > Dear Uladzislau,
> > 
> > in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
> > macro"), you have refactored the kfree_rcu macro.
> > 
> > Since then, make htmldocs warns:
> > 
> > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > 'ptr' description in 'kfree_rcu'
> > ./include/linux/rcupdate.h:882: warning: Excess function parameter
> > 'rhf' description in 'kfree_rcu'
> > 
> > As you deleted the two arguments in the macro definition, kerneldoc
> > cannot resolve the argument names in the macro's kerneldoc
> > documentation anymore and warns about that.
> > 
> > Probably, it is best to just turn the formal kerneldoc references to
> > the two arguments, which are not used in the macro definition anymore,
> > simply into two informal references in the documentation.
> > 
> Thanks for your suggestion. I am not sure if htmldocs supports something
> like "__maybe_unused", but tend to say that it does not. See below the
> patch:
> 
> <snip>
> >From 65ecc7c58810c963c02e0596ce2e5758c54ef55d Mon Sep 17 00:00:00 2001
> From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
> Date: Tue, 5 Jan 2021 13:23:30 +0100
> Subject: [PATCH] rcu: fix kerneldoc warnings
> 
> After refactoring of the kfree_rcu(), it becomes possible to use
> the macro with one or two arguments. From the other hand, in the
> description there are two arguments in the macro definition expected.
> That is why the "htmldocs" emits a warning about it:
> 
> <snip>
> ./include/linux/rcupdate.h:882: warning: Excess function parameter
> 'ptr' description in 'kfree_rcu'
> ./include/linux/rcupdate.h:882: warning: Excess function parameter
> 'rhf' description in 'kfree_rcu'
> <snip>
> 
> Fix it by converting two parameters into informal references in the
> macro description.
> 
> Fixes: 3d3d9ff077a9 ("rcu: Introduce kfree_rcu() single-argument macro")
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcupdate.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index ebd8dcca4997..e678ce7f5ca2 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -854,8 +854,8 @@ static inline notrace void rcu_read_unlock_sched_notrace(void)
>  
>  /**
>   * kfree_rcu() - kfree an object after a grace period.
> - * @ptr: pointer to kfree for both single- and double-argument invocations.
> - * @rhf: the name of the struct rcu_head within the type of @ptr,
> + * ptr: pointer to kfree for both single- and double-argument invocations.
> + * rhf: the name of the struct rcu_head within the type of ptr,
>   *       but only for double-argument invocations.
>   *
>   * Many rcu callbacks functions just call kfree() on the base structure.
> -- 
> 2.20.1
> <snip>
> 
> Paul, does it work for you?

If it works for the documentation generation, then it works for me.  ;-)

							Thanx, Paul
