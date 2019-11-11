Return-Path: <SRS0=YBb/=ZD=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4586AC17443
	for <rcu@archiver.kernel.org>; Mon, 11 Nov 2019 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF3620656
	for <rcu@archiver.kernel.org>; Mon, 11 Nov 2019 08:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XkMYZRMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKIdH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 11 Nov 2019 03:33:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726770AbfKKIdG (ORCPT
        <rfc822;rcu@vger.kernel.org>); Mon, 11 Nov 2019 03:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573461185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SI9+RvOGypR2KoH29dfLVgWtQl199+4Zg7Uo13CLCCI=;
        b=XkMYZRMrR2fawqqDVJzZCHYvHEu8/SKtC/DHKv5eJBO0MqtRRDBETa0nwXqHltLtmhmBbB
        F/7if7N0MMEciLDaRPPVj6P1Esc6+NK9baN/BGewG6xcsy6VqxDfuaMMz7/rD3ymriijg7
        rUpRS05djbhwNYWmOCufYDueIO/hgsU=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-LNXsQVGDNR6AzWxwcAxY8Q-1; Mon, 11 Nov 2019 03:33:03 -0500
Received: by mail-oi1-f199.google.com with SMTP id t185so10999108oif.13
        for <rcu@vger.kernel.org>; Mon, 11 Nov 2019 00:33:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Hs7tCyeFd/Wol64UzTQaQbtAGrWoy0+HduJ6HjXwiA=;
        b=h2ipHZrA8B+5tay1SgrIGD4RP+wTxOuasQrifw3OpfzNj2g81DxBz5ZfYgOoDafKt+
         0qh/lE99ZKU12+2veCaX3WiN+N9uzNfkRJjgqduNVynQ97uvdEy9L9YuMrFvva00ZBVu
         Zk3x73oVP6jjA7zcXlGeVYCSZ78SA9SALWB4w5uFSYUF6eXbipWMXDAOs/wHpSYqOx9J
         Jf3ziRfPAdXFnVY+pIzHDTDcgTyUh87O6wk6sSE61mJNKq4lDntmffdfpsop29973Y67
         Y8IwpKZVR+6LyV3P3zVIIR2oFTQadSqL+/bE27dZEhCYnJO0I7seAe5UfLA4TNx4wMBT
         Uf7A==
X-Gm-Message-State: APjAAAWXd5gD3FPPjdYKub2Jw/evLLefXujj3eRaCTh318vKWwq/TwVd
        19VXbSHbigGV/0llSaCIUwqn8MQWHPts5xxchCFSxRhYbuKyzXhYG0IyOVUO7nAq/YYXeR4iBL1
        9/fo1NhO4pLkdk7pX532xq7R2P0xn
X-Received: by 2002:a05:6808:8d8:: with SMTP id k24mr22106021oij.26.1573461182227;
        Mon, 11 Nov 2019 00:33:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxKNOT2p80YoPSne14PT7F85YJAzY0j2Oj7YyOp60EugTGQAmDr1HbFGGTjUiam7tK33NtlRc7vmja+QbCpQLA=
X-Received: by 2002:a05:6808:8d8:: with SMTP id k24mr22105990oij.26.1573461181840;
 Mon, 11 Nov 2019 00:33:01 -0800 (PST)
MIME-Version: 1.0
References: <20191108083909.658-1-omosnace@redhat.com> <20191110210334.GD2865@paulmck-ThinkPad-P72>
In-Reply-To: <20191110210334.GD2865@paulmck-ThinkPad-P72>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 Nov 2019 09:32:50 +0100
Message-ID: <CAFqZXNstDtFsoUXCJE3bJqSc0etfnxYzs++MbD_ghZiFOGP+sA@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: cache the SID -> context string translation
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, rcu@vger.kernel.org,
        Michal Sekletar <msekleta@redhat.com>
X-MC-Unique: LNXsQVGDNR6AzWxwcAxY8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Nov 10, 2019 at 10:03 PM Paul E. McKenney <paulmck@kernel.org> wrot=
e:
> On Fri, Nov 08, 2019 at 09:39:09AM +0100, Ondrej Mosnacek wrote:
> > +static void sidtab_destroy_entry(struct sidtab_entry *entry)
> > +{
> > +     context_destroy(&entry->context);
> > +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> > +     kfree(rcu_dereference_raw(entry->cache));
> > +#endif
> > +}
>
> I am assuming that this is called after all possible readers are done,
> for example late in shutdown.  Or is there some way that a grace period
> is guaranteed to have elapsed between the time this data was made
> inaccessible to readers and when sidtab_destroy_entry() is invoked?
>
> For example, suppose that sidtab_sid2str_get() is delayed just after
> it fetches entry->cache.  How does this patch avoid freeing entry->cache
> out from under that call to sidtab_sid2str_get()?

It is not visible in this patch, but the sidtab (along with other
policy-lifetime structures) is protected by a big fat read-write lock.
The only places where sidtab_destroy() is called are (a) error paths
when initializing a new sidtab (here the sidtab isn't shared yet, so
no race) and (b) when freeing the old sidtab during policy reload - in
this case it is happening after a policy write-locked critical
section, which had removed the old sidtab pointer from the shared
structures, so at that point all sidtab readers will already be
accessing the new sidtab and the old one is visible only by the thread
doing the destruction.

