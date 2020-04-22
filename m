Return-Path: <SRS0=2A48=6G=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A20C54FCB
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 14:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 039562082E
	for <rcu@archiver.kernel.org>; Wed, 22 Apr 2020 14:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="jePerAlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgDVO54 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgDVO5z (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 22 Apr 2020 10:57:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28480C03C1A9
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2020 07:57:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n143so2637302qkn.8
        for <rcu@vger.kernel.org>; Wed, 22 Apr 2020 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wcWMGAzYdEolg+eQOhfKp338bz4b86bEIDlwkh2nWxw=;
        b=jePerAlffyhaU7okrSYiISJtyH5dLzKoEq6SHKiWQBs7/onB/j6n93D8qOYZMPomDB
         LbdD2yUzCSjJJ0JfFjpdm/kVorGjmcDJk4dIFdw9w7gTSBCh1P3+hrzIwlP61m3SJkSO
         u6XtbDXYy8vGMXICzJo5S3a9PoAQ6RRyAcShBnACLqaAC/PZA3/gst4/opSG1157MhaL
         ByByaGm2dtpuI+HUpNAGhxneomjb9VWkFfSqHeZeW+mCeiwXVFEg5PS1yWj4iiKZXJQE
         2oHfJhj5qmtdJWKvUqoxn1/u683UWhjP1fQPOhRsX/7h2eVWmTqnNtSrDDkMgx1xdt2b
         Geaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcWMGAzYdEolg+eQOhfKp338bz4b86bEIDlwkh2nWxw=;
        b=Kms7yIhooxKPu7dnzw/nAPWJ+spbBOeGB1NlN0hrJoRxsUNPArGF1elbnVPmtbla9M
         pzBzzZ40chGBDY8qTKlN04NUhU3ci69eBHvADQaHgRWyFR60O2IXxIh+NHFKD4hv3uZ6
         eR+bISa0s04hcILqW4t8nYE6fS3Uz1FdYHX+yq7teomzE8Sr3uGv0Kgus9/NaU6hCuwV
         A3VdmrUjJlH09Ns7TSd9j2+RWck6x5a1+ZskF2JXfW6dudWmy9M7hVvixxU/dxFgJpUK
         XC6QMEyfPMMRnT5uSM4jvPtCFSFw2JCGjmhyd6oPJs+nm2KZ4pgSa37py7MDQQnCiwNd
         t3pw==
X-Gm-Message-State: AGi0PubYubcmjVurpE7kYB8kS8Eb3fn+6J1XkjYBcoYWXKFdTiLmyDUx
        f9HkISGxtmkOSt4cIP1y8+TbRg==
X-Google-Smtp-Source: APiQypLD81kqR7XuJ/VHtpjvQIsldoh+ZyvejSuPC9mqWsAQ4WarseX6ZmWa+WRFmOvt8lQ/d43V/w==
X-Received: by 2002:a05:620a:5bc:: with SMTP id q28mr25502315qkq.468.1587567474305;
        Wed, 22 Apr 2020 07:57:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id x43sm4186238qtj.65.2020.04.22.07.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 07:57:53 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:57:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Refactor object allocation and try harder
 for array allocation
Message-ID: <20200422145752.GB362484@cmpxchg.org>
References: <20200413211504.108086-1-joel@joelfernandes.org>
 <20200414194353.GQ17661@paulmck-ThinkPad-P72>
 <20200416103007.GA3925@pc636>
 <20200416131745.GA90777@google.com>
 <20200416180100.GT17661@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416180100.GT17661@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 16, 2020 at 11:01:00AM -0700, Paul E. McKenney wrote:
> On Thu, Apr 16, 2020 at 09:17:45AM -0400, Joel Fernandes wrote:
> > On Thu, Apr 16, 2020 at 12:30:07PM +0200, Uladzislau Rezki wrote:
> > > I have a question about dynamic attaching of the rcu_head. Do you think
> > > that we should drop it? We have it because of it requires 8 + syzeof(struct rcu_head)
> > > bytes and is used when we can not allocate 1 page what is much more for array purpose.
> > > Therefore, dynamic attaching can succeed because of using SLAB and requesting much
> > > less memory then one page. There will be higher chance of bypassing synchronize_rcu()
> > > and inlining freeing on a stack.
> > > 
> > > I agree that we should not use GFP_* flags instead we could go with GFP_NOWAIT |
> > > __GFP_NOWARN when head attaching only. Also dropping GFP_ATOMIC to keep
> > > atomic reserved memory for others.
> 
> I must defer to people who understand the GFP flags better than I do.
> The suggestion of __GFP_RETRY_MAYFAIL for no memory pressure (or maybe
> when the CPU's reserve is not yet full) and __GFP_NORETRY otherwise came
> from one of these people.  ;-)

The exact flags we want here depends somewhat on the rate and size of
kfree_rcu() bursts we can expect. We may want to start with one set
and instrument allocation success rates.

Memory tends to be fully consumed by the filesystem cache, so some
form of light reclaim is necessary for almost all allocations.

GFP_NOWAIT won't do any reclaim by itself, but it'll wake kswapd.
Kswapd maintains a small pool of free pages so that even allocations
that are allowed to enter reclaim usually don't have to. It would be
safe for RCU to dip into that.

However, there are some cons to using it:

- Depending on kfree_rcu() burst size, this pool could exhaust (it's
usually about half a percent of memory, but is affected by sysctls),
and then it would fail NOWAIT allocations until kswapd has caught up.

- This pool is shared by all GFP_NOWAIT users, and many (most? all?)
of them cannot actually sleep. Often they would have to drop locks,
restart list iterations, or suffer some other form of deterioration to
work around failing allocations.

Since rcu wouldn't have anything better to do than sleep at this
juncture, it may as well join the reclaim effort.

Using __GFP_NORETRY or __GFP_RETRY_MAYFAIL would allow them that
without exerting too much pressure on the VM.
