Return-Path: <SRS0=Mmc0=5N=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BEFC43331
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 11:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5455206CC
	for <rcu@archiver.kernel.org>; Sat, 28 Mar 2020 11:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgC1L3a (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:29:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55690 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1L3a (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 28 Mar 2020 07:29:30 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jI9eH-0004DV-GG; Sat, 28 Mar 2020 12:29:09 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2BD971040C1; Sat, 28 Mar 2020 12:29:09 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jules Irenge <jbi.octave@gmail.com>, julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@example.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>, Ingo Molnar <mingo@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, Qian Cai <cai@lca.pw>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:READ-COPY UPDATE \(RCU\)" <rcu@vger.kernel.org>
Subject: Re: [PATCH 03/10] cpu: Remove Comparison to bool
In-Reply-To: <20200327212358.5752-4-jbi.octave@gmail.com>
References: <20200327212358.5752-1-jbi.octave@gmail.com> <20200327212358.5752-4-jbi.octave@gmail.com>
Date:   Sat, 28 Mar 2020 12:29:09 +0100
Message-ID: <87v9mowwe2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Jules Irenge <jbi.octave@gmail.com> writes:
> ---
>  kernel/cpu.c      | 2 +-
>  kernel/rcu/tree.c | 2 +-

How is rcu/tree.c related to 'cpu:' ?

Thanks,

        tglx
