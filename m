Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B720CCA47B
	for <rcu@archiver.kernel.org>; Mon, 13 Jun 2022 20:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347572AbiFMUQ5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350850AbiFMUQm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jun 2022 16:16:42 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB92AE38
        for <rcu@vger.kernel.org>; Mon, 13 Jun 2022 11:53:29 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d128so4727636qkg.8
        for <rcu@vger.kernel.org>; Mon, 13 Jun 2022 11:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pL6Jigvp2l0jeBnwg+GrKKXW2isHg56IIoArd45A5i8=;
        b=L5CY/MDukSs9q5Lt8aInkSIT5VTrECS5e2Dj+dH/vyXib5iKrEY0e0o/97qKuQIVRX
         M12HQbrI4Sjd8n0Mul2gJ6oRTtN2KrcPkmEHSKS6t0ybxl+Og0zTX/Quf83Ny90WVUOj
         HES104aMVg4j6IxdABQ0hV/JH8EJuY3Z2KoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pL6Jigvp2l0jeBnwg+GrKKXW2isHg56IIoArd45A5i8=;
        b=tsfTeJ1EuB0pQF2WSVabxmIlDerqY/eR2TrIp5pKPs70PsZ1U/LvELV4mUa5I7cGCg
         sbqnGAW141RuaToAHM4PIZc8iCUrHU2TUho2VI85zY/ZTrCmUQmJpqJ3IVGv2qthYEPL
         CFiVLVwYtm4JCqFp7CeFTo87vMVocqzperkoukq+h1HfbEjAb0dMBwdoKOQYMAih/nDA
         ozkct8WfKPSxPyL3Ms5VKTyiM+jzftxMZosk1U8Ulwd3b2ritRxoq3zkQEWmaz31s0xL
         FQ9M7AseG4Vrk52aAmXzXXnXWOU3AvDKoEYEqoZVg/GlcpVkrkIegJ6RIYdUWfyCpmjq
         XhEw==
X-Gm-Message-State: AOAM532UjrW7a/jTtmrzh4W90knRNLRwvTPS4vqFkk5jXeuVSdmgnGy7
        O16YLX9ZuQ58etAnkrBCGl8uqshA1CsmvQ==
X-Google-Smtp-Source: ABdhPJyN9dgVCx9V6hpoAGlOEKZd02G0aEQq3/JD1bQG3TCDZMGY6NoLJH1MsqgRXxtfmBC9wI8MbQ==
X-Received: by 2002:a05:620a:462a:b0:6a6:effd:de6a with SMTP id br42-20020a05620a462a00b006a6effdde6amr1099543qkb.369.1655146408758;
        Mon, 13 Jun 2022 11:53:28 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id r13-20020a05620a298d00b006a6d60a39d0sm8075062qkp.5.2022.06.13.11.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:53:27 -0700 (PDT)
Date:   Mon, 13 Jun 2022 18:53:27 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <YqeHp0Zmm512x5nx@google.com>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512030442.2530552-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 12, 2022 at 03:04:28AM +0000, Joel Fernandes (Google) wrote:
> Hello!
> Please find the proof of concept version of call_rcu_lazy() attached. This
> gives a lot of savings when the CPUs are relatively idle. Huge thanks to
> Rushikesh Kadam from Intel for investigating it with me.

Just a status update, we're reworking this code to use the bypass lists which
takes care of a lot of corner cases. I've had to make changes the the rcuog
thread code to handle wakes up a bit differently and such. Initial testing is
looking good. Currently working on the early-flushing of the lazy CBs based
on memory pressure.

Should be hopefully sending v2 soon!

thanks,

 - Joel



