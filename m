Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573E7C43334
	for <rcu@archiver.kernel.org>; Sun, 26 Jun 2022 13:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbiFZNph (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 26 Jun 2022 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiFZNpg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 26 Jun 2022 09:45:36 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69959A453
        for <rcu@vger.kernel.org>; Sun, 26 Jun 2022 06:45:34 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 65so738295qva.9
        for <rcu@vger.kernel.org>; Sun, 26 Jun 2022 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fQgBpk4Ec6TNtbf94ivHew5bIAMV6bKhVZxWsth1n5U=;
        b=ENBwwSKy16oK4zs4Ej9VUDg81N5lPxxKNL+POUBsY3/JAn+04OVKrOA8vMqxkEovBj
         ezZTUlS7HfGE+ANUZ10jh8k7+azfrm6mog61f0wgTWcEJaiCdGuW7oeSNDWJc5ywQLbG
         AlKZLOOKibW/zojSNSvjr0lK3gbysqV65/mdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQgBpk4Ec6TNtbf94ivHew5bIAMV6bKhVZxWsth1n5U=;
        b=woZVw13esGCdVwzezL+a4s97i7jmadRchtcnBnnhaMEJeJi1IMz2+XZUt5A76FJogv
         EAJj+ItNlSM1OAFgRNYIO6baOuX+F4VLBsKrARjX+ViHcqphtnSxVJTxS7DiZ6fXKuVD
         OdTt2fPgVcrVVJFi2Sm4SuNuQfxvYVLHqT3gWBOQ/UG4K+Kj6tSVhvT21kFYzPxhjZWi
         0jM6d3BcmThFN+UXs8D0f3IzukPymKQR17vwijVnP29Tsx9AcwlDk1IvpNezNOfViBMd
         RRYNv007FGrzGWvVf+3Pc5BFoJkmDF0181Nvvneo6bD6WVdule7dzL391VXqMSB6EPjW
         WG5g==
X-Gm-Message-State: AJIora+UFSAEU3UrcEuoOfdPKClLPsOedQYCVG1gf4A+1qiaAjq7HgLJ
        3mIOkeiQNMt2c5R7nqSfF7yLtw==
X-Google-Smtp-Source: AGRyM1tMs7sIqC+PHHFppnueOvtk+qBIZMDfMjE8aWczyuFesJe3Yx+ybQkb69e6vJsppdf0BzU7Mw==
X-Received: by 2002:ac8:75c5:0:b0:304:ffea:c434 with SMTP id z5-20020ac875c5000000b00304ffeac434mr6255363qtq.170.1656251133533;
        Sun, 26 Jun 2022 06:45:33 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id x8-20020a05620a258800b006a75a0ffc97sm6662361qko.3.2022.06.26.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 06:45:33 -0700 (PDT)
Date:   Sun, 26 Jun 2022 13:45:32 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org
Subject: Re: [PATCH v2 5/8] rcu/nocb: Wake up gp thread when flushing
Message-ID: <Yrhi/Jwm0eLmDIGb@google.com>
References: <20220622225102.2112026-1-joel@joelfernandes.org>
 <20220622225102.2112026-7-joel@joelfernandes.org>
 <20220626040622.GM1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220626040622.GM1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jun 25, 2022 at 09:06:22PM -0700, Paul E. McKenney wrote:
> On Wed, Jun 22, 2022 at 10:50:59PM +0000, Joel Fernandes (Google) wrote:
> > We notice that rcu_barrier() can take a really long time. It appears
> > that this can happen when all CBs are lazy and the timer does not fire
> > yet. So after flushing, nothing wakes up GP thread. This patch forces
> > GP thread to wake when bypass flushing happens, this fixes the
> > rcu_barrier() delays with lazy CBs.
> 
> I am wondering if there is a bug in non-rcu_barrier() lazy callback
> processing hiding here as well?

I don't think so because in both nocb_try_bypass and nocb_gp_wait, we are not
going to an indefinite sleep after the flush. However, with rcu_barrier() ,
there is nothing to keep the RCU GP thread awake. That's my theory at least.
In practice, I have not been able to reproduce this issue with
non-rcu_barrier().

With rcu_barrier() I happen to hit it thanks to the rcuscale changes I did.
That's an interesting story! As I apply call_rcu_lazy() to the file table
code, turns out that on boot, the initram unpacking code continously triggers
call_rcu_lazy(). This happens apparently in a different thread than the one
that rcuscale is running in. In rcuscale, I did rcu_barrier() at init time
and this stalled for a long time to my surprise, and this patch fixed it.

thanks,

 - Joel


> 
> 							Thanx, Paul
> 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/tree_nocb.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > index 2f5da12811a5..b481f1ea57c0 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -325,6 +325,8 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> >  	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
> >  	WRITE_ONCE(rdp->nocb_bypass_first, j);
> >  	rcu_nocb_bypass_unlock(rdp);
> > +
> > +	wake_nocb_gp(rdp, true);
> >  	return true;
> >  }
> >  
> > -- 
> > 2.37.0.rc0.104.g0611611a94-goog
> > 
