Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF91AC433EF
	for <rcu@archiver.kernel.org>; Sat,  4 Jun 2022 03:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350369AbiFDDHZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 3 Jun 2022 23:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbiFDDHY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 3 Jun 2022 23:07:24 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC552505
        for <rcu@vger.kernel.org>; Fri,  3 Jun 2022 20:07:22 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u8so6837902qvj.2
        for <rcu@vger.kernel.org>; Fri, 03 Jun 2022 20:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=osrnw7sFcZ5hiIqyS5xV6+m+jsprQW4zwHLAGyXqgMg=;
        b=WYrQ9yTZJYCYdFgm9/MgjvArTTaJzu/RSBi4mskaKDEiQGipR4BfFspfWH2kfXNeqh
         U9XKJu6D6tWgVDlDtPplGnI4itW67t3oeI8qBR59AWdP+ZrdH+pXvjcp9/tzXRd7+WQe
         RWvD4aHW2C4bRPhZdXSieKADEZ3vAVnxu51uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osrnw7sFcZ5hiIqyS5xV6+m+jsprQW4zwHLAGyXqgMg=;
        b=6XF0pfce7d688qHLEQkEfuSL/aZVAyGegKRZEpD73f7sp8rlGuyVo5j1PIE0o4Tx7q
         tNzGGBideewm5g7e56AZiKOWpQkCMQWZ59THgd+SvTv0JJBzBKNpwYNlcWaEmMCXt8BG
         /gLGtNzo/8o4VJNFgjYFiXucGgntFSAbIN5TODykFzJfRa8luENe7pQwyipUdU25w/SJ
         BxaCeHN2bwoTb+XN+PTu04EKQIvRqrn8IxQtb0OAP/Y78P8obxYpXRdDXN79hdMFUNmX
         nDIzOlyM3pTbqxjE2NL7cghG5CU5eS+5sN2QQZDAf5MHdy42Wr3W3kze2yRk4vU2xazS
         iLUQ==
X-Gm-Message-State: AOAM533Bz9pHWjvzg2rfBZBqfLarA5uMLhEi6V20/iQxZxshR988bRX7
        +oS7XtKLnJg2FnMwyaTQkh7bvQ==
X-Google-Smtp-Source: ABdhPJxfYHKfr8xaO+ahB9oTgJ81iwcuyEq3PDIPpjjn5+P2uXDsKwlnfo1bxDdIRAwtSDRHoXeaqA==
X-Received: by 2002:a05:6214:2a8e:b0:464:5b2f:76bf with SMTP id jr14-20020a0562142a8e00b004645b2f76bfmr19327775qvb.60.1654312041776;
        Fri, 03 Jun 2022 20:07:21 -0700 (PDT)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id n79-20020a374052000000b0069fc13ce23dsm6427474qka.110.2022.06.03.20.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 20:07:21 -0700 (PDT)
Date:   Sat, 4 Jun 2022 03:07:21 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH 1/2] rcu/kvfree: Remove useless monitor_todo flag
Message-ID: <YprMaXsopH+A5A6o@google.com>
References: <20220602080644.432156-1-urezki@gmail.com>
 <YplLK2BcTn2oM0hr@google.com>
 <YpnZpopF7dR3NILz@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpnZpopF7dR3NILz@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 03, 2022 at 11:51:34AM +0200, Uladzislau Rezki wrote:
> > On Thu, Jun 02, 2022 at 10:06:43AM +0200, Uladzislau Rezki (Sony) wrote:
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > 
> > > monitor_todo is not needed as the work struct already tracks
> > > if work is pending. Just use that to know if work is pending
> > > using schedule_delayed_work() helper.
> > > 
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 33 ++++++++++++++++-----------------
> > >  1 file changed, 16 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 222d59299a2a..fd16c0b46d9e 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3295,7 +3295,6 @@ struct kfree_rcu_cpu_work {
> > >   * @krw_arr: Array of batches of kfree_rcu() objects waiting for a grace period
> > >   * @lock: Synchronize access to this structure
> > >   * @monitor_work: Promote @head to @head_free after KFREE_DRAIN_JIFFIES
> > > - * @monitor_todo: Tracks whether a @monitor_work delayed work is pending
> > >   * @initialized: The @rcu_work fields have been initialized
> > >   * @count: Number of objects for which GP not started
> > >   * @bkvcache:
> > > @@ -3320,7 +3319,6 @@ struct kfree_rcu_cpu {
> > >  	struct kfree_rcu_cpu_work krw_arr[KFREE_N_BATCHES];
> > >  	raw_spinlock_t lock;
> > >  	struct delayed_work monitor_work;
> > > -	bool monitor_todo;
> > >  	bool initialized;
> > >  	int count;
> > >  
> > > @@ -3500,6 +3498,18 @@ static void kfree_rcu_work(struct work_struct *work)
> > >  	}
> > >  }
> > >  
> > > +static bool
> > > +need_offload_krc(struct kfree_rcu_cpu *krcp)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i = 0; i < FREE_N_CHANNELS; i++)
> > > +		if (krcp->bkvhead[i])
> > > +			return true;
> > > +
> > > +	return !!krcp->head;
> > > +}
> > 
> > Thanks for modifying my original patch to do this, and thanks for giving me
> > the attribution for the patch. This function is a nice addition.
> > 
> It was you who did it :) Actually the second patch depends on it therefore 
> i decided to upload it on behalf of you with slight modification hoping that
> you would not mind.

Yes I don't mind at all :) Thank you again for seeing it through!

> > For the patch in its entirety:
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> Thanks for the review!

Sure, any time. By the way I am out in the Carribean next week. I will catch
you all the week after.

Quick update on my side on the lazy CB stuff, I made some progress on using
the bypass lists for lazy CBs, its looking good and builds now. I fixed bug
in my code where idle loop was flushing lazy CBs on its way to idle.. I think
its probably O(workingdays) away from v2 posting assuming all goes well.

thanks,

 - Joel

