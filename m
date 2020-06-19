Return-Path: <SRS0=nBXm=AA=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849AC433DF
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 00:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFDD5208D5
	for <rcu@archiver.kernel.org>; Fri, 19 Jun 2020 00:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFSABm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jun 2020 20:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgFSABm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jun 2020 20:01:42 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13469208C3;
        Fri, 19 Jun 2020 00:01:40 +0000 (UTC)
Date:   Thu, 18 Jun 2020 20:01:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 3/7] rcu/trace: Add name of the source for gp_seq
Message-ID: <20200618200138.500b20cb@oasis.local.home>
In-Reply-To: <20200618221901.GZ2723@paulmck-ThinkPad-P72>
References: <20200618202955.4024-1-joel@joelfernandes.org>
        <20200618202955.4024-3-joel@joelfernandes.org>
        <20200618221901.GZ2723@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, 18 Jun 2020 15:19:01 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> For future reference, the TPS() around strings is not optional.  Without
> it, trace messages from crash dumps are garbled, if I remember correctly.

When you pass in a string like this, only the pointer to the string is
saved in the ring buffer. User space tools have no idea what those
pointers are. The TPS() around strings maps those pointers to the
string and shows them in the /sys/kernel/tracing/printk_formats file,
such that perf and trace-cmd know how to make sense of those strings.

-- Steve
