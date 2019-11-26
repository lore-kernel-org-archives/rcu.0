Return-Path: <SRS0=hD4o=ZS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159ADC43215
	for <rcu@archiver.kernel.org>; Tue, 26 Nov 2019 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05472071A
	for <rcu@archiver.kernel.org>; Tue, 26 Nov 2019 14:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="A84KCxo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfKZO7C (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:59:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46368 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfKZO7C (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 26 Nov 2019 09:59:02 -0500
Received: by mail-lf1-f65.google.com with SMTP id a17so14328252lfi.13
        for <rcu@vger.kernel.org>; Tue, 26 Nov 2019 06:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eayF6Yqhzpqvz9bB8ZXM3qGNWF9TDQ7NmIzBjxe7aYo=;
        b=A84KCxo3JplzfN47P0+T33FuhKaHV7oZBRfQOL7YKOccGbW9/xBjv9h36FbBYrSjwf
         xBzQA11iGqiNTu5DsHDgBfD0V9rH3G1l0ZVcZeaPdY4CP3EI43lByVv9yda3j2Oy7F4u
         u5EgyvHCgGd31lhCEpRV2T3l64+GUS4k7EjuXq9RMNWDxBYW4KAqHyz4iQT1nuKdIGhT
         J6cJmYSQaiw2PxyMbRS4Hg/ZVmu+BS6DNPFwlTrUbymkmRalxhRasFeL9PfcnxMR0SCK
         4y9IyVL1JpZcGpOgSauIv6pPlRScB5yUuPYg+gc+iQ95uSF3uROri9GKH3Qr14jJzj4Z
         /gNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eayF6Yqhzpqvz9bB8ZXM3qGNWF9TDQ7NmIzBjxe7aYo=;
        b=qeRrgOPZumsGRQUVadPy13DmjIWr3rbjVk+FeUJLbodpoeTVO+oQ6dBPMG5hscRnLT
         DF+jMdhSMgTZcxoM7SFm5cHyC6o2erwpV0nvqkvtUjk5vFRMGvBpaxLPTDKg2VakYGnM
         4bX9BA3Nv93de/ZHKyPuGOjlSGd/nFpaYyyjJOa+WsihGWjftnlNvQ8N7fKKlULuJqL+
         Xh9x8Sj0tTMrXxa8QgLsgipw9On02AL5roqgFlhN3V7UWm32LQo11fmll9YYKUpUIpPV
         oRJ/+WkM7ZjG2DeDA+HZbi4qH63xkyROhMSNKwa9g53pDIYTfsFRxJFVSo76vccg+1rD
         UgVQ==
X-Gm-Message-State: APjAAAUuYlEn16N65QFhAWwQ15AdhDISkAQonzS0VcmhxrOLIk5SAgvv
        YSvNS4FUGjXsi3Ew0dwN4jsI4CRCNhdyxknESxpb9pE=
X-Google-Smtp-Source: APXvYqzIPR8GqnX8vicUKyTvvUVeNrKwiBWpc0adiw2qgXrDYgjL61C+TUQyice7opEnxlFHqP+CHClwKVbkKYGu+Ks=
X-Received: by 2002:a19:6553:: with SMTP id c19mr24805266lfj.158.1574780338762;
 Tue, 26 Nov 2019 06:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20191126135700.743238-1-omosnace@redhat.com> <7ea9d889-c226-68a3-7dfc-3c507eefa53f@tycho.nsa.gov>
In-Reply-To: <7ea9d889-c226-68a3-7dfc-3c507eefa53f@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Nov 2019 09:58:47 -0500
Message-ID: <CAHC9VhQvoMaH8ioQhExFV_noRXvcpro1yJ59vxrJCaT+-Mhzug@mail.gmail.com>
Subject: Re: [PATCH v5] selinux: cache the SID -> context string translation
To:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org
Cc:     rcu@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Michal Sekletar <msekleta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 26, 2019 at 9:32 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Looks good to me and tests passed.  I anticipate resolving conflicts
> between this and the sidtab reverse lookup hash table being non-trivial
> so it will probably require some review when/if Paul merges them both.

I haven't yet looked at the latest revision of either patch, but the
previous versions looked pretty good (my only comments were rather
small, and for the most part everyone else seemed happy as well -
minus the small fixes).  After I send the merge window PRs off to
Linus (tests are passing so that should be today) I'm going to give
these a final look and start trying to smoosh them together; I'll
probably create a new branch ("next-queue" or something similar) once
I'm done where people can review the merge and point out where I
messed things up ;)

-- 
paul moore
www.paul-moore.com