>
> > +
> >  static void sidtab_destroy_tree(union sidtab_entry_inner entry, u32 le=
vel)
> >  {
> >       u32 i;
> > @@ -473,7 +509,7 @@ static void sidtab_destroy_tree(union sidtab_entry_=
inner entry, u32 level)
> >                       return;
> >
> >               for (i =3D 0; i < SIDTAB_LEAF_ENTRIES; i++)
> > -                     context_destroy(&node->entries[i].context);
> > +                     sidtab_destroy_entry(&node->entries[i]);
> >               kfree(node);
> >       }
> >  }
> > @@ -484,7 +520,7 @@ void sidtab_destroy(struct sidtab *s)
> >
> >       for (i =3D 0; i < SECINITSID_NUM; i++)
> >               if (s->isids[i].set)
> > -                     context_destroy(&s->isids[i].context);
> > +                     sidtab_destroy_entry(&s->isids[i].entry);
> >
> >       level =3D SIDTAB_MAX_LEVEL;
> >       while (level && !s->roots[level].ptr_inner)
> > @@ -492,3 +528,88 @@ void sidtab_destroy(struct sidtab *s)
> >
> >       sidtab_destroy_tree(s->roots[level], level);
> >  }
> > +
> > +#if CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0
> > +
> > +void sidtab_sid2str_put(struct sidtab *s, struct sidtab_entry *entry,
> > +                     const char *str, u32 str_len)
> > +{
> > +     struct sidtab_str_cache *cache, *victim;
> > +
> > +     /* do not cache invalid contexts */
> > +     if (entry->context.len)
> > +             return;
> > +
> > +     /*
> > +      * Skip the put operation when in non-task context to avoid the n=
eed
> > +      * to disable interrupts while holding s->cache_lock.
> > +      */
> > +     if (!in_task())
> > +             return;
> > +
> > +     spin_lock(&s->cache_lock);
> > +
> > +     cache =3D rcu_dereference_raw(entry->cache);
>
> If entry->cache is protected by s->cache_lock, you can do this:
>
>         cache =3D rcu_dereference_protected(entry->cache, lockdep_is_held=
(s->cache_lock);
>
> Yes, this looks a little silly just after the lock is acquired, but
> future code changes might make the connection less obvious.  And there
> is no additional overhead unless CONFIG_PROVE_LOCKING is set, which
> won't normally be set in production.

Yeah, I realized this shortly after sending the patch. Queued this
change for v4.

>
> > +     if (cache) {
> > +             /* entry in cache - just bump to he head of LRU list */

Aaand I just spotted a typo here (he -> the). Also queued for v4.

> > +             list_move(&cache->lru_member, &s->cache_lru_list);
> > +             goto out_unlock;
> > +     }
> > +
> > +     cache =3D kmalloc(sizeof(struct sidtab_str_cache) + str_len, GFP_=
ATOMIC);
> > +     if (!cache)
> > +             goto out_unlock;
> > +
> > +     if (s->cache_free_slots =3D=3D 0) {
> > +             /* pop a cache entry from the tail and free it */
> > +             victim =3D container_of(s->cache_lru_list.prev,
> > +                                   struct sidtab_str_cache, lru_member=
);
> > +             list_del(&victim->lru_member);
> > +             kfree_rcu(victim, rcu_member);
> > +             rcu_assign_pointer(victim->parent->cache, NULL);
> > +     } else {
> > +             s->cache_free_slots--;
> > +     }
> > +     cache->parent =3D entry;
> > +     cache->len =3D str_len;
> > +     memcpy(cache->str, str, str_len);
> > +     rcu_head_init(&cache->rcu_member);
>
> You don't need rcu_head_init() unless you are also going to be using
> rcu_head_after_call_rcu(), which I don't see in this patch.  There is
> only one use of rcu_head_after_call_rcu() compared to something like 300
> uses of call_rcu(), so you probably won't ever need the rcu_head_init().

Ah, right. I just instinctively tried to keep everything initialized
and since I saw that rcu_head_init() exists I figured I should better
call it here... But it makes sense that rcu_member won't be touched
until call_rcu(), which can just initialize it itself. I'll drop the
call in v4.

>
> > +     list_add(&cache->lru_member, &s->cache_lru_list);
> > +
> > +     rcu_assign_pointer(entry->cache, cache);
> > +
> > +out_unlock:
> > +     spin_unlock(&s->cache_lock);
> > +}
> > +
> > +int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry,
> > +                    char **out, u32 *out_len)
> > +{
> > +     struct sidtab_str_cache *cache;
> > +     int rc =3D 0;
> > +
> > +     if (entry->context.len)
> > +             return -ENOENT; /* do not cache invalid contexts */
> > +
> > +     rcu_read_lock();
> > +
> > +     cache =3D rcu_dereference(entry->cache);
> > +     if (!cache) {
> > +             rc =3D -ENOENT;
> > +     } else {
> > +             *out_len =3D cache->len;
>
> Interesting.  The reason the above assignment is outside of the "if"
> below is so that the caller can learn the length by passing in NULL
> for "out" and non-NULL for "out_len"?

Yes, I was mirroring the logic of context_struct_to_string() (the
target of the caching), which seems to intentionally support such
feature. I'm not sure if it is ever used, but it's safer not to break
the contract.

Thank you for the review, much appreciated!

>
>                                                         Thanx, Paul
>
> > +             if (out) {
> > +                     *out =3D kmemdup(cache->str, cache->len, GFP_ATOM=
IC);
> > +                     if (!*out)
> > +                             rc =3D -ENOMEM;
> > +             }
> > +     }

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

