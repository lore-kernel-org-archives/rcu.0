Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6CBECAAD3
	for <rcu@archiver.kernel.org>; Mon,  5 Sep 2022 10:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiIEKRo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 5 Sep 2022 06:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiIEKRL (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 5 Sep 2022 06:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D71F558DC
        for <rcu@vger.kernel.org>; Mon,  5 Sep 2022 03:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662372916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MSP7nxlZMdVy1XY332EieoPjlkoDCB95TOL/13xEK/o=;
        b=NcvLkzD4qIA3oHaITB1k4o7t2A0n6AFWF9H/7T56RNgreJBp+ibo3NosUNECYu8tOx82pG
        ZaiSH35zOj8835TrZQ2PcGwoBbjsWuoXLaNpwIH+QRd5vsBDkwAphyv/fSDISUn/wC3SWw
        rK710wmTN6IYyYOCq3/RJOj/tmKILJM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-Z68_IGTsN8-guhvi5pOpAA-1; Mon, 05 Sep 2022 06:15:13 -0400
X-MC-Unique: Z68_IGTsN8-guhvi5pOpAA-1
Received: by mail-pg1-f197.google.com with SMTP id e187-20020a6369c4000000b0041c8dfb8447so4282222pgc.23
        for <rcu@vger.kernel.org>; Mon, 05 Sep 2022 03:15:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MSP7nxlZMdVy1XY332EieoPjlkoDCB95TOL/13xEK/o=;
        b=IiF01j8/eLGWhzQZ/2O1zsuHw+8+MupDr78bXxpz2KczVHLYoZRw01D52k86avE+r9
         sTnWUBI+ASewHs95VemktRJPW25bST9wHGgVW3eN4gyx/NjPEtW6MrH1QE80HxTSykJy
         5BAfdsz4Hh7V9YByDkua56ZnHDKsbHeWwIdNNDkFBwspBBCdeQ83++9gv9rO2LTZwm1N
         v2xESoXhHr33bzE6OZ2s956Q5bW+lRFtpqs/PAzH/H50BoUfBqnG0B/jLpC2QfiKFaUz
         SIsmFY/wAJ/A50NFP+NWaO0PLv9+VzivdOghSmsf/XbHGLkRSDTz2C83PO4W2SXK3tWB
         sHtA==
X-Gm-Message-State: ACgBeo1c4UCC0EC1Kc3j6vgVVdCTV/+0fq0e1tRhmpox7JPoOAHev6UG
        89d2wVwYKjSrb01r+DCryiwjk4jqs4AO6JrMWxZkUicW3VoE6LCrOi7TYu0G1qmt+YwOye+MIIn
        RpesXsDrYWsS1WIoSEzoelv6TpXv9
X-Received: by 2002:a63:1a53:0:b0:41f:5298:9b5f with SMTP id a19-20020a631a53000000b0041f52989b5fmr40538770pgm.244.1662372912672;
        Mon, 05 Sep 2022 03:15:12 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Tx02dLJJPBEF5iEuwkRvzHVzfPWHXhezKY1SrBF19i/Y78aVKPcFtIbx5YArUH92QYIk6bCU8DWnCMmzhW34=
X-Received: by 2002:a63:1a53:0:b0:41f:5298:9b5f with SMTP id
 a19-20020a631a53000000b0041f52989b5fmr40538753pgm.244.1662372912450; Mon, 05
 Sep 2022 03:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220901152632.970018-1-omosnace@redhat.com> <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
In-Reply-To: <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 5 Sep 2022 12:15:01 +0200
Message-ID: <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin Pitt <mpitt@redhat.com>, Vasily Averin <vvs@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > The goal of these patches is to avoid calling capable() unconditionally
> > in simple_xattr_list(), which causes issues under SELinux (see
> > explanation in the second patch).
> >
> > The first patch tries to make this change safer by converting
> > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > while the xattrs->lock is held. I didn't find evidence that this is an
> > issue in the current code, but it can't hurt to make that change
> > either way (and it was quite straightforward).
>
> Hey Ondrey,
>
> There's another patchset I'd like to see first which switches from a
> linked list to an rbtree to get rid of performance issues in this code
> that can be used to dos tmpfs in containers:
>
> https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
>
> I don't think Vasily has time to continue with this so I'll just pick it
> up hopefully this or the week after LPC.

Hm... does rbtree support lockless traversal? Because if not, that
would make it impossible to fix the issue without calling capable()
inside the critical section (or doing something complicated), AFAICT.
Would rhashtable be a workable alternative to rbtree for this use
case? Skimming <linux/rhashtable.h> it seems to support both lockless
lookup and traversal using RCU. And according to its manpage,
*listxattr(2) doesn't guarantee that the returned names are sorted.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

