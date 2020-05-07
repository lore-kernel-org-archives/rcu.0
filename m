Return-Path: <SRS0=FT7R=6V=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72775C38A2A
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5022145D
	for <rcu@archiver.kernel.org>; Thu,  7 May 2020 18:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="n76FtUi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGSbU (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 May 2020 14:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSbT (ORCPT
        <rfc822;rcu@vger.kernel.org>); Thu, 7 May 2020 14:31:19 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99510C05BD43
        for <rcu@vger.kernel.org>; Thu,  7 May 2020 11:31:19 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h6so3165863qvz.8
        for <rcu@vger.kernel.org>; Thu, 07 May 2020 11:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=965iQaC7U25MngSE/RPpVl7EpdT+hGY6mkDFjTh1cqM=;
        b=n76FtUi62ngOFM60rSuJXlZkjZ1HlMH02IyV+GHXQzF85CY3XFNfHCqJxchNIBxyy7
         CdWC+PaSu/F18zXIEqfpDcYfatMbxvaqxiNpT0OfdDzHVFLqdE/RZls9dCFCyECQs/Nz
         mw1ua1x1pNwYypsTeMLipyeL8kcYQevr0GE1FJmjPqIugwXVFv8Lrm41lmBecnUygd8x
         1q1BBOT4qtRU93gc61TmIFkyVCe7FzMWg4OhD4yd4Xqy6eUwyLfuEssUgM/pp/tQQlDp
         MFYZPErWyEIPeLdvprjrKhTfw29C334ocvmUld5K84V+i2PoMoh/dO51rBi7wtqf23OG
         l8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=965iQaC7U25MngSE/RPpVl7EpdT+hGY6mkDFjTh1cqM=;
        b=BJbOEmLh3xHC61CmdJ6nbh3iRXqgRObT0FlilNKrMiVxFOwwn9fFEwk6J2X2SBCmzd
         5pi6YvpbBmsQYsOda/C22JqFSOuCrQF9PpdafOIJothpydLSg2G5MDATmC01gLPoscD0
         mxa3HoyfQFOzCn1z9L82X/0zM6YwktxC+dbVnS05OwEdOEho0jcaHb2QyQTpSrTxDrsE
         kF6sgOqOAMCPpzDFu8YeJQCAyYRCyh5zyQtJu1Gel1kqUnXt4WMyLBxLtXuTYAVRbawt
         pK9vShPqBteEH5S8Vb7aoX0LifBnVruzmOsH5OvniZbVIdCCpEkDmCqUV73tOGeR3u3G
         cmdQ==
X-Gm-Message-State: AGi0PuansOKYcj2CqHYZWabcroCxIoKmaCiO131wkxrcUs7bgV4pZJEh
        T57jFi9AE7N6i6iui/7icunblQ==
X-Google-Smtp-Source: APiQypJVpsLWd4UdsEpG+O8Yd1rJbVFL5Fw81xtO9+6qJGsQ1AfrMD87Vxte9GzT7uTaaouTbL7fAg==
X-Received: by 2002:a0c:f54e:: with SMTP id p14mr15233094qvm.200.1588876278783;
        Thu, 07 May 2020 11:31:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:213c])
        by smtp.gmail.com with ESMTPSA id m33sm4708238qte.17.2020.05.07.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:31:17 -0700 (PDT)
Date:   Thu, 7 May 2020 14:31:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        Dave Chinner <david@fromorbit.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200507183102.GB155220@cmpxchg.org>
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
 <20200507170006.GA155220@cmpxchg.org>
 <20200507170903.GR2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507170903.GR2869@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, May 07, 2020 at 10:09:03AM -0700, Paul E. McKenney wrote:
> On Thu, May 07, 2020 at 01:00:06PM -0400, Johannes Weiner wrote:
> > On Wed, May 06, 2020 at 05:55:35PM -0700, Andrew Morton wrote:
> > > On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > This commit adds a shrinker so as to inform RCU when memory is scarce.
> > > > RCU responds by shifting into the same fast and inefficient mode that is
> > > > used in the presence of excessive numbers of RCU callbacks.  RCU remains
> > > > in this state for one-tenth of a second, though this time window can be
> > > > extended by another call to the shrinker.
> > 
> > We may be able to use shrinkers here, but merely being invoked does
> > not carry a reliable distress signal.
> > 
> > Shrinkers get invoked whenever vmscan runs. It's a useful indicator
> > for when to age an auxiliary LRU list - test references, clear and
> > rotate or reclaim stale entries. The urgency, and what can and cannot
> > be considered "stale", is encoded in the callback frequency and scan
> > counts, and meant to be relative to the VM's own rate of aging: "I've
> > tested X percent of mine for recent use, now you go and test the same
> > share of your pool." It doesn't translate well to other
> > interpretations of the callbacks, although people have tried.
> 
> Would it make sense for RCU to interpret two invocations within (say)
> 100ms of each other as indicating urgency?  (Hey, I had to ask!)

It's the perfect number for one combination of CPU, storage device,
and shrinker implementation :-)

> > > > If it proves feasible, a later commit might add a function call directly
> > > > indicating the end of the period of scarce memory.
> > > 
> > > (Cc David Chinner, who often has opinions on shrinkers ;))
> > > 
> > > It's a bit abusive of the intent of the slab shrinkers, but I don't
> > > immediately see a problem with it.  Always returning 0 from
> > > ->scan_objects might cause a problem in some situations(?).
> > > 
> > > Perhaps we should have a formal "system getting low on memory, please
> > > do something" notification API.
> > 
> > It's tricky to find a useful definition of what low on memory
> > means. In the past we've used sc->priority cutoffs, the vmpressure
> > interface (reclaimed/scanned - reclaim efficiency cutoffs), oom
> > notifiers (another reclaim efficiency cutoff). But none of these
> > reliably capture "distress", and they vary highly between different
> > hardware setups. It can be hard to trigger OOM itself on fast IO
> > devices, even when the machine is way past useful (where useful is
> > somewhat subjective to the user). Userspace OOM implementations that
> > consider userspace health (also subjective) are getting more common.
> > 
> > > How significant is this?  How much memory can RCU consume?
> > 
> > I think if rcu can end up consuming a significant share of memory, one
> > way that may work would be to do proper shrinker integration and track
> > the age of its objects relative to the age of other allocations in the
> > system. I.e. toss them all on a clock list with "new" bits and shrink
> > them at VM velocity. If the shrinker sees objects with new bit set,
> > clear and rotate. If it sees objects without them, we know rcu_heads
> > outlive cache pages etc. and should probably cycle faster too.
> 
> It would be easy for RCU to pass back (or otherwise use) the age of the
> current grace period, if that would help.
> 
> Tracking the age of individual callbacks is out of the question due to
> memory overhead, but RCU could approximate this via statistical sampling.
> Comparing this to grace-period durations could give information as to
> whether making grace periods go faster would be helpful.

That makes sense.

So RCU knows the time and the VM knows the amount of memory. Either
RCU needs to figure out its memory component to be able to translate
shrinker input to age, or the VM needs to learn about time to be able
to say: I'm currently scanning memory older than timestamp X.

The latter would also require sampling in the VM. Nose goes. :-)

There actually is prior art for teaching reclaim about time:
https://lore.kernel.org/linux-mm/20130430110214.22179.26139.stgit@zurg/

CCing Konstantin. I'm curious how widely this ended up being used and
how reliably it worked.

> But, yes, it would be better to have an elusive unambiguous indication
> of distress.  ;-)

I agree. Preferably something more practical than a dialogue box
asking the user on how well things are going for them :-)
