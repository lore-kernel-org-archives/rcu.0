Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4054C4332F
	for <rcu@archiver.kernel.org>; Fri, 11 Nov 2022 01:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbiKKB4b (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 10 Nov 2022 20:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiKKB4a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 10 Nov 2022 20:56:30 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF5C4B9B0
        for <rcu@vger.kernel.org>; Thu, 10 Nov 2022 17:56:29 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id c8so2654179qvn.10
        for <rcu@vger.kernel.org>; Thu, 10 Nov 2022 17:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O1+ZXXkNrHkfBXEqnZaSLuRUwnIIrNDVBjNXQSrU/e4=;
        b=mUzwqFjnIiSvqnAtZxDyjV/tWtB7cEgLY+jGPqDoztow5Js1uw6YnhfZ6IQDLx5Ijr
         ViSMgaePfqNm5pc7W7SQQjVD7A0ySlMjsDNBJrOxPiVX9Ib4EuurOxnlqwffSpaY/aSc
         LDdjL+5agg5orX4xJU+OTn4KgS0mXz1KimuOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1+ZXXkNrHkfBXEqnZaSLuRUwnIIrNDVBjNXQSrU/e4=;
        b=iJsmL5OR4xI56b1VPoDZ3D2YkvGh9KixUsVCxhm4F+db/DYqJmYICdW1iiM9tS3Kn2
         Q3HplxnkWrdtJOnPhfBxY/LabV5dHZ7m4Vgk2+Rz8PBtIW7osVT/Ep+3IfOR+nPtYt8U
         9dAh/1bNhrM42krDSJDo9Col42NfYPzIpFt6LxDQ1SmeikhbeJi43S+F4sCbG5SnJ3As
         FDEhdSQPKNSIsVAFXaZx5/24nM3KGjr3E5zZceARwpfYB3WKGshAD52ZHijnOFgP7hv+
         QcvimF8gizDnnYFF7ahtyf21Zr2nZxGybftu8DYxxKIb/MRaRWOWlbrX7STmP1g9kDtw
         FnNA==
X-Gm-Message-State: ANoB5plh9pFFLhHGPtElMHqSXgRDJV+GOZ9Xw+/wAfrFTU6sMh1T9m60
        DDdAaJ7D3ldszjU3+YIrXfTixQ==
X-Google-Smtp-Source: AA0mqf7LicnrkfFAdzES6dcyMLNLM85qPFTSaobOoZidfYVHfGpItCgEaTIdmbCTGm0ifCOIQciYlQ==
X-Received: by 2002:a05:6214:570f:b0:4b1:c5bb:25f2 with SMTP id lt15-20020a056214570f00b004b1c5bb25f2mr323203qvb.101.1668131788661;
        Thu, 10 Nov 2022 17:56:28 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id w27-20020a05620a0e9b00b006ce3f1af120sm627219qkm.44.2022.11.10.17.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 17:56:28 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:56:27 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH v2] rcu/kfree: Do not request RCU when not needed
Message-ID: <Y22ry4Q2OY2zovco@google.com>
References: <20221109024758.2644936-1-joel@joelfernandes.org>
 <Y2z3Mb3u8bFZ12wY@pc636>
 <CAEXW_YSq89xzgyQ9Tdt1tCqz8VAfzb7kSXVZmnxDuJ65U0UZ3w@mail.gmail.com>
 <Y20EOinwcLSZHmXg@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y20EOinwcLSZHmXg@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 10, 2022 at 03:01:30PM +0100, Uladzislau Rezki wrote:
