Return-Path: <SRS0=HY8l=A2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397ECC433E4
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 13:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 182EC20578
	for <rcu@archiver.kernel.org>; Wed, 15 Jul 2020 13:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGK+3YRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgGONiN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731790AbgGONiN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jul 2020 09:38:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF918C061755;
        Wed, 15 Jul 2020 06:38:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so1075989lfi.7;
        Wed, 15 Jul 2020 06:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PhzIdxeoOOUU/XGSkeb9dh49ltxKms8qytJ1eU3P30E=;
        b=iGK+3YRoYh+/wmS9ZsIRElLKFIkbUlwI9F4/gkDg/s20TO5qe4prNqh5NyB2CuGo0o
         CCT+973r9xzluoekHsBqOwdNU/PyftM7mIrBEwbiV2pb4r1Lb2unJ9UHl4ubYoX7KLRC
         b2RBtY+VcSTLEriIwpFTeO16VVNnXBt2S+0/4RCAlMJtD25pzohohjA9WL8mLHlXC4ON
         SKS1FuPEpLa3igzNK8dGrA9czwxw2HZtHtMSwY12Nddi7cgWBeAhjolTB5uqSgdnTRN3
         RFhCm1fI3ddJBUrmWpRWV4s3RhI0khdhYqkFte3+1DuqGgUNY3V+JqKisQE4O9qy7gRu
         vELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PhzIdxeoOOUU/XGSkeb9dh49ltxKms8qytJ1eU3P30E=;
        b=qacUbDAk0uGXRQgbbw6WRSmQTGAflJ06SVDCBDl84zl6nb717FftqAnFw4xL9GDMOJ
         +6XsgiD+IDsfx2Bn7J9T57IO4T0rAbRmONQX11huCRtsYdiv7WxOhvb2mADQLR7fUJFm
         61D9PdircDoNNB++hP9s/Zevsdwn/WlYyVTAohPfGeRcKRWgZ4yhTv5Pyvv9orVCaxh5
         zSMgdD2Puzf3GtLTxqXtce+lbr80gVDWGvhWe4kbr/BkMUlKXztsCJ0DIdhKxD8srQH/
         MJ2WgpifOI04iSCx+Xv1nImmfmyfaYIfpQy801nDZIAsaRM7mKRdZSNIvr4/OsWG8spw
         dqzQ==
X-Gm-Message-State: AOAM531/N8FOiiuEgD+tG6Rl6rBpgDsHeAXqGtLAkOT+MUpiEdmnu7ha
        NJVZjZvF4fZ95IhXmc1gT4Ecche3oVo=
X-Google-Smtp-Source: ABdhPJw79107V8AQsberXuQGbsLT4HaFiePpPxG6wY4GlpjAuYqtf5OjHQ5jy4gjZf19W6CyOhOLDg==
X-Received: by 2002:a05:6512:20f:: with SMTP id a15mr4815337lfo.118.1594820291132;
        Wed, 15 Jul 2020 06:38:11 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id 15sm458867ljj.104.2020.07.15.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:38:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 15 Jul 2020 15:38:08 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     paulmck@kernel.org, joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200715133808.GA24778@pc636>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 30, 2020 at 06:45:43PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-06-24 13:12:12 [-0700], paulmck@kernel.org wrote:
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > To keep the kfree_rcu() code working in purely atomic sections on RT,
> > such as non-threaded IRQ handlers and raw spinlock sections, avoid
> > calling into the page allocator which uses sleeping locks on RT.
> > 
> > In fact, even if the  caller is preemptible, the kfree_rcu() code is
> > not, as the krcp->lock is a raw spinlock.
> > 
> > Calling into the page allocator is optional and avoiding it should be
> > Ok, especially with the page pre-allocation support in future patches.
> > Such pre-allocation would further avoid the a need for a dynamically
> > allocated page in the first place.
> > 
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Reviewed-by: Uladzislau Rezki <urezki@gmail.com>
> > Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 64592b4..dbdd509 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3184,6 +3184,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
> >  		if (!bnode) {
> >  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
> >  
> > +			/*
> > +			 * To keep this path working on raw non-preemptible
> > +			 * sections, prevent the optional entry into the
> > +			 * allocator as it uses sleeping locks. In fact, even
> > +			 * if the caller of kfree_rcu() is preemptible, this
> > +			 * path still is not, as krcp->lock is a raw spinlock.
> > +			 * With additional page pre-allocation in the works,
> > +			 * hitting this return is going to be much less likely.
> > +			 */
> > +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +				return false;
> 
> This is not going to work together with the "wait context validator"
> (CONFIG_PROVE_RAW_LOCK_NESTING).

>
> As of -rc3 it should complain about printk() which is why it is still disabled by default.
>
Have you tried to trigger a "complain" you are talking about?
I suspect to get some trace dump when CONFIG_PROVE_RAW_LOCK_NESTING=y.

Thank you.

--
Vlad Rezki
