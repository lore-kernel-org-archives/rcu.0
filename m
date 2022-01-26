Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F11BC2BA4C
	for <rcu@archiver.kernel.org>; Wed, 26 Jan 2022 13:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238842AbiAZNV4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238974AbiAZNVy (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 26 Jan 2022 08:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643203314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wLkbgX/iEXY2i72yo8StnRlVlrU0XrHGrHBa3JoA9Zc=;
        b=G/JXi/ARFWeRkUzhC6YRhrigmBCJox6HjOUC5/545giQ5gaPphVzFQk/dIYUhxnmEatoL8
        Ty+CrAQ6iZFO5+5C1mkrCFN1MQKTne8CSCtcWXFAycm3Ad6myM7OWZlUqU6d9K4O3VVBW4
        3beSZo66tXX4sft68rNDrJ2KHLUGE8g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-X3uvxDHZNI6amHhGHh9eNA-1; Wed, 26 Jan 2022 08:21:52 -0500
X-MC-Unique: X3uvxDHZNI6amHhGHh9eNA-1
Received: by mail-qv1-f69.google.com with SMTP id 8-20020a0562140d0800b00422bb534680so10976817qvh.7
        for <rcu@vger.kernel.org>; Wed, 26 Jan 2022 05:21:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wLkbgX/iEXY2i72yo8StnRlVlrU0XrHGrHBa3JoA9Zc=;
        b=RrfUVf1gVAQAFV1lB/7NY4pJe6yftAIem8akKIoDAQEr4Yp/LnQt26uxQTNOnSiBGI
         hzyqhTIE+SCt+Qn+DI+8svvNNuM+ItRa8ywiP+tgXMJEdSErQqjg4reSGYXI+WcZigo1
         KN5CEnwNN9TRW3ubD9koA+gq+VzNagX3um2JbQYQutLq9WAKFKMB2kCEyVpkXmdQ7NyI
         y0V2udKkvtNbK/Yt63d6RhSD9FvcoASUxFaVoTNapn1sSK1kMvRqR/7i9UwCTBrL1roR
         ZcU2nPjbj5VmYA6P6C+RET2+DCYm4KoK/kcK4l9M8DVEnWRIiydcOXU4RBlUWdZyWUNe
         eY8g==
X-Gm-Message-State: AOAM531a2tRp2NHiBfThjrotIVnrCuhO9NNq9Y+e44gaW0m+2RlcAyNC
        IvwLSDalxk4LA+1jjZmTs52D9Ab7+ZnERKL3uT2yJZnxruX431BsKvtYfAEDaK9xocn9msQT75p
        ye3nN/hEkUtX7
X-Received: by 2002:a05:6214:2b05:: with SMTP id jx5mr10655779qvb.124.1643203312371;
        Wed, 26 Jan 2022 05:21:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaiKXsB9fAJq7SlTWEDP4n50KE4TvnpSTw+bfVNcuQoeyrA/zDChNFnzksO8oav8pydERdqw==
X-Received: by 2002:a05:6214:2b05:: with SMTP id jx5mr10655766qvb.124.1643203312108;
        Wed, 26 Jan 2022 05:21:52 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id t13sm1708624qti.47.2022.01.26.05.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:21:51 -0800 (PST)
Date:   Wed, 26 Jan 2022 08:21:49 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        rcu@vger.kernel.org
Subject: Re: [PATCH] xfs: require an rcu grace period before inode recycle
Message-ID: <YfFK7dYHKCEPCRoB@bfoster>
References: <20220121142454.1994916-1-bfoster@redhat.com>
 <Ye6/g+XMSyp9vYvY@bfoster>
 <20220124220853.GN59729@dread.disaster.area>
 <Ye82TgBY0VmtTjMc@bfoster>
 <20220125003120.GO59729@dread.disaster.area>
 <20220125144044.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <20220125223607.GP59729@dread.disaster.area>
 <20220126052910.GX4285@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126052910.GX4285@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jan 25, 2022 at 09:29:10PM -0800, Paul E. McKenney wrote:
> On Wed, Jan 26, 2022 at 09:36:07AM +1100, Dave Chinner wrote:
> > On Tue, Jan 25, 2022 at 06:40:44AM -0800, Paul E. McKenney wrote:
> > > On Tue, Jan 25, 2022 at 11:31:20AM +1100, Dave Chinner wrote:
> > > > > Ok, I think we're talking about slightly different things. What I mean
> > > > > above is that if a task removes a file and goes off doing unrelated
> > > > > $work, that inode will just sit on the percpu queue indefinitely. That's
> > > > > fine, as there's no functional need for us to process it immediately
> > > > > unless we're around -ENOSPC thresholds or some such that demand reclaim
> > > > > of the inode.
> > > > 
> > > > Yup, an occasional unlink sitting around for a while on an unlinked
> > > > list isn't going to cause a performance problem.  Indeed, such
> > > > workloads are more likely to benefit from the reduced unlink()
> > > > syscall overhead and won't even notice the increase in background
> > > > CPU overhead for inactivation of those occasional inodes.
> > > > 
> > > > > It sounds like what you're talking about is specifically
> > > > > the behavior/performance of sustained file removal (which is important
> > > > > obviously), where apparently there is a notable degradation if the
> > > > > queues become deep enough to push the inode batches out of CPU cache. So
> > > > > that makes sense...
> > > > 
> > > > Yup, sustained bulk throughput is where cache residency really
> > > > matters. And for unlink, sustained unlink workloads are quite
> > > > common; they often are something people wait for on the command line
> > > > or make up a performance critical component of a highly concurrent
> > > > workload so it's pretty important to get this part right.
> > > > 
> > > > > > Darrick made the original assumption that we could delay
> > > > > > inactivation indefinitely and so he allowed really deep queues of up
> > > > > > to 64k deferred inactivations. But with queues this deep, we could
> > > > > > never get that background inactivation code to perform anywhere near
> > > > > > the original synchronous background inactivation code. e.g. I
> > > > > > measured 60-70% performance degradataions on my scalability tests,
> > > > > > and nothing stood out in the profiles until I started looking at
> > > > > > CPU data cache misses.
> > > > > > 
> > > > > 
> > > > > ... but could you elaborate on the scalability tests involved here so I
> > > > > can get a better sense of it in practice and perhaps observe the impact
> > > > > of changes in this path?
> > > > 
> > > > The same conconrrent fsmark create/traverse/unlink workloads I've
> > > > been running for the past decade+ demonstrates it pretty simply. I
> > > > also saw regressions with dbench (both op latency and throughput) as
> > > > the clinet count (concurrency) increased, and with compilebench.  I
> > > > didn't look much further because all the common benchmarks I ran
> > > > showed perf degradations with arbitrary delays that went away with
> > > > the current code we have.  ISTR that parts of aim7/reaim scalability
> > > > workloads that the intel zero-day infrastructure runs are quite
> > > > sensitive to background inactivation delays as well because that's a
> > > > CPU bound workload and hence any reduction in cache residency
> > > > results in a reduction of the number of concurrent jobs that can be
> > > > run.
> > > 
> > > Curiosity and all that, but has this work produced any intuition on
> > > the sensitivity of the performance/scalability to the delays?  As in
> > > the effect of microseconds vs. tens of microsecond vs. hundreds of
> > > microseconds?
> > 
> > Some, yes.
> > 
> > The upper delay threshold where performance is measurably
> > impacted is in the order of single digit milliseconds, not
> > microseconds.
> > 
> > What I saw was that as the batch processing delay goes beyond ~5ms,
> > IPC starts to fall. The CPU usage profile does not change shape, nor
> > does the proportions of where CPU time is spent change. All I see if
> > data cache misses go up substantially and IPC drop substantially. If
> > I read my notes correctly, typical change from "fast" to "slow" in
> > IPC was 0.82 to 0.39 and LLC-load-misses from 3% to 12%. The IPC
> > degradation was all done by the time the background batch processing
> > times were longer than a typical scheduler tick (10ms).
> > 
> > Now, I've been testing on Xeon CPUs with 36-76MB of l2-l3 caches, so
> > there's a fair amount of data that these can hold. I expect that
> > with smaller caches, the inflection point will be at smaller batch
> > sizes rather than more. Hence while I could have used larger batches
> > for background processing (e.g. 64-128 inodes rather than 32), I
> > chose smaller batch sizes by default so that CPUs with smaller
> > caches are less likely to be adversely affected by the batch size
> > being too large. OTOH, I started to measure noticable degradation by
> > batch sizes of 256 inodes on my machines, which is why the hard
> > queue limit got set to 256 inodes.
> > 
> > Scaling the delay/batch size down towards single inode queuing also
> > resulted in perf degradation. This was largely because of all the
> > extra scheduling overhead that trying to switching between user task
> > and kernel worker task for every inode entailed. Context switch rate
> > went from a couple of thousand/sec to over 100,000/s for single
> > inode batches, and performance went backwards in proportion with the
> > amount of CPU then spent on context switches. It also lead to
> > increases in buffer lock contention (hence context switches) as both
> > user task and kworker try to access the same buffers...
> 
> Makes sense.  Never a guarantee of easy answers.  ;-)
> 
> If it would help, I could create expedited-grace-period counterparts
> of get_state_synchronize_rcu(), start_poll_synchronize_rcu(),
> poll_state_synchronize_rcu(), and cond_synchronize_rcu().  These would
> provide sub-millisecond grace periods, in fact, sub-100-microsecond
> grace periods on smaller systems.
> 