> > Hi,
> > 
> > On Thu, Nov 10, 2022 at 8:05 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > > > On ChromeOS, using this with the increased timeout, we see that we
> > > almost always
> > > > never need to initiate a new grace period. Testing also shows this frees
> > > large
> > > > amounts of unreclaimed memory, under intense kfree_rcu() pressure.
> > > >
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > > v1->v2: Same logic but use polled grace periods instead of sampling
> > > gp_seq.
> > > >
> > > >  kernel/rcu/tree.c | 8 +++++++-
> > > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 591187b6352e..ed41243f7a49 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
> > > >
> > > >  /**
> > > >   * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace
> > > period
> > > > + * @gp_snap: The GP snapshot recorded at the last scheduling of monitor
> > > work.
> > > >   * @head: List of kfree_rcu() objects not yet waiting for a grace period
> > > >   * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a
> > > grace period
> > > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a
> > > grace period
> > > > @@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
> > > >       struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > > >       raw_spinlock_t lock;
> > > >       struct delayed_work monitor_work;
> > > > +     unsigned long gp_snap;
> > > >       bool initialized;
> > > >       int count;
> > > >
> > > > @@ -3167,6 +3169,7 @@ schedule_delayed_monitor_work(struct kfree_rcu_cpu
> > > *krcp)
> > > >                       mod_delayed_work(system_wq, &krcp->monitor_work,
> > > delay);
> > > >               return;
> > > >       }
> > > > +     krcp->gp_snap = get_state_synchronize_rcu();
> > > >       queue_delayed_work(system_wq, &krcp->monitor_work, delay);
> > > >  }
> > > >
> > > How do you guarantee a full grace period for objects which proceed
> > > to be placed into an input stream that is not yet detached?
> > 
> > 
> > Just replying from phone as I’m OOO today.
> > 
> > Hmm, so you’re saying that objects can be queued after the delayed work has
> > been queued, but processed when the delayed work is run? I’m looking at
> > this code after few years so I may have missed something.
> > 
> > That’s a good point and I think I missed that. I think your version did too
> > but I’ll have to double check.
> > 
> > The fix then is to sample the clock for the latest object queued, not for
> > when the delayed work is queued.
> > 
> The patch i sent gurantee it. Just in case see v2:

You are right and thank you! CBs can be queued while the monitor timer is in
progress. So we need to sample unconditionally. I think my approach is still
better since I take advantage of multiple seconds (I update snapshot on every
CB queue monitor and sample in the monitor handler).

Whereas your patch is snapshotting before queuing the regular work and when
the work is executed (This is a much shorter duration and I bet you would be
blocking in cond_synchronize..() more often).

As you pointed, I was sampling too late, and should be fixed below. Thoughts?

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v3] rcu/kfree: Do not request RCU when not needed

On ChromeOS, using this with the increased timeout, we see that we almost always
never need to initiate a new grace period. Testing also shows this frees large
amounts of unreclaimed memory, under intense kfree_rcu() pressure.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 591187b6352e..499e6ab56fbf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2935,6 +2935,7 @@ struct kfree_rcu_cpu_work {
 
 /**
  * struct kfree_rcu_cpu - batch up kfree_rcu() requests for RCU grace period
+ * @gp_snap: The GP snapshot recorded at the last scheduling of monitor work.
  * @head: List of kfree_rcu() objects not yet waiting for a grace period
  * @bkvhead: Bulk-List of kvfree_rcu() objects not yet waiting for a grace period
  * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
@@ -2964,6 +2965,7 @@ struct kfree_rcu_cpu {
 	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
 	raw_spinlock_t lock;
 	struct delayed_work monitor_work;
+	unsigned long gp_snap;
 	bool initialized;
 	int count;
 
@@ -3217,7 +3219,10 @@ static void kfree_rcu_monitor(struct work_struct *work)
 			// be that the work is in the pending state when
 			// channels have been detached following by each
 			// other.
-			queue_rcu_work(system_wq, &krwp->rcu_work);
+			if (poll_state_synchronize_rcu(krcp->gp_snap))
+				queue_work(system_wq, &krwp->rcu_work.work);
+			else
+				queue_rcu_work(system_wq, &krwp->rcu_work);
 		}
 	}
 
@@ -3409,6 +3414,9 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 
 	WRITE_ONCE(krcp->count, krcp->count + 1);
 
+	// Snapshot the GP clock for the latest callback.
+	krcp->gp_snap = get_state_synchronize_rcu();
+
 	// Set timer to drain after KFREE_DRAIN_JIFFIES.
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING)
 		schedule_delayed_monitor_work(krcp);
-- 
2.38.1.493.g58b659f92b-goog

