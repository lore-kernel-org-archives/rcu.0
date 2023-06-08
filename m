Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53109C7EE23
	for <rcu@archiver.kernel.org>; Thu,  8 Jun 2023 20:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjFHUOY (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 8 Jun 2023 16:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFHUOX (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 8 Jun 2023 16:14:23 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C2273A
        for <rcu@vger.kernel.org>; Thu,  8 Jun 2023 13:14:22 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6237faa8677so7153326d6.1
        for <rcu@vger.kernel.org>; Thu, 08 Jun 2023 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686255261; x=1688847261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eRVCfDeAAMucNxeePix1yxCVE2NkWOFxs0IcqPVmf8=;
        b=x4iYbqUgHoJfnhLtBe3ZvyjbxVnyNnZVjNyHX8HOfkAnTIr1p9sewsfeubUdDHZL/J
         msV7VC/YGGsepIskxXWNCllufGswuXedGcG4O0QQyvnxW1Y5TMjdDZQ+y6KryVGjTiId
         QA0Q8gLk6/mIq4Fp51R2ol2NxkbfRup6yzId+gt/X+xXIrjTH68pbK3DZai2eM0rFMxB
         DV+Nt8R0g5B/DQS6HOqfvUrObDamGO2gIAqmzNwx4pGP5axMBJwvSEQeLdWIQCmSMfQh
         x6J9vyF1FhaMGaHC6+e2H5S2M5OM0wqHSTgrptWDTCKMAnKl9I640tRNFI7uggZVbQas
         yh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686255261; x=1688847261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eRVCfDeAAMucNxeePix1yxCVE2NkWOFxs0IcqPVmf8=;
        b=EHE5Wdc4fS2zsnyDmgJ3PAlQy6ap60ShJykgpcx7h/hokTEbUk1z5GdlWrl/hpZsNq
         6UK7qxEMPy9bSoWEqUfdMZ5OsV55VIHO+kzFDmC8N4/MQS8W6awyNBaC+GEvb2ZIo0Vs
         1cSIhGHzfaqUoVqiTQ/74BeB2MTK+ZMah9JLpzTYlLaTjTr3QHBIZB7taVzXK7g63Zi5
         OuJIaAdd2br1B0u7+jzyENNqZz9uieYQ1prK+C7XbqhkF5WjhCJIusOWTKPMRMLpbbLA
         mJDYOdgsbjzQcsGCgs4DOjjQh8+Q6WhIOkmQCPrxChm4f64Io/lnq0L0iQ0LoHyhuPEK
         9/BQ==
X-Gm-Message-State: AC+VfDzLW2aOK1OJJtZPdrCoe/n3vLKDZW+YmSsyI84phvgICTnsAI//
        xy7Jv3k5oPZWPjPeB7CAKve2d7rrv4AR2FS9DILxfg==
X-Google-Smtp-Source: ACHHUZ6r2wb1dJI5UymrIOL2HDKfArs9bbIeB/khx8uqZadNOvrgOAYTxFeyYXRYdaS6/plvrdMGAdRSSVg72BIReaM=
X-Received: by 2002:a05:6214:242c:b0:626:24c4:7d78 with SMTP id
 gy12-20020a056214242c00b0062624c47d78mr2916475qvb.56.1686255261266; Thu, 08
 Jun 2023 13:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wi-RyoUhbChiVaJZoZXheAwnJ7OO=Gxe85BkPAd93TwDA@mail.gmail.com>
 <20230606134005.GE905437@hirez.programming.kicks-ass.net> <CAHk-=wgQ5m+SnWTYGHu0JgYXTk2dkGF+msX=ARfYoo3t1_fX9g@mail.gmail.com>
 <20230606180806.GA942082@hirez.programming.kicks-ass.net> <CAHk-=wgXN1YxGMUFeuC135aeUvqduF8zJJiZZingzS1Pao5h0A@mail.gmail.com>
 <20230607094101.GA964354@hirez.programming.kicks-ass.net> <20230608085248.GA1002251@hirez.programming.kicks-ass.net>
 <CAHk-=wj-BGgTF0YgY+L7_G8Jb0UO38Cd8dwrfMqFMEh93B3D7g@mail.gmail.com>
 <202306080917.C0B16C8@keescook> <CAKwvOdmY_NEK4cnrqwU8acpU=SK3Z2uV_3PYCnhA5zQt2_TJJg@mail.gmail.com>
 <20230608185142.GA1019250@hirez.programming.kicks-ass.net>
In-Reply-To: <20230608185142.GA1019250@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Jun 2023 13:14:10 -0700
Message-ID: <CAKwvOd=MurF6DQHzRTai15h67FEpd_4R-gz_iFejzLsL=dw3dA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Lock and Pointer guards
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        gregkh@linuxfoundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de,
        linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jun 8, 2023 at 11:51=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jun 08, 2023 at 10:20:19AM -0700, Nick Desaulniers wrote:
> > Presumably, one could simply just not use RAII when working with a valu=
e that conditionally
> > "escapes" the local scope.
>
> But then you're back to the error goto :/

Thinking more about the expected ergonomics here over lunch...no
meaningful insights, just thoughts...

For something like a mutex/lock; I'd expect those to be acquired then
released within the same function, yeah? In which case
__attribute__((cleanup())) has fewer hazards since the resource
doesn't escape.

For a pointer to a dynamically allocated region that may get returned
to the caller...

I mean, people do this in C++. It is safe and canonical to return a
std::unique_ptr.  When created locally the destructor does the
expected thing regardless of control flow.  IIUC, std::unique_ptr's
move constructor basically does what Kees suggested earlier (trigger
warning: C++): https://github.com/llvm/llvm-project/blob/7a52f79126a5971701=
2d8039ef875f68e3c637fd/libcxx/include/__memory/unique_ptr.h#L429-L430.
example: https://godbolt.org/z/51s49G9f1

A recent commit to clang https://reviews.llvm.org/rG301eb6b68f30
raised an interesting point (deficiency is perhaps too strong a word)
about GNU-style attributes; they generally have no meaning on an ABI.

Consider a function that returns a locally constructed
std::unique_ptr.  If the function returns a type where the caller
knows what destructor functions to run.  This is part of the ABI.

Here, we're talking about using __attribute__((cleanup())) to DTR
locally, but then we return a "raw" pointer to a caller. What cleanup
function should the caller run, implicitly, if at all?  If we use
__attribute__((cleanup())) that saves us a few gotos locally, but the
caller perhaps now needs the same treatment.
--=20
Thanks,
~Nick Desaulniers
