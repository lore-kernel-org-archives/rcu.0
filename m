Return-Path: <SRS0=XkjU=AY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118B7C433E2
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 21:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D84242075D
	for <rcu@archiver.kernel.org>; Mon, 13 Jul 2020 21:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594675585;
	bh=4tUNGMCF5cW3WvYy5Oyj4NnCSXP7PdlHE63oRtm9reA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ETjQawdxosTWV5IOrswI+OtAo2Wn3nSxS9cGXSvGli/dMte3JOMZ7mTDI/M4tTavm
	 9CsJ8+bMnwP5mC8wccXZXRgdGBcse2jVnxU694SnzqpEiwB9Qcbgy+RjeB4xFNMVEE
	 ieYYtjUxcHILdVLjvfLedlGxe3Y8RtQfZZrdDhos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgGMV0Z (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgGMV0Z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jul 2020 17:26:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D465B2075D;
        Mon, 13 Jul 2020 21:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594675584;
        bh=4tUNGMCF5cW3WvYy5Oyj4NnCSXP7PdlHE63oRtm9reA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pwBuZmEkWd1xrIcMGIDTl6jVxbApAv1id8vru1Df38dQdn24oGMwpVKoZVTcqQ49l
         1aDlQegYbMr+7XEjVfkgYxhrzBRosDXvGNoy/vqpqFQpbvyubwjx3+6ETBj5n/Vqw8
         rSI0e46aiguQXPNYJiday+ZKlQNj/KE6ydiyoSqw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B5DB835226AF; Mon, 13 Jul 2020 14:26:24 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:26:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist: Fix _list_check_srcu() macro
Message-ID: <20200713212624.GM9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200713174846.8681-1-madhuparnabhowmik10@gmail.com>
 <20200713210244.GL9247@paulmck-ThinkPad-P72>
 <20200713211315.GA19516@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713211315.GA19516@madhuparna-HP-Notebook>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jul 14, 2020 at 02:43:16AM +0530, Madhuparna Bhowmik wrote:
> On Mon, Jul 13, 2020 at 02:02:44PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 13, 2020 at 11:18:46PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > > 
> > > This patch fixes the macro _list_check_srcu() for CONFIG_PROVE_RCU_LIST =
> > > False.
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > Thank you, Madhuparna!  I am folding this into your original, but
> > with lowercase "true".
> >
> I am really sorry and thanks for applying this with the correction.

No worries!  Just thought that I should mention it in case there was
some subtle reason why TRUE was needed in this case.  ;-)

							Thanx, Paul

> > > ---
> > >  include/linux/rculist.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> > > index 516b4feb2682..a435ad62b90b 100644
> > > --- a/include/linux/rculist.h
> > > +++ b/include/linux/rculist.h
> > > @@ -73,7 +73,7 @@ static inline void INIT_LIST_HEAD_RCU(struct list_head *list)
> > >  #define __list_check_rcu(dummy, cond, extra...)				\
> > >  	({ check_arg_count_one(extra); })
> > >  
> > > -#define __list_check_srcu(cond)
> > > +#define __list_check_srcu(cond)	TRUE
> > >  #endif
> > >  
> > >  /*
> > > -- 
> > > 2.17.1
> > > 
