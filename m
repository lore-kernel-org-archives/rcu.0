Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292AFC433FE
	for <rcu@archiver.kernel.org>; Fri, 14 Oct 2022 22:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiJNWri (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 14 Oct 2022 18:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJNWrh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 14 Oct 2022 18:47:37 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1EC13ECC9
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 15:47:36 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id r19so4613903qtx.6
        for <rcu@vger.kernel.org>; Fri, 14 Oct 2022 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIDMRjxZ4Xyp6yANZOVgTit6chFtmm8gE1u2KRrbiU8=;
        b=GipgvN6jIGf1x1HRWRkuPlagiWaApeFXdmJAP4qXH3TwUDbzJXtfqr9R3opH8hRWY/
         +/KDsmggt6ZxSzmGITw6hPj4/xT8x+GbDbVtnvjoUsxcx3QH7X07ta/EqTNWHeq2LdjV
         N7yTbp//7DJEsF8daPKOFeR3TIrsbhBlxBGT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIDMRjxZ4Xyp6yANZOVgTit6chFtmm8gE1u2KRrbiU8=;
        b=6iM+y4wQdi9LcTEptuRMyhqQWQ/Y1HKHv2CtEV3+FzxUSzVhoIj8pewQ1uSUfE7nzQ
         d+OySH21DN4SoZo0MVEi4qO4ptpsE6BaFvVPzeTqM101S4fySVKZWBHPP/Qey0INSOMJ
         J1Q9CdhXaVQxLqnKPvziNVN548FB306ny5Ysmu2GBeqboyzMosOWNCYDbnb8i92rNyAS
         bqrjtKR8nKWlZCEVFYB++EQ8VKCZyUc5t2t6pM4GgFHfNVcLLi9h4lx9il+daz5aC40f
         S8+kAtm1+VnIkmBQJ8rpwxy90L09sFg2Y6q4vRe0/uX4TD8f6yziQteRAw5b7fpjsAcK
         F7xw==
X-Gm-Message-State: ACrzQf0BsoJClMcvpCt7G+n9bdv+1tFANpSsD/SW5bXjSoAvlpW3h1Vx
        InoU+swvvjT5DBWH2HgBvaVtvw==
X-Google-Smtp-Source: AMsMyM7wDDuVtEeH+l+T5khpojv2WAPqZgECsSkVI+QouWbHu5+cM9SHTr9XgZdHMNlNXHQgigMWew==
X-Received: by 2002:a05:622a:4d1:b0:39c:beaa:411e with SMTP id q17-20020a05622a04d100b0039cbeaa411emr54269qtx.530.1665787655417;
        Fri, 14 Oct 2022 15:47:35 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d9-20020ac85349000000b00343057845f7sm2800923qto.20.2022.10.14.15.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 15:47:34 -0700 (PDT)
Date:   Fri, 14 Oct 2022 22:47:34 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, rostedt@goodmis.org, tglx@linutronix.de,
        john.ogness@linutronix.de, pmladek@suse.com
Subject: Re: [PATCH v2 rcu 0/8] NMI-safe SRCU reader API
Message-ID: <Y0nnBjTHgoIVYMrJ@google.com>
References: <20220921144620.GA1200846@paulmck-ThinkPad-P17-Gen-1>
 <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929180714.GA2874192@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 29, 2022 at 11:07:14AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> This RFC series provides the second version of an NMI-safe SRCU reader API
> in the guise of srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().

Just a comment about high-level use of the new NMI-safe SRCU api: say if for
certain arch, NMI cannot be interrupted (by breakpoint or something), then
using NMI-safe API will force such arch to potentially use more expensive RMW
atomic than the previously cheap local non-atomic operations that the arch
was able to get away with.

Thoughts? Otherwise, LGTM.

thanks,

 - Joel


> A given srcu_struct structure must use either the traditional
> srcu_read_lock() and srcu_read_unlock() API or the new _nmisafe() API:
> Mixing and matching is not permitted.  So much so that kernels built
> with CONFIG_PROVE_RCU=y will complain if you try it.
> 
> The reason for this restriction is that I have yet to find a use case
> that is not a accident waiting to happen.  And if free intermixing
> were permitted, it is pretty much a given that someone somewhere will
> get confused and use srcu_read_lock_nmisafe() within NMI handlers and
> srcu_read_lock() elsewhere, which will not (repeat, NOT) provide NMI
> safety.
> 
> I do not expect to push this into the v6.1 merge window.  However, if
> the printk() series that needs it goes in, then I will push it as a fix
> for the resulting regression.
> 
> The series is as follows:
> 
> 1.	Convert ->srcu_lock_count and ->srcu_unlock_count to atomic.
> 
> 2.	Create an srcu_read_lock_nmisafe() and srcu_read_unlock_nmisafe().
> 
> 3.	Check for consistent per-CPU per-srcu_struct NMI safety.
> 
> 4.	Check for consistent global per-srcu_struct NMI safety.
> 
> 5.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> 6.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> 7.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> 8.	Add ARCH_HAS_NMI_SAFE_THIS_CPU_OPS Kconfig option.
> 
> Changes since v1 RFC:
> 
> 1.	Added enabling patches for arm64, loongarch, s390, and x86.
> 	These have what appear to me to be NMI-safe this_cpu_inc()
> 	implementations.
> 
> 2.	Fix a build error on !SMP kernels built without SRCU.
> 
> 3.	Fix a build error on !SMP kernels.
> 
> 						Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
>  b/arch/arm64/Kconfig       |    1 
>  b/arch/loongarch/Kconfig   |    1 
>  b/arch/s390/Kconfig        |    1 
>  b/arch/x86/Kconfig         |    1 
>  b/include/linux/srcu.h     |   39 +++++++++++++++++++++
>  b/include/linux/srcutiny.h |   11 ++++++
>  b/include/linux/srcutree.h |    4 +-
>  b/kernel/rcu/Kconfig       |    3 +
>  b/kernel/rcu/rcutorture.c  |   11 ++++--
>  b/kernel/rcu/srcutree.c    |   24 ++++++-------
>  include/linux/srcu.h       |    4 +-
>  include/linux/srcutiny.h   |    4 +-
>  include/linux/srcutree.h   |   12 +++++-
>  kernel/rcu/srcutree.c      |   82 +++++++++++++++++++++++++++++++++++++++------
>  14 files changed, 166 insertions(+), 32 deletions(-)
