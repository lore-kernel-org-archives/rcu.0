Return-Path: <SRS0=wSob=VD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981CEC0650E
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D1720989
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 12:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="WviQ2C11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfGFMSL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Jul 2019 08:18:11 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:43876 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfGFMSK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 6 Jul 2019 08:18:10 -0400
Received: by mail-pf1-f179.google.com with SMTP id i189so5403373pfg.10
        for <rcu@vger.kernel.org>; Sat, 06 Jul 2019 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ekzw620iVN9hopuCq9HDJezZD1Eq5z77ZDpcBE0Rd5M=;
        b=WviQ2C11mGiDHMb3WHn9M0dOFBDxFLzQLdA6Z875Jb1IzBXV4CsZW1Cf2m2tZ9QGwl
         7wwsHE+gA3T37RLpRdVSCYjd1boBbjy5a4ABH5QS609GbZPhcee4i00ebpe+JdDMTdm/
         jfO0s6hjs27HfeFqr0533Tkc2hdPyf5ECSXlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ekzw620iVN9hopuCq9HDJezZD1Eq5z77ZDpcBE0Rd5M=;
        b=UH1eNi/u17G7bx/LjEaycohiuIC4xZNVNSK0wUtUqyGEe/g84sNYl/C1DusQFrOINQ
         1t5Mutas3fgQsRRHGxgXDVJ2Ee+lQ220xboOcUbJQ6yuVeZKoLxJj2Dw5nnnn2UNWgDV
         BMFvZhNIhJDnR+dh3pgov2Rmi0Pq/Jx2jQVtLs/VpRHX/3dTqtJAKIkCahYwaqpaEBdA
         iK0fS0TdOLDopMW+khzHfij8AqA55nl2vLWgNd0Qa8E/SSzjEUsdh8S0uVKC5MkKwZjF
         sQX//KG96BEIvNS3JKAEmNZJsRZMjhNgYiIah62h2amjFEx56zD4ZfYJLyZtbiFoT3yP
         DGFQ==
X-Gm-Message-State: APjAAAU6wCfF9rbdvCb96AImZio/uOrbaVT6zrCoLl2H+aX4g7WnHHfC
        TzcMeROKKcLacVRds0zfT9FJHA==
X-Google-Smtp-Source: APXvYqzjFh9diEY7yWc1z7dToSeCs22Bkfm6L1WawHSEArKaRL18p1kqIDR6ZF+ouOakQpMa3lrLZg==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr10666325pgd.249.1562415489976;
        Sat, 06 Jul 2019 05:18:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a5sm10407147pjv.21.2019.07.06.05.18.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 05:18:09 -0700 (PDT)
Date:   Sat, 6 Jul 2019 08:18:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: [attn: Steve] Re: Normal RCU grace period can be stalled for long
 because need-resched flags not set?
Message-ID: <20190706121807.GB200542@google.com>
References: <20190704002130.GA68801@google.com>
 <20190704003213.GA218086@google.com>
 <20190704005009.GZ26519@linux.ibm.com>
 <20190704032454.GA259593@google.com>
 <20190704171315.GG26519@linux.ibm.com>
 <20190704185055.GA12919@google.com>
 <20190704221702.GL26519@linux.ibm.com>
 <20190705000830.GB12919@google.com>
 <20190705013045.GA141984@google.com>
 <20190705015726.GN26519@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705015726.GN26519@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 04, 2019 at 06:57:26PM -0700, Paul E. McKenney wrote:
[snip]
> > I tried again, if I make sure the ftrace dump absolutely does not happen
> > until the preempt-disable loop is done marked by a new global variable as you
> > pointed, then it fixes it. And I don't need any set_preempt_need_resched() or
> > rcu_perf_shutdown_wait() in my preempt disable loop to fix it. Basically the
> > below diff. However, it still does answer the question about why a parallel
> > ftrace dump running in parallel with the still running preempt-disable loop
> > caused some writers to have multi-second grace periods. I think something
> > during the ftrace dump prevented the tick path of that loop CPU to set the
> > need-resched flag. It is quite hard to trace because the problem itself is
> > caused by tracing, so by the time the dump starts, the traces cannot be seen
> > after that which are what would give a clue here.
> 
> Hmmm...  Doesn't ftrace_dump() iterate through the trace buffer with
> interrupts disabled or some such?  If so, that would fully explain
> its delaying RCU grace periods.

Looking through the ftrace_dump() code, I don't see any interrupt disabled
happening, and in this case it would be happening on a different CPU than my
preempt disable loop anyway since that loop runs on a CPU I reserved, and the
writer thread doing the dump runs on a different CPU. So it is a bit odd that
the presence of my preempt disable loop effects anything. No having the
preempt disable loop in the first place, does not have this issue.

(Also added "attn: Steve" for the tracing question, to get his attention
since this thread is very long).
Steven, any thoughts on how rcu_ftrace_dump() can affect grace-period
durations or other RCU parts? Do you see how it could impact the RCU GP
thread if at all? I did setup RT priority 10 for the thread.

thanks,

- Joel

