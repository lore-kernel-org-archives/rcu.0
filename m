Return-Path: <SRS0=HKaF=VC=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4315C46499
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737C52133F
	for <rcu@archiver.kernel.org>; Fri,  5 Jul 2019 20:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="aL5g/htZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfGEUAH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 5 Jul 2019 16:00:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46218 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfGEUAH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 5 Jul 2019 16:00:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id c2so3470357plz.13
        for <rcu@vger.kernel.org>; Fri, 05 Jul 2019 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OPAXAnhkT4uZSctQZWV1C46mb9I9NT/kztcwNDiggR4=;
        b=aL5g/htZRlrExROSvMSyc7IoQawmcZBzqQ1QXr+jI6w+an8O5JeLOtzhgx0liosdmZ
         ZqMaJgfyMR7GUq+OQwh9jmlw5EBkSG3WmUMVQ8vXqg9U/CleOoQk/r0/qXq+tXDQx1zJ
         c40N8zuZhbkyznqguXC2dtjemBs0gvTgNR60M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OPAXAnhkT4uZSctQZWV1C46mb9I9NT/kztcwNDiggR4=;
        b=MlDMySHOn0hzg5KyEAoIC7ckU1MZC7p49YZ7XMaUCt3AXlCfjluJw3e2h+vI4ac8RA
         5BWbBA8efmoJKSP/LWdM+WOGe/eyjpx/gvn1p7zRUPOAJ8dx/avR8T2EG4uSQWe5AcxW
         VlDq0aPG+Cs+9XLqE043qNB26Uj1UO8U6XgiqXcNR7JXczULhY2R1QGA+M93XnME0qcv
         m07+JhbApZKofRviZbDNGM/09Ayu80AMMBMfTe5mIrocXldlpBDIAxhBaULqXzCVSxry
         zc3FBmfI1CZ70Y3c0CjDk5OrmcPXRf3xlB70JptXimPg0LKgyA/aL4/Gtwyr9XvFY+Yv
         GkTQ==
X-Gm-Message-State: APjAAAWU6ckTTGmmSc+T4W/ZrCp8DFm+vrY6TI45icpvbgTu+wLPoO1D
        iHYHw4XOtmlVlKRQ5wLr1SOGMQ==
X-Google-Smtp-Source: APXvYqxW6nCn29Nvym1Fo35HLgteQzwq1tpxscj8RCQfX4kSwdj2jd1uyXxG1H60u35FxFcc89ZY+w==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr7127331pll.298.1562356806046;
        Fri, 05 Jul 2019 13:00:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d16sm3195281pgb.4.2019.07.05.13.00.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 13:00:05 -0700 (PDT)
Date:   Fri, 5 Jul 2019 16:00:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        kernel-team@android.com
Subject: Re: [PATCH] rcuperf: Make rcuperf kernel test more robust for
 !expedited mode
Message-ID: <20190705200003.GB134527@google.com>
References: <20190704043431.208689-1-joel@joelfernandes.org>
 <20190704174044.GK26519@linux.ibm.com>
 <20190705035231.GA31088@X58A-UD3R>
 <20190705122450.GA82532@google.com>
 <20190705150932.GO26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705150932.GO26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jul 05, 2019 at 08:09:32AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 05, 2019 at 08:24:50AM -0400, Joel Fernandes wrote:
