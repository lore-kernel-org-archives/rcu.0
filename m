Return-Path: <SRS0=BzNy=Z2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8623DC43603
	for <rcu@archiver.kernel.org>; Wed,  4 Dec 2019 23:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5507A2077B
	for <rcu@archiver.kernel.org>; Wed,  4 Dec 2019 23:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="UyR9JWeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfLDXwf (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Dec 2019 18:52:35 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45265 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbfLDXwe (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 4 Dec 2019 18:52:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id d20so1287584ljc.12
        for <rcu@vger.kernel.org>; Wed, 04 Dec 2019 15:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgY37x/+7Cql9NNZG79hPhxCQjhuFiHviwcms4LCaiM=;
        b=UyR9JWeB9nrCzdLV2qA4dvotgBdtU8xShtqsd77nv/IRUQLcA7GyHe+DlMZmP0BWfS
         soHdg6DlaDpqiq3n4hNv5bo39scYknTSYYjpOgJB+23tKJGgxODHrrQrxavcDa0qinhy
         ne6IViJAWrUByRqpbZbHZjNaGDOB45pNjKDoBhqrDp97nK2bSAaBK+AmfM0Bx8PP+a6t
         MUZuqT+GsVCls9CgX7zLFRXh6mdcyyiuK95A6K0EHUXXgI5siHN6g9/W6b7PPShH3m+S
         hyBHVgtvi0z6/vGEjq9A04cTjoqb0lpvhFn3pRoSpM0w+a8Ko62l39IcL/Q8naGiVjDa
         UGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgY37x/+7Cql9NNZG79hPhxCQjhuFiHviwcms4LCaiM=;
        b=FilmByZrvKukTF7MQTgLkQqyl4OP9GaRr0oNUYfXFjZgyjJ0ICwqVOoBDMPMBw7K4/
         mcT5VKu6Y6fS0WJRqJ8Ycv4XtvsgqSHI0hPsyiumvP+/VA+t44ocmxxk9ZHQCYLQmJYI
         VSrE8DG66vLhhKTJCOJF8FXlSN0xzkfpkH2JCaOpwHAgK3zwjqQFi1qYXw54Ld2RbpaG
         GmVrl7oJwccFMkZrZayZ1x/Lq4StDsnebI/afwHfiyPbtQ8m25Qt4wvOP4Nar8gKUtfC
         c5NHNiEu6C8EAYLEOaQIr2miKgGhVVEnujdTTwXi5pjNFmYXGRHAHXivCjEucTyvHAx+
         3Dyw==
X-Gm-Message-State: APjAAAWZ3YiEgSM8CU1V2DJPvmUQu7QPknUTOQ+C2bctm7suOGuAolMW
        sgN3RNC8s7rXBCqePm3kx9nCBWZGDRglQMeEKMg6
X-Google-Smtp-Source: APXvYqwWgpKbHYRC+2VdIQJLVcuDlKqBe+8g7wH4TyCAyQQ/homvy4q0HI54Q3UL8Bh+GTmuJpRjD8QIR446kh5G35U=
X-Received: by 2002:a2e:9d9a:: with SMTP id c26mr3670252ljj.225.1575503552423;
 Wed, 04 Dec 2019 15:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
In-Reply-To: <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Dec 2019 18:52:21 -0500
Message-ID: <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Dec 4, 2019 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Dec 3, 2019 at 1:33 AM Paul Moore <paul@paul-moore.com> wrote:
> > Thanks Jeff, as well as everyone else who contributed reviews and feedback.
> >
> > I've pulled this into a working branch and I'll be merging it with the
> > other sidtab patches before posting it to a "next-queue" branch for
> > review later this week.  When done, I'll send a note to the list, as
> > well as the relevant patch authors; your help in reviewing the merge
> > would be greatly appreciated.
>
> I tried doing the merge on my own here [1], you can use it as a sanity
> check if we came to the same/similar result. I based it off your
> existing next-queue, which contains only Jeff's patch at the time of
> writing. I only build-tested it so far.

Thanks, that was a good sanity check.  There are some minor diffs from
what I ended up with, but nothing substantive that I can see.

Although I'll be honest, the merge wasn't as bad as I thought it would
be; most of the fuzz was simply due shuffling and renaming of data
structures, which generally isn't too bad.  Although I'm still
building the kernel to test it, so let's see if that statement still
holds (although it looks like it passed Stephen's testing). ;)

If you haven't noticed already, the merge currently lives in the
selinux/next-queue branch; if you notice anything off, feel free to
send a fixup patch.

> Note that there are two whitespace cleanups included in the string
> cache commit that I intuitively did while resolving the merge
> conflicts. You might want to move those to the first commit or just
> ignore them.

When looking at the combined diff between the two sidtab patches and
comparing it to your merge I did make a few additional small cosmetic
tweaks.  Assuming the testing goes well, I'll probably go over
everything one more time to make sure the style looks okay, but today
I was focusing more on the correctness.

> [1] https://gitlab.com/omos/linux-public/compare/selinux-next...rebase-selinux-sidtab-string-cache

-- 
paul moore
www.paul-moore.com
