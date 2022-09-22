Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40E2C54EE9
	for <rcu@archiver.kernel.org>; Thu, 22 Sep 2022 14:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbiIVOkw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 22 Sep 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiIVOkY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 22 Sep 2022 10:40:24 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82527F859A
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 07:39:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id v15so6910795qvi.11
        for <rcu@vger.kernel.org>; Thu, 22 Sep 2022 07:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=hMqblj/4z2GjKNiO1uGu1bXS3FyDtxJFwcuF5B7VkxE=;
        b=eSODAQej2Oow7dPw7KgIILSrGM0tHsAAz4XYvo8brnIop5QWH3dmoTplvhoWM1Ee2y
         +IcX+MhotrKxyv2owYiTHNYG7EOISGUVaroSK9rPpV68ZUPD7lJjGRyXTfurduyzs7gr
         s0YiVKaVSimtx9xSM5dGzvlxLQ9Wk0OUiPjnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=hMqblj/4z2GjKNiO1uGu1bXS3FyDtxJFwcuF5B7VkxE=;
        b=jzn6IiysUbULjh0hzQit7zO4IyLbjXGrW8S1oWRPmVn6XZMsc3wI9ziUWtQaJMiPll
         3s2VXGH4c4k9b1Ukm8JxWimNe8PgU5cF8+RK1kpl82ZrFPri24UgYRCkHmpk9au1ZIea
         VJhGuDWLpZ2YqvarOYFd97vLNLOR1EudM7lV/MvRbyrgfcfnHIWsXYSz0OHjJzMax1Zr
         EA6T4xP1/JaalwaZOu4P8FlaWfRI2NVO44HKWJUvIJCsaxFhIq6IJi/y4MRwbXf1CnDM
         sYeHPzJKFijkXGhBm4GGfi6wG1OC12uWbV22T31BAqBAaKrp+6tovCoEnrS7MXXoqWhD
         +VbA==
X-Gm-Message-State: ACrzQf0oiWaKin6o5xqZJyvdDm4ciUkDpHJJ3av6u9p0Nd1bFym+Znn8
        OghnfCMtPdL5/lAgT41uBNZm29NYHagLnw==
X-Google-Smtp-Source: AMsMyM62JbbSre6A9RQRYY64mKrvJvjB1oI6J7czcwacXp+TbMr/zaOcidSE8iyD/Gh8CzC5+k03nA==
X-Received: by 2002:a05:6214:27e5:b0:4ac:a637:729 with SMTP id jt5-20020a05621427e500b004aca6370729mr2823538qvb.73.1663857547981;
        Thu, 22 Sep 2022 07:39:07 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id o24-20020a05620a229800b006ce515196a7sm3949768qkh.8.2022.09.22.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 07:39:07 -0700 (PDT)
Date:   Thu, 22 Sep 2022 14:39:07 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     rcu@vger.kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <Yyxzix7f03nUkCnn@google.com>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <Yxfggt1/cLBhUi/y@google.com>
 <20220907094014.GA193994@lothringen>
 <YyujzQ/sU/aAdx4r@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyujzQ/sU/aAdx4r@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 21, 2022 at 11:52:45PM +0000, Joel Fernandes wrote:
[..]
> > > Anyway, for testing this should be good...
> > > 
> > > ---8<-----------------------
> > > 
> > > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> > > index bd8f39ee2cd0..e3344c262672 100644
> > > --- a/kernel/rcu/tree_nocb.h
> > > +++ b/kernel/rcu/tree_nocb.h
> > > @@ -382,15 +382,19 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
> > >  				  unsigned long j, unsigned long flush_flags)
> > >  {
> > >  	bool ret;
> > > +	bool was_alldone;
> > >  
> > >  	if (!rcu_rdp_is_offloaded(rdp))
> > >  		return true;
> > >  	rcu_lockdep_assert_cblist_protected(rdp);
> > >  	rcu_nocb_bypass_lock(rdp);
> > > +	if (flush_flags & FLUSH_BP_WAKE)
> > > +		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
> > > +
> > 
> > You can check that outside bypass lock (but you still need nocb_lock).
> > 
> > >  	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
> > >  
> > > -	if (flush_flags & FLUSH_BP_WAKE)
> > > -		wake_nocb_gp(rdp, true);
> > > +	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
> > > +		wake_nocb_gp(rdp, false);
> > 
> > That doesn't check if the bypass list was empty.
> 
> I am ending up with something like the below for v6, after discussing with
> Paul on IRC he pointed out we only need to do the rcu_barrier() related
> wakeup when all the CBs are lazy in the bypass list. Otherwise timer goes
> off. I think Frederic mentioned something similar above in different words.
> 
> I prefer to keep this logic in tree_nocb.h since rcu_barrier_entrain()
> shouldn't have to deal with nocb internals (in theory anyway).
> 
> Looks Ok?

And I did miss something so here is the updated version, testing it further
now, I think this is the last 'concern' I had before making the other API
changes we discussed so should hopefully be smooth sailing from here. Thank you!

---8<-----------------------

Subject: [PATCH for v6] fixup! rcu: Introduce call_rcu_lazy() API implementation

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree_nocb.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c197534d0c99..472ceb8af6d3 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -375,18 +375,27 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, unsigned long flush_flags)
 {
 	bool ret;
-	bool was_alldone;
+	bool was_alldone = false;
+	bool bypass_all_lazy = false;
+	long bypass_ncbs;
 
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	if (flush_flags & FLUSH_BP_WAKE)
+
+	if (flush_flags & FLUSH_BP_WAKE) {
 		was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+		bypass_all_lazy = bypass_ncbs && (bypass_ncbs == rdp->lazy_len);
+	}
 
 	ret = rcu_nocb_do_flush_bypass(rdp, rhp, j, flush_flags);
 
-	if (flush_flags & FLUSH_BP_WAKE && was_alldone)
+	// Wake up the nocb GP thread if needed. GP thread could be sleeping
+	// while waiting for lazy timer to expire (otherwise rcu_barrier may
+	// end up waiting for the duration of the lazy timer).
+	if (flush_flags & FLUSH_BP_WAKE && was_alldone && bypass_all_lazy)
 		wake_nocb_gp(rdp, false);
 
 	return ret;
-- 
2.37.3.998.g577e59143f-goog

