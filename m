Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA34C4332F
	for <rcu@archiver.kernel.org>; Tue, 31 Oct 2023 23:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376477AbjJaXHJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Oct 2023 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376467AbjJaXHI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Oct 2023 19:07:08 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469BAE4
        for <rcu@vger.kernel.org>; Tue, 31 Oct 2023 16:07:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so10793534a12.1
        for <rcu@vger.kernel.org>; Tue, 31 Oct 2023 16:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698793623; x=1699398423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wUvOEnKmTi8WEvQZdsskLf9E1FQBX1NqUbV0gaScgU=;
        b=H5bkq0jagJFW0iE3xOfnkj+r6I8OlwKpqSqHGBa/gZxnRdiX0dYJeAZ8/UGJn4sKOc
         RLSB2L1XwKOhdQj4pkQLbKLtBRF0LrDbnRg7DoQRx6hsUFky88pSvLVMwRGSCRlqJiZZ
         2BdJpWgPqOydcfAWZml4z2WtAiXciX8JqWTbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793623; x=1699398423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wUvOEnKmTi8WEvQZdsskLf9E1FQBX1NqUbV0gaScgU=;
        b=pbAvQZD30xwvI5Hgoef0IJb66WVTXyWhLiffxUlQ6J5wDReNcBtjaQoTMyIO0e9Adp
         PpBMZMgCTGnsvQN32+1B5N4UXWvRpTRizUpsSjje5Lwqgo5uwUsz4I5NgkPwXiy+/LGO
         9jj+OJiDa5IxMuQk2yGOr/BiCpwVCDWd5iucpNukK2zEUY5xl93vA2klaNvRieL1r7Cc
         n69kIjtOO/1anXyaqKAuvcAluU1YVBmjqmSPVwBgy0WFujOIi+X7voNhajVJfjtoheTI
         thi2qiYFLVHx5uOHKo+v/BnkY0FSWdbDnVrT0r0hPnkKkJm/PpeCHimZPV79etCh9BCJ
         coDA==
X-Gm-Message-State: AOJu0Yx8S5NZ9XvqLQvb7NbD9WbJipOZkK1OVdIdxHvJBjvE02jwR5Hz
        yMmhpZz3FzE0n8I4yS4z0L9/Wf2TU3fUYQAfuqPNeWzf
X-Google-Smtp-Source: AGHT+IHzYAkr5ThgydHrDIFIJ6eHAFHUMOhqhKxAsEu6/jp/FK04QXBCnSyCBVcoHVpBQ4wEHdqIiQ==
X-Received: by 2002:a50:8e58:0:b0:543:3df8:cc95 with SMTP id 24-20020a508e58000000b005433df8cc95mr4930224edx.9.1698793623687;
        Tue, 31 Oct 2023 16:07:03 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id n1-20020a509341000000b0053ed70ebd7csm233046eda.31.2023.10.31.16.07.01
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 16:07:01 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9bf86b77a2aso880680766b.0
        for <rcu@vger.kernel.org>; Tue, 31 Oct 2023 16:07:01 -0700 (PDT)
X-Received: by 2002:a17:906:ef0e:b0:9c7:4d3e:1e50 with SMTP id
 f14-20020a170906ef0e00b009c74d3e1e50mr631104ejs.76.1698793621035; Tue, 31 Oct
 2023 16:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZTuf+xNrfqGjHFDK@lothringen> <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen> <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
In-Reply-To: <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Oct 2023 13:06:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
Message-ID: <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 31 Oct 2023 at 03:57, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Would it help if we make rcu_stall_chain_notifier_register() print a
> suitably obnoxious message saying that future RCU CPU stall warnings
> might be unreliable?

It's not the future stall warnings I worry about.

It's literally things like somebody thinking they are being clever,
registering a rcu stall notifier that prints out extra information in
order to be helpful, and in the process takes a spinlock or something
without thinking about it.

And that spinlock might be the *reason* for the RCU stall in the first place.

So now the RCU stall code prints out NOTHING AT ALL, because now the
stall notifier itself has deadlocked.

This is *exactly* what has happened before with these kinds of
"helpful" exception case notifiers. Because they never trigger in
normal loads, they get basically zero testing - and then when bad
things happen, it turns out that the "helpful" debug code actually
just makes things worse.

Or, if they get testing, they get tested in artificial bad cases (eg
"let's just write a busy loop that hangs for 30 seconds to trigger a
RCU stall"), which doesn't show any of the issues, because they aren't
real bugs with real existing deadlocks.

See what I'm saying? Having notifiers for "sh*t happened" is
fundmanetally questionable to begin with, because they get no testing.

And then calling said notifiers *before* you even have the core
printout for "Look, things are going down hill quickly", now you've
turned a bad situation even worse.

I really think that we should *never* have any kind of notifiers for
kernel bugs. They cause problems. The *one* exception is an actual
honest-to-goodness kernel debugger, and then it should literally
*only* be the debugger that can register a notifier, so that you are
*never* in the situation that a kernel without a debugger will just
hang because of some bogus debug notifier.

              Linus
