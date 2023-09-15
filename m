Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41966EED617
	for <rcu@archiver.kernel.org>; Fri, 15 Sep 2023 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjIOQhq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Sep 2023 12:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjIOQhT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Sep 2023 12:37:19 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04DAC
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 09:37:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7983b202929so84881939f.2
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694795833; x=1695400633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aWEe3C04IH2pUfqlyqIcLPbigYNZQV2fKkdAuTky5xc=;
        b=f2zcjzJ8BCAVADDopwZlcVJzbjgDeoRAnsQGwVXIv5XawgW3EMDa402imjMfpGWmsy
         RBsi3v7LCanrjuDOUSGwILOq+HOWehUnSRiYvHIjvCjUgeUTGKgO8DCwwy60z+kLXkjo
         kU1FpQ0TJVvgK7Q+RCigJpCJyXwyoAqfTo5+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795833; x=1695400633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWEe3C04IH2pUfqlyqIcLPbigYNZQV2fKkdAuTky5xc=;
        b=Qj1sImTD0Gj3TQiC8YqlfjSELbJqY2aVvrCXD9SI3N1I2nTIGRekI994x65RsH60Ki
         /KyvXgypacPHf7Faud1zQx7Y/RTRuJoOaO6do5CBDfEMVYEgoX+vL4dNKaQF5BAZNcGf
         lJbifaq4HIA/P9+y79wa8lo1cRRzBK9qUm3qrAiBQsma9gjApHDDOnLhTDyqiO0QCFln
         tpg+mFTubHRVIxMJFuJK5Z35T9xG4TGiL5mzavy8dcCYDnWvMDLHSrDJddnQciwcNhtB
         TxP9wdahpKDQcMQBBVs0dt0hgwKTFnfQCnRbX8eXatt1EzsK11TecluILmsawihwPDlC
         Hc1w==
X-Gm-Message-State: AOJu0Yy8RYgjAJo7BmvhF77P/p+oPTRIQ46u/HYJGw9NznWCP4Xg0txD
        hey8/0/ZwnBT71F3qOgDM+gDsw==
X-Google-Smtp-Source: AGHT+IF9JxeVaHMyL6hHTBJAT8kMCOQH97HEgrEXyBUH6fOU4LoWUbcXAXgvy1x6Y69EiViN6gvBbQ==
X-Received: by 2002:a6b:6617:0:b0:783:60f7:ade9 with SMTP id a23-20020a6b6617000000b0078360f7ade9mr2083926ioc.5.1694795832936;
        Fri, 15 Sep 2023 09:37:12 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id y16-20020a02bb10000000b0042b3042ccd8sm1132947jan.13.2023.09.15.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:37:12 -0700 (PDT)
Date:   Fri, 15 Sep 2023 16:37:11 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>, rcu@vger.kernel.org
Subject: Re: [BUG] Random intermittent boost failures (Was Re: [BUG] TREE04..)
Message-ID: <20230915163711.GA3116200@google.com>
References: <1f12ffe6-4cb0-4364-8c4c-3393ca5368c2@paulmck-laptop>
 <CAEXW_YQpgjXexpHfGGJS5_VoVUvb+ZXp7pkOdm8NGo+Z4iJAKA@mail.gmail.com>
 <fe78cd08-1b2c-4ab0-bbf7-8d324b4fa77f@paulmck-laptop>
 <20230914131351.GA2274683@google.com>
 <885bb95b-9068-45f9-ba46-3feb650a3c45@paulmck-laptop>
 <20230914185627.GA2520229@google.com>
 <20230914215324.GA1972295@google.com>
 <20230915001331.GA1235904@google.com>
 <20230915113313.GA2909128@google.com>
 <ddc6c9d3-f9c7-46ab-a11e-0841148baa3a@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddc6c9d3-f9c7-46ab-a11e-0841148baa3a@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul,
Thanks! I merged replies to 3 threads into this one to make it easier to follow.

