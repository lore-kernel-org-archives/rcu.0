Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3967C433FE
	for <rcu@archiver.kernel.org>; Thu,  3 Nov 2022 09:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiKCJFg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 3 Nov 2022 05:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKCJFf (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 3 Nov 2022 05:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D451ED11B
        for <rcu@vger.kernel.org>; Thu,  3 Nov 2022 02:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667466280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDq35n6R89I+Aaea6Q0FlPepC7iWCing+SCmG3mC5oY=;
        b=C1psXn2wcicu8H93/tF3pHM2y6LILYcvpcGtwDQvbgRwymzZVENhz8ZN7arRrBKwWwcjIU
        n9Hkh/boBCfMtiodItbWbMiWWgfQFRQDj7mdxWIS+aEg100wD3l1RDya5VqnY8VCsGBDqY
        UzGQCd6sU0dIh1cs+RSLv7axIwwCx0s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-32-Ej_yS1BUPIKJX9-4ZX1pDw-1; Thu, 03 Nov 2022 05:04:38 -0400
X-MC-Unique: Ej_yS1BUPIKJX9-4ZX1pDw-1
Received: by mail-pl1-f197.google.com with SMTP id i17-20020a170902cf1100b00183e2a963f5so1004810plg.5
        for <rcu@vger.kernel.org>; Thu, 03 Nov 2022 02:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDq35n6R89I+Aaea6Q0FlPepC7iWCing+SCmG3mC5oY=;
        b=4cN4WdjK5G0i34Wcxj/6/jHf0b3IIS5Xe1bHNoCLA9hOs1HZRIU4Wz0yHMrOWRhJN5
         rOLNL0RcLcZ3H3p6GFRhaVyRM3TAS6yamqPHWfzGwNGzC9Q0SrTe0mPAboQAcI9lXc0G
         aZRIPY0B7bjgE64lQJn85lnH/cbqQBmJ3rknaB0YSrJbruc45sHXoIXDoGIfpfuM/fuP
         4d5Le3E0Yl7VuTsiyB2Kgh0OXiRRKvPdwokZQMYudkly4jrFyX6INydtAniX7gAnOa0C
         fVJE02u6WuFUUkgKm02YwqqwGCZR0FEaUY3FMQV9bBzAd2bb2xkVtEC3IMZibfS/TjUy
         8ewg==
X-Gm-Message-State: ACrzQf0wGuN1W3PQWeRfDqBE9348E9HJG9YrJ8poCOUdoYba6pWKVyuj
        uuvu4nZcunLz6VZy+8Y49ykFVdMtfdfjkSFjer4HSHufWq56YHSo3lO0x5S11iI+Hq8vA1iVW0S
        V5wlhvoG1aA5eVyFhJ7YzNRu1bxPN
X-Received: by 2002:a62:b40a:0:b0:56c:6c63:fdb2 with SMTP id h10-20020a62b40a000000b0056c6c63fdb2mr29340404pfn.4.1667466277840;
        Thu, 03 Nov 2022 02:04:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6XOQlonLupUwOI85H/ppJIQcX6sIKgcNNVh7P108FI/WJe10CsX84EYvQDqK4PHK5gJzbCdiQD9UiFCntuRmw=
X-Received: by 2002:a62:b40a:0:b0:56c:6c63:fdb2 with SMTP id
 h10-20020a62b40a000000b0056c6c63fdb2mr29340382pfn.4.1667466277487; Thu, 03
 Nov 2022 02:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220901152632.970018-1-omosnace@redhat.com> <20220905090811.ocnnc53y2bow7m3i@wittgenstein>
 <CAFqZXNu_jf0D8LQLc15+ZrFne5F5F5PFNbkT-EkfqXvNdSKKsQ@mail.gmail.com>
 <20220905153036.zzcovknz7ntgcn5f@wittgenstein> <20221102182451.aoos5udhf6rbb6us@wittgenstein>
In-Reply-To: <20221102182451.aoos5udhf6rbb6us@wittgenstein>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 3 Nov 2022 10:04:25 +0100
Message-ID: <CAFqZXNuG0gjRjSMpaMJQqmmwtqr5Yx1r6Eg0YpJ4DQ6u9CWqRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Vasily Averin <vvs@openvz.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, rcu@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 2, 2022 at 7:25 PM Christian Brauner <brauner@kernel.org> wrote:
> On Mon, Sep 05, 2022 at 05:30:36PM +0200, Christian Brauner wrote:
> > On Mon, Sep 05, 2022 at 12:15:01PM +0200, Ondrej Mosnacek wrote:
> > > On Mon, Sep 5, 2022 at 11:08 AM Christian Brauner <brauner@kernel.org> wrote:
> > > > On Thu, Sep 01, 2022 at 05:26:30PM +0200, Ondrej Mosnacek wrote:
> > > > > The goal of these patches is to avoid calling capable() unconditionally
> > > > > in simple_xattr_list(), which causes issues under SELinux (see
> > > > > explanation in the second patch).
> > > > >
> > > > > The first patch tries to make this change safer by converting
> > > > > simple_xattrs to use the RCU mechanism, so that capable() is not called
> > > > > while the xattrs->lock is held. I didn't find evidence that this is an
> > > > > issue in the current code, but it can't hurt to make that change
> > > > > either way (and it was quite straightforward).
> > > >
> > > > Hey Ondrey,
> > > >
> > > > There's another patchset I'd like to see first which switches from a
> > > > linked list to an rbtree to get rid of performance issues in this code
> > > > that can be used to dos tmpfs in containers:
> > > >
> > > > https://lore.kernel.org/lkml/d73bd478-e373-f759-2acb-2777f6bba06f@openvz.org
> > > >
> > > > I don't think Vasily has time to continue with this so I'll just pick it
> > > > up hopefully this or the week after LPC.
> > >
> > > Hm... does rbtree support lockless traversal? Because if not, that
> >
> > The rfc that Vasily sent didn't allow for that at least.
> >
> > > would make it impossible to fix the issue without calling capable()
> > > inside the critical section (or doing something complicated), AFAICT.
> > > Would rhashtable be a workable alternative to rbtree for this use
> > > case? Skimming <linux/rhashtable.h> it seems to support both lockless
> > > lookup and traversal using RCU. And according to its manpage,
> > > *listxattr(2) doesn't guarantee that the returned names are sorted.
> >
> > I've never used the rhashtable infrastructure in any meaningful way. All
> > I can say from looking at current users that it looks like it could work
> > well for us here:
> >
> > struct simple_xattr {
> >       struct rhlist_head rhlist_head;
> >       char *name;
> >       size_t size;
> >       char value[];
> > };
> >
> > static const struct rhashtable_params simple_xattr_rhashtable = {
> >       .head_offset = offsetof(struct simple_xattr, rhlist_head),
> >       .key_offset = offsetof(struct simple_xattr, name),
> >
> > or sm like this.
>
> I have a patch in rough shape that converts struct simple_xattr to use
> an rhashtable:
>
> https://gitlab.com/brauner/linux/-/commits/fs.xattr.simple.rework/
>
> Light testing, not a lot useful comments and no meaningful commit
> message as of yet but I'll get to that.

Looks mostly good at first glance. I left comments for some minor
stuff I noticed.

> Even though your issue is orthogonal to the performance issues I'm
> trying to fix I went back to your patch, Ondrej to apply it on top.
> But I think it has one problem.
>
> Afaict, by moving the capable() call from the top of the function into
> the actual traversal portion an unprivileged user can potentially learn
> whether a file has trusted.* xattrs set. At least if dmesg isn't
> restricted on the kernel. That may very well be the reason why the
> capable() call is on top.

Technically it would be possible, for example with SELinux if the
audit daemon is dead. Not a likely situation, but I agree it's better
to be safe.

> (Because the straightforward fix for this would be to just call
> capable() a single time if at least one trusted xattr is encountered and
> store the result. That's pretty easy to do by making turning the trusted
> variable into an int, setting it to -1, and only if it's -1 and a
> trusted xattr has been found call capable() and store the result.)

That would also run into the conundrum of holding a lock while
(potentially) calling into the LSM subsystem. And would it even fix
the information leak? Unless I'm missing something it would only
prevent a leak of the trusted xattr count, but not the presence of any
trusted xattr.

> One option to fix all of that is to switch simple_xattr_list() to use
>
>         ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)
>
> which doesn't generate an audit event.
>
> I think this is even the correct thing to do as listing xattrs isn't a
> targeted operation. IOW, if the the user had used getxattr() to request
> a trusted.* xattr then logging a denial makes sense as the user
> explicitly wanted to retrieve a trusted.* xattr. But if the user just
> requested to list all xattrs then silently skipping trusted without
> logging an explicit denial xattrs makes sense.
>
> Does that sound acceptable?

Yes, I can't see any reason why that wouldn't be the best solution.
Why haven't I thought of that? :)

I guess you will want to submit a patch for it along with your
rhashtable patch to avoid a conflict? Or would you like me to submit
it separately?


--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

