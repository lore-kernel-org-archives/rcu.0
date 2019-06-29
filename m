Return-Path: <SRS0=e08d=U4=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1C5C5B57A
	for <rcu@archiver.kernel.org>; Sat, 29 Jun 2019 18:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9721F21726
	for <rcu@archiver.kernel.org>; Sat, 29 Jun 2019 18:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vc8I/IQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfF2SVl (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 29 Jun 2019 14:21:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfF2SVk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 29 Jun 2019 14:21:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so9506944wrr.4
        for <rcu@vger.kernel.org>; Sat, 29 Jun 2019 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cOuGUeuvXYYHOBYHD3qLjLapejxLIFLy8lgJ6YZYaC8=;
        b=Vc8I/IQcDMsgrM97xjkT289KsEWPVOydDdA3LMxpz53y7k7on8Qe6YP6x5a7Q7s7DQ
         fq8sn95P7OsHdMkHO37MR3IxrqSRdBOqPAdW2nM+YOzEVSewvtbtfvntUb9b9D6nyUKi
         4+mPOafSRzFlPvK9UGLi71zUDQPc+q+jXNjlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cOuGUeuvXYYHOBYHD3qLjLapejxLIFLy8lgJ6YZYaC8=;
        b=CYI0kyVFoesmYklQZXCorThOqS1tc7w2Dt1yRfkflzic6Y55lQtJAMtM06pQhTrlTx
         n0/x6GdPSVvfAg8XQrjGnUD2DJbkgivX8jCXOMi5EOohaMzgW5bVq1Vfr2ds4f4hfgUY
         yiaSsdSY3MRPjYd+triXGL22CqgNLWB4sD6aFClUkSvPT/ptSv+3LJhfYHTn3XFFlBt6
         jWWIqpKqmTb6gtH+lgyao/j6nBIv2FURowdcQRdQ9c7lBpXDXckkoucP4Dhjo+FDPip+
         Koachc7VX9TSw8HJkv5hSxijFqNzYPPEiLbVTsRsMI5DzTcnMRveDnbv1IDYwxK/bO/s
         3ncw==
X-Gm-Message-State: APjAAAULh2BNVmvX08FvFojiXXK3q04v/W7RCmGaqUEUZ7BvYAP0euxc
        KeFVKvR5PUWTOvD0hx1Skog8Jw==
X-Google-Smtp-Source: APXvYqyDOqRN53A/pUdk7Ix1TM1I+/1F4ot46+1LL5m576jRJeOlLgdjBFxQpToalRTFnuuvM3wY0w==
X-Received: by 2002:adf:e384:: with SMTP id e4mr2439057wrm.308.1561832498351;
        Sat, 29 Jun 2019 11:21:38 -0700 (PDT)
Received: from andrea ([93.90.167.233])
        by smtp.gmail.com with ESMTPSA id h84sm6945311wmf.43.2019.06.29.11.21.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Jun 2019 11:21:37 -0700 (PDT)
Date:   Sat, 29 Jun 2019 20:21:32 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190629182132.GA5666@andrea>
References: <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628104045.GA8394@X58A-UD3R>
 <20190628114411.5d9ab351@gandalf.local.home>
 <20190629151236.GA7862@andrea>
 <20190629165533.GA3112@linux.ibm.com>
 <20190629180910.GA3399@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629180910.GA3399@andrea>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

> Remark: we do have code which (while acknowledging that "interrupts are
> synchronization points") doesn't quite seem to "believe it", c.f., e.g.,
> kernel/sched/membarrier.c:ipi_mb().  So, I guess the follow-up question
> would be "Would we better be (more) paranoid? ..."

should have been "IPIs are serializing" (so all a different "order"...)

  Andrea
