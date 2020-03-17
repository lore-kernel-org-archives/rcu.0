Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B7C0044D
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 01:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655F20679
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 01:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgCQBfw (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:35:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgCQBfw (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 21:35:52 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BC02051A;
        Tue, 17 Mar 2020 01:35:50 +0000 (UTC)
Date:   Mon, 16 Mar 2020 21:35:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, rcu <rcu@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: Power outage
Message-ID: <20200316213549.7c806dc9@oasis.local.home>
In-Reply-To: <20200317010805.GD3199@paulmck-ThinkPad-P72>
References: <CAJzB8QEUkcfx19N5369AqvfkOfQ+DL3pEjYJsK7yJi+tSq8CFg@mail.gmail.com>
        <CAEXW_YSBe3UOWwjTBpya_bM47RvrpV8kcx=RrskPP3z0i0nY2g@mail.gmail.com>
        <20200317010805.GD3199@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 16 Mar 2020 18:08:05 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Mar 16, 2020 at 07:29:46PM -0400, Joel Fernandes wrote:
> > I saw a bunch of ping timeouts on IRC and was wondering, yours among
> > them. :-). See you soon back online!  
> 
> Just to add insult to injury, vger rejected the email.
> 
> Due to its belief that said email contained a virus.

It shouldn't have rejected it. It should have just put it under a 14
day quarantine.

-- Steve 


> 
> You just can't make this stuff up!
> 
