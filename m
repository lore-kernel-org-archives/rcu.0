Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B505BC4727C
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64F292087E
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 08:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JxdiFBSc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mSaLvQC/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgJAIZK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Oct 2020 04:25:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgJAIZK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 04:25:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601540707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xvOXvLyBhcZh28iSmIhtImffHIXHFigmRBOmHiNvSc=;
        b=JxdiFBScbyhL+2rSWc2dJraE+cBQoTZcjFfu7waNc5nZ+RIQE3pc5Px7zpPN48BQUVjpsy
        GK0di6MUV50qV1ANlXnhsr8qGaDXwxTgnPRGXmIGwLjdKk4LNAOsSTuaeU59iRkr53BMAr
        2RpdYmkHGqIvtXZSxR9FM/G12Jzkt6sSDxhEoZLF7/+YW4BatuIppVi1Df1pJZF4mf43GZ
        AqJtyNM8OdciXaxRg6XLyrKhfT8BTAYANYwcjizxLEsXuvKStNa4uYSUh8yy9X+hZ8555M
        PEzo7NNILM+vr/seispwSvj3Vn6mFwzKXlnFSd9tb3itoeCgdqVtKmVVpJhiiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601540707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xvOXvLyBhcZh28iSmIhtImffHIXHFigmRBOmHiNvSc=;
        b=mSaLvQC/HM+x5VEk0mzZYQb5fN5pd6UpdUVUe3141TsuNSllOAU41IVB7/QNyWBL54IH/L
        wQwUT1rqC7H7+dBA==
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH tip/core/rcu 11/15] drm/i915: Cleanup PREEMPT_COUNT leftovers
In-Reply-To: <160153665673.4398.6268028176406103680@jlahtine-mobl.ger.corp.intel.com>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72> <20200928233102.24265-11-paulmck@kernel.org> <160153665673.4398.6268028176406103680@jlahtine-mobl.ger.corp.intel.com>
Date:   Thu, 01 Oct 2020 10:25:06 +0200
Message-ID: <871riigxp9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Oct 01 2020 at 10:17, Joonas Lahtinen wrote:
> Quoting paulmck@kernel.org (2020-09-29 02:30:58)
>> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
>> removed. Cleanup the leftovers before doing so.
>
> Change looks fine:
>
> Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
>
> Are you looking for us to merge or merge through another tree?
>
> If us, did the base patch always enabling PREEMPT_COUNT go into 5.9 or is
> it heading to 5.10? We can queue this earliest for 5.11 as drm-next closed
> for 5.10 at week of -rc5.

If at all it goes through rcu/tip because it depends on the earlier patches.

Thanks,

        tglx
