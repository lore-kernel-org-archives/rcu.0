Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAC5C433FE
	for <rcu@archiver.kernel.org>; Fri, 14 Oct 2022 22:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJNWw1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJNWw0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Oct 2022 18:52:26 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20614080
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 15:52:24 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id u2so3267598ilv.6
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 15:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbR5+XwFTuPn9xSU9fHoCkGo3f4KWngVx7w96DA+l4M=;
        b=cHPFwe4iw4yl5mXEfprNsN2xaBgevjV5qO4OzsPu5p8eDEiPSR7KEmYRst4GpE9/xU
         p9tNgxcXGObKH2u5IpWvsgX5Qf/f1YxJsapzR55DMn1k1Mch4IBnDoTyUkXaz+IemXlD
         f7mXXFL3XpJSkoyz2vlVY0B9b9cHjIughBqPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbR5+XwFTuPn9xSU9fHoCkGo3f4KWngVx7w96DA+l4M=;
        b=B++z8Fg+ilp22KbSxxXLDyJSh26VPKT8+CHMz7FSejWionzHcEIXa24+OvYN/1xBAH
         nDutw7JVASLoKY+/qN/LX5dvNiFKLuLjT6BUE9Ino0MTAurxodfj2ER8FUJzj6SE+I1H
         sOtHp4cQiutvN3LfxTZmmKiZ9tRjb2UegUkXfYrc/iF07o5Ub7o2BZtkouH2jjfKptyj
         nLAMGQQKBPumCT3NA1rvKnar0TEqy9OFCld2fPCXfhraBBl4ipbJoFuHfONKyVX6MkvW
         GMaWZmgTfIIa+h/bEkaxTlteOZTgRWqYB2mjBxMab3o+eS6fiS1E7vxUyjWEXv8ulHtZ
         km5Q==
X-Gm-Message-State: ACrzQf2XUoUkmKbjSMHMPFEMpvgPz0uMDoF6W4yMLob0x72vrqke4QC8
        UtM0V/w4Sun4xSDbiYQdag5h93ZDGaM8vPv2bxXwJw==
X-Google-Smtp-Source: AMsMyM5Y9vWnWJmRhIm/lbebDofHqwRfmBROC6dwCfOFWUYgGfL3zlVkCIAiFZoccJ++1Y8Q4J9s01TbymiJ9+tTLzw=
X-Received: by 2002:a05:6e02:507:b0:2f9:6ab8:2dd5 with SMTP id
 d7-20020a056e02050700b002f96ab82dd5mr6260ils.85.1665787944147; Fri, 14 Oct
 2022 15:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1> <Y0nnBjTHgoIVYMrJ@google.com>
In-Reply-To: <Y0nnBjTHgoIVYMrJ@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 14 Oct 2022 18:52:13 -0400
Message-ID: <CAEXW_YTBOM--SF0JDGmsa4sj5PmA6Zjx-b9t-4gfLtGkxhnHUQ@mail.gmail.com>
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        john.ogness@linutronix.de, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Oct 14, 2022 at 6:47 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Sep 29, 2022 at 11:07:14AM -0700, Paul E. McKenney wrote:
> > Hello!
> >
> > This RFC series provides the second version of an NMI-safe SRCU reader API
> > in the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
>
> Just a comment about high-level use of the new NMI-safe SRCU api: say if for
> certain arch, NMI cannot be interrupted (by breakpoint or something), then
> using NMI-safe API will force such arch to potentially use more expensive RMW
> atomic than the previously cheap local non-atomic operations that the arch
> was able to get away with.
>
> Thoughts? Otherwise, LGTM.
>

I take it back. You are indeed guarding it correctly as below. I got
confused by another patch that was doing debug checking even for arch
that does not need it (which is a good thing).

+config NEED_SRCU_NMI_SAFE
+ def_bool HAVE_NMI && !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !TINY_SRCU
+

Thanks!

 - Joel


> thanks,
>
>  - Joel
>
>
> > A given srcu_struct structure must use either the traditional
> > srcu_read_lock() and srcu_read_unlock() API or the new _nmisafe() API:
> > Mixing and matching is not permitted.  So much so that kernels built
> > with CONFIG_PROVE_RCU=y will complain if you try it.
> >
> > The reason for this restriction is that I have yet to find a use case
> > that is not a accident waiting to happen.  And if free intermixing
> > were permitted, it is pretty much a given that someone somewhere will
> > get confused and use srcu_read_lock_nmisafe() within NMI handlers and
> > srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
> > safety.
> >
> > I do not expect to push this into the v6.1 merge window.  However, if
> > the printk() series that needs it goes in, then I will push it as a fix
> > for the resulting regression.
> >
> > The series is as follows:
> >
> > 1.    Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.
> >
> > 2.    Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
> >
> > 3.    Check for consistent per-CPU per-srcu_struct NMI safety.
> >
> > 4.    Check for consistent global per-srcu_struct NMI safety.
> >
> > 5.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > 6.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > 7.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > 8.    Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> >
> > Changes since v1 RFC:
> >
> > 1.    Added enabling patches for arm64, loongarch, s390, and x86.
> >       These have what appear to me to be NMI-safe this_cpu_inc()
> >       implementations.
> >
> > 2.    Fix a build error on !SMP kernels built without SRCU.
> >
> > 3.    Fix a build error on !SMP kernels.
> >
> >                                               Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> >  b/arch/arm64/Kconfig       |    1
> >  b/arch/loongarch/Kconfig   |    1
> >  b/arch/s390/Kconfig        |    1
> >  b/arch/x86/Kconfig         |    1
> >  b/include/linux/srcu.h     |   39 +++++++++++++++++++++
> >  b/include/linux/srcutiny.h |   11 ++++++
> >  b/include/linux/srcutree.h |    4 +-
> >  b/kernel/rcu/Kconfig       |    3 +
> >  b/kernel/rcu/rcutorture.c  |   11 ++++--
> >  b/kernel/rcu/srcutree.c    |   24 ++++++-------
> >  include/linux/srcu.h       |    4 +-
> >  include/linux/srcutiny.h   |    4 +-
> >  include/linux/srcutree.h   |   12 +++++-
> >  kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
> >  14 files changed, 166 insertions(+), 32 deletions(-)
