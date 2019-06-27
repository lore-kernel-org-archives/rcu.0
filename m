Return-Path: <SRS0=YNYv=U2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B6EC48BD7
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EBD2064A
	for <rcu@archiver.kernel.org>; Thu, 27 Jun 2019 15:30:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PbjnU92s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0Paf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 27 Jun 2019 11:30:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43518 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfF0Pae (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 27 Jun 2019 11:30:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so1401778pfg.10
        for <rcu@vger.kernel.org>; Thu, 27 Jun 2019 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dL1z1+AELHrh/gFhMzGmcU7K2074TkwMyS+CqFQfsrg=;
        b=PbjnU92skcAu3krFTv0tz4Bn/qHYOkOQyOaNqWBxHUaoTLizBp6a38wZ+SNCv6kIDR
         MS5ToE79LqmipepGYVpfJtTc2olZeIUV3pcM7v4CFbmJw6YUqOovl4G7DcQHpA/U4L1b
         Ucvu3C08qlg/RisaZcWekyHL1A053q4Wo39WQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dL1z1+AELHrh/gFhMzGmcU7K2074TkwMyS+CqFQfsrg=;
        b=UVVPymfU6ARYvr1uyS634QaXrsG0h+WoSpg4GBDQjSoapBCh8RGw/royadqbq4qw0w
         4YyAaQjk+vfhsMazfynvfdwc1hQCzrCH+QlI8cTs8LXk/8NbWQ0BSTdLlnyCzBTHGJqx
         bm2wgFM1wOowzoKTQojQksPwxEfFbgCHh14dnGl448ZCKy+oesD3WnTzsi8GkA/UZ/SC
         cWDRZEjME8KLuYuQISgGAgAyJSuaemvs5XtEomzcBL979UyhoUIEvouptOJCeOL43lMh
         40QVwL8VQABbDs7l0c2kGxidO03HNAOuVFmjS8MWeYo33qb0uZwhkAQ5oYCKLS2o0J1+
         6TRQ==
X-Gm-Message-State: APjAAAV11pQhbuTAFE/nDI3miNXx5Qgxryb4VFBNs0XDMnmSCTjisp3D
        YAtyKXM5IjFYUl1yyf+Xo94QlQ==
X-Google-Smtp-Source: APXvYqz4kMtGKa6T57rblUMwcN2vFrLFaAaBcvdL5NP7LnGPX5K56OCL4uwnOYCa7fSaTMvd+eyQEw==
X-Received: by 2002:a17:90a:9b08:: with SMTP id f8mr6806111pjp.103.1561649434243;
        Thu, 27 Jun 2019 08:30:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s66sm2733414pgs.39.2019.06.27.08.30.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 08:30:33 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:30:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190627153031.GA249127@google.com>
References: <20190626135447.y24mvfuid5fifwjc@linutronix.de>
 <20190626162558.GY26519@linux.ibm.com>
 <20190627142436.GD215968@google.com>
 <20190627103455.01014276@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627103455.01014276@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 27, 2019 at 10:34:55AM -0400, Steven Rostedt wrote:
> On Thu, 27 Jun 2019 10:24:36 -0400
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > > What am I missing here?  
> > 
> > This issue I think is
> > 
> > (in normal process context)
> > spin_lock_irqsave(rq_lock); // which disables both preemption and interrupt
> > 			   // but this was done in normal process context,
> > 			   // not from IRQ handler
> > rcu_read_lock();
> >           <---------- IPI comes in and sets exp_hint
> 
> How would an IPI come in here with interrupts disabled?
> 
> -- Steve

This is true, could it be rcu_read_unlock_special() got called for some
*other* reason other than the IPI then?

Per Sebastian's stack trace of the recursive lock scenario, it is happening
during cpu_acct_charge() which is called with the rq_lock held. 

The only other reasons I know off to call rcu_read_unlock_special() are if
1. the tick indicated that the CPU has to report a QS
2. an IPI in the middle of the reader section for expedited GPs
3. preemption in the middle of a preemptible RCU reader section

1. and 2. are not possible because interrupts are disabled, that's why the
wakeup_softirq even happened.
3. is not possible because we are holding rq_lock in the RCU reader section.

So I am at a bit of a loss how this can happen :-(

Spurious call to rcu_read_unlock_special() may be when it should not have
been called?

thanks,

- Joel
