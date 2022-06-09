Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FACC433EF
	for <rcu@archiver.kernel.org>; Thu,  9 Jun 2022 11:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbiFILbo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 9 Jun 2022 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbiFILbT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 9 Jun 2022 07:31:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F188D3A481E
        for <rcu@vger.kernel.org>; Thu,  9 Jun 2022 04:31:11 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id s12so39645281ejx.3
        for <rcu@vger.kernel.org>; Thu, 09 Jun 2022 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XewJc/p+7yp1re11t6BfmEtfp27WPbXPnywgusXXTc=;
        b=dD0Bz9eW32MHk+TeRLS+QqFpXQSyJG1PFuM0sFc2oIQiPmRbBKI4wiAjUnrY0TOPB3
         vmLpoVIxPESYT9ISrrirk39KtLhSpCgEKtG3yrDCpv/Gh6ZWSamp4kS8RJg23gIGNIEa
         lDd2yagv7BcuRvFzrWxMhthjwknH7br96szys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XewJc/p+7yp1re11t6BfmEtfp27WPbXPnywgusXXTc=;
        b=oPyQxqD66mCpe8RuA3LY+uR3/GpErUl+t8xj8985P0d1qcEYufjkkSaHH+UAWh34n0
         hnHT1SATFFZFQShUz2TMqmv8FFXap260iYsuS5Lh9R54JcIdiPgNzBUUXVXDuiiyIHcf
         kSA6dqgjYVFTT26+3pyK/kJQDykttCJ5CE68fXFu4jaxw+BRycnu1FLdsKDhA288GWeV
         uNf52BbMsnDcnjPUdHcZPUVJLLtw6f7mZtZhD0UwaWEv4LxFeY4pgUgs8yRBdZToXiUO
         Uz08aINbJ1CFaXX8F4deciw1YV8rsq3u3kYwApwMmvXgjZo7RCZkmAa5+XN/nY+5ucqm
         Ws2A==
X-Gm-Message-State: AOAM531VpgsdME5/3cCYagW8XG952IH8l5R6TDhJYqLFvHAB9kjNvvg9
        XTPa1dyYFaFnOzKgovdKRihil/+kBfLnJ6YTp/yf0Q==
X-Google-Smtp-Source: ABdhPJx9nV7wAxP/lyAtNedlGfDPIROj9YXpatcH7EqCac1uVlfTSKszMzYbWUxkatf8WgjTCZNOZTjPAlJBoltWDx4=
X-Received: by 2002:a17:907:c22:b0:711:dc95:3996 with SMTP id
 ga34-20020a1709070c2200b00711dc953996mr13928684ejc.62.1654774269713; Thu, 09
 Jun 2022 04:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220608142723.103523089@infradead.org> <20220608144517.444659212@infradead.org>
 <YqG6URbihTNCk9YR@alley> <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
In-Reply-To: <YqHFHB6qqv5wiR8t@worktop.programming.kicks-ass.net>
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
Date:   Thu, 9 Jun 2022 20:30:58 +0900
Message-ID: <CA+_sPaoJGrXhNPCs2dKf2J7u07y1xYrRFZBUtkKwzK9GqcHSuQ@mail.gmail.com>
Subject: Re: [PATCH 24/36] printk: Remove trace_.*_rcuidle() usage
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk,
        ulli.kroll@googlemail.com, linus.walleij@linaro.org,
        shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, bcain@quicinc.com,
        chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org,
        sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de,
        dinguyen@kernel.org, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu,
        amakhalov@vmware.com, pv-drivers@vmware.com,
        boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com,
        rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz,
        gregkh@linuxfoundation.org, mturquette@baylibre.com,
        sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org,
        sudeep.holla@arm.com, agross@kernel.org,
        bjorn.andersson@linaro.org, anup@brainfault.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        jacob.jun.pan@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, rostedt@goodmis.org,
        john.ogness@linutronix.de, paulmck@kernel.org, frederic@kernel.org,
        quic_neeraju@quicinc.com, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, jpoimboe@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-xtensa@linux-xtensa.org,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org,
        rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

My emails are getting rejected... Let me try web-interface

Kudos to Petr for the questions and thanks to PeterZ for the answers.

On Thu, Jun 9, 2022 at 7:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
> This is the tracepoint used to spool all of printk into ftrace, I
> suspect there's users, but I haven't used it myself.

I'm somewhat curious whether we can actually remove that trace event.
