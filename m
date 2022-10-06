Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866BCC433F5
	for <rcu@archiver.kernel.org>; Thu,  6 Oct 2022 13:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiJFNdU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiJFNdJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 6 Oct 2022 09:33:09 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE6ABF09
        for <rcu@vger.kernel.org>; Thu,  6 Oct 2022 06:32:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id df9so1147404qvb.9
        for <rcu@vger.kernel.org>; Thu, 06 Oct 2022 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=huK45Nt60Oqwkfe5esCRl504StHwOSfI8fOM8xQEOqw=;
        b=BZW446SAc56TqZDeBdwgv69TRmEZQlyOkd0d+ZmTUQlOdI/aH3/lPpcJ2S5kqzSbjP
         mzOWQ/kyPGFwsYhkfMt0aY2+67Kcb6L4ISCVU3CdMFBWHeTof9yIuDtoalWelOujlaz+
         IepyN8EyJ09vuCpi/yg3/AdwBkeglPZ0zRuCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=huK45Nt60Oqwkfe5esCRl504StHwOSfI8fOM8xQEOqw=;
        b=2SnItO2p4m/Rj3yucaCbVHbYWKSh01mT78oJND4QGNQHD/Zi2il4UgWOGrHT4K4Zw9
         K8unuUmNXUtP1+7OYxwFoMXidLROeWmRi2tJK3Xlb+CvFMP823aL/uK+787d2cMNu9yO
         2n8hWZt9Sk7rYZivnah3oog6BH75ZCuChWJU3gi1uuSAso4yOQLy/LdNKE6MjwozfzvV
         Yl9I37M9TEAT4wxP0DKhhiwUpkMkIYky+xg2U88y+IJ1/4+Nq6xQbRtmAmdsBZebNapV
         z2xZJIGTqRmTZFK6gWIY4SR8fZbaT63r14McWLHX8CuD8NiKaGUb3Z0ZJb7mK6nw86P6
         NWhA==
X-Gm-Message-State: ACrzQf3JuclVKNjEIiJ7SlqnNhj6610+6sZE78D1vn/Dn44FBs2E/50X
        wjdyHg8TXKummMIEZZcljyORylNFM0aGDw==
X-Google-Smtp-Source: AMsMyM741myRLb3JM16m2F1xiRYR7uHBDn2+tcq4iJGdEsNoM++xH/v+D1TlgPAp/KMgwZWr5hjQOg==
X-Received: by 2002:a05:6214:2301:b0:498:9f6f:28d with SMTP id gc1-20020a056214230100b004989f6f028dmr3826245qvb.5.1665063104435;
        Thu, 06 Oct 2022 06:31:44 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id c9-20020ac85189000000b0038f24b23a36sm4209925qtn.37.2022.10.06.06.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:31:43 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:31:43 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        rcu@vger.kernel.org, paulmck@kernel.org, frederic@kernel.org
Cc:     Florent Carli <fcarli@gmail.com>, linux-rt-users@vger.kernel.org
Subject: Re: RCU stall warnings even with rcu_nocbs and rcu_nocb_poll
Message-ID: <Yz7Yv6d3v3oETZYI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86930e4-4b9c-cf18-5119-50c6910b76dd@redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Oct 05, 2022 at 06:03:39PM +0200, Daniel Bristot de Oliveira wrote:
> On 10/5/22 18:01, Florent Carli wrote:
> > Hello,
> > 
> > I'm trying to isolate some cores to run a CPU-bound real-time task and
> > even though I'm using rcu_nocbs and rcu_nocb_poll, I can see the rcuc
> > threads wake up, and I get RCU stall warnings on the isolated core.

Isolating a CPU does not mean that RCU activity is forbidden on it, even with
nohz_full, if the CPU enters the kernel (say syscall or interrupt), then it
may enter a read-side critical section so RCU will be watching it, and such
CPU will have to report quiescent state.

> > As per the documentation, if I use rcutree.kthread_prio with a
> > priority > my RT task, then the rcu stall does not happen.

Yes, it sounds like the main RCU GP thread (mostly called rcu_preempt thread)
in your system is competing with your RT task. Increase kthread_prio is
standard procedure to resolve this issue, as you did.

> > However I find it confusing: why are the rcuc threads woken up on the
> > isolated cores despite using rcu_nocbs and rcu_nocb_poll? In my (very
> > likely erroneous) understanding, I shouldn't have to fiddle with rcu
> > priority... In other words, how come I get rcu stalls on cores that
> > have no rcu callbacks?

It is not possible to provide further help without more info, in particular
are you using nohz_full and isolcpus options? Can you provide kernel
and #CPU configuration?

Happy to look further! Also adding some more folks who know a lot about this
stuff and +rcu list for archives.

thanks,

 - Joel

> 
> Adding Joel because we had a chat about it during lpc...
> 
> > Thanks.
> > 
> -- Daniel
> 
