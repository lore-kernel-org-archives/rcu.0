Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75ADC433E9
	for <rcu@archiver.kernel.org>; Fri, 12 Mar 2021 11:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BB764F6F
	for <rcu@archiver.kernel.org>; Fri, 12 Mar 2021 11:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCLLhH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Mar 2021 06:37:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhCLLgo (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Mar 2021 06:36:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABB2C64FB9;
        Fri, 12 Mar 2021 11:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615549004;
        bh=Tnmzg1VNWRp37vPZH7WBHF69zo4cruqMAptSEKsDpE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/fav6v6j9c1sr6Et0T7YtmGJSMg4RyEoLnMA/co9nN/OBXrOQLJrtp+gk/6s6XAE
         hUK4HFynm6jq9pgRe/XG+RoYmhe0DCEyaEYPKpOWiUHyjuaaHTMt9tpES9moyFWDpj
         fUiQIJuEnIHdAnbTKBywNw+n1kwnJN0L3j/RuCaCstCmY2lIXWy194pwK7tD9ApdoW
         nYgP5ltxrab4g8LZ0bxbUwYMh0/1uPbKC9CL91Qx2ZmIaPhdWNripUKQkQ+j/DJsTZ
         r99jsE+iw9oPJ8NdThPjsutWFWHutaEc8x/rlYS09F6qrDSrYj3icAKZJfQU4nmjjZ
         Noe+S0gYjYxKw==
Date:   Fri, 12 Mar 2021 12:36:41 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 06/10] softirq: Don't try waking ksoftirqd
 before it has been spawned
Message-ID: <20210312113641.GA3646@lothringen>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
 <20210304000019.22459-6-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304000019.22459-6-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 03, 2021 at 04:00:15PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> If there is heavy softirq activity, the softirq system will attempt
> to awaken ksoftirqd and will stop the traditional back-of-interrupt
> softirq processing.  This is all well and good, but only if the
> ksoftirqd kthreads already exist, which is not the case during early
> boot, in which case the system hangs.
> 
> One reproducer is as follows:
> 
> tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 2 --configs "TREE03" --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y CONFIG_NO_HZ_IDLE=y CONFIG_HZ_PERIODIC=n" --bootargs "threadirqs=1" --trust-make
> 
> This commit therefore adds a couple of existence checks for ksoftirqd
> and forces back-of-interrupt softirq processing when ksoftirqd does not
> yet exist.  With this change, the above test passes.
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Uladzislau Rezki <urezki@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> [ paulmck: Remove unneeded check per Sebastian Siewior feedback. ]
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
