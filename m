Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AD0C433EF
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 01:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEF861154
	for <rcu@archiver.kernel.org>; Wed,  6 Oct 2021 01:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhJFBGz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Oct 2021 21:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhJFBGy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Oct 2021 21:06:54 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8341C06174E
        for <rcu@vger.kernel.org>; Tue,  5 Oct 2021 18:05:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id on6so905778pjb.5
        for <rcu@vger.kernel.org>; Tue, 05 Oct 2021 18:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:date:message-id:mime-version;
        bh=A4VJniHKXgRvhM9CB9NqAoMDuZnGdMIB2tESsniPS5Y=;
        b=TH36DqQf1moGQssfh4QgEdwXQvhAEmenHRbwdfAHRx7OYEjvUKPDIvA65DiWpKadfr
         jgR+P2cUnr/DFKc+ZhfOGY2pHijmE2lPE9a/szbwDNJ0qofyiUQQz9wlTGcCGJqTlgWm
         mf1KomYOTZNqPDKQyDhgqLAvvKvMyIrlfn8d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version;
        bh=A4VJniHKXgRvhM9CB9NqAoMDuZnGdMIB2tESsniPS5Y=;
        b=BwNEKoZ67Us1t/j1sBD5DDZ0dFakgbSRODBBIG2Ym7kckYFK6I1meiHsLrzHOZV1pZ
         lLh/nQvcq8XqgdEGWm7GC9JlVZ22oEan96V65J+SrtiHg8rFvhHrdNSK7QFTnb7UHG1G
         fVXiy4cBRUCVfjAVkpHUI3RZQ8fUKdkGasY3GuPydeivBqQMTzpD5oExE79bpQJ0ZRXQ
         IJpgI1aTjKTJ5XkJ+u4hEsDBUZJ4cY/RqG9IQhkf+h+qUlkTqNOLFJEdp7fDaq3K9QK3
         fcv9XnjQcXvrceb5bzA4+7EviHHOm5ViiWdLuL+bJ2Ucas+74SA7axWlEh/U2lSRUVrF
         wUOA==
X-Gm-Message-State: AOAM530CBaD/y+FsSEu5pjK/mvRf9sI72iyRBXtLSj2VFJIz8X9Ku9pW
        tT7qQQNB7v3qQgi8E5WHyD/toe30poh8Cw==
X-Google-Smtp-Source: ABdhPJwMdryG4AdKdWKK2MFAk/p+BOVs/L4iZbITxjJxjI2CqYrwvdF8NvcHiMlf0GMa3woH2FXn5w==
X-Received: by 2002:a17:90b:4a07:: with SMTP id kk7mr7417246pjb.37.1633482303184;
        Tue, 05 Oct 2021 18:05:03 -0700 (PDT)
Received: from localhost ([2001:4479:e300:600:ce15:427:ed6f:99de])
        by smtp.gmail.com with ESMTPSA id e4sm14781238pfj.130.2021.10.05.18.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 18:05:02 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        rcu@vger.kernel.org
Subject: instrument_atomic_read()/_write() in noinstr functions?
Date:   Wed, 06 Oct 2021 12:05:00 +1100
Message-ID: <871r4z55fn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

commit b58e733fd774 ("rcu: Fixup noinstr warnings") adds some
instrument_atomic_read calls to rcu_nmi_enter - a function marked
noinstr. Similar calls are added to some other functions as well.

This is causing me some grief on powerpc64 while trying to enable
KASAN. powerpc64 book3s takes some NMIs in real mode, and in real mode
we can't access where I'm proposing to put the KASAN shadow - we can
only access it with translations on. So I end up taking a fault in the
kasan_check_read path via rcu_nmi_enter.

As far as I can tell `instrumentation_begin()` and
`instrumentation_end()` don't make it safe to call instrumentation, they
just tell the developer that instrumentation is safe. (And they are used
to check the balance of _begin()/_end() blocks.)

Is the underlying assumption that the KASAN shadow will always be safe
to access, even in functions marked noinstr? It seems to undercut what
an architecture can assume about a function marked noinstr...

Kind regards,
Daniel

P.S. On a more generic note instrumentation_begin()/_end() is now
scattered across the kernel and it makes me a bit nervous. It's making a
statement about something that is in part a property of how the arch
implements instrumentation. Are arches expected to implement things in
such a way as to make these blocks accurate? For example in
arch/powerpc/include/asm/interrupt.h::interrupt_nmi_enter_prepare we
currently sometimes call nmi_enter in real mode; should we instead only
call it when we have translations on?
