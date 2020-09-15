Return-Path: <SRS0=zZsG=CY=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E4C43461
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 16:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E961520936
	for <rcu@archiver.kernel.org>; Tue, 15 Sep 2020 16:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600186644;
	bh=UC1yh2hp7xYE271XAEDPNKg+J+sQcRAFlbeySxxF1fY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R5dko05OjI5FyV9+y/oLMxnQO54qMI/gey4fX9prBZAAFzX77AiztxLLYhpgeuDjb
	 z78HGEIL7LzEAUp0Qx9ueyvrez3OddfKagSpIw1V6s+cFPpCHMIZ0QtyCwATDCdepu
	 UoJNI6fz5pWTOdLp7VbB9ezJ4nGvl9osL8kLusAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbgIOQRS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 15 Sep 2020 12:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbgIOQQi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 15 Sep 2020 12:16:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680002074B;
        Tue, 15 Sep 2020 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600186275;
        bh=UC1yh2hp7xYE271XAEDPNKg+J+sQcRAFlbeySxxF1fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLJBoJyZ2MbAregGNpzO/CAOq3qYqCUVYtw7hO4M7FduU8HInY48wZG+1gWntYelQ
         oLWO9tTjUONmPdC0nJ9es906NbinxDOlYlq9MiTPOxDMzJntQj9N/nuOqfyS1ru3ka
         TrV8du2f8kHA6eUDyUlEROxdTu8m4Jc0gLv8xEr4=
Date:   Tue, 15 Sep 2020 17:11:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [patch 04/13] lockdep: Clenaup PREEMPT_COUNT leftovers
Message-ID: <20200915161104.GB26745@willie-the-truck>
References: <20200914204209.256266093@linutronix.de>
 <20200914204441.375753691@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914204441.375753691@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 14, 2020 at 10:42:13PM +0200, Thomas Gleixner wrote:
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> ---
>  include/linux/lockdep.h |    6 ++----
>  lib/Kconfig.debug       |    1 -
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -585,16 +585,14 @@ do {									\
>  
>  #define lockdep_assert_preemption_enabled()				\
>  do {									\
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> -		     debug_locks			&&		\
> +	WARN_ON_ONCE(debug_locks			&&		\
>  		     (preempt_count() != 0		||		\
>  		      !raw_cpu_read(hardirqs_enabled)));		\
>  } while (0)
>  
>  #define lockdep_assert_preemption_disabled()				\
>  do {									\
> -	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> -		     debug_locks			&&		\
> +	WARN_ON_ONCE(debug_locks			&&		\
>  		     (preempt_count() == 0		&&		\
>  		      raw_cpu_read(hardirqs_enabled)));			\
>  } while (0)
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1161,7 +1161,6 @@ config PROVE_LOCKING
>  	select DEBUG_RWSEMS
>  	select DEBUG_WW_MUTEX_SLOWPATH
>  	select DEBUG_LOCK_ALLOC
> -	select PREEMPT_COUNT
>  	select TRACE_IRQFLAGS
>  	default n
>  	help

Acked-by: Will Deacon <will@kernel.org>

Will
