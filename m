Return-Path: <SRS0=ZNv1=EE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501A7C2D0A3
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 21:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC7720790
	for <rcu@archiver.kernel.org>; Thu, 29 Oct 2020 21:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuW7Mx7J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgJ2VAH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgJ2VAH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 29 Oct 2020 17:00:07 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA418C0613CF;
        Thu, 29 Oct 2020 14:00:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so5121426lfj.3;
        Thu, 29 Oct 2020 14:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XMYQHua+Jp8R5JX70fRoBEjc3AEfEl7IroFDKAy/9VI=;
        b=XuW7Mx7Jqmden4ULLfUgpuMx2WFE16DAkEp7fGksePcfthhf3J1Akx0VxMQITaiTdi
         tCR5h0VHvJKT7dLrHvZW9YABQ94qtDMAmVIzAhe0sfOK3p7cNj6BfCkzsepWWvM7udKJ
         jk1tkc6HjQPLtGJml6fuurkkz1d7SzqVEhBPpekjQYvOqYMip1nsey6Ny+nr8hnhCwkc
         N4ZXLJInDwWL/wfEEZrx3+m3yCqCRc+wv9E+1tWJuSCPDKaUKGyDbkTviJTqISLIsaR3
         gBNDJPJayoT+jl8SkTOKCC7pKQMtuC1ZdnGCxAlaF1QhwqxMo9/iJGeFsXNz7n0gwrMA
         luLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XMYQHua+Jp8R5JX70fRoBEjc3AEfEl7IroFDKAy/9VI=;
        b=Mte/AfDgJosf/HkclcwRRx9DLQrN1ahGNjBjgOztMOU40qqPfyPMmK0v6exZZbzyOs
         DFbhORdJRpS1qgnLq+WcPD0eGpkwDVlf8hqZhceoF+HVyte3GpoLzQvmD4tc0GKeH8gP
         sYU/fp5pAZOwC3/EF3Hnu9FI4JKoQFWHJonbUbEH5uLHECuHZnoFQ/mWOxldChYeKENe
         CIBfw7uxI5qHuv/qTL6j9VdBVtR8BPA1OvMto/HmjDuGHhOcuqq9QXxLlYGCad/yTeEE
         Iq7uDOif5cQcU6IzvUyzxjzOTJ0BtdqEPLe+4MVOdydLABhcpW09g/xbFoaqqQH8dmzb
         /adA==
X-Gm-Message-State: AOAM531deFjp5n13XLtlM/bpXXvTzZ9BifYWy52SIZbvb3UraNr/ITm3
        eLjAqpU8u04MHs9oD7oYzXk=
X-Google-Smtp-Source: ABdhPJzUfcde8m346JkaofmbaSRmOWSgyIaCedEBGK2TgVFdQqA2xiMcPqzvPoX0fKXwpQArB4S9Ww==
X-Received: by 2002:a19:ed0d:: with SMTP id y13mr2149692lfy.582.1604005203162;
        Thu, 29 Oct 2020 14:00:03 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id w17sm394115lfq.86.2020.10.29.14.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 14:00:02 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 29 Oct 2020 22:00:00 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
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
Message-ID: <20201029210000.GB24578@pc636>
References: <20201029165019.14218-1-urezki@gmail.com>
 <20201029165019.14218-16-urezki@gmail.com>
 <20201029194724.GN3249@paulmck-ThinkPad-P72>
 <20201029201342.GA24122@pc636>
 <20201029202241.GA24399@pc636>
 <20201029203355.GO3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201029203355.GO3249@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 29, 2020 at 01:33:55PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 29, 2020 at 09:22:41PM +0100, Uladzislau Rezki wrote:
