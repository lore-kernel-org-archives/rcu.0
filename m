Return-Path: <SRS0=ZUOr=XB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9C0C43331
	for <rcu@archiver.kernel.org>; Fri,  6 Sep 2019 17:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2328D20838
	for <rcu@archiver.kernel.org>; Fri,  6 Sep 2019 17:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="g+kiLp3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388746AbfIFR0q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:26:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34347 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbfIFR0p (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 6 Sep 2019 13:26:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id r12so4963417pfh.1
        for <rcu@vger.kernel.org>; Fri, 06 Sep 2019 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tjTFPsf2DNxsjE2a8i9G461OudiUTTXZgFUmeTRYsOE=;
        b=g+kiLp3az9CyjTc6pxcyGvJcUmtfHu6/Pb78/cJdv6XEo9ckaguTCF/9/EagFdvnCo
         jPUDiZuxJze1xG/wj0Xrk0SxtxbYayWzf2xgBvWqusIPD8xk2NMphiwZmc1tkOkghM4r
         JgbY4nksDcpfoiJWmk9B7Sx0dn15waEhL5iHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjTFPsf2DNxsjE2a8i9G461OudiUTTXZgFUmeTRYsOE=;
        b=htL7uTY0khYPvNrAT9I1IG1t58t4f0kI1YueMMUm55PwKdPy6PR9tZ0NIR2JO1swU5
         HejTQEC8quELmgN6yCOJgDZDHDdNp0MaWTcnVafJPVsNbYeSCKnAN3wwBbEjLue3YlkA
         Q05+2n1dHn957ytS0eDcA+3QkFhPzfz6itoKAE5r8sI8FVrmajER7dsbdODRlpYKRjdq
         9M/Ajed03l3MGTEJYSvqy1O7wE00gh9gjEQT3D+hEBkEEdTzOJcvC0iJW+u2SUdkXJAU
         YGHrSIsifY75PVrO2CDrLaXcH46G5BCCUplZKiYerYqVuvvIkvzfhAMcKJ+F642li7ca
         s09w==
X-Gm-Message-State: APjAAAWXIT0bB8zbz9zAZR0scc5m3gwtkR0ojnGMz1ZiYDWh7l1hYsnp
        uJ9RtOERjSlwbbtnfmXkP7Y3Jg==
X-Google-Smtp-Source: APXvYqxUjh8vYhfUkzzHghKc6iGyrAQB8idr1czO4uE7him1Zaxi0rWcC03ts8w3NLYgI4Sk7bXGFQ==
X-Received: by 2002:a62:52d0:: with SMTP id g199mr12269924pfb.120.1567790804635;
        Fri, 06 Sep 2019 10:26:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a12sm4974891pgv.48.2019.09.06.10.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 10:26:43 -0700 (PDT)
Date:   Fri, 6 Sep 2019 13:26:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH -rcu dev 1/2] Revert b8c17e6664c4 ("rcu: Maintain special
 bits at bottom of ->dynticks counter")
Message-ID: <20190906172642.GB40876@google.com>
References: <20190904135420.GB240514@google.com>
 <20190904231308.GB4125@linux.ibm.com>
 <20190905153620.GG26466@google.com>
 <20190905164329.GT4125@linux.ibm.com>
 <20190906000137.GA224720@google.com>
 <20190906150806.GA11355@google.com>
 <20190906152144.GF4051@linux.ibm.com>
 <20190906152753.GA18734@linux.ibm.com>
 <20190906165751.GA40876@google.com>
 <20190906171646.GI4051@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906171646.GI4051@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 06, 2019 at 10:16:47AM -0700, Paul E. McKenney wrote:
> On Fri, Sep 06, 2019 at 12:57:51PM -0400, Joel Fernandes wrote:
> > On Fri, Sep 06, 2019 at 08:27:53AM -0700, Paul E. McKenney wrote:
> > > On Fri, Sep 06, 2019 at 08:21:44AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Sep 06, 2019 at 11:08:06AM -0400, Joel Fernandes wrote:
> > > > > On Thu, Sep 05, 2019 at 08:01:37PM -0400, Joel Fernandes wrote:
> > > > > [snip] 
> > > > > > > > > @@ -3004,7 +3007,7 @@ static int rcu_pending(void)
> > > > > > > > >  		return 0;
> > > > > > > > >  
> > > > > > > > >  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> > > > > > > > > -	if (rdp->core_needs_qs && !rdp->cpu_no_qs.b.norm)
> > > > > > > > > +	if (READ_ONCE(rdp->core_needs_qs) && !rdp->cpu_no_qs.b.norm)
> > > > > > > > >  		return 1;
> > > > > > > > >  
> > > > > > > > >  	/* Does this CPU have callbacks ready to invoke? */
> > > > > > > > > @@ -3244,7 +3247,6 @@ int rcutree_prepare_cpu(unsigned int cpu)
> > > > > > > > >  	rdp->gp_seq = rnp->gp_seq;
> > > > > > > > >  	rdp->gp_seq_needed = rnp->gp_seq;
> > > > > > > > >  	rdp->cpu_no_qs.b.norm = true;
> > > > > > > > > -	rdp->core_needs_qs = false;
> > > > > > > > 
> > > > > > > > How about calling the new hint-clearing function here as well? Just for
> > > > > > > > robustness and consistency purposes?
> > > > > > > 
> > > > > > > This and the next function are both called during a CPU-hotplug online
> > > > > > > operation, so there is little robustness or consistency to be had by
> > > > > > > doing it twice.
> > > > > > 
> > > > > > Ok, sorry I missed you are clearing it below in the next function. That's
> > > > > > fine with me.
> > > > > > 
> > > > > > This patch looks good to me and I am Ok with merging of these changes into
> > > > > > the original patch with my authorship as you mentioned. Or if you wanted to
> > > > > > be author, that's fine too :)
> > > > > 
> > > > > Paul, does it make sense to clear these urgency hints in rcu_qs() as well?
> > > > > After all, we are clearing atleast one urgency hint there: the
> > > > > rcu_read_unlock_special::need_qs bit.
> > 
> > Makes sense.
> > 
> > > > We certainly don't want to turn off the scheduling-clock interrupt until
> > > > after the quiescent state has been reported to the RCU core.  And it might
> > > > still be useful to have a heavy quiescent state because the grace-period
> > > > kthread can detect that.  Just in case the CPU that just called rcu_qs()
> > > > is slow about actually reporting that quiescent state to the RCU core.
> > > 
> > > Hmmm...  Should ->need_qs ever be cleared from FQS to begin with?
> > 
> > I did not see the FQS loop clearing ->need_qs in the rcu_read_unlock_special
> > union after looking for a few minutes. Could you clarify which path this?
> > 
> > Or do you mean ->core_needs_qs? If so, I feel the FQS loop should clear it as
> > I think your patch does, since the FQS loop is essentially doing heavy-weight
> > RCU core processing right?
> > 
> > Also, where does FQS loop clear rdp.cpu_no_qs? Shouldn't it clear that as
> > well for the dyntick-idle CPUs?
> 
> Synchronization?

Didn't follow. Probably I am asking silly questions. There's too many hints
so it is confusing. I will trace this out later and study it more.

Doing by best,  ;-)

thanks,

 - Joel

