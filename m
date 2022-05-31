Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB51C433EF
	for <rcu@archiver.kernel.org>; Tue, 31 May 2022 21:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbiEaV3T (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 May 2022 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbiEaV3R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 May 2022 17:29:17 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34649D4D5
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 14:29:16 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b200so14120154qkc.7
        for <rcu@vger.kernel.org>; Tue, 31 May 2022 14:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PVlBDdtT/HOnBX/+cXHKdpbIw2a7ogBM6W0p4HPqp4=;
        b=CRg81V1y70cuX2GHAPETVpgbbS0MAUAAYdeBgnogegyXq5FISpdSzHIp51fbdbTbSa
         Mo6y46fxl3mnlL/6D+bBBagORhB5RaeLHqxGff4FKNkKDbJc7A784vvdH3TSaR83FmBi
         qNXfI1DMHX4MzLvR6VdkLdg97LTzGZ+1KlS2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1PVlBDdtT/HOnBX/+cXHKdpbIw2a7ogBM6W0p4HPqp4=;
        b=3ij/O7U+p1zKqjppTsktaww1v+4/uhf1hp1u6qyTOuccuUs84/pHEoBV8GqOjP4rIq
         WhjmNFzccK04GgWrUxEp7DSpCBW7BuhjzKr1BNwjLki30rQGBc6Tn3/U48xK1Tzliq61
         S/r00KGncY4jOKG5KuYMQ0gdjWR08oDhPnAvzIwHC2lZD3klPWSpE/EPjXyDukVqs/Qd
         zHtmm/ZS/W+Z9cuMENlqrM4aichg3X7IpHO8xVwlY25Zl2pFlH4+RXrvVm6BKHIDT6Tb
         tmocQJGlAfjxPCauvU/2epgMiQyfwjRp1Qz0IsCIEF+cPdvBfP/qGVCXtCqBHV9lROCa
         958Q==
X-Gm-Message-State: AOAM532F79qftRC6ke0XE922bBKgC9McMxNgnaE/1bWbhtwNAed19gUd
        PWpjXfHJwuZ3/yPnCk2JvUy8Fg==
X-Google-Smtp-Source: ABdhPJzXJf2LXCTb4g1cwAd6C8nG1Ucj347Hap0UKa5w1ZIYGhoiH1qH6GvMiEucqwJ6HpGCF5lCLw==
X-Received: by 2002:a37:4247:0:b0:6a6:48c1:6233 with SMTP id p68-20020a374247000000b006a648c16233mr5918315qka.498.1654032556120;
        Tue, 31 May 2022 14:29:16 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id m185-20020a37bcc2000000b0069c72b41b59sm64535qkf.2.2022.05.31.14.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 14:29:15 -0700 (PDT)
Date:   Tue, 31 May 2022 21:29:15 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 01/14] rcu: Add a lock-less lazy RCU implementation
Message-ID: <YpaIqxdiOH8eGZXC@google.com>
References: <YpFawyhgLCj1+X1A@google.com>
 <20220528175735.GV1790663@paulmck-ThinkPad-P17-Gen-1>
 <a945a7d1-fc4f-2ca5-8820-c08579f564e4@joelfernandes.org>
 <20220530164203.GB1790663@paulmck-ThinkPad-P17-Gen-1>
 <0da0d321-7007-2c19-7f85-11d6ef8fed1f@joelfernandes.org>
 <20220531042624.GF1790663@paulmck-ThinkPad-P17-Gen-1>
 <6def6fce-13e2-7b80-467f-56a33124d67f@joelfernandes.org>
 <20220531164534.GJ1790663@paulmck-ThinkPad-P17-Gen-1>
 <YpZjxKX5sNwl9wMK@google.com>
 <20220531192532.GK1790663@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531192532.GK1790663@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, May 31, 2022 at 12:25:32PM -0700, Paul E. McKenney wrote:
> On Tue, May 31, 2022 at 06:51:48PM +0000, Joel Fernandes wrote:
> > On Tue, May 31, 2022 at 09:45:34AM -0700, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
> > > Here is hoping!
> > > 
> > > After all, if you thought that taking care of applications that need
> > > expediting of grace periods is scary, well, now...
> > 
> > Haha... my fear is I don't know all the applications requiring expedited GP
> > and I keep getting surprised by new RCU usages that pop up in the system, or
> > new systems.
> > 
> > For one, a number of tools and processes, use ftrace directly in the system,
> > and it may not be practical to chase down every tool. Some of them start
> > tracing randomly in the system. Handling it in-kernel itself would be best if
> > possible.
> 
> Shouldn't it be possible to hook into the kernel code that runs when
> the sysfs tracing files are updated?  As in, why not both?  ;-)

Yes, Point taken on this, let us do both solutions.

thanks,

 - Joel