If you have something with enough basic functionality, I'd be interested
in converting this patch over to an expedited variant to run some
tests/experiments. As it is, it seems the current approach is kind of
playing wack-a-mole between disrupting allocation performance by
populating the free inode pool with too many free but "pending rcu grace
period" inodes and sustained remove performance by pushing the internal
inactivation queues too deep and thus losing CPU cache, as Dave
describes above. So if an expedited grace period is possible that fits
within the time window on paper, it certainly seems worthwhile to test.

Otherwise the only thing that comes to mind right now is to start
playing around with the physical inode allocation algorithm to avoid
such pending inodes. I think a scanning approach may ultimately run into
the same problems with the right workload (i.e. such that all free
inodes are pending), so I suspect what this really means is either
figuring a nice enough way to efficiently locate expired inodes (maybe
via our own internal rcu callback to explicitly tag now expired inodes
as good allocation candidates), or to determine when to proceed with
inode chunk allocations when scanning is unlikely to succeed, or
something similar along those general lines..

> Of course, nothing comes for free.  Although expedited grace periods
> are way way cheaper than they used to be, they still IPI non-idle
> non-nohz_full-userspace CPUs, which translates to roughly the CPU overhead
> of a wakeup on each IPIed CPU.  And of course disruption to aggressive
> non-nohz_full real-time applications.  Shorter latencies also translates
> to fewer updates over which to amortize grace-period overhead.
> 
> But it should get well under your single-digit milliseconds of delay.
> 

If the expedited variant were sufficient for the fast path case, I
suppose it might be interesting to see if we could throttle down to
non-expedited variants either based on heuristic or feedback from
allocation side stalls.

Brian

> 							Thanx, Paul
> 

