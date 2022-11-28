Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB2EC43217
	for <rcu@archiver.kernel.org>; Mon, 28 Nov 2022 14:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbiK1Og1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiK1OgX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 28 Nov 2022 09:36:23 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519281DF23
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 06:36:22 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a16so10235490pfg.4
        for <rcu@vger.kernel.org>; Mon, 28 Nov 2022 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YH7Ee3sDR7jtaerGz3FtSRejwiZHYsWLW/uJGNQh6OE=;
        b=DnmoiD9IPUOjRygPiSRXIgGi++wZ18JAtu6s2vhs2di1Ygul/gnPDIQ8kYQLLaahps
         4T4pBOdPlXx2rybrQQuhlzmquM0+ga0bfD+L9sXr8gcFSsmA7KAv644Jn5gPAz0HMmmR
         xIO9CvADp0mzOO89hIcekSV585bgJBHcRY4nKEdBPMb4H9plEPZV27u+eueKCesnavzq
         2gDBIramFROd3nI4s0ireMfGPh5nhvlJd/4uprv79KJSK6KFO6OgfjOki4roZZQ/9bNX
         zv38iupHQe/4fvA0B9h5WErlnak3LVS+ppibKA3gvpOx9BooxUmE9KvMYD8uVfQELthT
         0ajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH7Ee3sDR7jtaerGz3FtSRejwiZHYsWLW/uJGNQh6OE=;
        b=i4KHovrJarA37ZtlLQJqbN7JBUUeuu1BEa92GVXBj0Lgw2QRUcAocCV8rcYv6AafQE
         CzgkJiKnw4PaUa5fCGn6/J6wfsVCNq0rPseBRdHNaUnUeCdkzP3hxT0dt2+qus5xRmBK
         0jH/pazhWGB8H7nzJlihfjLSgaeHiWjpNG0g4uxq9K56cb2v2cMncU/vd0J6M1ZtFsaa
         cO0MWA4qQVgpAC/0poxBTF13hWpWIXZ+vwbeY+8srsRSJHz1K0UM45CLI7dL1/g+4Cd9
         jSgsmDDBk8rb0U4dBasLv6G0p3UDfWbUwJOLQox98aXhLCzpOyowtFo2HUInI5L8fEsm
         Ig6w==
X-Gm-Message-State: ANoB5pkfHUIA9frgAy2cpTdHuIQEfdEKuV3yAkfmQ4eqaMg1ipEVOMAv
        wuccDIHELzjD54dVFNoBOw==
X-Google-Smtp-Source: AA0mqf6G2+myfuRVkWA8y/J+M/J8krUtx9glhZcSclfRZ20PpL17z99Cuyh8eEll6GbqW0Lcixpi6A==
X-Received: by 2002:a05:6a00:4308:b0:575:649c:e9e3 with SMTP id cb8-20020a056a00430800b00575649ce9e3mr499073pfb.48.1669646181800;
        Mon, 28 Nov 2022 06:36:21 -0800 (PST)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902680800b0018862bb3976sm8851065plk.308.2022.11.28.06.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 06:36:21 -0800 (PST)
Date:   Mon, 28 Nov 2022 22:36:15 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>
Cc:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
Message-ID: <Y4THX7G73KbIFi5z@piliu.users.ipa.redhat.com>
References: <20221128082816.28518-1-kernelfans@gmail.com>
 <20221128082816.28518-3-kernelfans@gmail.com>
 <PH0PR11MB5880585607E73B0228D77946DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5880585607E73B0228D77946DA139@PH0PR11MB5880.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 28, 2022 at 09:20:18AM +0000, Zhang, Qiang1 wrote:
> >Subject: [PATCH 2/3] srcu: protect against concurrent srcu_gp_end()
> >
> >At present, the code chunk "Transition to big if needed" is out of the
> >lock srcu_cb_mutex, which allows the following scene:
> >
> >    srcu_gp_end() on cpu1                srcu_gp_end() on cpu2
> >
> >    init_srcu_struct_nodes()
> >    ^^  scheduled out in the middle
> >                                         init_srcu_struct_nodes()
> >                                         ^^ overwrite the context set up by cpu1
> 
> Hi Pingfan
> 
> This scenario shouldn't happen.
> The srcu_gp_end() is invoked only in process_srcu() workfn.
> for the same ssp->work, workqueue can guaranteed that the 
> process_srcu() workfn is executed serially. (view __queue_work () details)
> 

How about this:

In process_one_work()

  set_work_pool_and_clear_pending(work, pool->id);
                                               -----> another ssp->work
					       can be queued, which can raise the
					       scenario mentioned above
					       
  worker->current_func(work);


Thanks,

	Pingfan
> 
> Thanks
> Zqiang
> 
> 
> >
> >Squashing out the race window by putting the code chunk under the
> >protection of srcu_cb_mutex.
> >
> >Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> >Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> >Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >Cc: Frederic Weisbecker <frederic@kernel.org>
> >Cc: Josh Triplett <josh@joshtriplett.org>
> >Cc: Steven Rostedt <rostedt@goodmis.org>
> >Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >Cc: "Zhang, Qiang1" <qiang1.zhang@intel.com>
> >To: rcu@vger.kernel.org
> >---
> > kernel/rcu/srcutree.c | 14 +++++++-------
> > 1 file changed, 7 insertions(+), 7 deletions(-)
> >
> >diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> >index fe0759d89c2d..281cd69fe804 100644
> >--- a/kernel/rcu/srcutree.c
> >+++ b/kernel/rcu/srcutree.c
> >@@ -811,6 +811,13 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > 			spin_unlock_irqrestore_rcu_node(sdp, flags);
> > 		}
> > 
> >+	/* Transition to big if needed. */
> >+	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> >+		if (ss_state == SRCU_SIZE_ALLOC)
> >+			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >+		else
> >+			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
> >+	}
> > 	/* Callback initiation done, allow grace periods after next. */
> > 	mutex_unlock(&ssp->srcu_cb_mutex);
> > 
> >@@ -826,13 +833,6 @@ static void srcu_gp_end(struct srcu_struct *ssp)
> > 		spin_unlock_irq_rcu_node(ssp);
> > 	}
> > 
> >-	/* Transition to big if needed. */
> >-	if (ss_state != SRCU_SIZE_SMALL && ss_state != SRCU_SIZE_BIG) {
> >-		if (ss_state == SRCU_SIZE_ALLOC)
> >-			init_srcu_struct_nodes(ssp, GFP_KERNEL);
> >-		else
> >-			smp_store_release(&ssp->srcu_size_state, ss_state + 1);
> >-	}
> > }
> > 
> > /*
> >-- 
> >2.31.1
> >
