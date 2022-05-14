Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF3DC433EF
	for <rcu@archiver.kernel.org>; Sat, 14 May 2022 19:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiENTKJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 14 May 2022 15:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiENTKI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 14 May 2022 15:10:08 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770BE1D0DA
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 12:10:06 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu29so19780881lfb.0
        for <rcu@vger.kernel.org>; Sat, 14 May 2022 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VWY96mGOMjDABUNG8OhNjcx5WwAyzrmlc31ha/jiVPU=;
        b=S1kW11KD+J2RA8z4ZukqDWvkp8Wi6n4tUsFemXPlSDTMYbewGPvwtiu3p4rSEWw07F
         m5/lLAgHmsKwtisyjVEYW9LWSkYY152BxpTkfa0BUhPbyXXIsBdzNPNTO8qR/Qo4Hxcy
         axGCeY3bjJBzeb6z6SoWuahSZ47k67vKC+GqRx+R5p5REcZRQHcCgSKMrxSjUblptFW3
         JKrlOwvKE7ESQ3VhBXvm2AsYV0+oxcD6L5ENTF+s75tLKb1/ykbZ7u03jsjEFPu13O6v
         1UDcLAQ/RMvvk4ebqRL5/wcV7RRfWVVC6FOFE96GItK8SaBhqbKmStsfTAd7iINhRTLb
         5pEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VWY96mGOMjDABUNG8OhNjcx5WwAyzrmlc31ha/jiVPU=;
        b=WjnDILzW/Ovkopd0eOGxAdQf7o9b42D27meMPaxCuBir7LMc77Dxo9ylrzxVId6yvl
         EVKn4GhmNknl+K+ubjgNHLaTWsZglcyG3v9UCikSDZMz+AloyYb7b/AOVT8EPvE6VdBk
         rELDiqQukCE4PRUGCYOxRAV+/M+jwoGnXgbsnO/Q15HD08rz3Ki9kOpnNyUjGKzuDB/m
         z+wKV+tqxHeE922+V2d8lXsxsOOV6ijUXCq65LJyeAWdnWWOVSuB0fPyd4SqXF9qP18c
         BvBYnAGjHtxUpM8y9UR4xPVvbDoN3N45KjyFhbNnZHnwj02bpBmOF8clCbMAmLJW5CIq
         a7mQ==
X-Gm-Message-State: AOAM533KsqNwgmn1ST03Jd4uozGg8tG95wOHU4TxerolNfRq8zXyoDgF
        GySHOMA/fJnaz7i/j3r0acU=
X-Google-Smtp-Source: ABdhPJyQOdyofpqlSmBCN7NG4ofoHg/Ho9/PoF/BvzzB2lwfHPW6PH36PDRAg6rDzoo1kcttXMQhlA==
X-Received: by 2002:a05:6512:3d28:b0:472:6386:9eab with SMTP id d40-20020a0565123d2800b0047263869eabmr7802669lfv.484.1652555404793;
        Sat, 14 May 2022 12:10:04 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id g1-20020a19ac01000000b0047255d211f4sm780311lfc.291.2022.05.14.12.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 12:10:04 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sat, 14 May 2022 21:10:02 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        rushikesh.s.kadam@intel.com, neeraj.iitr10@gmail.com,
        frederic@kernel.org, rostedt@goodmis.org
Subject: Re: [RFC v1 10/14] kfree/rcu: Queue RCU work via
 queue_rcu_work_lazy()
Message-ID: <Yn/+il1h0hdaXzrP@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <20220512030442.2530552-11-joel@joelfernandes.org>
 <20220513001206.GZ1790663@paulmck-ThinkPad-P17-Gen-1>
 <Yn5xZkENgmnd7wyq@pc638.lan>
 <Yn+91Q3fgteCj+td@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn+91Q3fgteCj+td@google.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> On Fri, May 13, 2022 at 04:55:34PM +0200, Uladzislau Rezki wrote:
> > > On Thu, May 12, 2022 at 03:04:38AM +0000, Joel Fernandes (Google) wrote:
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > 
> > > Again, given that kfree_rcu() is doing its own laziness, is this really
> > > helping?  If so, would it instead make sense to adjust the kfree_rcu()
> > > timeouts?
> > > 
> > IMHO, this patch does not help much. Like Paul has mentioned we use
> > batching anyway.
> 
> I think that depends on the value of KFREE_DRAIN_JIFFIES. It it set to 20ms
> in the code. The batching with call_rcu_lazy() is set to 10k jiffies which is
> longer which is at least 10 seconds on a 1000HZ system. Before I added this
> patch, I was seeing more frequent queue_rcu_work() calls which were starting
> grace periods. I am not sure though how much was the power saving by
> eliminating queue_rcu_work() , I just wanted to make it go away.
> 
> Maybe, instead of this patch, can we make KFREE_DRAIN_JIFFIES a tunable or
> boot parameter so systems can set it appropriately? Or we can increase the
> default kfree_rcu() drain time considering that we do have a shrinker in case
> reclaim needs to happen.
> 
> Thoughts?
> 
Agree. We need to change behaviour of the simple KFREE_DRAIN_JIFFIES.
One thing is that we can relay on shrinker. So making the default drain
interval, say, 1 sec sounds reasonable to me and swith to shorter one
if the page is full:

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 222d59299a2a..89b356cee643 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3249,6 +3249,7 @@ EXPORT_SYMBOL_GPL(call_rcu);
 
 
 /* Maximum number of jiffies to wait before draining a batch. */
+#define KFREE_DRAIN_JIFFIES_SEC (HZ)
 #define KFREE_DRAIN_JIFFIES (HZ / 50)
 #define KFREE_N_BATCHES 2
 #define FREE_N_CHANNELS 2
@@ -3685,6 +3686,20 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
 	return true;
 }
 
+static bool
+is_krc_page_full(struct kfree_rcu_cpu *krcp)
+{
+	int i;
+
+	// Check if a page is full either for first or second channels.
+	for (i = 0; i < FREE_N_CHANNELS && krcp->bkvhead[i]; i++) {
+		if (krcp->bkvhead[i]->nr_records == KVFREE_BULK_MAX_ENTR)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * Queue a request for lazy invocation of the appropriate free routine
  * after a grace period.  Please note that three paths are maintained,
@@ -3701,6 +3716,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
+	unsigned long delay;
 	bool success;
 	void *ptr;
 
@@ -3749,7 +3765,11 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
 	    !krcp->monitor_todo) {
 		krcp->monitor_todo = true;
-		schedule_delayed_work(&krcp->monitor_work, KFREE_DRAIN_JIFFIES);
+
+		delay = is_krc_page_full(krcp) ?
+			KFREE_DRAIN_JIFFIES:KFREE_DRAIN_JIFFIES_SEC;
+
+		schedule_delayed_work(&krcp->monitor_work, delay);
 	}
 
 unlock_return:

please note it is just for illustration because the patch is not completed.
As for parameters, i think we can add both to access over /sys/module/...

--
Uladzislau Rezki
