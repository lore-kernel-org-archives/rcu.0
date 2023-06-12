Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAC8C88CB4
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 16:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbjFLQii (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjFLQih (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 12:38:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6FE4A
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:38:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f649db9b25so5351762e87.0
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587914; x=1689179914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=QfRYTQECfsBgMvyANysDt2RqPFsfrwgoAKZdmqX3rGzWsJ3gsg3tWM3BfT3YO28z7i
         KO8y/9WDuNXKmWoTxT13cai/Wm7m4y6wPY83rl/OQK6dg+xMq3Nnii/t8HGOZfZRERRT
         1ocjt3a3ZtBIwhfj1NR06ypynKgvg6npBjc6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587914; x=1689179914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkQkCR0zK+G1VvzG47ybOhl6nFuB5nGWY9v59LgjCEc=;
        b=SReYDtWPt/kXw25cLUgQiUOHx3KWk3UqubqL/SwzYqvF1i6A8JQV57TmuiaI4wBH3t
         5CctcSmcGnYei0B3fOtgUFpKqLlGFocDaN+3KQptG29LghPxeXoqjFWxj3oqkIdUEW95
         xYFdunLqY7Qq5HOepOctu0RTlv6BP+4PIb6MhZD1pO8xeYgS5EmIt6t6gASZAYR9cqrF
         UUBgAUS//wZ8FK1HQqisW2JwF84XmVqt2BG8PAsnjeUhyAiTAavoSMMDv22iskVQBOzq
         rUDk13pggnsxru44UTa45Xro9VSD2vXUbiPCGS7PNgx+qWAG71POQhIflfqxfY5dmF2i
         jjBA==
X-Gm-Message-State: AC+VfDyBBD6vumUJRuSw15b1XoAsye+ZXYMIPKiHe0DudgS/hgzY5IzG
        jzMmx4kHwEMKqfjLdPL4mh803ANeQ4zbuqPojhJgbwgi
X-Google-Smtp-Source: ACHHUZ45IBVl05ztGi94pyO741bA6DaV7Pp4J2o4m5D8A42+WtDPmag44aMBxsXzXA0eEGfb5MDRUQ==
X-Received: by 2002:a2e:910e:0:b0:2af:160d:888a with SMTP id m14-20020a2e910e000000b002af160d888amr3583792ljg.1.1686587913926;
        Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d21-20020a2eb055000000b002aeee2a093csm1827911ljl.59.2023.06.12.09.38.32
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:38:33 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5336393e87.2
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:38:32 -0700 (PDT)
X-Received: by 2002:a19:e30c:0:b0:4f6:1779:b1c1 with SMTP id
 a12-20020a19e30c000000b004f61779b1c1mr5015246lfh.48.1686587892415; Mon, 12
 Jun 2023 09:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org>
In-Reply-To: <20230612090713.652690195@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:37:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Message-ID: <CAHk-=wj3jV+v63RA30eVpjHVyrGmmTF7d3ajdV=1wBU=5OHa=A@mail.gmail.com>
Subject: Re: [PATCH v3 00/57] Scope-based Resource Management
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     keescook@chromium.org, gregkh@linuxfoundation.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> These are by no means 'complete' convertions, I've mostly focussed on fun=
ctions
> that had 'goto' in them. Since that's a large part of why I started on al=
l this.

So I found what looks like two patches being completely broken because
the conversion was fundamentally misguided.

And honestly, by the end of walking through the patches I was just
scanning so quickly that I might have missed some.

Let's make the rule be that

 - max 10 patches in the series so that I think they were actually
thought about, and people can actually review them

 - only clear "goto out of scope" conversions. When you see a
"continue" or a "goto repeat", you TAKE A BIG STEP BACK.

Because this is all clever, and I am now happy with the syntax, but I
am *not* happy with that 60-patch monster series with what looks like
horrible bugs.

             Linus
