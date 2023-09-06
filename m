Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE081EE14C3
	for <rcu@archiver.kernel.org>; Wed,  6 Sep 2023 23:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjIFXKt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Sep 2023 19:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236302AbjIFXKs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Sep 2023 19:10:48 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD4A1BC2
        for <rcu@vger.kernel.org>; Wed,  6 Sep 2023 16:10:44 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7951f0e02ecso12964339f.0
        for <rcu@vger.kernel.org>; Wed, 06 Sep 2023 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694041844; x=1694646644; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYm4i3hdu7juwyOUQk1xpuXZZsw548ZwUyNloE+R6Ac=;
        b=sHDOpxyehBi+oWQwketOrssuoxipUKNrxFN5KHgDhsruFipux6tzZXc5ILluEyErb3
         82HocP8d7zKcJdATsXo01ER5jLwjeW5YxGiiOtY9v6juNGexCfiqCslxX5XnS3uMyGkO
         /BFT5H8WrzNjwWnNdt8gZL45nwp51HTZ6ZTHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694041844; x=1694646644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYm4i3hdu7juwyOUQk1xpuXZZsw548ZwUyNloE+R6Ac=;
        b=XU7l/myWWRAF+2qjs8IeiuUnoea6sxU4HXzS2v1eZ0tlcYmj6zkgQW/fHX9uM1BVIO
         qtJU0LGK201lSRUb3tevUAQr8oUcCwRKHJTM6AxL+k7EgAYoAfqwjfyZQ1rEl+HmTkWA
         3fWYtT553+71iuqzNGBZD7VyD8h1uJ/TkB/lddt2iDmssR/be9K/WWkOlOrjEr3PDCcV
         1UwX464bjGcm17s5LKp6VOyT3eGbLtELVN0bD6T/PFUYibfd75fDxnNWWa6oEX+wnm/Z
         CmxEg0567agTb/jwG4hHFIffMnDJl2zuFnj3nCGrWuIG9pyj5npooR9MCQJoO10Z2Fgl
         4U7Q==
X-Gm-Message-State: AOJu0YxRyRwCToVSIlFNvvRjErfk4DwhMRYeTThBhCc0Cp+Za65nM/S9
        cxYO5ckk4enL3UIj7oGzI7II6BLtb1HjaZSOQcI=
X-Google-Smtp-Source: AGHT+IHNaizib5VvwK0oLEc0my890WJH2cjyEtGdhjY466dsxuMemrbybowAPHrFM9H94DX9Sflh3g==
X-Received: by 2002:a05:6e02:1bcf:b0:349:9745:89f with SMTP id x15-20020a056e021bcf00b003499745089fmr20615111ilv.17.1694041844112;
        Wed, 06 Sep 2023 16:10:44 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id o2-20020a056638124200b0042b669f5084sm5326529jas.62.2023.09.06.16.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 16:10:43 -0700 (PDT)
Date:   Wed, 6 Sep 2023 23:10:42 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Paasch <cpaasch@apple.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        MPTCP Upstream <mptcp@lists.linux.dev>, rcu@vger.kernel.org,
        urezki@gmail.com
Subject: Re: kmemleak handling of kfree_rcu
Message-ID: <20230906231042.GA1296802@google.com>
References: <F903A825-F05F-4B77-A2B5-7356282FBA2C@apple.com>
 <ZPZKsJUPVeHCsLQB@arm.com>
 <20230905111725.GA3737639@google.com>
 <ZPc+HGjmY2ZC4WO3@arm.com>
 <20230906143529.GB1127143@google.com>
 <ZPizxVT5s9JA5MPw@arm.com>
 <24f3d4fc-56c0-46bd-8e5b-af57f09fa777@paulmck-laptop>
 <ZPjxJJjuHJbPVyfT@arm.com>
 <38f21251-4911-4300-9b53-e390e621e68a@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38f21251-4911-4300-9b53-e390e621e68a@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Sep 06, 2023 at 03:02:45PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 06, 2023 at 10:37:40PM +0100, Catalin Marinas wrote:
> > On Wed, Sep 06, 2023 at 12:11:12PM -0700, Paul E. McKenney wrote:
> > > On Wed, Sep 06, 2023 at 06:15:49PM +0100, Catalin Marinas wrote:
> > > > On Wed, Sep 06, 2023 at 02:35:29PM +0000, Joel Fernandes wrote:
> > > > > On Tue, Sep 05, 2023 at 03:41:32PM +0100, Catalin Marinas wrote:
> > > > > > On Tue, Sep 05, 2023 at 11:17:25AM +0000, Joel Fernandes wrote:
> > > > > > > The correct fix then should probably be to mark the object as
> > > > > > > kmemleak_not_leak() until a grace period elapses. This will cause the object
> > > > > > > to not be reported but still be scanned until eventually the lower layers
> > > > > > > will remove the object from kmemleak-tracking after the grace period. Per the
> > > > > > > docs also, that API is used to prevent false-positives.
> > > > > > 
> > > > > > This should work as well but I'd use kmemleak_ignore() instead of
> > > > > > kmemleak_not_leak(). The former, apart from masking the false positive,
> > > > > > also tells kmemleak not to scan the object. After a kvfree_rcu(), the
> > > > > > object shouldn't have any valid references to other objects, so not
> > > > > > worth scanning.
> > > > > 
> > > > > Yes I am also OK with that, however to me I consider the object as alive as
> > > > > long as the grace period does not end. But I agree with you and it may not be
> > > > > worth tracking them or scanning them.
> > > > 
> > > > I guess from an RCU perspective, the object is still alive. From the
> > > > kvfree_rcu() caller perspective though, it can disappear at any point
> > > > after the grace period, so it shouldn't rely on its content being valid
> > > > and referencing other objects (other than transiently e.g. in RCU list
> > > > traversal).
> > > > 
> > > > It probably only matters if we have some very long grace periods (I'm
> > > > not up to date with the recent RCU developments). In such cases, the
> > > > object still being scanned could introduce false negatives. That's my
> > > > reasoning for suggesting kmemleak_ignore() rather than
> > > > kmemleak_not_leak().
> > > 
> > > Very long RCU readers still result in very long RCU grace periods.  And,
> > > after some tens of seconds, RCU CPU stall warnings.  So don't let your
> > > RCU readers run for that long.  But you knew that already.  ;-)
> > 
> > That's still ok. I was more thinking of deferred freeing well past the
> > RCU readers completing.
> 
> Ah, that can happen.  Some kernels are built with CONFIG_RCU_LAZY=y, which
> delays freeing in order to reduce power consumption.  And kfree_rcu()
> will also delay for a bit.  But in both cases, a flood of callbacks
> should get things going again.
> 
> But an isolated kfree_rcu() might well see a few seconds delay.
> Saving your battery!  ;-)

I agree with both of you. I also think kmemleak_ignore() is the right thing
to do for kfree_rcu().

thanks,

 - Joel

