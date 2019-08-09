Return-Path: <SRS0=m0PJ=WF=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558AC433FF
	for <rcu@archiver.kernel.org>; Fri,  9 Aug 2019 18:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E19F20B7C
	for <rcu@archiver.kernel.org>; Fri,  9 Aug 2019 18:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kx6+mVWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437366AbfHISHZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 9 Aug 2019 14:07:25 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38424 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437351AbfHISHZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 9 Aug 2019 14:07:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id m12so6642766plt.5
        for <rcu@vger.kernel.org>; Fri, 09 Aug 2019 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A8u6xz/dyTLZLo8WFi4XrNKF86SJ1n86/Q6ZMmMptYg=;
        b=kx6+mVWSGuvNvigzmgMGMPha4xfouHeFaHvkOz5Dvpelc/XzhpByC2ohmY105RhaUD
         ogW2EsEmwHgW/EjYP3Th0/dAKd38FuBtl40pfyIWcTR4P8OVHl1b8Q4LqEX82ttM+ao8
         WdjLBGeXZx7iiBb66qNDPFVvOAuyZMMozh7mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A8u6xz/dyTLZLo8WFi4XrNKF86SJ1n86/Q6ZMmMptYg=;
        b=pjalnL3DZW2wc0WnhGvc0K7+i6wHnrH1IvC0LdbMpiNAWz9AjW8m8LB6/fTLqK1niT
         WnSYHtEzDyWFsB+lrxB8gqM8TMROOspbb6jDcqHuhfBF15KCEosZRVPVFwuX1NsnaGTN
         1K5Y1XRig1wj+r3PwMYkbTtX5qUivZw7WNrHDpx4aqewFm72nMUVU3k0TMhIK8Z5+zdh
         isS49wD6tpaZbDSXEMkDOv6vi9QoXUDdtZkUgzW6WXFVYtuxD9RrciMDte4bogzUmW8g
         KCa3OAH/lwgtfYEpWqNDporZAg24WTpAm5GIgmZqAeKnFxGnc35XTc1stLcZv/moI768
         cn4Q==
X-Gm-Message-State: APjAAAW3iaoc/ZSVxAQFbGF56sUFP8HbxUGw9cm8HD3NwVvFBIYKb2oU
        NfPTPaF+s9Wx57wZt3hDY22DVw==
X-Google-Smtp-Source: APXvYqxjkrJrCM6RBfjUMnnVbAQ+FHVIt6F9+T0vbrK/3lsscpNrNa2hSKqUfAlNfXuCOHz7WizI5Q==
X-Received: by 2002:a17:902:2b8a:: with SMTP id l10mr20203663plb.283.1565374043636;
        Fri, 09 Aug 2019 11:07:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y11sm107017072pfb.119.2019.08.09.11.07.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 11:07:22 -0700 (PDT)
Date:   Fri, 9 Aug 2019 14:07:21 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH RFC tip/core/rcu 14/14] rcu/nohz: Make multi_cpu_stop()
 enable tick on all online CPUs
Message-ID: <20190809180721.GA255533@google.com>
References: <20190804184159.GC28441@linux.ibm.com>
 <20190805080531.GH2349@hirez.programming.kicks-ass.net>
 <20190805145448.GI28441@linux.ibm.com>
 <20190805155024.GK2332@hirez.programming.kicks-ass.net>
 <20190805174800.GK28441@linux.ibm.com>
 <20190806180824.GA28448@linux.ibm.com>
 <20190807214131.GA15124@linux.ibm.com>
 <20190808203541.GA8160@linux.ibm.com>
 <20190808213012.GA28773@linux.ibm.com>
 <20190809165120.GA5668@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809165120.GA5668@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 09, 2019 at 09:51:20AM -0700, Paul E. McKenney wrote:
> > > > And of course I forgot to dump out the online CPUs, so I really had no
> > > > idea whether or not all the CPUs were accounted for.  I added tracing
> > > > to dump out the online CPUs at the beginning of __stop_cpus() and then
> > > > reworked it a few times to get the problem to happen in reasonable time.
> > > > Please see below for the resulting annotated trace.
> > > > 
> > > > I was primed to expect a lost IPI, perhaps due to yet another qemu bug,
> > > > but all the migration threads are running within about 2 milliseconds.
> > > > It is then almost two minutes(!) until the next trace message.
> > > > 
> > > > Looks like time to (very carefully!) instrument multi_cpu_stop().
> > > > 
> > > > Of course, if you have any ideas, please do not keep them a secret!
> > > 
> > > Functionally, multi_cpu_stop() is working fine, according to the trace
> > > below (search for a line beginning with TAB).  But somehow CPU 2 took
> > > almost three -minutes- to do one iteration of the loop.  The prime suspect
> > > in that loop is cpu_relax() due to the hypervisor having an opportunity
> > > to do something at that point.  The commentary below (again, search for
> > > a line beginning with TAB) gives my analysis.
> > > 
> > > Of course, if I am correct, it should be possible to catch cpu_relax()
> > > in the act.  That is the next step, give or take the Heisenbuggy nature
> > > of this beast.
> > > 
> > > Another thing for me to try is to run longer with !NO_HZ_FULL, just in
> > > case the earlier runs just got lucky.
> > > 
> > > Thoughts?
> > 
> > And it really can happen:
> > 
> > [ 1881.467922] migratio-33      4...1 1879530317us : stop_machine_yield: cpu_relax() took 756140 ms
> > 
> > The previous timestamp was 1123391100us, so the cpu_relax() is almost
> > exactly the full delay.
> > 
> > But another instance stalled for many minutes without a ten-second
> > cpu_relax().  So it is not just cpu_relax() causing trouble.  I could
> > rationalize that vCPU preemption being at fault...
> > 
> > And my diagnostic patch is below, just in case I am doing something
> > stupid with that.
> 
> I did a 12-hour run with the same configuration except for leaving out the
> "nohz_full=1-7" kernel parameter without problems (aside from the RCU CPU
> stall warnings due to the ftrace_dump() at the end of the run -- isn't
> there some way to clear the ftrace buffer without actually printing it?).

I think if tracing_reset_all_online_cpus() is exposed, then calling that with
the appropriate locks held can reset the ftrace ring buffer and clear the
trace. Steve, is there a better way?

thanks,

 - Joel

