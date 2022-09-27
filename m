Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CADAC54EE9
	for <rcu@archiver.kernel.org>; Tue, 27 Sep 2022 15:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiI0POV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiI0POU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Sep 2022 11:14:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25841251A0
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 08:14:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id c15so1072226qvp.7
        for <rcu@vger.kernel.org>; Tue, 27 Sep 2022 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jbmPaXjwsVDY1AN/HRtWM1ofxdcO2XSj8Vv58jSa1+U=;
        b=HeQBREf2pKuUYgS4eZIcHY8BNuj31cGuPueOiQUEHmUMRmz1K/eQOieKIDnMrFM6Gv
         zb9bF1NNPsnO7jhA9+Jb1/BmSK3lGWsV2jhv7js/c8fcOJZ9xIPgBs/eQjgaGuF/w6T0
         mwlV4fA6Q3CL6nd5UClqCcS2AwIPtrQT0Cad8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jbmPaXjwsVDY1AN/HRtWM1ofxdcO2XSj8Vv58jSa1+U=;
        b=18DfBMtu24DJMDh/lYWtIlG/oKb8X8PDA6MtzyVdhOvrRgPkFQAL1/Zo/wd9Uy1XpK
         h2dFQrGXYkAUTMWVTHBZ+EFjBKsRxAOf91oPhwD0ij/ZG3Nd0x3/BG0FGIu/yFbajehA
         FnJIydxDtCgPxqfSC4ZQ2QoBABeL9eu+4c6Ba/9OMLRmkOQUssbtwA2GShLNaO0aulsA
         Z/VhnoGC4s+sHe2SaI8sS7HZSroAMlPj5El3AfgNMmF0BPCXeHZ35C4JfgHS6cMF2hKq
         DyQGKfEqgPJtnTfJSEs+I8YfiPMTYWbKNlFcby6FDQRZ+ZYoM4gac3n+0AeNHkwYU/lX
         jgJA==
X-Gm-Message-State: ACrzQf2t43lgJR8MF3qKIX1b1ffZTIAFsZ9lMILCpLqwSmguI6flp8WQ
        S6/geth+0KDZaDlBJFtmBJuzYg==
X-Google-Smtp-Source: AMsMyM5qFpL6YVYNNOcjFaiePEUxR+p5LZkevzl6LVx2pIMIsxWABx/5VMEnMVA7XW7hljToBvef6g==
X-Received: by 2002:a05:6214:2629:b0:4ad:88cb:66ac with SMTP id gv9-20020a056214262900b004ad88cb66acmr17341441qvb.87.1664291655354;
        Tue, 27 Sep 2022 08:14:15 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id dt39-20020a05620a47a700b006bbd2c4cccfsm1159084qkb.53.2022.09.27.08.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:14:15 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:14:14 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, paulmck@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v6 1/4] rcu: Make call_rcu() lazy to save power
Message-ID: <YzMTRrMKCnEMl/ov@google.com>
References: <20220922220104.2446868-1-joel@joelfernandes.org>
 <20220922220104.2446868-2-joel@joelfernandes.org>
 <YzAX5kOwjrZzoed6@pc636>
 <YzCUDXn3htWbqM4f@google.com>
 <YzH/646RHxhHBy6+@pc636>
 <YzIRg2u2JYXN9bnK@google.com>
 <YzMD0pdR6rvGSZ/o@pc636>
 <YzMI68pbXXVWWKEN@google.com>
 <YzMP4LaIUY8Dh9Nw@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzMP4LaIUY8Dh9Nw@pc636>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 27, 2022 at 04:59:44PM +0200, Uladzislau Rezki wrote:
[...]
> > >    systemd-udevd-642     [050] .....    17.349832: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.349834: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-675     [012] .....    17.349835: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-675     [012] .....    17.349853: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-642     [050] .....    17.349861: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > >    systemd-udevd-675     [012] .....    17.349873: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.349879: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350007: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350011: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350080: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350175: __call_rcu_common: -> ____fput+0x0/0x10: task_work_run+0x5c/0x90 <- 0x0
> > >    systemd-udevd-665     [061] .....    17.350362: dev_change_name: --> renamed from eth0
> > > <snip>
> > > 
> > > First delay:
> > > 
> > > <snip>
> > > systemd-udevd-645     [053] .....     2.339024: __call_rcu_common: -> 0x0: __dentry_kill+0x140/0x180 <- 0x2
> > >   kworker/0:3-546     [000] d..1.     6.329516: __call_rcu_common: -> 0x0: queue_rcu_work+0x2b/0x40 <- 0xffff8c70effe40a0
> > > <snip>
> > > 
> > > __dentry_kill() function and after 4 seconds there is another one queue_rcu_work().
> > > I have checked the __dentry_kill() if it can do any sync talk with RCU but from the
> > > first glance i do not see anything critical. But more attention is required.
> > 
> > Can you log rcu_barrier() as well? It could be that the print is just a side
> > effect of something else that is not being printed.
> > 
> It has nothing to do with rcu_barrier() in my case. Also i have checked
> the synchronize_rcu() it also works as expected, i.e. it is not a
> blocking reason.
> 
> Have you tried my config?

Yes I am in the process of trying it.

thanks,

 - Joel

