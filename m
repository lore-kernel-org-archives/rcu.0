Return-Path: <SRS0=nLJu=VQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF522C76188
	for <rcu@archiver.kernel.org>; Fri, 19 Jul 2019 07:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99AA12084C
	for <rcu@archiver.kernel.org>; Fri, 19 Jul 2019 07:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGSHvS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:51:18 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:42273 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSHvS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Jul 2019 03:51:18 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 19 Jul 2019 16:51:16 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 19 Jul 2019 16:51:16 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Fri, 19 Jul 2019 16:50:11 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu <rcu@vger.kernel.org>, kernel-team@lge.com
Subject: Re: This percpu_rwsem that always enters its reader slow path
Message-ID: <20190719075011.GD28226@X58A-UD3R>
References: <CAEXW_YR39bnCCj+eo30jSZrNEvcJY8wrXuA0fYr_gfbfNiVsPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YR39bnCCj+eo30jSZrNEvcJY8wrXuA0fYr_gfbfNiVsPQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 18, 2019 at 05:09:45PM -0400, Joel Fernandes wrote:
> Hello friends,
> 
> Just providing an update on my debugging of percpu_rwsem (related to
> rcu-sync) for the day! which I pinged Byungchul about. Please ignore
> this email if you are busy :) I am just archiving it in here..
> 
> As you may know, percpu_rwsem uses rcu-sync framework to reduce cost
> of read-side by making it free of any serializing/atomic instructions
> at all. However, there was one sempahore which broke the rules!
> 
> I spent a couple hours trying to figure out why
> cgroup_threadgroup_rwsem always entered the reader-slow path on my
> system (RCU-sync turns out to be non-idle for this rwsem). I really
> thought it was a bug, because I felt what's the pointed of rcu-sync if
> it never goes idle..

Yes, with the following patch, the cgroup rwsem cannot make use of
rcu_sync any more, but it still gets benefit from percpu structure
as you told me like avoiding cache bouncing and contention on a shared
area even though every read lock keeps firing smp full barrier.

What matters is which one is more expensive between (1) firing smp_mb
and (2) accessing a shared data, sem->count, and acquiring/releasing
sem->wait_lock. I think using percpu-rwsem involving the smp barrier is
much better even with rcu_sync disabled.

Or am I missing the point? Please let me know if so.

Thanks,
Byungchul

> Then I landed on the commit below, and turns it was done for Android
> and reported by John :) And the patch author was a certain guy named
> Peter :)
> 
> commit 3942a9bd7b5842a924e99ee6ec1350b8006c94ec
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Thu Aug 11 18:54:13 2016 +0200
> 
>     locking, rcu, cgroup: Avoid synchronize_sched() in __cgroup_procs_write()
> -----------
> 
> Basically, this commit makes the read-side cost percpu_rwsem slightly
> more expensive (one smp_load_acquire of readers_block, at the cost of
> making write-side a bit more expensive...)
> 
> So turns out it is weird, but it is certainly not a bug.
> 
> Learned something new but wasted my time a bit :)
> 
> Cheers, and see you later,
> - Joel
