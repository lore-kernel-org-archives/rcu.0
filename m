Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03873C7EE2F
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 16:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbjFLQdW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236772AbjFLQdU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 12:33:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2584E11B
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:33:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so5328466e87.2
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587597; x=1689179597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=J3qARN+jFRLBlihaBWQm2k0OC745YSc8L/QV9x8sfpDSG0AJIqwc+LkDpqYT/4J2Nf
         YhQrjvP2Nc1xr054mv1XbrEj2WMWDNRpRxnOhn+2USK/sYaK1esqh25lllRgxb2Rc5op
         puDa6lRoQrgBM3ibvBS8fijpfvbZ4D3q4oRWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587597; x=1689179597;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQ64AB6vFE2gCnLICKj93uVfxKBboA+BfLd8wCYY+0E=;
        b=Kwm1/NghpJCrbN7VYKGoJUPNf5BzDMRtaOAsg6mcKCLRAxlS7XqHisyGHYeyOW7o2O
         jxFHSALOtuEpNG+pWNbxh5ra4LpVjPONKJwEuBcwhL3+lFgC+MWEXDajK3uNfyzPuzz4
         hPyLjDmXSNPGlUen/2dyPQqYASj7cp6Az8Ch8tKRKI1HbLz9slhWK1QUHbVlvVf+KwNs
         aehvwqkyhWGC4+Ih7oEdFeC3zmcgFPbYGvqjamLtfNPr5VfpAMr0d2VuGZrq67yoVdG4
         H+M+2Sp70HgHDiFucygT0YYng/HOpy2bS7wDVevUw6sr+8eT7CHQ/FYMt/eLhFEWuMQ5
         JJ6g==
X-Gm-Message-State: AC+VfDzVzXU6gceQBKZQF5rVYHN3rnz9y0uX9iL/Xkb9u6/gz9RaXmBg
        LJ5+t8lU0+7bYxobGiVq+rwk+hERqj0pAxARS8joe+SJ
X-Google-Smtp-Source: ACHHUZ6fdiRyHRP2fN4lQDgf7UxetWM4vIvvYzj4Rf91DGYlG0gZK/df9neDqf1o6XHfScoQbcVX7w==
X-Received: by 2002:a19:771d:0:b0:4f6:217a:561e with SMTP id s29-20020a19771d000000b004f6217a561emr4346590lfc.37.1686587597199;
        Mon, 12 Jun 2023 09:33:17 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id h20-20020a17090619d400b00977db7d08cbsm5401210ejd.74.2023.06.12.09.33.16
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:33:16 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9745d99cfccso795386566b.1
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:33:16 -0700 (PDT)
X-Received: by 2002:a05:6402:6d3:b0:514:93b2:f3b1 with SMTP id
 n19-20020a05640206d300b0051493b2f3b1mr5343956edy.40.1686587246075; Mon, 12
 Jun 2023 09:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093539.895253662@infradead.org>
In-Reply-To: <20230612093539.895253662@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:27:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Message-ID: <CAHk-=wgPtj9Y+nkMe+s20sntBPoadKL7GLxTr=mhfdONMR=iZg@mail.gmail.com>
Subject: Re: [PATCH v3 33/57] perf: Simplify perf_adjust_freq_unthr_context()
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
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

This seems to have the same pattern that I *think* it's entirely
broken, ie you are doing that

                guard(perf_pmu_disable)(event->pmu);

inside a loop, and then you are randomly just removing the

               perf_pmu_enable(event->pmu);

at the end of the loop, or when you do a "continue"./

That's not right.

The thing does not not go out of scope when the loop *iterates*.

It only goes out of scope when the loop *ends*.

Big difference as far as cleanup goes.

So you have not "simplified" the unlocking code, you've broken it. Now
it no longer locks and unlocks for each iteration, it tries to re-lock
every time.

Or have I mis-understood something completely?

               Linus