> > On Thu, Oct 29, 2020 at 09:13:42PM +0100, Uladzislau Rezki wrote:
> > > On Thu, Oct 29, 2020 at 12:47:24PM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 29, 2020 at 05:50:19PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > A CONFIG_PREEMPT_COUNT is unconditionally enabled, thus a page
> > > > > can be obtained directly from a kvfree_rcu() path. To distinguish
> > > > > that and take a decision the preemptable() macro is used when it
> > > > > is save to enter allocator.
> > > > > 
> > > > > It means that refilling a cache is not important from timing point
> > > > > of view. Switch to a delayed work, so the actual work is queued from
> > > > > the timer interrupt with 1 jiffy delay. An immediate placing a task
> > > > > on a current CPU can lead to rq->lock double lock. That is why a
> > > > > delayed method is in place.
> > > > > 
> > > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > 
> > > > Thank you, Uladzislau!
> > > > 
> > > > I applied this on top of v5.10-rc1 and got the following from the
> > > > single-CPU builds:
> > > > 
> > > >   SYNC    include/config/auto.conf.cmd
> > > >   DESCEND  objtool
> > > >   CC      kernel/bounds.s
> > > >   CALL    scripts/atomic/check-atomics.sh
> > > >   UPD     include/generated/bounds.h
> > > >   CC      arch/x86/kernel/asm-offsets.s
> > > > In file included from ./include/asm-generic/atomic-instrumented.h:20:0,
> > > >                  from ./include/linux/atomic.h:82,
> > > >                  from ./include/linux/crypto.h:15,
> > > >                  from arch/x86/kernel/asm-offsets.c:9:
> > > > ./include/linux/pagemap.h: In function ‘__page_cache_add_speculative’:
> > > > ./include/linux/build_bug.h:30:34: error: called object is not a function or function pointer
> > > >  #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
> > > >                                  ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/mmdebug.h:45:25: note: in expansion of macro ‘BUILD_BUG_ON_INVALID’
> > > >  #define VM_BUG_ON(cond) BUILD_BUG_ON_INVALID(cond)
> > > >                          ^~~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/pagemap.h:207:2: note: in expansion of macro ‘VM_BUG_ON’
> > > >   VM_BUG_ON(preemptible())
> > > >   ^~~~~~~~~
> > > > scripts/Makefile.build:117: recipe for target 'arch/x86/kernel/asm-offsets.s' failed
> > > > make[1]: *** [arch/x86/kernel/asm-offsets.s] Error 1
> > > > Makefile:1199: recipe for target 'prepare0' failed
> > > > make: *** [prepare0] Error 2
> > > > 
> > > > I vaguely recall something like this showing up in the previous series
> > > > and that we did something or another to address it.  Could you please
> > > > check against the old series at -rcu branch dev.2020.10.22a?  (I verified
> > > > that the old series does run correctly in the single-CPU scenarios.)
> > > > 
> > > I see the same build error. Will double check if we have similar in the
> > > previous series also. It looks like the error is caused by the Thomas series.
> > > 
> > > Will check!
> > > 
> > OK. Found it:
> > 
> > urezki@pc638:~/data/coding/linux.git$ git diff
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index cbfbe2bcca75..7dd3523093db 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -204,7 +204,7 @@ void release_pages(struct page **pages, int nr);
> >  static inline int __page_cache_add_speculative(struct page *page, int count)
> >  {
> >  #ifdef CONFIG_TINY_RCU
> > -       VM_BUG_ON(preemptible())
> > +       VM_BUG_ON(preemptible());
> >         /*
> >          * Preempt must be disabled here - we rely on rcu_read_lock doing
> >          * this for us.
> > urezki@pc638:~/data/coding/linux.git$
> > 
> > I guess we had some extra patch that fixes a kernel compilation for !SMP
> > case. Will check dev.2020.10.22a.
> 
> I guess I am blind today!
> 
> And yes, that semicolon is in the corresponding commit in -tip.
> 
> So, an important safety tip:  When forward porting, start from the
> commits that have been tested rather than from the original series
> of patches.  ;-)
> 
> 							Thanx, Paul
Right. Sorry for that. I remember you mentioned about a build error
some time ago. My bad :)

I have updated the: [PATCH 06/16] mm/pagemap: Cleanup PREEMPT_COUNT leftovers
in this series.

--
Vlad Rezki
