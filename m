Return-Path: <SRS0=BzNy=Z2=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BEC43603
	for <rcu@archiver.kernel.org>; Wed,  4 Dec 2019 09:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CD0206DB
	for <rcu@archiver.kernel.org>; Wed,  4 Dec 2019 09:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4kzqsne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfLDJLj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 4 Dec 2019 04:11:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49619 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725830AbfLDJLj (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 4 Dec 2019 04:11:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575450697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q7Lg8cDUVfxBXxCRzCrnTJ+QCtM61bTFUOU+LDgLN14=;
        b=K4kzqsneSMNQbxK4of9qPaBlU0gsS4w1QlUcNcCnJ/qclh4NjmS7N8fmh/V23TLUpFgsdn
        FFUSBd65+c46GodOTpUjUUwdoWb4k2hpkTk0AHcBoWs/fmTAjP5TpgmlqjS8XVU6tiOaOD
        GaKsnVwwMP/68K2lrauFmn0gm6fVC/s=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-f56X7UULMwSKE6oaBrlkcg-1; Wed, 04 Dec 2019 04:11:33 -0500
Received: by mail-oi1-f200.google.com with SMTP id y11so428442oiy.6
        for <rcu@vger.kernel.org>; Wed, 04 Dec 2019 01:11:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0KbZ2KtCux97FGRs2TrvDEKNeFoXlUkQDFLPI/VaOA=;
        b=i5elANQ/hEsaXhfvNULMTMKez6wIRLxCPq7EOgIWTaj9oDG3mKSYniC/Ppj+dZYcPS
         PWkeCHtTOMqrN12CRXaJeunkupyoZfQfh9L7xjU4AvldKR+GaPTyLWqtKIgSwgfinXeE
         6L9fpI5C2fUuiP+20CFRS+QHMko1MUm5HH1hmfpyXpH6DOQiBssxKUgdfPpkYbzQKguC
         j28FYc5FqSjIyLNsDZLuV2mFS00ZYC3wH8bon7qxXOafK1zfSapg4qGOReXRYdieut0b
         jyhoA0AfZqvwg/Jl1t54jUo49yu7QzfE1JTyHarIaJsjA9bX22ervDoKJnFuQJ5THWVG
         rQ/w==
X-Gm-Message-State: APjAAAVWaFW29wLvtrO8Yh565SfvP9096MPKPdC6jIiAi4kPJ2JBMEpY
        CYDw9Bl/LqvU2752Dt+7KfkmYS13gq3gAhAxoJ3aYI/LXSdXfHWIJNVNOaM7l1vJ+fDKq+3fNWE
        PT9U9DEZGma8UJTKSr5tXfi2xsEDZ
X-Received: by 2002:a05:6808:285:: with SMTP id z5mr73168oic.127.1575450692363;
        Wed, 04 Dec 2019 01:11:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsVWegwPNnar/6/YnRmo0K2tHud+yZApOW8EBYQtMXzMhH1hIKY9dgSIteOmJG3TkmVfqVFLdgvmAheNstyIo=
X-Received: by 2002:a05:6808:285:: with SMTP id z5mr73150oic.127.1575450691959;
 Wed, 04 Dec 2019 01:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
In-Reply-To: <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 4 Dec 2019 10:11:45 +0100
Message-ID: <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
X-MC-Unique: f56X7UULMwSKE6oaBrlkcg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Dec 3, 2019 at 1:33 AM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Nov 22, 2019 at 4:33 AM Jeff Vander Stoep <jeffv@google.com> wrot=
e:
> > This replaces the reverse table lookup and reverse cache with a
> > hashtable which improves cache-miss reverse-lookup times from
> > O(n) to O(1)* and maintains the same performance as a reverse
> > cache hit.
> >
> > This reduces the time needed to add a new sidtab entry from ~500us
> > to 5us on a Pixel 3 when there are ~10,000 sidtab entries.
> >
> > The implementation uses the kernel's generic hashtable API,
> > It uses the context's string represtation as the hash source,
> > and the kernels generic string hashing algorithm full_name_hash()
> > to reduce the string to a 32 bit value.
> >
> > This change also maintains the improvement introduced in
> > commit ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > performance") which removed the need to keep the current sidtab
> > locked during policy reload. It does however introduce periodic
> > locking of the target sidtab while converting the hashtable. Sidtab
> > entries are never modified or removed, so the context struct stored
> > in the sid_to_context tree can also be used for the context_to_sid
> > hashtable to reduce memory usage.
> >
> > This bug was reported by:
> > - On the selinux bug tracker.
> >   BUG: kernel softlockup due to too many SIDs/contexts #37
> >   https://github.com/SELinuxProject/selinux-kernel/issues/37
> > - Jovana Knezevic on Android's bugtracker.
> >   Bug: 140252993
> >   "During multi-user performance testing, we create and remove users
> >   many times. selinux_android_restorecon_pkgdir goes from 1ms to over
> >   20ms after about 200 user creations and removals. Accumulated over
> >   ~280 packages, that adds a significant time to user creation,
> >   making perf benchmarks unreliable."
> >
> > * Hashtable lookup is only O(1) when n < the number of buckets.
> >
> > Changes in V2:
> > -The hashtable uses sidtab_entry_leaf objects directly so these
> > objects are shared between the sid_to_context lookup tree and the
> > context_to_sid hashtable. This simplifies memory allocation and
> > was suggested by Ondrej Mosnacek.
> > -The new sidtab hash stats file in selinuxfs has been moved out of
> > the avc dir and into a new "ss" dir.
> >
> > V3:
> > -Add lock nesting notation.
> >
> > V4/V5:
> > -Moved to *_rcu variants of the various hashtable functions
> > as suggested by Will Deacon.
> > -Naming/spelling fixups.
> >
> > V6
> > -Remove nested locking. Use lock of active sidtab to gate
> > access to the new sidtab.
> > -Remove use of rcu_head/kfree_rcu(), they're unnecessary because
> > hashtable objects are never removed when read/add operations are
> > occurring. Why is this safe? Quoting Ondrej Mosnacek from the
> > selinux mailing list:
> > "It is not visible in this patch, but the sidtab (along with other
> > policy-lifetime structures) is protected by a big fat read-write lock.
> > The only places where sidtab_destroy() is called are (a) error paths
> > when initializing a new sidtab (here the sidtab isn't shared yet, so
> > no race) and (b) when freeing the old sidtab during policy reload - in
> > this case it is happening after a policy write-locked critical
> > section, which had removed the old sidtab pointer from the shared
> > structures, so at that point all sidtab readers will already be
> > accessing the new sidtab and the old one is visible only by the thread
> > doing the destruction."
> >
> > V7
> > -Change format of /sys/fs/selinux/ss/sidtab_hash_stats to match
> > /sys/fs/selinux/avc/hash_stats.
> > -Add __rcu annotation to rcu pointers.
> > -Test with CONFIG_SPARSE_RCU_POINTER and CONFIG_PROVE_RCU.
> > -Add rcu@vger.kernel.org and Paul McKenney to Cc for review of the
> > RCU logic.
> >
> > V8
> > -Removed the __rcu annotation used in V7. The annotation is
> > intended to be applied to pointers to an object, however the
> > objects referenced in the rcu hashtable are allocated in an
> > array.
> > -Fixed bug where multiple SIDs were receiving the same hash
> > due to security_get_user_sids() reusing the same context
> > struct without calling context_init() on it. This bug was
> > discovered and root-caused by Stephen Smalley.
> >
> > V9
> > -Do not compute the hash in string_to_context_struct
> > because this string representation is non-canonical.
> >
> > Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> > Reported-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Reported-by: Jovana Knezevic <jovanak@google.com>
> > ---
> >  security/selinux/Kconfig            |  12 ++
> >  security/selinux/include/security.h |   1 +
> >  security/selinux/selinuxfs.c        |  65 +++++++
> >  security/selinux/ss/context.h       |  11 +-
> >  security/selinux/ss/policydb.c      |   5 +
> >  security/selinux/ss/services.c      |  96 +++++++---
> >  security/selinux/ss/services.h      |   4 +-
> >  security/selinux/ss/sidtab.c        | 263 ++++++++++++++--------------
> >  security/selinux/ss/sidtab.h        |  16 +-
> >  9 files changed, 306 insertions(+), 167 deletions(-)
>
> Thanks Jeff, as well as everyone else who contributed reviews and feedbac=
k.
>
> I've pulled this into a working branch and I'll be merging it with the
> other sidtab patches before posting it to a "next-queue" branch for
> review later this week.  When done, I'll send a note to the list, as
> well as the relevant patch authors; your help in reviewing the merge
> would be greatly appreciated.

I tried doing the merge on my own here [1], you can use it as a sanity
check if we came to the same/similar result. I based it off your
existing next-queue, which contains only Jeff's patch at the time of
writing. I only build-tested it so far.

Note that there are two whitespace cleanups included in the string
cache commit that I intuitively did while resolving the merge
conflicts. You might want to move those to the first commit or just
ignore them.

[1] https://gitlab.com/omos/linux-public/compare/selinux-next...rebase-seli=
nux-sidtab-string-cache

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