> > On Fri, Jul 05, 2019 at 12:52:31PM +0900, Byungchul Park wrote:
> > > On Thu, Jul 04, 2019 at 10:40:44AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Jul 04, 2019 at 12:34:30AM -0400, Joel Fernandes (Google) wrote:
> > > > > It is possible that the rcuperf kernel test runs concurrently with init
> > > > > starting up.  During this time, the system is running all grace periods
> > > > > as expedited.  However, rcuperf can also be run for normal GP tests.
> > > > > Right now, it depends on a holdoff time before starting the test to
> > > > > ensure grace periods start later. This works fine with the default
> > > > > holdoff time however it is not robust in situations where init takes
> > > > > greater than the holdoff time to finish running. Or, as in my case:
> > > > > 
> > > > > I modified the rcuperf test locally to also run a thread that did
> > > > > preempt disable/enable in a loop. This had the effect of slowing down
> > > > > init. The end result was that the "batches:" counter in rcuperf was 0
> > > > > causing a division by 0 error in the results. This counter was 0 because
> > > > > only expedited GPs seem to happen, not normal ones which led to the
> > > > > rcu_state.gp_seq counter remaining constant across grace periods which
> > > > > unexpectedly happen to be expedited. The system was running expedited
> > > > > RCU all the time because rcu_unexpedited_gp() would not have run yet
> > > > > from init.  In other words, the test would concurrently with init
> > > > > booting in expedited GP mode.
> > > > > 
> > > > > To fix this properly, let us check if system_state if SYSTEM_RUNNING
> > > > > is set before starting the test. The system_state approximately aligns
> > > 
> > > Just minor typo..
> > > 
> > > To fix this properly, let us check if system_state if SYSTEM_RUNNING
> > > is set before starting the test. ...
> > > 
> > > Should be
> > > 
> > > To fix this properly, let us check if system_state is set to
> > > SYSTEM_RUNNING before starting the test. ...
> > 
> > That's a fair point. I wonder if Paul already fixed it up in his tree,
> > however I am happy to resend if he hasn't. Paul, how would you like to handle
> > this commit log nit?
> > 
> > it is just 'if ..' to 'is SYSTEM_RUNNING'
> 
> It now reads as follows:
> 
> 	To fix this properly, this commit waits until system_state is
> 	set to SYSTEM_RUNNING before starting the test.  This change is
> 	made just before kernel_init() invokes rcu_end_inkernel_boot(),
> 	and this latter is what turns off boot-time expediting of RCU
> 	grace periods.

Ok, looks good to me, thanks.

And for below patch,

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>


> I dropped the last paragraph about late_initcall().  And I suspect that
> the last clause from rcu_gp_is_expedited() can be dropped:
> 
> bool rcu_gp_is_expedited(void)
> {
> 	return rcu_expedited || atomic_read(&rcu_expedited_nesting) ||
> 	       rcu_scheduler_active == RCU_SCHEDULER_INIT;
> }
> 
> This is because rcu_expedited_nesting is initialized to 1, and is
> decremented in rcu_end_inkernel_boot(), which is called long after
> rcu_scheduler_active has been set to RCU_SCHEDULER_RUNNING, which
> happens at core_initcall() time.  So if the last clause says "true",
> so does the second-to-last clause.
> 
> The similar check in rcu_gp_is_normal() is still need, however, to allow
> the power-management subsystem to invoke synchronize_rcu() just after
> the scheduler has been initialized, but before RCU is aware of this.
> 
> So, how about the commit shown below?
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 1f7e72efe3c761c2b34da7b59e01ad69c657db10
> Author: Paul E. McKenney <paulmck@linux.ibm.com>
> Date:   Fri Jul 5 08:05:10 2019 -0700
> 
>     rcu: Remove redundant "if" condition from rcu_gp_is_expedited()
>     
>     Because rcu_expedited_nesting is initialized to 1 and not decremented
>     until just before init is spawned, rcu_expedited_nesting is guaranteed
>     to be non-zero whenever rcu_scheduler_active == RCU_SCHEDULER_INIT.
>     This commit therefore removes this redundant "if" equality test.
>     
>     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 249517058b13..64e9cc8609e7 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -136,8 +136,7 @@ static atomic_t rcu_expedited_nesting = ATOMIC_INIT(1);
>   */
>  bool rcu_gp_is_expedited(void)
>  {
> -	return rcu_expedited || atomic_read(&rcu_expedited_nesting) ||
> -	       rcu_scheduler_active == RCU_SCHEDULER_INIT;
> +	return rcu_expedited || atomic_read(&rcu_expedited_nesting);
>  }
>  EXPORT_SYMBOL_GPL(rcu_gp_is_expedited);
>  
> 
