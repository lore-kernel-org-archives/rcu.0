Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FE9C88CB7
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 16:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbjFLQZ2 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjFLQZN (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Jun 2023 12:25:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8686BF9
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:25:12 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977d6aa3758so827908666b.0
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686587111; x=1689179111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=DwHmkFITL8Ew3tvDpAr7Y+tiUZ1se6ElKdUROkam2eBQl51HeUB6tU4j7/nL0BZxSg
         7HW6MDP6UsN3m5wPjJ/NPjyvT/fkLUXbHnr460hjdgWwhdyc9hmrd04I8awSxs/tuglB
         raZeZ3BFDkkR68xdwTF4xhvS1FT9B1tyBn6jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686587111; x=1689179111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/KCMaMkVpL2TvKmUhvddPCRbVA7+Ro9TFJ9/0bVSYQ=;
        b=HvnQ//guaFK90vRETnj1pduiT1Hw7YC9qsepZ/++1v2B1mrtFsdzB79oZy2DJav8YR
         hQDsStsSNam09s1GwIRY4E7NEpTFPW/67VoBzFCDPb1G7ktcLB1IScnOKGvHw+ADDIxA
         vjn//g8wQOvVPR9kpjYTEfZPWZthFS95yDyRBIZm3G9Ou7z/LxO1spFmnORZJMG5wB3v
         +4cYxT7XbOQkqPEjVnI0a1+nNDhV13tkIJxmMEjYLOPUQGaaNnIweTWgBJ2WYKJ0IcQL
         xdmf8B8SR+DdY8xpZk7Yl5qHEtRXhjgqcdgf3t/fsq2nVL+iyQVyL42Stutr0dQKCMLe
         RWhg==
X-Gm-Message-State: AC+VfDzvXtv5URBGyhJk/BngaqUgwna6z9IPSnbEiPDBtxyu177TRswV
        Vp2AmYpksfYBqyxE4Xdlzs/Y/5xL7239ki748RzHr8nf
X-Google-Smtp-Source: ACHHUZ4Zh2SvgHdhVTYrTP2cjGSuR06EQnSphis1R/DDBspN1CpQGAZMGyEycv3Z4FdRIdkQbPNhzA==
X-Received: by 2002:a17:906:da85:b0:96a:4ea0:a1e7 with SMTP id xh5-20020a170906da8500b0096a4ea0a1e7mr10941203ejb.50.1686587110857;
        Mon, 12 Jun 2023 09:25:10 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id i3-20020a170906264300b009737b8d47b6sm5364444ejc.203.2023.06.12.09.25.10
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:25:10 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-30fa23e106bso2114715f8f.3
        for <rcu@vger.kernel.org>; Mon, 12 Jun 2023 09:25:10 -0700 (PDT)
X-Received: by 2002:aa7:d14e:0:b0:50b:c3f0:fb9d with SMTP id
 r14-20020aa7d14e000000b0050bc3f0fb9dmr5534541edo.41.1686586776585; Mon, 12
 Jun 2023 09:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230612090713.652690195@infradead.org> <20230612093541.598260416@infradead.org>
In-Reply-To: <20230612093541.598260416@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jun 2023 09:19:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Message-ID: <CAHk-=wh6JEk7wYECcMdbXHf5ST8PAkOyUXhE8x2kqT6to+Gn9Q@mail.gmail.com>
Subject: Re: [PATCH v3 56/57] perf: Simplify perf_pmu_output_stop()
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

This patch looks completely broken to me.

You now do

                if (err =3D=3D -EAGAIN)
                        goto restart;

*within* the RCU-guarded section, and the "goto restart" will guard it agai=
n.

So no. Sending out a series of 57 patches that can have these kinds of
bugs in it is not ok. By patch 56 (which just happened to come in
fairly early for me), all sane peoples eyes have glazed over and they
don't react to this kind of breakage any more.

                Linus

On Mon, Jun 12, 2023 at 2:39=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7977,7 +7977,8 @@ static void perf_pmu_output_stop(struct
>         int err, cpu;
>
>  restart:
> -       rcu_read_lock();
> +       /* cannot have a label in front of a decl */;
> +       guard(rcu)();
>         list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry) {
>                 /*
>                  * For per-CPU events, we need to make sure that neither =
they
> @@ -7993,12 +7994,9 @@ static void perf_pmu_output_stop(struct
>                         continue;
>
>                 err =3D cpu_function_call(cpu, __perf_pmu_output_stop, ev=
ent);
> -               if (err =3D=3D -EAGAIN) {
> -                       rcu_read_unlock();
> +               if (err =3D=3D -EAGAIN)
>                         goto restart;
> -               }
>         }
> -       rcu_read_unlock();
>  }