> 
> Some numbers below:
> 
> Following are power savings we see on top of RCU_NOCB_CPU on an Intel platform.
> The observation is that due to a 'trickle down' effect of RCU callbacks, the
> system is very lightly loaded but constantly running few RCU callbacks very
> often. This confuses the power management hardware that the system is active,
> when it is in fact idle.
> 
> For example, when ChromeOS screen is off and user is not doing anything on the
> system, we can see big power savings.
> Before:
> Pk%pc10 = 72.13
> PkgWatt = 0.58
> CorWatt = 0.04
> 
> After:
> Pk%pc10 = 81.28
> PkgWatt = 0.41
> CorWatt = 0.03
> 
> Further, when ChromeOS screen is ON but system is idle or lightly loaded, we
> can see that the display pipeline is constantly doing RCU callback queuing due
> to open/close of file descriptors associated with graphics buffers. This is
> attributed to the file_free_rcu() path which this patch series also touches.
> 
> This patch series adds a simple but effective, and lockless implementation of
> RCU callback batching. On memory pressure, timeout or queue growing too big, we
> initiate a flush of one or more per-CPU lists.
> 
> Similar results can be achieved by increasing jiffies_till_first_fqs, however
> that also has the effect of slowing down RCU. Especially I saw huge slow down
> of function graph tracer when increasing that.
> 
> One drawback of this series is, if another frequent RCU callback creeps up in
> the future, that's not lazy, then that will again hurt the power. However, I
> believe identifying and fixing those is a more reasonable approach than slowing
> RCU down for the whole system.
> 
> NOTE: Add debug patch is added in the series toggle /proc/sys/kernel/rcu_lazy
> at runtime to turn it on or off globally. It is default to on. Further, please
> use the sysctls in lazy.c for further tuning of parameters that effect the
> flushing.
> 
> Disclaimer 1: Don't boot your personal system on it yet anticipating power
> savings, as TREE07 still causes RCU stalls and I am looking more into that, but
> I believe this series should be good for general testing.
> 
> Disclaimer 2: I have intentionally not CC'd other subsystem maintainers (like
> net, fs) to keep noise low and will CC them in the future after 1 or 2 rounds
> of review and agreements.
> 
> Joel Fernandes (Google) (14):
>   rcu: Add a lock-less lazy RCU implementation
>   workqueue: Add a lazy version of queue_rcu_work()
>   block/blk-ioc: Move call_rcu() to call_rcu_lazy()
>   cred: Move call_rcu() to call_rcu_lazy()
>   fs: Move call_rcu() to call_rcu_lazy() in some paths
>   kernel: Move various core kernel usages to call_rcu_lazy()
>   security: Move call_rcu() to call_rcu_lazy()
>   net/core: Move call_rcu() to call_rcu_lazy()
>   lib: Move call_rcu() to call_rcu_lazy()
>   kfree/rcu: Queue RCU work via queue_rcu_work_lazy()
>   i915: Move call_rcu() to call_rcu_lazy()
>   rcu/kfree: remove useless monitor_todo flag
>   rcu/kfree: Fix kfree_rcu_shrink_count() return value
>   DEBUG: Toggle rcu_lazy and tune at runtime
> 
>  block/blk-ioc.c                            |   2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_object.c |   2 +-
>  fs/dcache.c                                |   4 +-
>  fs/eventpoll.c                             |   2 +-
>  fs/file_table.c                            |   3 +-
>  fs/inode.c                                 |   2 +-
>  include/linux/rcupdate.h                   |   6 +
>  include/linux/sched/sysctl.h               |   4 +
>  include/linux/workqueue.h                  |   1 +
>  kernel/cred.c                              |   2 +-
>  kernel/exit.c                              |   2 +-
>  kernel/pid.c                               |   2 +-
>  kernel/rcu/Kconfig                         |   8 ++
>  kernel/rcu/Makefile                        |   1 +
>  kernel/rcu/lazy.c                          | 153 +++++++++++++++++++++
>  kernel/rcu/rcu.h                           |   5 +
>  kernel/rcu/tree.c                          |  28 ++--
>  kernel/sysctl.c                            |  23 ++++
>  kernel/time/posix-timers.c                 |   2 +-
>  kernel/workqueue.c                         |  25 ++++
>  lib/radix-tree.c                           |   2 +-
>  lib/xarray.c                               |   2 +-
>  net/core/dst.c                             |   2 +-
>  security/security.c                        |   2 +-
>  security/selinux/avc.c                     |   4 +-
>  25 files changed, 255 insertions(+), 34 deletions(-)
>  create mode 100644 kernel/rcu/lazy.c
> 
> -- 
> 2.36.0.550.gb090851708-goog
> 
