Return-Path: <SRS0=wSob=VD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A95C5B578
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 23:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF45420843
	for <rcu@archiver.kernel.org>; Sat,  6 Jul 2019 23:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfGFXZ6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 6 Jul 2019 19:25:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbfGFXZ6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 6 Jul 2019 19:25:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5362020830;
        Sat,  6 Jul 2019 23:25:57 +0000 (UTC)
Date:   Sat, 6 Jul 2019 19:25:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>
Subject: Re: [attn: Steve] Re: Normal RCU grace period can be stalled for
 long because need-resched flags not set?
Message-ID: <20190706192555.23fe2ea6@oasis.local.home>
In-Reply-To: <20190706180532.GX26519@linux.ibm.com>
References: <20190704003213.GA218086@google.com>
        <20190704005009.GZ26519@linux.ibm.com>
        <20190704032454.GA259593@google.com>
        <20190704171315.GG26519@linux.ibm.com>
        <20190704185055.GA12919@google.com>
        <20190704221702.GL26519@linux.ibm.com>
        <20190705000830.GB12919@google.com>
        <20190705013045.GA141984@google.com>
        <20190705015726.GN26519@linux.ibm.com>
        <20190706121807.GB200542@google.com>
        <20190706180532.GX26519@linux.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, 6 Jul 2019 11:05:32 -0700
"Paul E. McKenney" <paulmck@linux.ibm.com> wrote:

> I see a local_irq_save() a few lines into ftrace_dump() itself.  Am I
> missing where interrupts are being re-enabled prior to the trace-dump
> loop?

BTW, I saw the "attn: Steve" but my brain is too fried from doing yard
work all day, that I'll postpone answering this to Monday ;-)
Why yard work would fry the brain, probably didn't, but I'm so exhausted
I can't think.

-- Steve
