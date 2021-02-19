Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B804C433E0
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB40564E77
	for <rcu@archiver.kernel.org>; Fri, 19 Feb 2021 11:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBSLSX (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:18:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57966 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBSLSW (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Feb 2021 06:18:22 -0500
Date:   Fri, 19 Feb 2021 12:17:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613733460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gXxVy4DaRNO7v21ruxk6GY+4axiURV9Ra9AYEdoq3k=;
        b=lfEzXjnQnH4CONBJpKdvsJ8C4/Ka2bcAyWbHRs/qui2Ewq8j3K3XqAjOUWMxgrJeI3mL+M
        6xjDpBAKGT9c88Kcyt0H22J2urj4X87Q4bBppZ/Q7iwVP/jGp4pnvLDQqabC1zkcF3XREE
        FeUeFGMFtTgWigugYDXsQFsp978i4fBiw5Feu9KeOraJ84LCrKkKYI2fcz7IxyZ61eQY5L
        8mMgfxe5ZZERCtWe3uhrU1acS22F1Lb36yevAxADg3VnZVJNrZvtAVl1rWGJ6g3QYqcUh2
        c7FllEDmL1scCo9DelG7o7maS4MGyU5MMb5swvRvFrafxkmg1y/IPtky4mqhlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613733460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gXxVy4DaRNO7v21ruxk6GY+4axiURV9Ra9AYEdoq3k=;
        b=QGPD6BVNUOBq35ALcLfeKuYa92yCC4MuxV5VuZ0A5orNUm0I1AnaZoV14z6qM/Fi75fUYQ
        0dy0wlAwjepKg8DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] kprobes: Fix to delay the kprobes jump optimization
Message-ID: <20210219111738.go6i2fdzvavpotxd@linutronix.de>
References: <161365856280.719838.12423085451287256713.stgit@devnote2>
 <20210218151554.GQ2743@paulmck-ThinkPad-P72>
 <20210219081755.eucq4srbam6wg2gm@linutronix.de>
 <20210219104958.GA34308@pc638.lan>
 <20210219105710.d626zexj6vzt6k6y@linutronix.de>
 <20210219111301.GA34441@pc638.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219111301.GA34441@pc638.lan>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-02-19 12:13:01 [+0100], Uladzislau Rezki wrote:
> I or Paul will ask for a test once it is settled down :) Looks like
> it is, so we should fix for v5.12.

Okay. Since Paul asked for powerpc test on v5.11-rc I wanted check if
parts of it are also -stable material.

Sebastian
