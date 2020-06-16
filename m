Return-Path: <SRS0=B8+c=75=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831D8C433DF
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 21:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B4A2082E
	for <rcu@archiver.kernel.org>; Tue, 16 Jun 2020 21:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFPVr7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 16 Jun 2020 17:47:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFPVr7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 16 Jun 2020 17:47:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B3072082E;
        Tue, 16 Jun 2020 21:47:58 +0000 (UTC)
Date:   Tue, 16 Jun 2020 17:47:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>
Subject: Re: Question about list_sort() RCU version.
Message-ID: <20200616174756.53309ed0@oasis.local.home>
In-Reply-To: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BYAPR04MB4965874567CDA672B704ABCC869D0@BYAPR04MB4965.namprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 16 Jun 2020 20:17:56 +0000
Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:

> Hi RCU maintainers and experts,
> 
> I'm working on a linux kernel upstream project which is in the tree. 
> With the POC I can already see that significant performance improvement 
> with RCU in the fast path which are replacing rw semaphore, but not 
> having list_sort() rcu variant is blocking the developement and getting 
> code upstream.
> 
> I was not able to find the such helper implemented for the RCU flavor of 
> list.
> 
> Can someone provide information about :-
> 
> 1. Is there any plan to have list_sort_rcu() ? if so when can we expect
>     that ? (Also how can I help ?)

I'm pretty sure there isn't any plan.

> 
> 2. In case there is no plan what are design considerations if someone
>     wants to implement the code and submit it upstream ?
>     (Also how can I help here ?
> 

Good luck! For RCU to work, you basically need two states where both
are "valid" for a time. You have an initial state, and then you have
the state you want to get to. In the transition period, readers will
see one of either those states, until the last reader is finished with
the initial state, all new readers will only see the second state after
a quiescent point in time.

To sort a list, you will need to modify it in such a case that the list
is valid for all readers. This requires moving a list item. The problem
is, this will require two modifications, where the list will not be
valid in between. How would you move an item where the list is valid
for ever change? Say you want to move the last element up. To do so,
you need to remove the pointer to that element, make another element
point to it, and in the mean time you need to update that last
element's pointer as well. You can't do all that at once, and doing any
of those without the other two will make the list invalid.

One answer is to make a copy of the entire list, sort it, and then make
it the new list. That's the only way I can see this work.

-- Steve
