Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49DEC4332F
	for <rcu@archiver.kernel.org>; Wed, 23 Nov 2022 13:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238419AbiKWNle (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Nov 2022 08:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiKWNlS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Nov 2022 08:41:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BD1B78E
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:29:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so2024110pjk.1
        for <rcu@vger.kernel.org>; Wed, 23 Nov 2022 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hJEhJwgSxHk9ZBET+nXV0gP26iUPgmyBX2hPM/coDQQ=;
        b=nxfKond9J57iz6iujQewofkDohuDPumqAnbdFXqiDxJsJlZydnGZ2XotsctrG5rcfy
         dtlcSQuHcwmQ4jPNuIJD0hNn2Kbw4oURrTco/ATuv6zXxOW8eJwSzvQlH4cqyxWVXUuN
         K6StzhCQa+/cuEhErnlACzYD4RZHdHSzf/1jeMxlb0mSvgRYws/60SkDlL2u4s7AkK/v
         jWvJkDj9HAYRwuzlXkAGIwAGPvplgF3H7RujH+S0bqe8Rt0K4iCCaGZdyaKVKJ17/Fav
         U+2613PnmyGEHsy4ciK4i8ZkkXFj+P+QvtE6on1/wvG7FRdplEggiLlUfHyeCT1KHnyh
         DbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJEhJwgSxHk9ZBET+nXV0gP26iUPgmyBX2hPM/coDQQ=;
        b=YZP+GlHzNVI8at2VbB2cmjQSYGMd4COueRqVRuKBA0sGhdGp3opMalB/FbOxp09PvQ
         4iEKOJFrePLXlY/17ZwVWZDbWhfjUWCoNdd3SlPwg+pxjvyT6peB4eEEC5m4wErnaNiF
         6pn02elV2IhFlKNI8WIlOLykvybzintfMQvvPVP47zizewUHs9rCYxD3Pgkt3sIDbOYU
         1p5nhaSkIfA2kQoQHCBGhTGH+VsliAbCmCx3l0woVSZs4P9bOOelPVeYmJSIc/Q642mL
         4NzOBF6Ut2PJYdcvYx9j1Eb3xhom5kpYBtfD8RCOi0fKAzBuDvL69mObOsMOwPIE9I4x
         4yvg==
X-Gm-Message-State: ANoB5pmHcGXvrdJgAlyYh4E+Yt8AZOXZiCvyADXd7KNY7Kzcze4o0iJi
        OFD56VhSvM/8N5zoO8ZF4Q==
X-Google-Smtp-Source: AA0mqf6wAv6Ah7SvDYI7yrqcze13ptWEUgCfjsKxKMM4WB0rHKrX11KprJpVshL90oL/hma41nYKlw==
X-Received: by 2002:a17:902:8212:b0:186:85c3:98b7 with SMTP id x18-20020a170902821200b0018685c398b7mr9483265pln.31.1669210164140;
        Wed, 23 Nov 2022 05:29:24 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090a4c8200b00200461cfa99sm1421742pjh.11.2022.11.23.05.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:29:23 -0800 (PST)
Date:   Wed, 23 Nov 2022 21:29:17 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] srcu: Remove needless updating of srcu_have_cbs in
 srcu_gp_end()
Message-ID: <Y34gLXdlr2ppvL4J@piliu.users.ipa.redhat.com>
References: <20221120034014.7390-1-kernelfans@gmail.com>
 <20221120034014.7390-3-kernelfans@gmail.com>
 <20221122011916.GT4001@paulmck-ThinkPad-P17-Gen-1>
 <Y3ydcMAkqpCGNosw@piliu.users.ipa.redhat.com>
 <20221122144549.GH4001@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122144549.GH4001@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 22, 2022 at 06:45:49AM -0800, Paul E. McKenney wrote:
> On Tue, Nov 22, 2022 at 05:59:12PM +0800, Pingfan Liu wrote:
> > On Mon, Nov 21, 2022 at 05:19:16PM -0800, Paul E. McKenney wrote:
> > > On Sun, Nov 20, 2022 at 11:40:14AM +0800, Pingfan Liu wrote:
> > > > At present, snp->srcu_have_cbs[idx] is updated by either
> > > > srcu_funnel_gp_start() or srcu_gp_end().
> > > > 
> > > > But as the code changes, now, srcu_funnel_gp_start() is called with srcu
> > > > read lock held. And its input parameter s, s = rcu_seq_snap(&ssp->srcu_gp_seq),
> > > > whose counter field always proceeds that of the srcu_gp_seq by one or two.
> > > > 
> > > > If the seq snap only proceeds by one, the state machine should be in
> > > > state SRCU_STATE_IDLE, the held srcu read lock will prevent the state
> > > > machine from moving ahead. So when srcu_gp_end() updates
> > > > snp->srcu_have_cbs[idx], the idx must be the past idx for
> > > > srcu_funnel_gp_start() that is cared by nobody.
> > > > 
> > > > So removing the unnecessary updating in srcu_gp_end().
> > > 
> > > This looks plausible, good eyes!
> > > 
> > > But is there a debug check that could verify that this is unnecessary?
> > > Logical reasoning is all well and good, but the actual system always
> > > wins arguments.  ;-)
> > > 
> > 
> > Agree. Reasoning may miss some ground and render a wrong result.
> > 
> > But it is a little hard to demonstrate the past idx is not accessed. I
> > will go on to figure a way out.
> 
> On a 64-bit system especially, it should be easy to generate a pattern
> that never actually occurs.  Even on a 32-bit system, aren't there bit
> patterns in the low-order bits that never occur?
> 
> Wouldn't it be possible to check for those?
> 

I had thought about that way, but that means a write and cache invalid.

While on the other way, I still rely on the logic to add some check
code, which should be avoided.

Finally, I turn back to the way which you suggested. But I have a new
plan for this patch. So I will send out V2 for the other two patches.

As for this one, it will come in the next series.

Thanks,

	Pingfan


> 							Thanx, Paul
> 
> > Thanks,
> > 
> > 	Pingfan
> > 
> > > 							Thanx, Paul
> > > 
> > > > Test info:
> > > >   Running "tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 10h --configs 18*SRCU-P"
> > > > without any failure.
> > > > 
> > > > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > To: rcu@vger.kernel.org
> > > > ---
> > > >  kernel/rcu/srcutree.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 7df59fc8073e..c54d6c04751f 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -783,8 +783,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > > >  			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
> > > >  			if (last_lvl)
> > > >  				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
> > > > -			snp->srcu_have_cbs[idx] = gpseq;
> > > > -			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
> > > >  			sgsne = snp->srcu_gp_seq_needed_exp;
> > > >  			if (srcu_invl_snp_seq(sgsne) || ULONG_CMP_LT(sgsne, gpseq))
> > > >  				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
> > > > -- 
> > > > 2.31.1
> > > > 
