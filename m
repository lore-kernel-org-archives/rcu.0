Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462FEC38A2A
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 17:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C512075E
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 17:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="AG5WDF/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEGRAY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 May 2020 13:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGRAY (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 7 May 2020 13:00:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D18C05BD0A
        for <rcu@vger.kernel.org>; Thu,  7 May 2020 10:00:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id p12so1011163qtn.13
        for <rcu@vger.kernel.org>; Thu, 07 May 2020 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zrl4Q5RwimOaOPzJ4SvHWrYvKD/IGDnpYrEl4Dr0Twg=;
        b=AG5WDF/CkoslEjDZdSnwRk5sEa28EkvkUYjjtyS8kME1e7eqJzm6NLMS+vuGLDU4zK
         tN76V8FpTQbDTXdWqjWKBymdDZ5VcKbbzrQcHbEJUmrVCWz6vjVg3T5iCV7P9aRTddXe
         lblNzqxepfUMxXN2Z7BTzvgcd6sMFvFLRRMjmC1RW/CVijzI+BeIpgrzKr6mIpNHX+BC
         H32PGtDDeG1AGNL+H52cyl0/53UHRQtbpIjur0GcBp2n+vjBm41bJlHnVeuzq81IxO8p
         gx+vbUP9uqMMjviTOyQFFuIT0fZSyTqdkn5bDc1dlRR6h8Yiin4SpgnzjNjYBAAzhVtK
         3Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zrl4Q5RwimOaOPzJ4SvHWrYvKD/IGDnpYrEl4Dr0Twg=;
        b=BJzvC6vcWXVVAZPdFru0wT51STmZEGyUw4LGPLf+IGpXfVQmDa7b8F63koQez7qvSj
         CWB/GZLEVzJr+yD085iPjRlxre5/TzWOSopZYpnQyxXZe2gnJocKU4aljj2vfxGCjH/c
         +RbpGuYjijYwhDb8xcSvPE0YB33UAnMCO4cf/Qad3kr015d7sjFSV5Xfzs0ofs7ViGSc
         itJKIua8WdPe2pOFGVstpfcSJrKrW9vf9asLMDDRC89/CZTbPrQKnVCBRHOOOJ7r6TYg
         ijqh/WVSeJKdKlqe35ChKvUEb2DehJb9u8nZp8O6l9wRYFWik8+GJ75va3teXb2mNmlD
         /w2g==
X-Gm-Message-State: AGi0PubLQO8g7NYiJ7ePR9dX25sFl2qZDOY7HagFH5tOocHmFiK1bmOf
        a6GXKIqb2kr+41HkmgjZLyoPWA==
X-Google-Smtp-Source: APiQypJix8z3BJDzc3/nMXJNVLJU+fpdTdhM5AUcNziovXv/1ZEfZhczdAgwriND7njS3zR/txvJkQ==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr15785986qtp.338.1588870821922;
        Thu, 07 May 2020 10:00:21 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s15sm4843057qtc.31.2020.05.07.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:00:21 -0700 (PDT)
Date:   Thu, 7 May 2020 13:00:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200507170006.GA155220@cmpxchg.org>
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, May 06, 2020 at 05:55:35PM -0700, Andrew Morton wrote:
> On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This commit adds a shrinker so as to inform RCU when memory is scarce.
> > RCU responds by shifting into the same fast and inefficient mode that is
> > used in the presence of excessive numbers of RCU callbacks.  RCU remains
> > in this state for one-tenth of a second, though this time window can be
> > extended by another call to the shrinker.

We may be able to use shrinkers here, but merely being invoked does
not carry a reliable distress signal.

Shrinkers get invoked whenever vmscan runs. It's a useful indicator
for when to age an auxiliary LRU list - test references, clear and
rotate or reclaim stale entries. The urgency, and what can and cannot
be considered "stale", is encoded in the callback frequency and scan
counts, and meant to be relative to the VM's own rate of aging: "I've
tested X percent of mine for recent use, now you go and test the same
share of your pool." It doesn't translate well to other
interpretations of the callbacks, although people have tried.

> > If it proves feasible, a later commit might add a function call directly
> > indicating the end of the period of scarce memory.
> 
> (Cc David Chinner, who often has opinions on shrinkers ;))
> 
> It's a bit abusive of the intent of the slab shrinkers, but I don't
> immediately see a problem with it.  Always returning 0 from
> ->scan_objects might cause a problem in some situations(?).
> 
> Perhaps we should have a formal "system getting low on memory, please
> do something" notification API.

It's tricky to find a useful definition of what low on memory
means. In the past we've used sc->priority cutoffs, the vmpressure
interface (reclaimed/scanned - reclaim efficiency cutoffs), oom
notifiers (another reclaim efficiency cutoff). But none of these
reliably capture "distress", and they vary highly between different
hardware setups. It can be hard to trigger OOM itself on fast IO
devices, even when the machine is way past useful (where useful is
somewhat subjective to the user). Userspace OOM implementations that
consider userspace health (also subjective) are getting more common.

> How significant is this?  How much memory can RCU consume?

I think if rcu can end up consuming a significant share of memory, one
way that may work would be to do proper shrinker integration and track
the age of its objects relative to the age of other allocations in the
system. I.e. toss them all on a clock list with "new" bits and shrink
them at VM velocity. If the shrinker sees objects with new bit set,
clear and rotate. If it sees objects without them, we know rcu_heads
outlive cache pages etc. and should probably cycle faster too.
