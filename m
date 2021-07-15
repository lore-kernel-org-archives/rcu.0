Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB23C07E96
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 09:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D82660BD3
	for <rcu@archiver.kernel.org>; Thu, 15 Jul 2021 09:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhGOJMo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 15 Jul 2021 05:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhGOJMo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 15 Jul 2021 05:12:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6828FC06175F
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 02:09:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w15so5377735pgk.13
        for <rcu@vger.kernel.org>; Thu, 15 Jul 2021 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KUb2QkrkQ8ko4G078uye8RdkQ5z0d+6I4mThvq6tm5M=;
        b=LsTt8+jKu7B2i3FTudYEE6Cx0zDvQrhi/SyMFOLRQ0RA8dvTjPxYA4KfIQGrVmwQiD
         XkFdISvOWcgEJyCbg4z/KPXoUG6xgRwwZBPCt6raWN9FRWTbWUsGnk5s289nys7fn4sX
         B0+Oy0Xuz4roi2d5VWeGko2eDqXACou67289I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KUb2QkrkQ8ko4G078uye8RdkQ5z0d+6I4mThvq6tm5M=;
        b=CCvQV3c7P8lVgv7z2masPukYgzviYM94QoG7msRpcwjt5BARfJdW1+MCDJaZB1UQPJ
         dzWhLT+EozVuW7jZpIqztRXUD+IOOL3aFyhVbqj+Vq5XL2P0aYOSqyw71OTOkCoufDP9
         hCxkeBiX/Kk1+/jpywd7KZDTK7RmbHAxJCexGgIkH9LiW0+c4nntls7aWi06x8yK8NiU
         vRYOmMDC20TNKQB/n7t5t5rTa7Jfbf6yFbZc0qhtO42H2p3SyilESt+7qZsnIIwJblez
         hD3wdHD54CSHYi8AEKCTDGBWsBqKchzhhIAjqataCxG08HyFxDxjxBhWSPDwZjrITZc+
         zZFQ==
X-Gm-Message-State: AOAM532KJhifs3o+Nt+fE79bxwSoZoQOF/yc7Bxww2rwprNGbh9V47lv
        AyAnfB+unF0mDcfqX8yMoIQfeg==
X-Google-Smtp-Source: ABdhPJwlXpAIZhgHr+sKRH9JqJhO8b5bbttsmXnjTJUyUqXp5WVPhcSpjW5bawKM30k3u+REa/x7wA==
X-Received: by 2002:a65:67d6:: with SMTP id b22mr3565984pgs.271.1626340190981;
        Thu, 15 Jul 2021 02:09:50 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:cf9:3b54:4709:3747])
        by smtp.gmail.com with ESMTPSA id o10sm5837260pfu.131.2021.07.15.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 02:09:50 -0700 (PDT)
Date:   Thu, 15 Jul 2021 18:09:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] rcu/tree: handle VM stoppage in stall detection
Message-ID: <YO/7WS/WefdkFFbj@google.com>
References: <20210521155624.174524-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521155624.174524-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On (21/05/22 00:56), Sergey Senozhatsky wrote:
> Soft watchdog timer function checks if a virtual machine
> was suspended and hence what looks like a lockup in fact
> is a false positive.
> 
> This is what kvm_check_and_clear_guest_paused() does: it
> tests guest PVCLOCK_GUEST_STOPPED (which is set by the host)
> and if it's set then we need to touch all watchdogs and bail
> out.
> 
> Watchdog timer function runs from IRQ, so PVCLOCK_GUEST_STOPPED
> check works fine.
> 
> There is, however, one more watchdog that runs from IRQ, so
> watchdog timer fn races with it, and that watchdog is not aware
> of PVCLOCK_GUEST_STOPPED - RCU stall detector.
> 
> apic_timer_interrupt()
>  smp_apic_timer_interrupt()
>   hrtimer_interrupt()
>    __hrtimer_run_queues()
>     tick_sched_timer()
>      tick_sched_handle()
>       update_process_times()
>        rcu_sched_clock_irq()
> 
> This triggers RCU stalls on our devices during VM resume.
> 
> If tick_sched_handle()->rcu_sched_clock_irq() runs on a VCPU
> before watchdog_timer_fn()->kvm_check_and_clear_guest_paused()
> then there is nothing on this VCPU that touches watchdogs and
> RCU reads stale gp stall timestamp and new jiffies value, which
> makes it think that RCU has stalled.
> 
> Make RCU stall watchdog aware of PVCLOCK_GUEST_STOPPED and
> don't report RCU stalls when we resume the VM.

Hello Paul,

I've noticed that this patch set didn't make it to Linus's tree.
Was it intentional?
