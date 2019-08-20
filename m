Return-Path: <SRS0=T5MY=WQ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F86C3A5A0
	for <rcu@archiver.kernel.org>; Tue, 20 Aug 2019 01:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD41B22CE8
	for <rcu@archiver.kernel.org>; Tue, 20 Aug 2019 01:40:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ped8gofm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfHTBkd (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Aug 2019 21:40:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44931 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfHTBkd (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Aug 2019 21:40:33 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so1846763plr.11
        for <rcu@vger.kernel.org>; Mon, 19 Aug 2019 18:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VO+RstRa5u4AZu2WUEqYKpmwxXdX1i3TaxyPX2rlHR0=;
        b=Ped8gofmbEt2IuVEAadFWuFWmOHcGKJL186QhfAPfKtA1wk0nIHG2vtwmuNB0pANo9
         9VUtCCm/XGAtfFtuEbUcqnaEpO5KiB0yeRbZpi6PYCx9QlB2P+E8XGA9mzdqJTQLhUq8
         boQxvZ8aFbcIDC6AVhr5HONeNUN6G2S0QAPnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VO+RstRa5u4AZu2WUEqYKpmwxXdX1i3TaxyPX2rlHR0=;
        b=qs5fybxeOp0+msrySyWVYWLvRFkvwKWcRzGaWH7JA1GITLDWEFjzlhWBuvR7nt00LX
         heJztSRMiWJDRiA1DN8bw1V1/IVCZZYGSLJc86Vkpv1TVgm6zdtL1OP67cycI40AzxNx
         jPfQ0XDUF+laQH69sDX1UJjC2BCvIq5J+tKhqiWxwmY2ecd0fP5dYYIsb6an1+NMmQO6
         ggW72eWFaX5lMIesUKrRXRAbVDJfR5enVoqBvG0ZDMfk1I9t6KsCLpBeIwutqT8FmPgP
         ABYW+NQAp0nLnIvk/STKWpQn8LPYNP14c0ld11XzP/OXTyrGva88Q91TECmAJWSa2bhJ
         5oYA==
X-Gm-Message-State: APjAAAVq2CvMzRwR02WDs1avQGmiT8hn9iyeCB6pU29JZ4Qxk4tR9NnH
        FUg/hBTrwW7VfWd97kyzJyz2Ng==
X-Google-Smtp-Source: APXvYqyZ7UDxlZP3LbgDlpY/VYbPkx3Q03uAIKSdq9hEwTrEVKKMCLB1QizGD0Nvqysc5GQuGsvAkA==
X-Received: by 2002:a17:902:a607:: with SMTP id u7mr25775304plq.43.1566265232650;
        Mon, 19 Aug 2019 18:40:32 -0700 (PDT)
Received: from localhost ([172.19.216.18])
        by smtp.gmail.com with ESMTPSA id a16sm5765809pfo.33.2019.08.19.18.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 18:40:31 -0700 (PDT)
Date:   Mon, 19 Aug 2019 21:40:15 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Scott Wood <swood@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v2] rcu/tree: Try to invoke_rcu_core() if in_irq() during
 unlock
Message-ID: <20190820014015.GA199862@google.com>
References: <20190818214948.GA134430@google.com>
 <b12aa6442bd12c725beb8e381083e6880dbd9206.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12aa6442bd12c725beb8e381083e6880dbd9206.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 19, 2019 at 07:14:38PM -0500, Scott Wood wrote:
> On Sun, 2019-08-18 at 17:49 -0400, Joel Fernandes (Google) wrote:
> > When we're in hard interrupt context in rcu_read_unlock_special(), we
> > can still benefit from invoke_rcu_core() doing wake ups of rcuc
> > threads when the !use_softirq parameter is passed.  This is safe
> > to do so because:
> 
> What is the benefit, beyond skipping the irq work overhead?  Is there some
> reason to specifically want the rcuc thread woken rather than just getting
> into the scheduler (and thus rcu_note_context_switch) as soon as possible?

Isn't skipping irq work overhead enough of a benefit?

Anyway, I think it is useful in this scenario:
 Consider exp==true when the rcu_read_unlock() is done on a nohz_full CPU.

 If you simply 'get into the scheduler' as you pointed, that is not enough to
 end the grace period. The quiescent state has to be reported up the tree and
 propagated to the root node in the tree. This happens only in 2 places:
 	1. The scheduler tick raising softirq, the end of which will execute the
	   RCU core from the softirq or do the invoke_rcu_core().
	2. The FQS loop which needs to see a dyntick idle transition on the
	   CPU (usermode/idle to kernel or viceversa).

Case 1. is unlikely since the tick may be turned off but I worked last week
        with Paul on turning it on and is doing better.
Case 2. is not happening if we're looping in kernel mode.

In this scenario, calling invoke_rcu_core() directly is better than
scheduling the IRQ work. I don't think the IRQ work will do anything for
nohz_full CPU but I am not sure about that.

To give more background about why I arrived at this patch, I noticed that
this call to invoke_rcu_core() was already being done but it was removed
because the commit removing it said that it is pointless as it does not do
anything. But I think it does do something, that's why I introduced it back.
The rcu_read_unlock_special() is a slow path anyway so one more branch should
be harmless and actually could be beneficial. However, this is just RFC,
please treat it as such. I am running more tests on it based on Paul's
suggestions and looking more closely at it tomorrow.

Thanks!

 - Joel