On Fri, Sep 15, 2023 at 07:53:15AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 15, 2023 at 11:33:13AM +0000, Joel Fernandes wrote:
> > On Fri, Sep 15, 2023 at 12:13:31AM +0000, Joel Fernandes wrote:
[...]
> > On the other hand, I came up with a real fix [1] and I am currently testing it.
> > This is to fix a live lock between RT push and CPU hotplug's
> > select_fallback_rq()-induced push. I am not sure if the fix works but I have
> > some faith based on what I'm seeing in traces. Fingers crossed. I also feel
> > the real fix is needed to prevent these issues even if we're able to hide it
> > by halving the total rcutorture boost threads.
> 
> This don't-schedule-on-dying CPUs approach does quite look promising
> to me!
> 
> Then again, I cannot claim to be a scheduler expert.  And I am a bit
> surprised that this does not already happen.  Which makes me wonder
> (admittedly without evidence either way) whether there is some CPU-hotplug
> race that it might induce.  But then again, figuring this sort of thing
> out is what part of the scheduler guys are there for, right?  ;-)

Yes it looks promising. Actually this sort of thing also seems to be already
done in CFS, it just not there in RT. So maybe it is OK. Testing so far
showed me pretty good results even with hotplug testing. Here is hoping!

> > > On the other hand, I came up with a real fix [1] and I am currently testing it.
> > > This is to fix a live lock between RT push and CPU hotplug's
> > > select_fallback_rq()-induced push. I am not sure if the fix works but I have
> > > some faith based on what I'm seeing in traces. Fingers crossed. I also feel
> > > the real fix is needed to prevent these issues even if we're able to hide it
> > > by halving the total rcutorture boost threads.
> > 
> > So that fixed it without any changes to RCU. Below is the updated patch also
> > for the archives. Though I'm rewriting it slightly differently and testing
> > that more. The main thing I am doing in the new patch is I find that RT
> > should not select !cpu_active() CPUs since those have the scheduler turned
> > off. Though checking for cpu_dying() also works. I could not find any
> > instance where cpu_dying() != cpu_active() but there could be a tiny window
> > where that is true. Anyway, I'll make some noise with scheduler folks once I
> > have the new version of the patch tested.
> > 
> > Also halving the number of RT boost threads makes it less likely to occur but
> > does not work. Not too surprising since the issue actually may not be related
> > to too many RT threads but rather a lockup between hotplug and RT..
> 
> Again, looks promising!  When I get the non-RCU -rcu stuff moved to
> v6.6-rc1 and appropriately branched and tested, I will give it a go on
> the test setup here.

Thanks a lot, and I have enclosed a simpler updated patch below which also
similarly shows very good results. This is the one I would like to test
more and send to scheduler folks. I'll send it out once I have it tested more
and also possibly after seeing your results (I am on vacation next week so
there's time).

> > We could run them on just the odd, or even ones and still be able to get
> > sufficient boost testing. This may be especially important without RT
> > throttling. I'll go ahead and queue a test like that.
> > 
> > Thoughts?
> 
> The problem with this is that it will often render RCU priority boosting
> unnecessary.  Any kthread preempted within an RCU read-side critical
> section will with high probability quickly be resumed on one of the
> even-numbered CPUs.
> 
> Or were you also planning to bind the rcu_torture_reader() kthreads to
> a specific CPU, preventing such migration?  Or am I missing something
> here?

You are right, I see now why you were running them on all CPUs. One note
though, af the RCU reader threads are CFS, they will not be immediately
pushed out so maybe it may work (unlike if the RCU reader threads being
preempted were RT). However testing shows thread-halving does not fix the
issue anyway so we can scratch that. Instead, below is the updated patch for
don't schedule-on-dying/inactive CPUs approach which is showing really good
results!

And I'll most likely see you the week after, after entering into a 4-day
quiescent state. ;-)

thanks,

 - Joel

---8<-----------------------

From: Joel Fernandes (Google) <joel@joelfernandes.org>
Subject: [PATCH] RT: Alternative fix for livelock with hotplug

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpupri.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index a286e726eb4b..42c40cfdf836 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -101,6 +101,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
-- 
2.42.0.459.ge4e396fd5e-goog

