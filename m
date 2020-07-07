Return-Path: <SRS0=8S7d=AS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40D5C433E3
	for <rcu@archiver.kernel.org>; Tue,  7 Jul 2020 09:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A444207C4
	for <rcu@archiver.kernel.org>; Tue,  7 Jul 2020 09:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MO7Ppzm9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qaqbbubx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGGJ1L (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGGJ1K (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 7 Jul 2020 05:27:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF8FC061755;
        Tue,  7 Jul 2020 02:27:10 -0700 (PDT)
Date:   Tue, 7 Jul 2020 11:27:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594114028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLBTzIwDXRw8Ngy3frJIgWMDMydSG5GmWktyqhaqBeo=;
        b=MO7Ppzm9g4auQbN/35wAZgxdqPFOCGkJIsA1FU6fXW8rDsAD8z98NHJL4EpFs1MWQnqT0Z
        UX6AaIaphrgEw7cpzAqVHdV0VsaUoT3XlakzRjgZrWgyiuhTEi26xzLuvYLakLjK+w/LZS
        y6x6ShETS2+aKEkISOeG49AJBOS3SfNknmo3MqnZ2WBEt+9t7LQuw3pNcSQrP+oehQMTwh
        GXkDJTuKLDh1rQrDqQUH/lmmkyg3VUU5IHG4OmkDnQCxk6LSsFZEv18p4qryygjCNZnEWS
        VU0O4OxM761HgnjDn8/3wKBniuB2CRFu6m53V+6Tn2EcPUyAZum7sERzjKS2bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594114028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QLBTzIwDXRw8Ngy3frJIgWMDMydSG5GmWktyqhaqBeo=;
        b=qaqbbubx9fvSPosR3yx7SvkqXwsNksqEypCk+pQW1mWQ0c7qkSnxMlduSpzkWLB7IvJMLB
        9ZBQWb3vznwTUxCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200707092707.eos6yiq5t6h7d7ko@linutronix.de>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702194506.GA31478@pc636>
 <20200706194232.GA233429@google.com>
 <20200706195557.GA24082@pc636>
 <20200706202949.GB233429@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706202949.GB233429@google.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2020-07-06 16:29:49 [-0400], Joel Fernandes wrote:
> Anyway, I think as we discussed on IRC, your proposal will work for both
> kernels while allowing us to keep the internal lock as raw.

Why can't we use the migrate_disable() and spinlock_t?

> thanks,
> 
>  - Joel

Sebastian
