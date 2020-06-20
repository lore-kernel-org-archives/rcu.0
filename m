Return-Path: <SRS0=jbur=AB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BF9C433E0
	for <rcu@archiver.kernel.org>; Sat, 20 Jun 2020 05:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BCF222D5
	for <rcu@archiver.kernel.org>; Sat, 20 Jun 2020 05:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="h89TZJi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgFTFgK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 20 Jun 2020 01:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFTFgK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 20 Jun 2020 01:36:10 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B48C06174E
        for <rcu@vger.kernel.org>; Fri, 19 Jun 2020 22:36:10 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p15so5538768qvr.9
        for <rcu@vger.kernel.org>; Fri, 19 Jun 2020 22:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sEtHXpr5gWn4D+rk7bJwwM7YLWZx4Y1kJ+VFyfCOfQo=;
        b=h89TZJi2mtNjFsKvYVF/Y88N4S1FYwRBoUNMSy36/lHVaVyZSjHyvfZj7V/PXAmD8T
         CIgu27LDPVaCg83M9FznxHf7OfBZAQhxXlNhRviU8PDOsGp3VTeWoCPrMtuVSngA+aQn
         Zdtklu24C3Vo2/iaB0TyyGFolt7eqYEmvPGTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sEtHXpr5gWn4D+rk7bJwwM7YLWZx4Y1kJ+VFyfCOfQo=;
        b=BeumKhhPMcA6gIQimaOMn9w9wIiIwQ1HLoxd0Eay9LKA7X1LqpY1zAjCNpW5FziGyM
         8oeUNscV0fZ2Nuw9Hh6szsFBPBm8QJOIpinrCiFLdXYrgnWYdHFDrUhWFOxPGykOrd08
         3Do1uS42Ojoy0lrxAIKTpAdH2a5cSZugPCmdiJe3J0ayhst5NOZzoRVI6ihEhxFeLH+2
         +Af5TlxHZOnXtTS+8eM+oodMkGi6VaW+dSZtakxuIB44jFjNrUagMySctEO0YGjNbInB
         MMetGCzy+NX4UCr/tJaVXOftD/c0kvzcXZ9N7vNrRqHn4MQVHCrb5Bfeny3xbQDRh7Dm
         AKAA==
X-Gm-Message-State: AOAM5312V0fiToSyL8Rm9FhLgXj138Q1nFvQgjtEqfsqaapApvXvWg7K
        7LA4C4XIGjd3HWYTNKqFtY7N0w==
X-Google-Smtp-Source: ABdhPJzD+qJ0yPoU9Oob8CVa/M41F6w/ldkBLr8txj8FAcpcC5wcV3yq2HBcHnMk/OXG0rOdqAg6yQ==
X-Received: by 2002:ad4:4c51:: with SMTP id cs17mr12205934qvb.205.1592631368970;
        Fri, 19 Jun 2020 22:36:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o12sm918781qtl.48.2020.06.19.22.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 22:36:08 -0700 (PDT)
Date:   Sat, 20 Jun 2020 01:36:08 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 3/3] rcu/trace: Add name of the source for gp_seq to
 prevent confusion
Message-ID: <20200620053608.GC9005@google.com>
References: <20200619013641.63453-1-joel@joelfernandes.org>
 <20200619013641.63453-3-joel@joelfernandes.org>
 <20200619020718.GA74764@google.com>
 <20200619174001.GL2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619174001.GL2723@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jun 19, 2020 at 10:40:01AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 18, 2020 at 10:07:18PM -0400, Joel Fernandes wrote:
> > On Thu, Jun 18, 2020 at 09:36:41PM -0400, Joel Fernandes (Google) wrote:
> > [...]
> > > @@ -2019,7 +2019,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
> > >  			cond_resched_tasks_rcu_qs();
> > >  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > >  			WARN_ON(signal_pending(current));
> > > -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> > > +			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
> > >  					       TPS("reqwaitsig"));
> > >  		}
> > >  
> > > @@ -2263,7 +2263,7 @@ int rcutree_dying_cpu(unsigned int cpu)
> > >  		return 0;
> > >  
> > >  	blkd = !!(rnp->qsmask & rdp->grpmask);
> > > -	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> > > +	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), READ_ONCE(rnp->gp_seq),
> > 
> > This should be: TPS("rnp")  :-(
> > 
> > Happy to fix it up and resend if you'd like. Thanks!
> 
> I queued and pushed 1/2 and 2/2.

Thanks!

> but again, I am still not at all
> convinced by 3/3.  If you want to make RCU trace output human
> readable, post-processing will be needed.

Or I could post-process the code before building it since the pattern seems
easy to parse ;-)

 - Joel

