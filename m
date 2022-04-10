Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBDCC433F5
	for <rcu@archiver.kernel.org>; Sun, 10 Apr 2022 11:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbiDJLf6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 10 Apr 2022 07:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiDJLf5 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 10 Apr 2022 07:35:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4813B58E44
        for <rcu@vger.kernel.org>; Sun, 10 Apr 2022 04:33:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kbqcm0Qzdz4xLT;
        Sun, 10 Apr 2022 21:33:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1649590424;
        bh=8f4PE/GIp3JZl1tbeUfCm8Jv9/KkWtCPiuEasvbGIAA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ABKNUeSeLo3WdS/+bOvS2AJ1X/1pZe4Kef4f27If8oRAovqbCa2TkEHR9K8gX/bun
         PQrm/tRn0DUnxAhqxq+TbWuwu5foVhU12i71rskhcLZg3coQlqL5tM1ssPfjFVEaLP
         y4ItLOpgqylvXYGRC7RHBFmLvgLe3YMr7zAesd5a8odeiD6NXTQNRtSJEKKeg+n8hv
         Mn85WXh5Ea5Rwe9OpzubQcnXhvg2174MlHYK9meczsgUQCe5mNkvrGfR1r2Dl1Lshk
         aaKsMqo0x7RG3Yt1WtyiccwzKdx6F13J6LUCeqsXtI2LJ5fE0+0KAx8wicNbbRfxfO
         kpqeLxwEwO9Mw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu <rcu@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
In-Reply-To: <CAABZP2zEU8eULq30ZLcUeqxjXuLTKO4b3wm_Jo458Nq_JJ7pEw@mail.gmail.com>
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <87pmls6nt7.fsf@mpe.ellerman.id.au>
 <CAABZP2wVAzybDTjUWxwGG4HmWK7V8rJVVFxpRx-3F9n5oST3+A@mail.gmail.com>
 <20220408140712.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <CAABZP2zEU8eULq30ZLcUeqxjXuLTKO4b3wm_Jo458Nq_JJ7pEw@mail.gmail.com>
Date:   Sun, 10 Apr 2022 21:33:43 +1000
Message-ID: <871qy56ulk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
> On Fri, Apr 8, 2022 at 10:07 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> On Fri, Apr 08, 2022 at 06:02:19PM +0800, Zhouyi Zhou wrote:
>> > On Fri, Apr 8, 2022 at 3:23 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
...
>> > > I haven't seen it in my testing. But using Miguel's config I can
>> > > reproduce it seemingly on every boot.
>> > >
>> > > For me it bisects to:
>> > >
>> > >   35de589cb879 ("powerpc/time: improve decrementer clockevent processing")
>> > >
>> > > Which seems plausible.
>> > I also bisect to 35de589cb879 ("powerpc/time: improve decrementer
>> > clockevent processing")
...
>>
>> > > Reverting that on mainline makes the bug go away.

>> > I also revert that on the mainline, and am currently doing a pressure
>> > test (by repeatedly invoking qemu and checking the console.log) on PPC
>> > VM in Oregon State University.

> After 306 rounds of stress test on mainline without triggering the bug
> (last for 4 hours and 27 minutes), I think the bug is indeed caused by
> 35de589cb879 ("powerpc/time: improve decrementer clockevent
> processing") and stop the test for now.

Thanks for testing, that's pretty conclusive.

I'm not inclined to actually revert it yet.

We need to understand if there's actually a bug in the patch, or if it's
just exposing some existing bug/bad behavior we have. The fact that it
only appears with CONFIG_HIGH_RES_TIMERS=n is suspicious.

Do we have some code that inadvertently relies on something enabled by
HIGH_RES_TIMERS=y, or do we have a bug that is hidden by HIGH_RES_TIMERS=y ?

cheers
