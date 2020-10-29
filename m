Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BFC2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A371206FA
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 20:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJenf88G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgJ2UNt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UNs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 16:13:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6176BC0613CF;
        Thu, 29 Oct 2020 13:13:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l28so4916375lfp.10;
        Thu, 29 Oct 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zjF17W0vOMBHvXRSXvNM6sne+NYRImdcD8ZAV+fudt8=;
        b=WJenf88GwVujPLIoyqjWOsekMNi7gV/8Y7AkUIT5ybCsV046c2360Z8tOVnB6aqRtr
         LghMVYaImRBMWmgKSqg8EY5TOw8BgHbzJ1GNrFzXbQjN9Q6zkTZj/eT+3X77aHed/ACr
         9b+bd/bhvLox7WGsrSt/lTEX+Pt5VtwwPq/5m23slfILU+7NzDmnHX3t51hAbiAcLVtI
         4V1OMXUuXIzT/FjXzoLus96LhkAL1ubnYfiG5H2Z69a+h1kZAVbO2oP/pPryXcgRT70R
         EUM5kJ2FZYrNinfGDszqt7U45BY1uthyF9GnAJFUtNmrSWfy4JG8EamEJwSzzLGoJqBa
         SJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zjF17W0vOMBHvXRSXvNM6sne+NYRImdcD8ZAV+fudt8=;
        b=rpDo/DTuSK3WWuKCTDsaaM9mnETNe/mYAeecO0ijLkzcgSGizlTUeFo27CGLyaF7jY
         VglANu2hbhHEVtMboRD4/6qoIkxkGjM9gN0f1J9icNl2/RGCqBf4o2IkjSnFownmly5H
         pCw7MTJkL0jg+NRT8zc0MP9NGPR7YOw0mmSzUEl0qKXGhUPTEOKSA3Aa6eei8WzsoMqm
         /nQ1pDK8YBxDXQhsB4CuNkuveZwEJHHSzll+fdax7UOC7oUafofmkjyKvl6mt8xcPmwt
         YZWOZ4lfkTyMiipdWEmqfUXbC+fw4HvYEvYbMAZTWpJ6N09NATD4FcwVi2urGEBgXOzo
         gk7g==
X-Gm-Message-State: AOAM532iP0esMbuXa9qIIepg+TqFeSDuMw8L6Oo1djGhBasK4z2Kr+l0
        NnLNCksl7E/Tc9YDo5rC8OE=
X-Google-Smtp-Source: ABdhPJwAKZvLKhP/FMM9d4z87z8UU/QtyaaeXEbnaXMrdC6FoloO7nmL1UgDF90To/kdBO7frnhHPw==
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr2108833lfr.180.1604002426679;
        Thu, 29 Oct 2020 13:13:46 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v123sm383473lfa.129.2020.10.29.13.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:13:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 29 Oct 2020 21:13:42 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 16/16] rcu/tree: Use delayed work instead of hrtimer to
 refill the cache
Message-ID: <20201029201342.GA24122@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-16-urezki@gmail.com>
 <20201029194724.GN3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029194724.GN3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 12:47:24PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 29, 2020 at 05:50:19PM +0100, Uladzislau Rezki (Sony) wrote:
> > A CONFIG_PREEMPT_COUNT is unconditionally enabled, thus a page
> > can be obtained directly from a kvfree_rcu() path. To distinguish
> > that and take a decision the preemptable() macro is used when it
> > is save to enter allocator.
> > 
> > It means that refilling a cache is not important from timing point
> > of view. Switch to a delayed work, so the actual work is queued from
> > the timer interrupt with 1 jiffy delay. An immediate placing a task
> > on a current CPU can lead to rq->lock double lock. That is why a
> > delayed method is in place.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> Thank you, Uladzislau!
> 
> I applied this on top of v5.10-rc1 and got the following from the
> single-CPU builds:
> 
>   SYNC    include/config/auto.conf.cmd
>   DESCEND  objtool
>   CC      kernel/bounds.s
>   CALL    scripts/atomic/check-atomics.sh
>   UPD     include/generated/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from ./include/asm-generic/atomic-instrumented.h:20:0,
>                  from ./include/linux/atomic.h:82,
>                  from ./include/linux/crypto.h:15,
>                  from arch/x86/kernel/asm-offsets.c:9:
> ./include/linux/pagemap.h: In function ‘__page_cache_add_speculative’:
> ./include/linux/build_bug.h:30:34: error: called object is not a function or function pointer
>  #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
>                                  ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/mmdebug.h:45:25: note: in expansion of macro ‘BUILD_BUG_ON_INVALID’
>  #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
>                          ^~~~~~~~~~~~~~~~~~~~
> ./include/linux/pagemap.h:207:2: note: in expansion of macro ‘VM_BUG_ON’
>   VM_BUG_ON(preemptible())
>   ^~~~~~~~~
> scripts/Makefile.build:117: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
> make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> Makefile:1199: recipe for target 'prepare0' failed
> make: *** [prepare0] Error 2
> 
> I vaguely recall something like this showing up in the previous series
> and that we did something or another to address it.  Could you please
> check against the old series at -rcu branch dev.2020.10.22a?  (I verified
> that the old series does run correctly in the single-CPU scenarios.)
> 
I see the same build error. Will double check if we have similar in the
previous series also. It looks like the error is caused by the Thomas series.

Will check!

--
Vlad Rezki
