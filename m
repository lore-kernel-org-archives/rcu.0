Return-Path: <SRS0=IXig=5B=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91ECC0044D
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 18:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B3220679
	for <rcu@archiver.kernel.org>; Mon, 16 Mar 2020 18:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732266AbgCPSgK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731967AbgCPSgK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Mar 2020 14:36:10 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E0220674;
        Mon, 16 Mar 2020 18:36:07 +0000 (UTC)
Date:   Mon, 16 Mar 2020 14:36:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/16] Prototype RCU usable from idle,
 exception, offline
Message-ID: <20200316143606.605ddd68@gandalf.local.home>
In-Reply-To: <20200315175921.GT3199@paulmck-ThinkPad-P72>
References: <20200312181618.GA21271@paulmck-ThinkPad-P72>
        <20200313144145.GA31604@lenoir>
        <20200313154243.GU3199@paulmck-ThinkPad-P72>
        <2062731308.28584.1584294305768.JavaMail.zimbra@efficios.com>
        <20200315175921.GT3199@paulmck-ThinkPad-P72>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, 15 Mar 2020 10:59:21 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Nothing survives real life

  #coronavirus!

-- Steve
