Return-Path: <SRS0=lJWX=7Z=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B4FC433E0
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 19:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B61206D7
	for <rcu@archiver.kernel.org>; Fri, 12 Jun 2020 19:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dhZFlHSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgFLT2P (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 12 Jun 2020 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLT2P (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 12 Jun 2020 15:28:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA5C03E96F
        for <rcu@vger.kernel.org>; Fri, 12 Jun 2020 12:28:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t7so4576867pgt.3
        for <rcu@vger.kernel.org>; Fri, 12 Jun 2020 12:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=zsiP9iQ9KiOQJSx2zUcdJopzapXweO50L90z0lhR9+4=;
        b=dhZFlHSQ5y0Nn3ryJaMzoMy/15vrArjg+ifwa8iPrLFnoe6amNlNNkx0GYNBa7V9s3
         OozZSabvHjLObtWmECjBNPoYoWpJDxJGzGxEY6D7X7r3q/7lG2TfNtKNECLpfGdiXp1V
         uS/ePjwyWiSp85V11V+giaEBc9EGiakNP6H4UFDRcjGQmTwBcMeVWX+nMy+BG4rwKTKS
         SUxlFDLybdbVA+exakNdfYA/pGBccnCyPWy/57Dm1hmORJP2dpUXLzvFhC3YCt1vO4ov
         B2kmt8hA4z6pDfkkm5EHeFVxSRwK1yusgnqhO+43SWNnXCwsMpU2+I0nS3KUQXA1qwaw
         CBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=zsiP9iQ9KiOQJSx2zUcdJopzapXweO50L90z0lhR9+4=;
        b=UKM/SBoVo50ie/gjL32xv0B9cdQm5RutFKHKpDOhQ4f+a4RJGIki6dVVPz6jVl5frD
         eC+d9wFw5H4iyTwYBxXFNJj8gSf5srGfvD8XD3191Vn1UxQkxA3xUQ77WtrP2ZM3QTfq
         eUQpp52bm5IWPc4JM6nWBzILQm85rMFOqPck1KEux3lHH2BydKoKrtuG4ju0I6siD6uA
         01V7NIb7xBfKDL9kIp1/ms2M6bkVuxGMJPeOzVboqQ1/2noFKXbJ2ez+h93AQXjoENjJ
         LZyqFF4/hX3+6Hiy9Nl13EZuLEZFk21DuMWhA2gPSW6rPRlfgBiWz9VtsdAvdzxOeAf0
         y53Q==
X-Gm-Message-State: AOAM532oEiOO4CQ7zvdznO81YEjSXLaR6ZQNBQaBCyMi1GQQJ4r2ziQA
        jHFpW8FtVLKn4D8f65sZM/MP3Q==
X-Google-Smtp-Source: ABdhPJwgHA7//MRGcr/0D8HMMU76zBNsnkEyPAH29sduBCZe1RFg0IURCKWcY6EMZvsXlnYGKiX4iw==
X-Received: by 2002:a65:6496:: with SMTP id e22mr12507501pgv.63.1591990093576;
        Fri, 12 Jun 2020 12:28:13 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:c0da:d349:5a19:d9c1? ([2601:646:c200:1ef2:c0da:d349:5a19:d9c1])
        by smtp.gmail.com with ESMTPSA id 12sm7322426pfb.3.2020.06.12.12.28.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 12:28:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
Date:   Fri, 12 Jun 2020 12:28:11 -0700
Message-Id: <FE145E46-D160-4826-9D81-553EB2A660C1@amacapital.net>
References: <87r1ukxf1b.fsf@nanos.tec.linutronix.de>
Cc:     paulmck@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Andrew Lutomirski <luto@kernel.org>,
        X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <87r1ukxf1b.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17F80)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


> On Jun 12, 2020, at 12:25 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BF"Paul E. McKenney" <paulmck@kernel.org> writes:
>>> On Fri, Jun 12, 2020 at 10:49:53AM -0700, Paul E. McKenney wrote:
>>> I will therefore address this issue in a follow-on patch.
>>=20
>> I should add that -your- patch from yesterday did -not- cause this
>> problem, in case that is of interest.
>=20
> So I still can add it back and amend the changelog and comment:
>=20
> Change the condition from !rcu_is_watching() to is_idle_task(current) ||
> rcu_is_watching() which enforces that interrupts in the idle task
> unconditionally invoke rcu_irq_enter() independent of the RCU state. For
> most scenarios is_idle_task() would be sufficient but Task RCU needs it
> according to Paul.
>=20
>=20

Can you easily get a call trace for a case where the system is fully booted,=
 is_idle_task returns false, and rcu_is_watching() also returns false?=
