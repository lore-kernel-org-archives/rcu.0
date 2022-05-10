Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B8CC433FE
	for <rcu@archiver.kernel.org>; Tue, 10 May 2022 13:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242725AbiEJNW2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 10 May 2022 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243390AbiEJNVu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 10 May 2022 09:21:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3047B4B436;
        Tue, 10 May 2022 06:16:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id bv19so32893249ejb.6;
        Tue, 10 May 2022 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IAUYLfqUIj6E6rVxVYSr8ar5yxzTVRlspTjstUVMSqg=;
        b=Kju8Nya5/XzIqQPFDQl+lLN/vdxQvO8nw82I6Cr/P2t0lP1LxewlPMEkZl50gU+NJx
         EVHiqlLW/afmurs5qFfVPvnIEbSamovPXxVy6QO8HS2lbg+PPVOgVESFRsRZK1cvlsem
         fLM1e3Se75/O5VRz4JCIjzojI3Ae2HKrotoKEWB9jd58QIh+jz7WPvneEyC1YHwq/u++
         pLTv93QgcMBO89LBbL6+xHNlmBiCylB6haSMfnPxOhOXPi/QikKvYe4sARppoGu7t2LD
         4gLlQhCX6KCgyQDYd0zTU0OUtZXPe71q9H2xiWbn7m2ypLQCgtQVyXxFUicUyHPIoIiA
         L35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IAUYLfqUIj6E6rVxVYSr8ar5yxzTVRlspTjstUVMSqg=;
        b=JyU+pRWJmJ+PYaJIw16c7frLyCDsUJCf72qwwqlHyVCBn2E+ieNzpKH3R2kDwXb5zQ
         WyF6j+XiHfjfvr2pjj9U6afGWzGm720mIhtOX4gtmJOvMugtxPvuWf0xH71mnq8uatVi
         bmdzD/dT0dcxYXRDL04WVDnDjziCM8a0hyzULI8QHdKR5dytbW7FGyfaQS/kyi8gR6Cj
         0E4DRVLpwA0UDj4P1jMX5ZLIpxrEfAzboHM/O1jctBxWBY0/pgHl+QEGiSwgFCDvcHGw
         23hgLfCtVdpHCv91PGX6Ty5OLcVizsRh7x6l8/ST/nwL4GLwSBje2Amxn0UyGh0zxYjA
         mpXg==
X-Gm-Message-State: AOAM532JSPqujPEwchNiCSE6OOP80UqeeXl2UWIvCUDcgUgv1y6D8WEK
        Ps+yq2KqxJvtVuwauVDHGxclZhMreBGPoya8Izw=
X-Google-Smtp-Source: ABdhPJz5LNJY8GWY1rPBqNXs5mgGPNUJ7IWDbR7vrbqymeXQ+f5NfjaRqg3kCUCDIP5W7agINa98ubQ7lfZODUF1mn0=
X-Received: by 2002:a17:906:c284:b0:6f4:dcc3:7939 with SMTP id
 r4-20020a170906c28400b006f4dcc37939mr18980434ejz.444.1652188554545; Tue, 10
 May 2022 06:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220503191709.155266-1-urezki@gmail.com> <YnpIpYgD7W4q+Nwj@kroah.com>
In-Reply-To: <YnpIpYgD7W4q+Nwj@kroah.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Tue, 10 May 2022 15:15:43 +0200
Message-ID: <CA+KHdyXGoWfyXvwqYAqhwks36RUJhBztVov10nA0qi8Lnc1FtA@mail.gmail.com>
Subject: Re: [PATCH 0/2] RCU offloading vs scheduler latency(for 5.15 stable)
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, RCU <rcu@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Thank you!

On Tue, May 10, 2022 at 1:12 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, May 03, 2022 at 09:17:07PM +0200, Uladzislau Rezki (Sony) wrote:
> > Motivation of backport:
> > -----------------------
> >
> > 1. The cfcdef5e30469 ("rcu: Allow rcu_do_batch() to dynamically adjust batch sizes")
> > broke the default behaviour of "offloading rcu callbacks" setup. In that scenario
> > after each callback the caller context was used to check if it has to be rescheduled
> > giving a CPU time for others. After that change an "offloaded" setup can switch to
> > time-based RCU callbacks processing, what can be long for latency sensitive workloads
> > and SCHED_FIFO processes, i.e. callbacks are invoked for a long time with keeping
> > preemption off and without checking cond_resched().
> >
> > 2. Our devices which run Android and 5.10 kernel have some critical areas which
> > are sensitive to latency. It is a low latency audio, 8k video, UI stack and so on.
> > For example below is a trace that illustrates a delay of "irq/396-5-0072" RT task
> > to complete IRQ processing:
> >
> > <snip>
> >   rcuop/6-54  [000] d.h2  183.752989: irq_handler_entry:    irq=85 name=i2c_geni
> >   rcuop/6-54  [000] d.h5  183.753007: sched_waking:         comm=irq/396-5-0072 pid=12675 prio=49 target_cpu=000
> >   rcuop/6-54  [000] dNh6  183.753014: sched_wakeup:         irq/396-5-0072:12675 [49] success=1 CPU:000
> >   rcuop/6-54  [000] dNh2  183.753015: irq_handler_exit:     irq=85 ret=handled
> >   rcuop/6-54  [000] .N..  183.753018: rcu_invoke_callback:  rcu_preempt rhp=0xffffff88ffd440b0 func=__d_free.cfi_jt
> >   rcuop/6-54  [000] .N..  183.753020: rcu_invoke_callback:  rcu_preempt rhp=0xffffff892ffd8400 func=inode_free_by_rcu.cfi_jt
> >   rcuop/6-54  [000] .N..  183.753021: rcu_invoke_callback:  rcu_preempt rhp=0xffffff89327cd708 func=i_callback.cfi_jt
> >   ...
> >   rcuop/6-54  [000] .N..  183.755941: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c5a968 func=i_callback.cfi_jt
> >   rcuop/6-54  [000] .N..  183.755942: rcu_invoke_callback:  rcu_preempt rhp=0xffffff8993c4bd20 func=__d_free.cfi_jt
> >   rcuop/6-54  [000] dN..  183.755944: rcu_batch_end:        rcu_preempt CBs-invoked=2112 idle=>c<>c<>c<>c<
> >   rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      Start context switch
> >   rcuop/6-54  [000] dN..  183.755946: rcu_utilization:      End context switch
> >   rcuop/6-54  [000] d..2  183.755959: sched_switch:         rcuop/6:54 [120] R ==> migration/0:16 [0]
> >   ...
> >   migratio-16 [000] d..2  183.756021: sched_switch:         migration/0:16 [0] S ==> irq/396-5-0072:12675 [49]
> > <snip>
> >
> > The "irq/396-5-0072:12675" was delayed for ~3 milliseconds due to introduced side effect.
> > Please note, on our Android devices we get ~70 000 callbacks registered to be invoked by
> > the "rcuop/x" workers. This is during 1 seconds time interval and regular handset usage.
> > Latencies bigger that 3 milliseconds affect our high-resolution audio streaming over the
> > LDAC/Bluetooth stack.
> >
> > Two patches depend on each other.
>
> All now queued up, thanks.
>
> greg k-h



-- 
Uladzislau Rezki
